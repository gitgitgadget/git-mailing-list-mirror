From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] mailmap: Testing the single letter name case.
Date: Sat, 13 Jul 2013 09:20:20 +0200
Message-ID: <1373700020-30436-1-git-send-email-stefanbeller@googlemail.com>
References: <1373665135-32484-2-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: sunshine@sunshineco.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 13 09:20:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxu8I-0002CU-5Q
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 09:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3GMHUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 03:20:24 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:35960 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3GMHUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 03:20:23 -0400
Received: by mail-ea0-f173.google.com with SMTP id g15so6772904eak.32
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ul8Z+0j9Y4cCTpKBskFgUi9L6pbjorR3nqvmgHWUhbA=;
        b=H5y4SbhjGglu2T/Tv1OHJGYqkBQn5s0rhKemLTp0K/ylp97URejBX3Ay9ymW11S0+2
         9ZjG6E//hr0LAGEQ1Q/YR78w6S+FYQbNzQyH2Uns1cryow+qsQ/U7SViBK8LGJVYTjPx
         RWPX39URvCfeDz9Dh/egyPry1694xSsqEo0MNiejmth2YzM6lwR4viDelbo7PesKf0os
         rBRXo/BF+dlQnmEkrNjOkDOcrAp902mkyl7B0G2+fd01CtA0Pj0RqYVlx0XpIfPKFOjD
         xWfk4D5JpDrfJaPlNzbnGJqKaY+pZLLOuskKbBHPkm4EQXg/F+UaUWtjdzEEpZYEO9UL
         Gfqg==
X-Received: by 10.14.177.196 with SMTP id d44mr50085034eem.35.1373700022382;
        Sat, 13 Jul 2013 00:20:22 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a4sm84936600eez.0.2013.07.13.00.20.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 13 Jul 2013 00:20:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.776.gfcf213d
In-Reply-To: <1373665135-32484-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230278>

This is a regression test for a66e77eab70a08938fdc2227b7ada0f0465c6991

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 t/t4203-mailmap.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 842b754..9ec87a2 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -409,4 +409,45 @@ test_expect_success 'Blame output (complex mapping)' '
 	test_cmp expect actual.fuzz
 '
 
+cat >expect <<\EOF
+A <ShortName@company.xy> (2):
+      eighth
+      nineth
+
+A U Thor <author@example.com> (1):
+      initial
+
+CTO <cto@company.xx> (1):
+      seventh
+
+Other Author <other@author.xx> (2):
+      third
+      fourth
+
+Santa Claus <santa.claus@northpole.xx> (2):
+      fifth
+      sixth
+
+Some Dude <some@dude.xx> (1):
+      second
+
+EOF
+
+# Regression test
+# Using a single letter name to check for off-by-one errors in parse_name_and_email
+test_expect_success 'check mapping for short names' '
+	echo one >two &&
+	git add two &&
+	git commit --author "A <shortname@company.xx>" -m "eighth" &&
+
+	echo two >> two &&
+	git add two &&
+	git commit --author "A <ShortName@company.xy>" -m "nineth" &&
+
+	echo "A <ShortName@company.xy> <shortname@company.xx>" >> .mailmap &&
+	git shortlog HEAD -e >actual
+
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.2.776.gfcf213d
