Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B22C43461
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02222613BE
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhEDQ2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 12:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhEDQ2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 12:28:48 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6DC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 09:27:53 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i8so4748639qvv.0
        for <git@vger.kernel.org>; Tue, 04 May 2021 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCCZkZB+9Ylm+ycwoLpyU0b64+dJciURMkmf5PJr15g=;
        b=c9s+mcExEOGC1hxOpM7AeSk3hbflTaQJrp0kJmRuAjSxEQjSYS6nVZyqGzzkFWujdj
         93GWxSKU+0SU8fbKUR613FQ8vZ6Aygl19bGD18HilhXDKNVLcEt8SylfKv+LYK6VIx/1
         mYBSAFLGl1N19Zv+xDof/iWbpM7T6nTgUc/OPsLZfbxoHhHDvtg/UCGBZZ4gXOXoKiHA
         I6gQpPLM1yoU65eWXiDsWDx2S8Hsr4/nzkl9JW7T/miucmee0eo/O/oDpxtZvDB38BF6
         /dDQPwrc7ilyRis17M2WLoeGpnT1Zht69Ws40k2XIKDdXoskjclWInN9psVmcfg4t1Wn
         2nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCCZkZB+9Ylm+ycwoLpyU0b64+dJciURMkmf5PJr15g=;
        b=nnwWrZuER9cnT8t8SloTyXESZTKWNVjzKvSmDwlqyGerkWIWvPA9B6Pll/QrWFhNxm
         l7IQ2M3rlkuga+50mL0C9fngP9atRS0kf4WzDdrd2t0wtfDMI5UBBmszI0rpENPFw03n
         jpmr/zLvYOPc/grjkRjAgXDXk7nHirZbh5jRkKyEFAyhHkGeBRdF5Bmk68C7SLbRfTBW
         pRv4JSJjd+87R+8O+jHBk+mfsm0Tdr1mX4PoOR6CoqvwtwNDXCe5IwFx6rUEjoTZecqU
         GO0evKjuRxEiFwNNZes95jYUVukGbCaEIMPXc5mJT1nHqYCV6fnq87kITcEYz3XH9qH+
         +nxw==
X-Gm-Message-State: AOAM532YgvBAHW3RE1P51k/mGdja0gR9+Tm/w9fKLEp9nqJ9MmWHbOXm
        Ag70aTlemCQZneSuvkW6BbslTgg2RO6YWw==
X-Google-Smtp-Source: ABdhPJzTsRfq/CUo1r3tz8rc7KWkSoONhkhd9Jqaz3OWlDNj5LpNSgc3KrvxmkmdE82a5e2I7GAi8w==
X-Received: by 2002:ad4:4081:: with SMTP id l1mr26606015qvp.24.1620145672272;
        Tue, 04 May 2021 09:27:52 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x19sm11202689qkx.107.2021.05.04.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:27:51 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        stolee@gmail.com, tboegi@web.de
Subject: [PATCH v3 3/8] checkout-index: add parallel checkout support
Date:   Tue,  4 May 2021 13:27:30 -0300
Message-Id: <916f391a46a1ccedee3fca52893d0339ff37864a.1620145501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1620145501.git.matheus.bernardino@usp.br>
References: <cover.1620145501.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow checkout-index to use the parallel checkout framework, honoring
the checkout.workers configuration.

There are two code paths in checkout-index which call
`checkout_entry()`, and thus, can make use of parallel checkout:
`checkout_file()`, which is used to write paths explicitly given at the
command line; and `checkout_all()`, which is used to write all paths in
the index, when the `--all` option is given.

In both operation modes, checkout-index doesn't abort immediately on a
`checkout_entry()` failure. Instead, it tries to check out all remaining
paths before exiting with a non-zero exit code. To keep this behavior
when parallel checkout is being used, we must allow
`run_parallel_checkout()` to try writing the queued entries before we
exit, even if we already got an error code from a previous
`checkout_entry()` call.

However, `checkout_all()` doesn't return on errors, it calls `exit()`
with code 128. We could make it call `run_parallel_checkout()` before
exiting, but it makes the code easier to follow if we unify the exit
path for both checkout-index modes at `cmd_checkout_index()`, and let
this function take care of the interactions with the parallel checkout
API. So let's do that.

With this change, we also have to consider whether we want to keep using
128 as the error code for `git checkout-index --all`, while we use 1 for
`git checkout-index <path>` (even when the actual error is the same).
Since there is not much value in having code 128 only for `--all`, and
there is no mention about it in the docs (so it's unlikely that changing
it will break any existing script), let's make both modes exit with code
1 on `checkout_entry()` errors.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout-index.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c9a3c71914..e21620d964 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -12,6 +12,7 @@
 #include "cache-tree.h"
 #include "parse-options.h"
 #include "entry.h"
+#include "parallel-checkout.h"
 
 #define CHECKOUT_ALL 4
 static int nul_term_line;
@@ -115,7 +116,7 @@ static int checkout_file(const char *name, const char *prefix)
 	return -1;
 }
 
-static void checkout_all(const char *prefix, int prefix_length)
+static int checkout_all(const char *prefix, int prefix_length)
 {
 	int i, errs = 0;
 	struct cache_entry *last_ce = NULL;
@@ -144,11 +145,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 	}
 	if (last_ce && to_tempfile)
 		write_tempfile_record(last_ce->name, prefix);
-	if (errs)
-		/* we have already done our error reporting.
-		 * exit with the same code as die().
-		 */
-		exit(128);
+	return !!errs;
 }
 
 static const char * const builtin_checkout_index_usage[] = {
@@ -184,6 +181,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, not_new = 0;
 	int index_opt = 0;
 	int err = 0;
+	int pc_workers, pc_threshold;
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
@@ -238,6 +236,10 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	}
 
+	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
+	if (pc_workers > 1)
+		init_parallel_checkout();
+
 	/* Check out named files first */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
@@ -277,12 +279,16 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
+	if (all)
+		err |= checkout_all(prefix, prefix_length);
+
+	if (pc_workers > 1)
+		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
+					     NULL, NULL);
+
 	if (err)
 		return 1;
 
-	if (all)
-		checkout_all(prefix, prefix_length);
-
 	if (is_lock_file_locked(&lock_file) &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
-- 
2.30.1

