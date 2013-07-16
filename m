From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] t3032 - make compatible with systems using \r\n as a line ending
Date: Tue, 16 Jul 2013 14:49:52 -0400
Message-ID: <1374000592-31845-1-git-send-email-mlevedahl@gmail.com>
References: <51E591FF.7030600@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 16 20:50:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzAK2-0007Pl-0u
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933530Ab3GPSt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:49:58 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:46268 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933353Ab3GPSt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:49:57 -0400
Received: by mail-gh0-f180.google.com with SMTP id f18so270620ghb.11
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HW7RqVI34sR7KXNrenZCCEtBoJMhJn1yg3K5NgjlKxw=;
        b=npHh5CjNZga/kCB8/MKllPxc1G75cEZy9f0pwVExDoQ74455tAU1WxzzaSCZ/GiVjL
         nwrF2DdeiXG8o2jMHzgc2ZTrCOmIrp4owhbhVB0iOJtofEXBJVyjNxWPp0+FojEzlU82
         eGlZYXP2hV06ToqEXYNkTfc5v58pACDm17mB4P+MTAYQABNGmrvAHc7OnF3NVsPhv194
         Wux3+62Mp+xCZ7AezYwEtJhGX32d+UssPgRL2WOzG2P5/83++Kl+ObYgVNAbsFQ5MqJz
         r3xQaJF9JiqzI0agyLtVl50kmI5urMTd5zc98qWjEWiPkwKXWjFeEWxqWHak0k0cJbHm
         1Qxg==
X-Received: by 10.236.87.107 with SMTP id x71mr849771yhe.10.1374000596888;
        Tue, 16 Jul 2013 11:49:56 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id s80sm2922296yhe.27.2013.07.16.11.49.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:49:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
In-Reply-To: <51E591FF.7030600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230575>

Subtests 6, 7, and 9 rely test that merge-recursive correctly
ignores whitespace when so directed. Change the particular whitespace
sequences to be ones that are not known line endings so the whitespace
is not changed when being extracted by line oriented grep.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 t/t3032-merge-recursive-options.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-recursive-options.sh
index 2b17311..52e275c 100755
--- a/t/t3032-merge-recursive-options.sh
+++ b/t/t3032-merge-recursive-options.sh
@@ -92,7 +92,7 @@ test_expect_success 'setup' '
 			s/Polemarchus interposing./Polemarchus, interposing.Q/
 			/justice and holiness/ s/$/Q/
 			/pay your debts/ s/$/Q/
-		" text.txt | q_to_cr >text.txt+ &&
+		" text.txt | q_to_tab >text.txt+ &&
 	mv text.txt+ text.txt &&
 	git commit -a -m "Clarify" &&
 	git show-branch --all
@@ -125,7 +125,7 @@ test_expect_success '-Xignore-space-change makes cherry-pick succeed' '
 '
 
 test_expect_success '--ignore-space-change: our w/s-only change wins' '
-	q_to_cr <<-\EOF >expected &&
+	q_to_tab <<-\EOF >expected &&
 	    justice and holiness and is the nurse of his age and theQ
 	EOF
 
@@ -150,7 +150,7 @@ test_expect_success '--ignore-space-change: does not ignore new spaces' '
 	cat <<-\EOF >expected1 &&
 	Well said, Cephalus, I replied; but as con cerning justice, what is
 	EOF
-	q_to_cr <<-\EOF >expected2 &&
+	q_to_tab <<-\EOF >expected2 &&
 	un intentionally; and when he departs to the world below he is not inQ
 	EOF
 
@@ -174,7 +174,7 @@ test_expect_success '--ignore-all-space drops their new spaces' '
 '
 
 test_expect_success '--ignore-all-space keeps our new spaces' '
-	q_to_cr <<-\EOF >expected &&
+	q_to_tab <<-\EOF >expected &&
 	un intentionally; and when he departs to the world below he is not inQ
 	EOF
 
@@ -185,7 +185,7 @@ test_expect_success '--ignore-all-space keeps our new spaces' '
 '
 
 test_expect_success '--ignore-space-at-eol' '
-	q_to_cr <<-\EOF >expected &&
+	q_to_tab <<-\EOF >expected &&
 	<<<<<<< HEAD
 	is not in his right mind; ought I to give them back to him?  No oneQ
 	=======
-- 
1.8.3.2.0.13
