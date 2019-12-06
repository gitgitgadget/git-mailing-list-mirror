Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF362C3F68F
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DFE24670
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW8Wpye5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFNIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50850 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLFNIa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so7786579wmg.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dk4jHk9V8pKAO9UUtocjKNsOEWJO42Db7pR93uzxgG8=;
        b=HW8Wpye5UsXzKD0D/AntCvESL8d/zVvvtFatVXeIgIwpAOJu5FSWnGS5OtjwPzUKsH
         h55bIDKWfbsFVX6MXcSYor3cHUwcBS9fwhZ+yvgnZxQrWLV2YrTKTlGxNNbCs4xlBnqE
         h0gmULSFbMjZ5mTCSZT0/qiha7h3Ydl6HgcMWw7jlimMQp63NBRg9pYjqGwgpfpnLbY9
         +LqJkiLdVGcBCdlZB8yysno2/MT7cVvmWMF5dclBDqJMmtA43K+DW+uZIYVbnoVBCAyO
         Tc5b6STfRusgHo3AZTUIpsKBB7LBcQdcB9CfVHa8L+j/4Cvxk0oFocfQE6Ss8IJlNgAU
         w/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dk4jHk9V8pKAO9UUtocjKNsOEWJO42Db7pR93uzxgG8=;
        b=h7PFjkBL87+ptX3ORQA6gEtL5EehLAJQ1HkZsmlRSVYR0zTKrVBLn3kbt5JyBCJa58
         m+lJbmdrXRqZ8N9+4f431U/Xfi8TZg1MA4gWwf+lcB5GnJSdWPRqhEQ8ej/tYBWrYQiw
         KBfVw56F7HBKgH44H+eruV76PhKpCXGWYUcVb9+zgi6Fb9UqgXknFHySw5mu3Op2KVTs
         PoopOI2rNJXWVkcOkb8NLjg8z+ma0bLlre0eZ+01NAu42915+dw8PMRqG34UI3MbAIzX
         dSmzsGMGB7VIwC5BG8mwB/pG7Mty3wPolmySssFJxCk5CMwEbixR+mDEsIXpvbpnlHf6
         qEQQ==
X-Gm-Message-State: APjAAAU1GY1ZnvWHZR4hvbtNnyfK9sl6FEgRbVwIJQHrgJxryoxwcAQv
        bkVNzE+Jgwge9ID3VRtARLIBrlQW
X-Google-Smtp-Source: APXvYqzqNq8RUde4XVK/ZmSR4RwBCuKxpBizkI1pDiIZqb5dqiEkLzQhv5Ngw5UgZ2PqcACDjhF9zw==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr10831000wma.62.1575637708456;
        Fri, 06 Dec 2019 05:08:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm15963252wrr.75.2019.12.06.05.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:28 -0800 (PST)
Message-Id: <ed870d34a8479366df786e76e2770df344469a41.1575637705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.172.git.1575637705.gitgitgadget@gmail.com>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:20 +0000
Subject: [PATCH 2/7] t3701: avoid depending on the TTY prerequisite
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The TTY prerequisite is a rather heavy one: it not only requires Perl to
work, but also the IO/Pty.pm module (with native support, and it
requires pseudo terminals, too).

In particular, test cases marked with the TTY prerequisite would be
skipped in Git for Windows' SDK.

In the case of `git add -p`, we do not actually need that big a hammer,
as we do not want to test any functionality that requires a pseudo
terminal; all we want is for the interactive add command to use color,
even when being called from within the test suite.

And we found exactly such a trick earlier already: when we added a test
case to verify that the main loop of `git add -i` is colored
appropriately. Let's use that trick instead of the TTY prerequisite.

While at it, we avoid the pipes, as we do not want a SIGPIPE to break
the regression test cases (which will be much more likely when we do not
run everything through Perl because that is inherently slower).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 4da99e27af..793ce28297 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -23,6 +23,17 @@ diff_cmp () {
 	test_cmp "$1.filtered" "$2.filtered"
 }
 
+# This function uses a trick to manipulate the interactive add to use color:
+# the `want_color()` function special-cases the situation where a pager was
+# spawned and Git now wants to output colored text: to detect that situation,
+# the environment variable `GIT_PAGER_IN_USE` is set. However, color is
+# suppressed despite that environment variable if the `TERM` variable
+# indicates a dumb terminal, so we set that variable, too.
+
+force_color () {
+	env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
+}
+
 test_expect_success 'setup (initial)' '
 	echo content >file &&
 	git add file &&
@@ -451,35 +462,38 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	diff_cmp expected diff
 '
 
-test_expect_success TTY 'diffs can be colorized' '
+test_expect_success 'diffs can be colorized' '
 	git reset --hard &&
 
 	echo content >test &&
-	printf y | test_terminal git add -p >output 2>&1 &&
+	printf y >y &&
+	force_color git add -p >output 2>&1 <y &&
 
 	# We do not want to depend on the exact coloring scheme
 	# git uses for diffs, so just check that we saw some kind of color.
 	grep "$(printf "\\033")" output
 '
 
-test_expect_success TTY 'diffFilter filters diff' '
+test_expect_success 'diffFilter filters diff' '
 	git reset --hard &&
 
 	echo content >test &&
 	test_config interactive.diffFilter "sed s/^/foo:/" &&
-	printf y | test_terminal git add -p >output 2>&1 &&
+	printf y >y &&
+	force_color git add -p >output 2>&1 <y &&
 
 	# avoid depending on the exact coloring or content of the prompts,
 	# and just make sure we saw our diff prefixed
 	grep foo:.*content output
 '
 
-test_expect_success TTY 'detect bogus diffFilter output' '
+test_expect_success 'detect bogus diffFilter output' '
 	git reset --hard &&
 
 	echo content >test &&
 	test_config interactive.diffFilter "echo too-short" &&
-	printf y | test_must_fail test_terminal git add -p
+	printf y >y &&
+	test_must_fail force_color git add -p <y
 '
 
 test_expect_success 'patch-mode via -i prompts for files' '
@@ -689,7 +703,7 @@ test_expect_success 'show help from add--helper' '
 	<BOLD;BLUE>What now<RESET>>$SP
 	Bye.
 	EOF
-	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
+	test_write_lines h | force_color git add -i >actual.colored &&
 	test_decode_color <actual.colored >actual &&
 	test_i18ncmp expect actual
 '
-- 
gitgitgadget

