From: larsxschneider@gmail.com
Subject: [PATCH v5 1/3] t: do not hide Git's exit code in tests using 'nul_to_q'
Date: Wed, 17 Feb 2016 09:57:46 +0100
Message-ID: <1455699468-45443-2-git-send-email-larsxschneider@gmail.com>
References: <1455699468-45443-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 09:58:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVxvt-0006mu-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 09:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbcBQI54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 03:57:56 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35343 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbcBQI5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 03:57:55 -0500
Received: by mail-wm0-f52.google.com with SMTP id c200so201696031wme.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 00:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICI4GlA7xsen67uTw8efI9EdnmcXuio6Dis1OsoiiDo=;
        b=pEDqz2mdlaKY/emcel424aVUBfJHpf6JGI0yiYhEYylaENuJnQXIIkT2cfQtWo3tqS
         PnJjN8waw9Afw4oqGNqT6Da+CDXx209hdSvA2uai/7WMMn7X6w3VbAKJZPzZzEQnjK1s
         GFdjckvo2YV2SPQ/1nv5WVL26GnmOW49HfSGjEsiSFzVS5MUxapTvzHMmdpbfPUXY0lF
         2EsQQeKKPJiQuCC8NEUhCpgGSUc7sb+woNpHE31In6ykL5G1wdfU4qJg2OMUJ7wH13zy
         CJk8R4kvWlU09VEc3v/pOTmNYhuMvUQ02h7Zw3MGfck0WmqZksQIbykvsgW0fROesnWm
         TW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICI4GlA7xsen67uTw8efI9EdnmcXuio6Dis1OsoiiDo=;
        b=USMwpJaKljHChU5VKcmLWCFBXnXIVcMN1zsP9bquWPDwDNYuk9OsvAu2CPqgw6sLm6
         a8AFggkCUlERDZ7wnQzFGlLxX457B1I03C8DDhwy7ZoEW3/ytsyuiSSg2V9TeofMrrjF
         nqVhmuy+DMdHf6652J5Kf36OcZCUnjlXOJqT4lz80zN6+ERYbjhwhKCByvJdg9gEaba1
         4z9wYJCceG00xHPu7+yOxOjyM7dzwmPGD3Mws8gaALFb4EWi5Dd6KrqjMpY1zgmfdfo6
         ri8kAyJaF2vgXfJfTHFa8/obDpGApI5ZSP+0Gb4ciON7WH8Hu3/waR2++IgSh9Dj3uu+
         GnPQ==
X-Gm-Message-State: AG10YOQl5j/P2+Leqqebvs/taTA/dDj1pAgjl3jzTYr4EZ/xOA4PnArruQZdCrv4+G2T0g==
X-Received: by 10.194.61.19 with SMTP id l19mr499521wjr.148.1455699473982;
        Wed, 17 Feb 2016 00:57:53 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB412D.dip0.t-ipconnect.de. [93.219.65.45])
        by smtp.gmail.com with ESMTPSA id q129sm2006973wmd.14.2016.02.17.00.57.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 00:57:53 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455699468-45443-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286488>

From: Lars Schneider <larsxschneider@gmail.com>

Git should not be on the left-hand side of a pipe, because it hides the exit
code, and we want to make sure git does not fail.

Fix all invocations of 'nul_to_q' (defined in /t/test-lib-functions.sh) using
this pattern. There is one more occurrence of the pattern in t9010-svn-fe.sh
which is too evolved to change it easily.

All remaining test code that does not adhere to the pattern can be found with
the following command:
git grep -E 'git.*[^|]\|($|[^|])'

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t1300-repo-config.sh | 6 ++++--
 t/t7008-grep-binary.sh | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 52678e7..1782add 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -957,13 +957,15 @@ Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
 test_expect_success '--null --list' '
-	git config --null --list | nul_to_q >result &&
+	git config --null --list >result.raw &&
+	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
 '
 
 test_expect_success '--null --get-regexp' '
-	git config --null --get-regexp "val[0-9]" | nul_to_q >result &&
+	git config --null --get-regexp "val[0-9]" >result.raw &&
+	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
 '
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index b146406..9c9c378 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -141,7 +141,8 @@ test_expect_success 'grep respects not-binary diff attribute' '
 	test_cmp expect actual &&
 	echo "b diff" >.gitattributes &&
 	echo "b:binQary" >expect &&
-	git grep bin b | nul_to_q >actual &&
+	git grep bin b >actual.raw &&
+	nul_to_q <actual.raw >actual &&
 	test_cmp expect actual
 '
 
-- 
2.5.1
