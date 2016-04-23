From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/2] git-p4 tests: work with python3 as well as python2
Date: Sat, 23 Apr 2016 15:13:46 +0100
Message-ID: <1461420826-4416-3-git-send-email-luke@diamand.org>
References: <1461420826-4416-1-git-send-email-luke@diamand.org>
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 16:11:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atyHL-0001cG-3X
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 16:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbcDWOLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 10:11:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35567 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcDWOLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 10:11:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so10800865wme.2
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r1ToX1h1QVzP6CKpvaZjCdfDlFKxSUHONg7VST8PaKI=;
        b=KOcKMDBaqJSJ0f5Ry6TpfIOhi/Tq/RTYIgzd0oDeaq1GB5RhZsZ5/5d9HCagMGqNAx
         p+9T5xuNJsSxf5UKhDjum4yrmzIJbdifIcvoY1FW129BC7PXjFXy5JWEjkMKrYLHmP9i
         9sjln6+7/9Uu+BLNGZ2Rz6gT//sZ3NXEqbXYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r1ToX1h1QVzP6CKpvaZjCdfDlFKxSUHONg7VST8PaKI=;
        b=HL5bkACRMt+aRKbDmCvCbkrdYymCHto17BqR4NH1xKqSyAAvIqgvfnF2E68M5szgll
         CJZDBi/4c1yhRxGp0XKusYGSBmX4qUW0qnRA3RJebZTwGJrM3oGPpEe662HLd9UfeXcz
         uQpan03TaZiKGs8Ou7ru5Xd9hPEclqgyVSTKIa97Jg1NXuCVJHi59FXzv7fj3kof0+cA
         R0nvubv+oEj/5+yPns7NOtF46yy6uif5c7SKPN311quLc86jk3HckgmEo/oEMVkafDjJ
         w4Av5j18jQqjJqzD08COXxkozTBXaThb/zbOGnrgVVYs0LHyked+q3e7na2rCrFv1J89
         TD9g==
X-Gm-Message-State: AOPr4FUhuwgVdqhSuhu1/JR6J+j2fEoAlsuSGAMbHOGHWIc/O7isQrM7rO+Fvyzr2Z1v/Q==
X-Received: by 10.28.144.20 with SMTP id s20mr2972277wmd.12.1461420671360;
        Sat, 23 Apr 2016 07:11:11 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id u3sm8537920wmg.15.2016.04.23.07.11.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 23 Apr 2016 07:11:10 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
In-Reply-To: <1461420826-4416-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292302>

Update the git-p4 tests so that they work with both
Python2 and Python3.

We have to be explicit about the difference between
Unicode text strings (Python3 default) and raw binary
strings which will be exchanged with Perforce.

Additionally, print always takes braces in Python3.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh            | 5 +++--
 t/t9802-git-p4-filetype.sh | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 77802fe..b97d27c 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -198,9 +198,10 @@ marshal_dump() {
 	cat >"$TRASH_DIRECTORY/marshal-dump.py" <<-EOF &&
 	import marshal
 	import sys
+	instream = getattr(sys.stdin, 'buffer', sys.stdin)
 	for i in range($line):
-	    d = marshal.load(sys.stdin)
-	print d['$what']
+	    d = marshal.load(instream)
+	print(d[b'$what'].decode('utf-8'))
 	EOF
 	"$PYTHON_PATH" "$TRASH_DIRECTORY/marshal-dump.py"
 }
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 66d3fc9..eb9a8ed 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -223,12 +223,12 @@ build_gendouble() {
 	import sys
 	import struct
 
-	s = struct.pack(">LL18s",
+	s = struct.pack(b">LL18s",
 			0x00051607,  # AppleDouble
 			0x00020000,  # version 2
-			""           # pad to 26 bytes
+			b""          # pad to 26 bytes
 	)
-	sys.stdout.write(s)
+	getattr(sys.stdout, 'buffer', sys.stdout).write(s)
 	EOF
 }
 
-- 
2.8.1.218.gd2cea43.dirty
