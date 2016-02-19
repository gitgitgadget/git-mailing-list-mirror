From: larsxschneider@gmail.com
Subject: [PATCH v6 1/4] t: do not hide Git's exit code in tests using 'nul_to_q'
Date: Fri, 19 Feb 2016 10:15:59 +0100
Message-ID: <1455873362-66998-2-git-send-email-larsxschneider@gmail.com>
References: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 10:16:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhAr-0004in-T0
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948531AbcBSJQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 04:16:24 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37670 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948080AbcBSJQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 04:16:08 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so61815858wme.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICI4GlA7xsen67uTw8efI9EdnmcXuio6Dis1OsoiiDo=;
        b=tqAS5fMbPMR4RzqtfcDVw1hJdZTsZx9jPQpTA3tH6WXcoY8BByKF7BIi2F5WE9RmsQ
         f7bP9yMpPdOMArsdsqQNuTGEUbIz6ptml4VDfriaqbkA1cJ47J5QIg1gqMoXXll4Qnl9
         Fwo5P2WSsYrpNfdxg8caxY9g1fDuXYNQ2MjBpjD7ssj8WoLLsl9dPSH7kQK1faic5tD/
         agtHsf7hqObswGLqmSkOJZJJv7tIwYd9C2sHtPuxWAtFJpjbYyCkH8pyfpud4QYkTpUB
         kKnd2rlqHKLh9bF5BxTYax9sSYp/M7Qw/7y+REI0eqqqpmXTm8P4NhnlP+hlW/G6FgX+
         2j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICI4GlA7xsen67uTw8efI9EdnmcXuio6Dis1OsoiiDo=;
        b=Pya0v2nLXZZHM/Ny+/SP/6PMDXbFGPtUXecEcQnTzJx0mGguaomZDOJOL1FE65U8lk
         oXSimvyQrpCVlnpNz+gYlxa7bVvjZDRjcLo6H2idCoHI2Z5ly9KHSlXXYFwugoOLwRzs
         yJuprhUumuOWfauZHjRgkyaBEl5VaLmEMjPdz1FIXIiYvDSkE0BAfOM7N69f+KJJKPU7
         gRiZAoNoELeUJ/AJFrv+4XZR6rV2c/9VeXfFCrlvjCKcAD0h+jbk0H2Ykr7DMMLksi+J
         NqXrnt1J944lOOjaoOc7qAAcyzSYFfL7j+IB51X53RQIGbh7RilblpNJpVEelIGlxkr2
         WsIw==
X-Gm-Message-State: AG10YORaHRTIINKAoAJTGM3zZ0WwbYjj/66QXucH0Zrdbm1FAENLU9gxFlCJsDEEb+jTSA==
X-Received: by 10.28.4.134 with SMTP id 128mr7605128wme.96.1455873366593;
        Fri, 19 Feb 2016 01:16:06 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB455F.dip0.t-ipconnect.de. [93.219.69.95])
        by smtp.gmail.com with ESMTPSA id ks5sm10301204wjb.13.2016.02.19.01.16.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 01:16:05 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1455873362-66998-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286673>

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
