Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597FEC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhLMGcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhLMGcE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:04 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0CC061748
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:04 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i13so3235866ilk.13
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNkgleSHS5lkSjYgdZWp65JdZD79anPtZQGwgipfWAs=;
        b=GigN4b4akrDBCpp2dLAsxGxsnN1hZ3fITXTqU6Gr5IvTMcf/BPelVEh5EcCi6/mzqn
         4WLmt5s2DqqZIxZngnRT1rAL55Q+ZPMnhk310X7nJRNtDWdDHQ2RnjR9KjwZ2xagSMkb
         93iUml2QjJwv7lb18LK2MiY4tl9e1FEpMJz0nL2+er/C05unEmqmq8j6XEpeDG3Mt16d
         Va1/Hv1fYBgMJjSiviYvZ9McjkCcJFQ3YwsfBt9GC8he9AiNxm+UNlJjbRKfn70lNcbU
         K2L1LELEl7Hm356/C8GzJXcl6fvGl38OoS+AOZIsGs4JuMkEsNTDfvZx84EcP/b0zTx0
         6iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cNkgleSHS5lkSjYgdZWp65JdZD79anPtZQGwgipfWAs=;
        b=t1slQByeaPleIWOmNPBzv2gcEa2E0DgeWtW4K+WTh2hsmRmh2fi77Y+qkKcbmFMdxY
         yiIX1mXfVHA+2oGDjlgtth4atiCZLWrs+DveMG1UexHuqMv8crudHlV2qXSq8Eym4hhf
         6TcoiHxnAhbwsQMhYRPvoR7tj8YsXxUsuN02AU2idt6akCktEBEQ+qhYBDtkW8fBQ9zE
         n08IQYc35Q7od2UdIOSFpDs95gSLQTMrVbwuYR2AIv+WK9VYiLyx6Uo5fCxcgaTTAkle
         yJ8q1BnWGkXSo+sRaWYE+KrCCQIN1FwigjPxnMQa37PmtI0wIB3lP9uA6etQmQvYStVK
         omjg==
X-Gm-Message-State: AOAM532lMRkPulCQL3NMAuoBxZFsVjYbJo8Fj3cPLe/P1HQuMNfdXIYs
        SftxMHvaiKLS7NjCu5cZJsPRD3mdYq0+2Q==
X-Google-Smtp-Source: ABdhPJzjyC7QhlIrTsuOpM8AlujnDbFf7Yve4CadCftxM4WnbK5ZrYrCuDmqpE7ju/qwait363ziDQ==
X-Received: by 2002:a05:6e02:1583:: with SMTP id m3mr32883820ilu.294.1639377123474;
        Sun, 12 Dec 2021 22:32:03 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:02 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/15] chainlint.sed: improve ?!SEMI?! placement accuracy
Date:   Mon, 13 Dec 2021 01:30:51 -0500
Message-Id: <20211213063059.19424-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When chainlint.sed detects commands separated by a semicolon rather than
by `&&`, it places a ?!SEMI?! annotation at the beginning of the line.
However, this is an unusual location for programmers accustomed to error
messages (from compilers, for instance) indicating the exact point of
the problem. Therefore, relocate the ?!SEMI?! annotation to the location
of the semicolon in order to better direct the programmer's attention to
the source of the problem.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                       |  4 ++--
 t/chainlint/negated-one-liner.expect  |  4 ++--
 t/chainlint/one-liner.expect          |  6 +++---
 t/chainlint/semicolon.expect          | 14 +++++++-------
 t/chainlint/subshell-one-liner.expect |  8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 883a2b307c..60c2099c18 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -126,7 +126,7 @@ b
 # "&&" (but not ";" in a string)
 :oneline
 /;/{
-	/"[^"]*;[^"]*"/!s/^/?!SEMI?!/
+	/"[^"]*;[^"]*"/!s/;/; ?!SEMI?!/
 }
 b
 
@@ -230,7 +230,7 @@ s/.*\n//
 # string and not ";;" in one-liner "case...esac")
 /;/{
 	/;;/!{
-		/"[^"]*;[^"]*"/!s/^/?!SEMI?!/
+		/"[^"]*;[^"]*"/!s/;/; ?!SEMI?!/
 	}
 }
 # line ends with pipe "...|" -- valid; not missing "&&"
diff --git a/t/chainlint/negated-one-liner.expect b/t/chainlint/negated-one-liner.expect
index cf18429d03..60baf84b7a 100644
--- a/t/chainlint/negated-one-liner.expect
+++ b/t/chainlint/negated-one-liner.expect
@@ -1,5 +1,5 @@
 ! (foo && bar) &&
 ! (foo && bar) >baz &&
 
-?!SEMI?!! (foo; bar) &&
-?!SEMI?!! (foo; bar) >baz
+! (foo; ?!SEMI?! bar) &&
+! (foo; ?!SEMI?! bar) >baz
diff --git a/t/chainlint/one-liner.expect b/t/chainlint/one-liner.expect
index c64058f7af..3b46554728 100644
--- a/t/chainlint/one-liner.expect
+++ b/t/chainlint/one-liner.expect
@@ -2,8 +2,8 @@
 (foo && bar) |
 (foo && bar) >baz &&
 
-?!SEMI?!(foo; bar) &&
-?!SEMI?!(foo; bar) |
-?!SEMI?!(foo; bar) >baz &&
+(foo; ?!SEMI?! bar) &&
+(foo; ?!SEMI?! bar) |
+(foo; ?!SEMI?! bar) >baz &&
 
 (foo "bar; baz")
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index ffc87bdffb..d2d804f5b0 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -1,20 +1,20 @@
 (
-?!SEMI?!	cat foo ; echo bar ?!AMP?!
-?!SEMI?!	cat foo ; echo bar
+	cat foo ; ?!SEMI?! echo bar ?!AMP?!
+	cat foo ; ?!SEMI?! echo bar
 >) &&
 (
-?!SEMI?!	cat foo ; echo bar &&
-?!SEMI?!	cat foo ; echo bar
+	cat foo ; ?!SEMI?! echo bar &&
+	cat foo ; ?!SEMI?! echo bar
 >) &&
 (
 	echo "foo; bar" &&
-?!SEMI?!	cat foo; echo bar
+	cat foo; ?!SEMI?! echo bar
 >) &&
 (
-?!SEMI?!	foo;
+	foo; ?!SEMI?!
 >) &&
 (
 cd foo &&
 	for i in a b c; do
-?!SEMI?!		echo;
+		echo; ?!SEMI?!
 >	done)
diff --git a/t/chainlint/subshell-one-liner.expect b/t/chainlint/subshell-one-liner.expect
index ec77aa5b95..432217801b 100644
--- a/t/chainlint/subshell-one-liner.expect
+++ b/t/chainlint/subshell-one-liner.expect
@@ -2,13 +2,13 @@
 	(foo && bar) &&
 	(foo && bar) |
 	(foo && bar) >baz &&
-?!SEMI?!	(foo; bar) &&
-?!SEMI?!	(foo; bar) |
-?!SEMI?!	(foo; bar) >baz &&
+	(foo; ?!SEMI?! bar) &&
+	(foo; ?!SEMI?! bar) |
+	(foo; ?!SEMI?! bar) >baz &&
 	(foo || exit 1) &&
 	(foo || exit 1) |
 	(foo || exit 1) >baz &&
 	(foo && bar) ?!AMP?!
-?!SEMI?!	(foo && bar; baz) ?!AMP?!
+	(foo && bar; ?!SEMI?! baz) ?!AMP?!
 	foobar
 >)
-- 
2.34.1.397.gfae76fe5da

