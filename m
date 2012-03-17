From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] t7800: Test difftool passing arguments to diff
Date: Fri, 16 Mar 2012 20:54:37 -0700
Message-ID: <1331956477-61346-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 04:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8kjg-0004ON-JS
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 04:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab2CQDym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 23:54:42 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43948 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab2CQDyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 23:54:41 -0400
Received: by iagz16 with SMTP id z16so6348558iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 20:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=nOuSXemROPnvJ7JwhARHc4MRBX6Ti4htszXgnS3XGDU=;
        b=Y2mW+AzqDxKyGP0Ca/e/IwsQqt8kmo8o4Il0MUL1wcsnFLo4lgjSRg88AWDBJbX2rk
         rps+/fRSvDXpQvobo0J91vjFyKDoZv/Mojz16l9DrfArbOgB5LayEtwiYu7TbgD5Qgbf
         d0aBVakYlwvwBIcNN8Sq6Vf/+OvLY1QEkpt+QB6LlXdfn/47ZIVSv4ibviEKNjkmYD7h
         cywBXegyOxUH+T5cYXHjY/xtJgGMVXR7mpDxFLOoBy7Gd0n1A/h0SDnV1xTDbH6mWOxj
         +B/klfaUXqNdIfuNf/HmsdmwKYlaNuCHjVY6lRKGoavgsOiE87WJp8V+XeAW4GeD715F
         SvtQ==
Received: by 10.182.141.10 with SMTP id rk10mr4838669obb.48.1331956480618;
        Fri, 16 Mar 2012 20:54:40 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id xh3sm6666340obb.13.2012.03.16.20.54.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 20:54:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.22.gf5241.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193305>

git-difftool relies on the ability to forward unknown arguments
to the git-diff command.  Add a test to ensure that this works
as advertised.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 4fb4c93..2763d79 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -83,6 +83,17 @@ test_expect_success PERL 'difftool ignores bad --tool values' '
 	test "$diff" = ""
 '
 
+test_expect_success PERL 'difftool forwards arguments to diff' '
+	>for-diff &&
+	git add for-diff &&
+	echo changes>for-diff &&
+	git add for-diff &&
+	diff=$(git difftool --cached --no-prompt -- for-diff) &&
+	test "$diff" = "" &&
+	git reset -- for-diff &&
+	rm for-diff
+'
+
 test_expect_success PERL 'difftool honors --gui' '
 	git config merge.tool bogus-tool &&
 	git config diff.tool bogus-tool &&
-- 
1.7.10.rc1.22.gf5241.dirty
