From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 3/5] t4205 (log-pretty-format): Use `tformat` rather than `format`
Date: Wed, 21 May 2014 17:20:05 +0400
Message-ID: <257a808af3a14e999f99823792b37f12190209f3.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400678003.git.Alex.Crezoff@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 15:20:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn6Rw-0002Hb-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 15:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbaEUNUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 09:20:43 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:53086 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbaEUNUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 09:20:42 -0400
Received: by mail-lb0-f180.google.com with SMTP id p9so1547287lbv.39
        for <git@vger.kernel.org>; Wed, 21 May 2014 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xtxigmc44HDnlrXEeGBdON9K8XW+nb9V3rUGZr2ArlY=;
        b=tfd0SxmVWCz3cZrWt3bXxnHEMRVf3DVuDUzGgJQ425yOPUfX0T4krIb2mZ/U1SJG2N
         DzOrkj0jKvHIU2tS68FwjBlV5ORT2Xz4Z5pQXPEP1pFhkb9hxfoRXY3BinpI5bO9A9je
         DDMvZEZeb55xdeRmmzgoH3h9RdbtW5sePKy06lF9BDcSSCF4DcoyEfka8fz9p+jf54oM
         t9NlnPk08irHn2jVohfeq3K5iC//cVfQT8ueVYuxDRmfaHI82PXRE0sLeEotVsvQmoF8
         o83lKmKehJKRMJItsE4HeOQPhKYuLmXUlzGlnKtIRvWzGNaalCR9p/ytvMP/rLJoQTiI
         w7Aw==
X-Received: by 10.152.23.42 with SMTP id j10mr37654227laf.19.1400678440862;
        Wed, 21 May 2014 06:20:40 -0700 (PDT)
Received: from localhost (ppp91-77-196-183.pppoe.mtu-net.ru. [91.77.196.183])
        by mx.google.com with ESMTPSA id f4sm1793188lbv.26.2014.05.21.06.20.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 06:20:40 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com> <cover.1400678003.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249797>

Use `tformat` to avoid using of `echo` to complete end of line.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 52 +++++++++++--------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f5ea3f8..c03a65e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -144,9 +144,7 @@ test_expect_success 'setup more commits' '
 '
 
 test_expect_success 'left alignment formatting' '
-	git log --pretty="format:%<(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 message two                            Z
 message one                            Z
@@ -157,9 +155,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting at the nth column' '
-	git log --pretty="format:%h %<|(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 $head1 message two                    Z
 $head2 message one                    Z
@@ -170,9 +166,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with no padding' '
-	git log --pretty="format:%<(1)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(1)%s" >actual &&
 	cat <<EOF >expected &&
 message two
 message one
@@ -183,9 +177,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with trunc' '
-	git log --pretty="format:%<(10,trunc)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 message ..
 message ..
@@ -196,9 +188,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with ltrunc' '
-	git log --pretty="format:%<(10,ltrunc)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 ..sage two
 ..sage one
@@ -209,9 +199,7 @@ EOF
 '
 
 test_expect_success 'left alignment formatting with mtrunc' '
-	git log --pretty="format:%<(10,mtrunc)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 mess.. two
 mess.. one
@@ -222,9 +210,7 @@ EOF
 '
 
 test_expect_success 'right alignment formatting' '
-	git log --pretty="format:%>(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%>(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 Z                            message two
 Z                            message one
@@ -235,9 +221,7 @@ EOF
 '
 
 test_expect_success 'right alignment formatting at the nth column' '
-	git log --pretty="format:%h %>|(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 $head1                      message two
 $head2                      message one
@@ -248,9 +232,7 @@ EOF
 '
 
 test_expect_success 'right alignment formatting with no padding' '
-	git log --pretty="format:%>(1)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<EOF >expected &&
 message two
 message one
@@ -261,9 +243,7 @@ EOF
 '
 
 test_expect_success 'center alignment formatting' '
-	git log --pretty="format:%><(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%><(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 Z             message two              Z
 Z             message one              Z
@@ -274,9 +254,7 @@ EOF
 '
 
 test_expect_success 'center alignment formatting at the nth column' '
-	git log --pretty="format:%h %><|(40)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<EOF >expected &&
 $head1           message two          Z
 $head2           message one          Z
@@ -287,9 +265,7 @@ EOF
 '
 
 test_expect_success 'center alignment formatting with no padding' '
-	git log --pretty="format:%><(1)%s" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%><(1)%s" >actual &&
 	cat <<EOF >expected &&
 message two
 message one
@@ -305,9 +281,7 @@ old_head1=$(git rev-parse --verify HEAD~0)
 
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
-	git log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
-	# complete the incomplete line at the end
-	echo >>actual &&
+	git log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	cat <<EOF >expected &&
 short long  long long
 message ..   A U Thor
-- 
1.9.2-15
