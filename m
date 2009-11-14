From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] t3101: test more ls-tree options
Date: Fri, 13 Nov 2009 20:34:07 -0800
Message-ID: <1258173248-31059-2-git-send-email-bebarino@gmail.com>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 05:34:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9ALP-0006F7-I5
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 05:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831AbZKNEeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 23:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757823AbZKNEeL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 23:34:11 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:57772 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787AbZKNEeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 23:34:10 -0500
Received: by yxe17 with SMTP id 17so3510958yxe.33
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 20:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=x8AS+ZmUyk3s4GuJjfd/iK019oatByBAVQb5CMToR6I=;
        b=iqNA2ssYdPkXP/XBBwfflJjvaw5WTQY/B5YywhlwRe4yErAVXS3nSQKEAkOjlKrNz3
         5AsNlS9DY1FVaXccY+bMmEbpazPaUjcOM1UXA7bXNOl2+PWQIGGgeXHrlqf8s9jK+m4V
         YVZ4SF/xX2cLaf1ZymC+vP0RwbrZoquY4QKiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hOOWYgrWi4JK7Z5X/7RNdSiNZqqXFUTllnBSeEPsiARe8vIZKhBc2JGt4QIi1LWjPA
         ugaYfz2LX9OCkZyGuWkcyHJ3Ggvq3nTticTXL6m7CtSnynveNeHbjj2qnXEnnKBH0HgA
         2Aso4aKzTszO44xtmO7qxEBrmYPYfv7+KQdcM=
Received: by 10.150.129.13 with SMTP id b13mr9266788ybd.304.1258173255862;
        Fri, 13 Nov 2009 20:34:15 -0800 (PST)
Received: from earth (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 20sm173104ywh.2.2009.11.13.20.34.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 20:34:15 -0800 (PST)
Received: by earth (sSMTP sendmail emulation); Fri, 13 Nov 2009 20:34:12 -0800
X-Mailer: git-send-email 1.6.5.2.155.gbb47
In-Reply-To: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132859>

Add tests for --full-name, --full-tree, --abbrev, and --name-only.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t3101-ls-tree-dirname.sh |   89 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 51cb4a3..99458e4 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -39,8 +39,8 @@ test_expect_success \
      tree=`git write-tree` &&
      echo $tree'
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+_x5='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x5$_x5$_x5$_x5$_x5$_x5$_x5$_x5"
 test_output () {
     sed -e "s/ $_x40	/ X	/" <current >check
     test_cmp expected check
@@ -141,4 +141,89 @@ test_expect_success 'ls-tree filter is leading path match' '
 	test_output
 '
 
+test_expect_success 'ls-tree --full-name' '
+	(
+		cd path0 &&
+		git ls-tree --full-name $tree a
+	) > current &&
+	cat >expected <<\EOF &&
+040000 tree X	path0/a
+EOF
+	test_output
+'
+
+test_expect_success 'ls-tree --full-tree' '
+	(
+		cd path1/b/c &&
+		git ls-tree --full-tree $tree
+	) > current &&
+	cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	2.txt
+040000 tree X	path0
+040000 tree X	path1
+040000 tree X	path2
+040000 tree X	path3
+EOF
+	test_output
+'
+
+test_expect_success 'ls-tree --full-tree -r' '
+	(
+		cd path3/ &&
+		git ls-tree --full-tree -r $tree
+	) > current &&
+	cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	2.txt
+100644 blob X	path0/a/b/c/1.txt
+100644 blob X	path1/b/c/1.txt
+100644 blob X	path2/1.txt
+100644 blob X	path3/1.txt
+100644 blob X	path3/2.txt
+EOF
+	test_output
+'
+
+test_expect_success 'ls-tree --abbrev=5' '
+	git ls-tree --abbrev=5 $tree > current.abbrev &&
+	sed -e "s/ $_x5	/ X	/"  < current.abbrev > current &&
+	cat >expected <<\EOF &&
+100644 blob X	1.txt
+100644 blob X	2.txt
+040000 tree X	path0
+040000 tree X	path1
+040000 tree X	path2
+040000 tree X	path3
+EOF
+	test_output
+'
+
+test_expect_success 'ls-tree --name-only' '
+	git ls-tree --name-only $tree > current
+	cat >expected <<\EOF &&
+1.txt
+2.txt
+path0
+path1
+path2
+path3
+EOF
+	test_output
+'
+
+test_expect_success 'ls-tree --name-only -r' '
+	git ls-tree --name-only -r $tree > current
+	cat >expected <<\EOF &&
+1.txt
+2.txt
+path0/a/b/c/1.txt
+path1/b/c/1.txt
+path2/1.txt
+path3/1.txt
+path3/2.txt
+EOF
+	test_output
+'
+
 test_done
-- 
1.6.5.2.155.gbb47
