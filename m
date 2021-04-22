Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59F3C43461
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1DE6144A
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbhDVPSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbhDVPSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:18:42 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418AC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s5so37857274qkj.5
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TaxKTevRj9KNItutE8NJIJeb/G3/fDBUHsrFXaVnfbw=;
        b=BBdjEBjSTdrCf0uYxVu1FqQKsaAdTis6HUSxE+lJHt3AkabcyGaTTjAFzBk6KuJ9Yz
         omHAMQPjxUprpgNOQaH8F1TVKTQsdiW8yD1pvP7TN06+r7NNofWDH+4cCB+DvStr3wO3
         oOkUO069FzmS6DzGHX1i27dDN7/tHiJ/ECKECaIeuQenSBBJ7GNjZ8VT86zVmpbKQ8/X
         YRaG/HRVAYx3JwpRYXgIOOfFxa3wA59V6G6qe2nrNXQ5eiQ0+/2QSYwfN1HSsQu0Mn+D
         ymlpXxaHffseiG0NG4I2UOMqbCpUw916iQnJfc+40bPoF4iD1nJOPTIbRIEXkN1kIpL0
         21mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TaxKTevRj9KNItutE8NJIJeb/G3/fDBUHsrFXaVnfbw=;
        b=qDDrS1vTX/jBe4FRLk6r4kOKfZgiqtp3dZWaxxikQHRpHH8oP4TObqgo/pCm3KQ/Pn
         0w39Ubebykz0gdcV6Fxp8g2qc0mOHhSXX2y4igS8ZXpgqB2VUEUobCmNtCHcZaNHfXGZ
         B5jognf/zMigkpCRyKPHB9by6JN9MxAqPAMKhRTJIxY7Z3CPfKkpzUK0R6tVU5BFkLKa
         h7eFihwPsmmqCyXaNTLu0DDcjnnAGJ7MUTA4pndFRFgDM0fDzEii5hZsDSlJYG0FYRvH
         xr9kmTLJox9fFoOEdq0LSR1IxVqOwW9eXhm/galbSiOdIKj328hN338I6S1tTOlSpSgN
         oFSg==
X-Gm-Message-State: AOAM533NpxBbnjQDQD/g/AlnwJ2kqi6S6+lipiRlFUODJPqCf0xyl3i6
        gAPBGFhXbuTmsp3gowXwVMKhsx2/+g4pgw==
X-Google-Smtp-Source: ABdhPJxMaciAYSFVC0glQzBQ6YG5saYIvHeUofppLRV0gxtM4tbLsUyk7NR8GB1M8zj+h5Ye8KrbcQ==
X-Received: by 2002:a37:b103:: with SMTP id a3mr4287855qkf.261.1619104687203;
        Thu, 22 Apr 2021 08:18:07 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id l16sm2348909qkg.91.2021.04.22.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:18:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
Subject: [PATCH 3/7] checkout-index: add parallel checkout support
Date:   Thu, 22 Apr 2021 12:17:49 -0300
Message-Id: <6bf1db2fd8e807f9f259787ef75651d43b61e03a.1619104091.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619104091.git.matheus.bernardino@usp.br>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
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

