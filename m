Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569DC49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BD361263
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhFQKZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhFQKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A6C061768
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d7so3339328edx.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEFqbkcyoN1dYwRjQG/l3c7WOwsfBIe/4hyHq1K4CQA=;
        b=EpIM9utIc3onG4Pxfxtrg2x+aJCR6OUDtldRPcljvN4XNOTUO+OsIpzLOHb9ucNk17
         kp2o5oDsEGS+y/2D/LbeL1UzkuaTDVFC+HtJsun8fMUfqzDwDxlIPRY/fZT2zEoAAbWW
         VDSo8dayOTiW0MDBIHAtsLlZa+U4Tn8N2Phk2CEaP6x6DQ+BsrcQimXbClkaWABY/co0
         o5CQgEHDMH8AXFZH7bnI0Knz401cgUIxOjMJXV/GrRFbv9X6Nex0TcYSsfwK1dj8eCCy
         VEA1E7ixTseII5kxjVQ0nM+QDuM+jkjqfLVOJYDeVY75Yi49yPPBQwVbis43xjxeRPfU
         y1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEFqbkcyoN1dYwRjQG/l3c7WOwsfBIe/4hyHq1K4CQA=;
        b=Wje90wXql/JT5GihmwmZJPfXH7BAIIGSOgGFzbePfMdO0sAXDq6HH58mzpLLPWD418
         f+W6WE1foG917Bqvf5MNNw5JGN2GVoNW/V7Tyeh7fxGIPltm9OWdmvsILMSguaBfY/z6
         nt+1nODqMBI4J5YfNz5ubYpIVsxGcKMcUyhIfwmOcB1UH4NtNa167Y3mvoD6AaKnSg0V
         BQD7VhK/pvWxbzjdBghfXn4EbbKOusBdkvXl4I7nS0g4OI5WXQCLzCJ/3xifxwZLJ/GS
         9PA2rikj9gzkUuiSGlfALgvK8+cIruJAXWIoA5nvVuJ1sdThvIHFL9ieGR0ky2KHmjew
         4sKA==
X-Gm-Message-State: AOAM530+0IxwNCIVT1E+687LdQprLZRT+TRnmhycPzXFimi3Ixvemetj
        zOHVU11NaFt6E10YJ5GgO1q12UinVZUYsw==
X-Google-Smtp-Source: ABdhPJw1ynPnx7UNw+I5gsvqBxuvt13gqeKbjEjfmvQS6plVwKO+IxA2Em7wGcqYc+O3MxdCrwmzeA==
X-Received: by 2002:aa7:c845:: with SMTP id g5mr5489761edt.306.1623925393845;
        Thu, 17 Jun 2021 03:23:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/27] merge: use config-based hooks for post-merge hook
Date:   Thu, 17 Jun 2021 12:22:40 +0200
Message-Id: <patch-06.27-e9fa3f6759-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach post-merge to use the hook.h library instead of the run-command.h
library to run hooks. This means that post-merge hooks can come from the
config as well as from the hookdir. post-merge is invoked only from
builtin/merge.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index be98d66b0a..6128b60942 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -448,6 +448,7 @@ static void finish(struct commit *head_commit,
 		   const struct object_id *new_head, const char *msg)
 {
 	struct strbuf reflog_message = STRBUF_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	const struct object_id *head = &head_commit->object.oid;
 
 	if (!msg)
@@ -489,7 +490,9 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	strvec_push(&opt.args, squash ? "1" : "0");
+	run_hooks("post-merge", &opt);
+	run_hooks_opt_clear(&opt);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
@@ -849,7 +852,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit"))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
-- 
2.32.0.576.g59759b6ca7d

