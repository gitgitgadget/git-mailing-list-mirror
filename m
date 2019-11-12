Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07401F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKLAOE (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:14:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40504 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfKLAOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:14:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so10565298pgt.7
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gG2R8T2DeukWcWpEtd6fxUlg3W5wMJX6ub3CEerfX2k=;
        b=KYZ7RD7SsNuGTYmMGvswgkZ6mXmGW3pxrqK9ZaYnlXMGk52tZAfgAv7Wbq5udLjqC1
         OrNd1OekdZtDC4eEeWSi5Nn5a62vcGfZPGDARIhz3qcovnlSUYCiRaMugI/Kuh6OAYXa
         +Xb8KBYJHL1pmcTes7/HjCXKJTBh1hRB6FmwwypNg0/N1hUPtUPxHWHi9wqZHCDpYF3k
         7vMCrgU0FqQJWKXssAZApZdH8z1RhnHL25IESmAIekLw3Vv1p0/zysaa36gQ11Prgdw7
         ytj43iuMaECh/KfjsboJBrm80WmIEMiVhbGeZa6qRbhDesHAeAphVhT56vrk5VgRVKTE
         en/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gG2R8T2DeukWcWpEtd6fxUlg3W5wMJX6ub3CEerfX2k=;
        b=rzSG8py3QVFr+PSoB2OZr3EAXGJrnz0ODkA0ET+r3xnxK7TG89dL9VLf/wla86ef8b
         ZUuJfvHxRVRyq0AXryJ9K+pgYlZlbIb3a823R8qGDg+wdFdFKEph33xdg20m1kq6kt3m
         fQxCZBiSo+HQj7UFspgw1lY7mGqonrNWOZBiIrjXDvIwfwfvzb8pPJ5u7cMakU8m6/v+
         6Icp347pT5KVO0jOvqgk29GcP++FSfPd/QLIv8G2CYXMZWY4aVeH0fnw8qbbwqOPft/b
         TDkr74NrCh84mOJmssX9qvcxtiizFqCWpHqIzRMva3lKWdhSy9k2qk2D/BHc8c6oX6kl
         WCrQ==
X-Gm-Message-State: APjAAAWFozAazp64ObGsFWy6bmmu0IuMtmIZhCvHa2z3vuYeSGed2fPL
        3eZP9v56YUaorDKkBmR2GgKHW1w/
X-Google-Smtp-Source: APXvYqyzoTTWB3s+3r2jlWRxZZp6LkRHKGA3qvYA+Lfam22N9ofYen2l+oS2RbjGmxLgprrZzVXfGw==
X-Received: by 2002:a63:1065:: with SMTP id 37mr31449104pgq.31.1573517642363;
        Mon, 11 Nov 2019 16:14:02 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id p7sm14619762pfn.14.2019.11.11.16.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:14:01 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:14:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 09/14] t5520: use test_cmp_rev where possible
Message-ID: <3d437843919e84a056f3b8cab32cb745cc03cea5.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
 <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case an invocation of `git rev-list` fails within the subshell, the
failure will be masked. Remove the subshell and use test_cmp_rev() so
that failures can be discovered.

This change was done with the following sed expressions:

	s/test "$(git rev-parse.* \([^)]*\))" = "$(git rev-parse \([^)]*\))"/test_cmp_rev \1 \2/
	s/test \([^ ]*\) = "$(git rev-parse.* \([^)]*\))"/test_cmp_rev \1 \2/
	s/test "$(git rev-parse.* \([^)]*\))" != "$(git rev-parse.* \([^)]*\))"/test_cmp_rev ! \1 \2/
	s/test \([^ ]*\) != "$(git rev-parse.* \([^)]*\))"/test_cmp_rev ! \1 \2/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 18225d8430..1af6ea06ee 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -230,7 +230,7 @@ test_expect_success 'fast-forwards working tree if branch head is updated' '
 	git pull . second:third 2>err &&
 	test_i18ngrep "fetch updated the current branch head" err &&
 	test "$(cat file)" = modified &&
-	test "$(git rev-parse third)" = "$(git rev-parse second)"
+	test_cmp_rev third second
 '
 
 test_expect_success 'fast-forward fails with conflicting work tree' '
@@ -241,7 +241,7 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 	test_must_fail git pull . second:third 2>err &&
 	test_i18ngrep "Cannot fast-forward your working tree" err &&
 	test "$(cat file)" = conflict &&
-	test "$(git rev-parse third)" = "$(git rev-parse second)"
+	test_cmp_rev third second
 '
 
 test_expect_success '--rebase' '
@@ -254,7 +254,7 @@ test_expect_success '--rebase' '
 	git commit -m "new file" &&
 	git tag before-rebase &&
 	git pull --rebase . copy &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
@@ -266,7 +266,7 @@ test_expect_success '--rebase fast forward' '
 
 	git checkout to-rebase &&
 	git pull --rebase . ff &&
-	test "$(git rev-parse HEAD)" = "$(git rev-parse ff)" &&
+	test_cmp_rev HEAD ff &&
 
 	# The above only validates the result.  Did we actually bypass rebase?
 	git reflog -1 >reflog.actual &&
@@ -290,7 +290,7 @@ test_expect_success '--rebase --autostash fast forward' '
 	git checkout behind &&
 	echo dirty >file &&
 	git pull --rebase --autostash . to-rebase-ff &&
-	test "$(git rev-parse HEAD)" = "$(git rev-parse to-rebase-ff)"
+	test_cmp_rev HEAD to-rebase-ff
 '
 
 test_expect_success '--rebase with conflicts shows advice' '
@@ -328,7 +328,7 @@ test_expect_success 'failed --rebase shows advice' '
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
-	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
+	test_cmp_rev HEAD before-rebase &&
 	test_i18ngrep "Cannot rebase onto multiple branches" err &&
 	test modified = "$(git show HEAD:file)"
 '
@@ -380,7 +380,7 @@ test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
@@ -398,7 +398,7 @@ test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
@@ -407,14 +407,14 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_config pull.rebase true &&
 	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^)" != "$(git rev-parse copy)" &&
+	test_cmp_rev ! HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
 test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)" &&
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
@@ -422,7 +422,7 @@ test_expect_success 'pull --rebase warns on --verify-signatures' '
 test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)" &&
 	test_i18ngrep ! "verify-signatures" err
 '
@@ -443,8 +443,8 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase false &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -452,7 +452,7 @@ test_expect_success 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -460,7 +460,7 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase 1 &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -469,8 +469,8 @@ test_expect_success REBASE_P \
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
+	test_cmp_rev HEAD^^ copy &&
+	test_cmp_rev HEAD^2 keep-merge
 '
 
 test_expect_success 'pull.rebase=interactive' '
@@ -505,8 +505,8 @@ test_expect_success '--rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=false . copy &&
-	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -514,7 +514,7 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -523,8 +523,8 @@ test_expect_success REBASE_P \
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=preserve . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
+	test_cmp_rev HEAD^^ copy &&
+	test_cmp_rev HEAD^2 keep-merge
 '
 
 test_expect_success '--rebase=invalid fails' '
@@ -536,7 +536,7 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -597,10 +597,10 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	echo dirty >>file &&
 	git add file &&
 	test_must_fail git pull &&
-	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
+	test_cmp_rev "$COPY" me/copy &&
 	git checkout HEAD -- file &&
 	git pull &&
-	test "$COPY" != "$(git rev-parse --verify me/copy)"
+	test_cmp_rev ! "$COPY" me/copy
 '
 
 test_expect_success 'pull --rebase works on branch yet to be born' '
-- 
2.24.0.300.g722ba42680

