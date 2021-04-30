Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674D6C43460
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A3610EA
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhD3Vlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhD3Vli (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:38 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C2C06138B
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:49 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h3so34426383qve.13
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaxKTevRj9KNItutE8NJIJeb/G3/fDBUHsrFXaVnfbw=;
        b=GgeF+CjNUcc4cbN8nh0tFm3jFjVGt9P1oH+cpkpsRtWmUF0OrxQY4CO3EQvA3fBkv5
         8gx93IhohEfOEWIvcWrEogwV0HIBY1Fe+7EoB2g8E3YAW8h3EHBXLk6hhP3XYD9JgYdc
         uICU20O46Whwt3jAPMu/OzcrYCelgLSRxEJ3wzG91NWC0AOKEceZqmYg1XxJKXQuRN8N
         J/WJwzTg5LmE7T5FdmW8DychP1N39AUta6DAF0lK1kTub3ngI2GnbnAChHrGi+3WV2GZ
         UfLIBd7h2I3Xn2yh1x7tkwZXJPYpjgFrIddl9koBvVkD3xerL6y6Lj9XVY3kSupt7axe
         AwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaxKTevRj9KNItutE8NJIJeb/G3/fDBUHsrFXaVnfbw=;
        b=etDiHzGV5AVO7vPYqFuGIYKA+5HsiYegLJNi5e50DA+rYxeac5gzKGS7SUUvZLF+oJ
         wJi0KvXm6PlXVjKQlkhvqdMvxWJyUygrtWHU3OKWKb3RLThd94rBknHmEhs++3yJA2rP
         VCPpWEA/03cZsPQVVBOwuBvvIQPZaRoFFErRTpom6l37MWknbqlO1qz6SNAsUu33Fs8A
         zepG5AqOiHjONhemmNCWji73fAYlzL6esZuN/gJoUFJlSQEqslWX1dbrQ2esfGaLFMXs
         VqTgfv/cb6LT/HVzEJ81cfAni3b85XR6vESGIiWnGBGPpZWjHpsb5ajYjKpr8nR8Y7Du
         X+LA==
X-Gm-Message-State: AOAM530pW1+TWphAeZHfZcglcn5HRiYnCwr+Rzd7FC+2wcm42XWV8KAS
        z5gyOaKfrbcHIJgtJViqKB02WLnhjq0edQ==
X-Google-Smtp-Source: ABdhPJxZlH51x5b+psK0jBUCKIyV18YfJxtX9i3KHtG3Hh3DmAeYJjydqELYeqGP3oi9+BeBBV/Gdg==
X-Received: by 2002:a0c:e8c4:: with SMTP id m4mr7646388qvo.21.1619818848598;
        Fri, 30 Apr 2021 14:40:48 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:48 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 3/8] checkout-index: add parallel checkout support
Date:   Fri, 30 Apr 2021 18:40:30 -0300
Message-Id: <0fe1a5fabc8cb5f7c2421afaefae030d399d28ed.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: previously, `checkout_all()` would not return on errors, but
instead call `exit()` with a non-zero code. However, it only did that
after calling `checkout_entry()` for all index entries, thus not
stopping on the first error, but attempting to write the maximum number
of entries possible. In order to maintain this behavior we now propagate
`checkout_all()`s error status to `cmd_checkout_index()`, so that it can
call `run_parallel_checkout()` and attempt to write the queued entries
before exiting with the error code.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout-index.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c0bf4ac1b2..e8a82ea9ed 100644
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
@@ -142,11 +143,7 @@ static void checkout_all(const char *prefix, int prefix_length)
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
@@ -182,6 +179,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int force = 0, quiet = 0, not_new = 0;
 	int index_opt = 0;
 	int err = 0;
+	int pc_workers, pc_threshold;
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
@@ -236,6 +234,10 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	}
 
+	get_parallel_checkout_configs(&pc_workers, &pc_threshold);
+	if (pc_workers > 1)
+		init_parallel_checkout();
+
 	/* Check out named files first */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
@@ -275,12 +277,16 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
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

