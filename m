Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3EF01F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeBWXkR (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:17 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37183 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbeBWXkM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:12 -0500
Received: by mail-wr0-f194.google.com with SMTP id z12so15694307wrg.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aYHQnIfeIsCnPLbYnXBLj2hvBY6G61fUx/uGwpnhE9c=;
        b=O0A8z5MqeTLQ5tgtEgeNC+EmEYd0VCu9K1GFkBgb/UbVU2KukT8i/SVFkSD+UnJuIS
         L5QguJdgQ9uyWEDPcTT4mywxUKbcwV0P/S/9L8RsUfYee64XCpM9J17lktXfQGnqW8+y
         SaLnLwIRqmoI5Seij7xM3FQNOo8NrvoaVvTfxyFs/P+16UB+m4CcfPmtMX/YJYXLODhf
         SqGNDvK89g/kwgm8SKQB38eW5DQqz3hDeG4UIFjQczLv7yCwEZZNPkFL4hW8Lm1grtjw
         Gdek5BKdgw0sYM8klJgnHM5UHkX27MpjsuR1qB1FAxAvUJSpDpiryG0X5SdrdVZcClUY
         YhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYHQnIfeIsCnPLbYnXBLj2hvBY6G61fUx/uGwpnhE9c=;
        b=szJvctt2SmS0ESzxGfwE6Ctvd7r1Qk/PCHMH0xdBQiJ7KRkPgQkZIrj0L8L5iDYPz8
         G8UIfcu0O4IpBuJ5yqRJbIBZ+WNNOXX2S1aUAPdU0qR77+2CAeEVctr6jdcK/SmrHRha
         dtywYQ93sL3YItcqEwBf/TLDC9gl4z1IbG8rivjXBtWahfDoF1veUXgB7LjTr4gtyalv
         UdlXJyNRN3hweZxaUJhAltIg6ML20S5uBjjvdYcyfYdR9Fg+uW1jxeCcukF/d0ZzihgT
         SfH9xP4OMy8IACg0ghz8EjYhRdUat5UZjXujYWrjnSzmjdS0u5YiLz32m0eSNIE+QfI3
         M0XA==
X-Gm-Message-State: APf1xPBgZFx0QA2EEnF9HW4Hiv83FXwaLhnNc9xFQq5D7a/wSj9Lyt7b
        1x0njneh0VQJzJoDfYl9qh7Dtw==
X-Google-Smtp-Source: AH8x227DqBfxXqTUMlwhfRnn+bZTeyk1BeEQoXqP9qM8U+ZF0YnuPSkcG2dizkLcczuC5lYkPkoeqg==
X-Received: by 10.223.158.10 with SMTP id u10mr3227138wre.165.1519429211320;
        Fri, 23 Feb 2018 15:40:11 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:10 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/11] t1507-rev-parse-upstream: don't check the stderr of a shell function
Date:   Sat, 24 Feb 2018 00:39:43 +0100
Message-Id: <20180223233951.11154-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three tests in 't1507-rev-parse-upstream.sh' fail when the test script
is run with '-x' tracing (and using a shell other than a Bash version
supporting BASH_XTRACEFD).  The reason for those failures is that the
tests check the stderr of the function 'error_message', which includes
the trace of commands executed in that function as well, throwing off
the comparison with the expected output.

Save stderr of 'git rev-parse' only instead of the whole function, so
it remains free from tracing output.

After this change t1507 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index b23c4e3fab..2ce68cc277 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -42,7 +42,7 @@ commit_subject () {
 
 error_message () {
 	(cd clone &&
-	 test_must_fail git rev-parse --verify "$@")
+	 test_must_fail git rev-parse --verify "$@" 2>../error)
 }
 
 test_expect_success '@{upstream} resolves to correct full name' '
@@ -159,8 +159,8 @@ test_expect_success 'branch@{u} error message when no upstream' '
 	cat >expect <<-EOF &&
 	fatal: no upstream configured for branch ${sq}non-tracking${sq}
 	EOF
-	error_message non-tracking@{u} 2>actual &&
-	test_i18ncmp expect actual
+	error_message non-tracking@{u} &&
+	test_i18ncmp expect error
 '
 
 test_expect_success '@{u} error message when no upstream' '
@@ -175,8 +175,8 @@ test_expect_success 'branch@{u} error message with misspelt branch' '
 	cat >expect <<-EOF &&
 	fatal: no such branch: ${sq}no-such-branch${sq}
 	EOF
-	error_message no-such-branch@{u} 2>actual &&
-	test_i18ncmp expect actual
+	error_message no-such-branch@{u} &&
+	test_i18ncmp expect error
 '
 
 test_expect_success '@{u} error message when not on a branch' '
@@ -192,8 +192,8 @@ test_expect_success 'branch@{u} error message if upstream branch not fetched' '
 	cat >expect <<-EOF &&
 	fatal: upstream branch ${sq}refs/heads/side${sq} not stored as a remote-tracking branch
 	EOF
-	error_message bad-upstream@{u} 2>actual &&
-	test_i18ncmp expect actual
+	error_message bad-upstream@{u} &&
+	test_i18ncmp expect error
 '
 
 test_expect_success 'pull works when tracking a local branch' '
-- 
2.16.2.400.g911b7cc0da

