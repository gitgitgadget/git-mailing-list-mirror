From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v4 2/4] t0060: Add test for prefix_path when path == work tree
Date: Sun,  2 Feb 2014 02:59:09 +0100
Message-ID: <1391306351-13237-3-git-send-email-martinerikwerner@gmail.com>
References: <20140131202142.GA9731@mule>
 <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 03:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9mLz-0007u1-6o
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 03:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbaBBCAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 21:00:01 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:56212 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaBBCAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 21:00:00 -0500
Received: by mail-lb0-f171.google.com with SMTP id c11so4432650lbj.2
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 17:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkWJN/rasDWmg835phTWFAN11Te+fXG/o/+wBb5Y5Ww=;
        b=Nyfz9Im1qwHfEuQvNXv0Xeo45/dTpXS7G4MUZuP19mkw294tkHOaB4JQDVuoIuKiUL
         D3f/aPHkT2i1efOSy9iOyTnNtEuCC1FnTaGGkwLMwNZyaQye3Fb73pV82zAbqcVfwBd5
         Np5NfbD818TU80BXaCaTXGdZ38AdU1sIDcmzCDxXNLNbhVYU0ZpLhvbsuhEb96RV0p/F
         qj8Yy3oPrlplb+TxvKBH2VZaq3p7KR/DHrBjjUOV7DHv7/ONwhvka7qUeihSE3RlChOh
         12Hhv9kYuwl7NgDA6QH+FLKhg4wTJT9i9vc10EjHdb4gf21E//4PmrtljuqTu3nNXRbm
         OWog==
X-Received: by 10.112.172.8 with SMTP id ay8mr67132lbc.41.1391306398802;
        Sat, 01 Feb 2014 17:59:58 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id g8sm22136585lae.1.2014.02.01.17.59.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Feb 2014 17:59:58 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241348>

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
