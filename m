From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/3] git-p4 tests: work with python3 as well as python2
Date: Tue, 26 Apr 2016 08:51:00 +0100
Message-ID: <1461657061-7984-3-git-send-email-luke@diamand.org>
References: <1461657061-7984-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 09:48:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxjO-0006Lm-P9
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbcDZHsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:48:24 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37599 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcDZHsW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:48:22 -0400
Received: by mail-wm0-f49.google.com with SMTP id n3so20840076wmn.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oLmHXko2EAPU1qx14vXM+CRC38tzFcB4OKRnRRD/84k=;
        b=eDxxAaltmacm9Rav6a6HEq82nonV2pa8vFQnE5n+ALPV/kheXgiiajUy4NI/TfiC3k
         ++XB8iUWWNj9Lp3O5qVBdEQlPs7ai4Nt1M45zl6k+8T6uOtANzGQXPMktM9z7O2AVXgX
         5qKh/n2RQJjwP2mnoGrOdoRRT2gUcn/c58LEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oLmHXko2EAPU1qx14vXM+CRC38tzFcB4OKRnRRD/84k=;
        b=f43HFSuy6sM9g7d2C2E6lTq+FhFUORC5cXY86znI6KAfp/PPdYtzikVpkf50EY3Un4
         QKns6Fj2T9dpN8TB345wC7Cboo+cot4wugFjU+E0wLF9JiRKrXQNNopm6Bk8jzw35jX1
         cMbmVKhwKZh0BEWWre432PbMWIMr2PXuEVPfrw4hTnXt+7IpECAvQS//LsiwG7eP65gw
         3cIAcjkf5u3lIaEQTXAFgCCLE4lQR7h6NJzIB/pVQp7/DDxJdykDFzQal1CF/5Sm6eAl
         rGKcJBwrQcQ1g4umHQsjMxE5JeK9rziGeXjEoE8EdUZawxj6mKzWh0eYWeaozBUa0FsQ
         rcMA==
X-Gm-Message-State: AOPr4FUhwS6tf3pJwI5EgIrwcZj8Nm7YaLzuhKVTA2dRvX/K/RKfRpaNQ2qWGlFNPVAR+g==
X-Received: by 10.28.146.135 with SMTP id u129mr1834445wmd.8.1461656901026;
        Tue, 26 Apr 2016 00:48:21 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id h8sm1734520wmd.2.2016.04.26.00.48.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 00:48:20 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
In-Reply-To: <1461657061-7984-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292589>

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
index 724bc43..7393ee2 100644
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
