Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 479F31F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeAZMh3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:29 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37541 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeAZMh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:26 -0500
Received: by mail-wr0-f193.google.com with SMTP id f11so410866wre.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvhcmLmnSFbQtakXmdwnRQEWZrM/3qrgej0xOzD7SCc=;
        b=PqWrwWghz7k4QG8WC9CS8zb9rv9ccYupKlJGkq8jZiJ/7AAY1eIs3Nmilmp5mmcYhV
         C1uHpxUdQTwFsxd0qlpZAGzuxwZ9Z9nEde51zBcjAhnzkgUj0GA8fP1LqfFrj6dAhCEY
         BdTsAUGnvng48nzTuSX2/BN3vIF8bc0EAtN2JLWL+jVAkqEOov+rIjJ2Nv+2I/0E+UOp
         N6kKGMqxr78eJe1ozAhTsvpHpR4nxp9NhhgVi4ZO3YtE0QKtIOjphJYLh5Ih2UVGmuXx
         6Vo0NoKArZ+yGxG0YHVteyezHx82alRL4fBi7BLdniNnzF537ZU1JPs3kq/SCFlp5kKC
         nF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvhcmLmnSFbQtakXmdwnRQEWZrM/3qrgej0xOzD7SCc=;
        b=XOr7QLX+nuFStW03VMJNKyfsfouxuQ9W1RnWBYtmoa6eNfq8IYpOqZUOGNKT7WWmns
         UlIkJBqjYw82hqTv+IOCddLPvqvk/H6nIIYtwJD54lYRi6SRQdby3oXJm2VD9U/EEVWh
         CSWQ9bj8F/6ivWaQ1JiJIbZHngMkuXU98Svlxo2XOJKqWfWaDLoeo8YMY30+hVocXAOQ
         HM7fW8sbfKDCmt0t+pjkMPk4Um0V8jcpEOWtdAgENy0rU8ht/tZEN4oToAjfbEB3wDaP
         ztW1vfgApGb+/DY8NI2fusiE96GsuyJ128QLLvcBBxzGWO3nvW3P00TUwwOttOqY4eXU
         53HQ==
X-Gm-Message-State: AKwxytdXQNucH0rrKuoqhjpI2+3weYnv8Yz/YOwLAPleYzFZWW9igMfN
        QToyhjTlvoYly4mmw41Fb2YG4A==
X-Google-Smtp-Source: AH8x225k+wWRGplsZvaX7C0frk+WlDBAaV6RRnWhi5RauXXGqt6cao9kjRgAQcl4pFsbnrnLpGc0Ww==
X-Received: by 10.223.208.132 with SMTP id y4mr11382581wrh.141.1516970244955;
        Fri, 26 Jan 2018 04:37:24 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:24 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/10] t4001: don't run 'git status' upstream of a pipe
Date:   Fri, 26 Jan 2018 13:37:02 +0100
Message-Id: <20180126123708.21722-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The primary purpose of three tests in 't4001-diff-rename.sh' is to
check rename detection in 'git status', but all three do so by running
'git status' upstream of a pipe, hiding its exit code.  Consequently,
the test could continue even if 'git status' exited with error.

Use an intermediate file between 'git status' and 'test_i18ngrep' to
catch a potential failure of the former.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t4001-diff-rename.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index eadf4f624..a07816d56 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -134,11 +134,15 @@ test_expect_success 'favour same basenames over different ones' '
 	git rm path1 &&
 	mkdir subdir &&
 	git mv another-path subdir/path1 &&
-	git status | test_i18ngrep "renamed: .*path1 -> subdir/path1"'
+	git status >out &&
+	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+'
 
 test_expect_success 'favour same basenames even with minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
-	git status | test_i18ngrep "renamed: .*path1 -> subdir/path1"'
+	git status >out &&
+	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+'
 
 test_expect_success 'two files with same basename and same content' '
 	git reset --hard &&
@@ -148,7 +152,8 @@ test_expect_success 'two files with same basename and same content' '
 	git add dir &&
 	git commit -m 2 &&
 	git mv dir other-dir &&
-	git status | test_i18ngrep "renamed: .*dir/A/file -> other-dir/A/file"
+	git status >out &&
+	test_i18ngrep "renamed: .*dir/A/file -> other-dir/A/file" out
 '
 
 test_expect_success 'setup for many rename source candidates' '
-- 
2.16.1.155.g5159265b1

