From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v5 2/5] t0060: Add test for prefix_path when path == work tree
Date: Sun,  2 Feb 2014 17:35:37 +0100
Message-ID: <1391358940-17373-3-git-send-email-martinerikwerner@gmail.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 17:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA02Z-0000DW-Dr
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 17:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbaBBQgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 11:36:50 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34605 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbaBBQgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 11:36:39 -0500
Received: by mail-lb0-f173.google.com with SMTP id y6so4671934lbh.4
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 08:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkWJN/rasDWmg835phTWFAN11Te+fXG/o/+wBb5Y5Ww=;
        b=Oup8aboBCHTyujCkq3NwUU1Ur3g33KlKlJorfezvsJQkkKwiqbCJcrrQ3WpKxJGPRz
         +lEShc3jKyrauNB5gzdTc5MC9r2MHMVYnhf4kmfLtS91IpsmIkxGx/fTm3KpYQsj0Dj4
         KFLtdiFsyyuHrnTU1tDczqwrzsCylKxvdVztS47vswm6Q0hxVaZuIESyXxABfRuSMLYC
         Gllaa4hUI0lulpfkUuO1XEYXWyvMNfa+jw2Psv7ZLH4uKuVouJX1pfZNIL3QoKHqPC9D
         5hq3IIg+6AU4a2hq4Hr0y9Tcibi9VmlJid7P2H3mpMITA/3IgZ1iR4bPKvot12h1xmz1
         3dvQ==
X-Received: by 10.112.131.100 with SMTP id ol4mr1428003lbb.38.1391358998538;
        Sun, 02 Feb 2014 08:36:38 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id jl8sm18063514lbc.16.2014.02.02.08.36.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Feb 2014 08:36:37 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241378>

The current behaviour of prefix_path is to return an empty string if
prefixing and absolute path that only contains exactly the work tree.
This behaviour is a potential regression point.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t0060-path-utils.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0bba988..b8e92e1 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -195,6 +195,12 @@ test_expect_failure SYMLINKS 'prefix_path works with absolute paths to work tree
 	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
 '
 
+test_expect_success 'prefix_path works with only absolute path to work tree' '
+	echo "" >expected &&
+	test-path-utils prefix_path prefix "$(pwd)" >actual &&
+	test_cmp expected actual
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2
