Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B677C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F39D613E6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhE1MNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbhE1MN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F5C061761
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so4424949wmf.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xj8icIvejGwsanHl7uf5Vf1isdc38/vb+8pGosmEsUE=;
        b=HiXVbvt4aJ3G8Pc5ehaQ5/UTmAJWDFsk9Mg9v0l/nnDiB/iuBMXyyRF8E6CWlRT1HH
         4VNVWvTb9BB6XIoGVEKMtnLn/UmKw6AOViexU6t/YRhuqGpySSgzGdeUaCrw3MhdpHVK
         n0zAo72H1cYiJHtpg8jOBr5LshhNyQKC0yT84kPyC8zkrNBgGgUuV9TADzLy5qVyxQFQ
         Bs70idMM09A7kSjMvLQgjr25Q9mIkLJ2Zm77ZZFe7zIACJFZUa6ZPjLGIzVecBx17AzM
         lsNxrlTrTlCws09V4aA9J5VQZ8w/tnpT3u3OcnxeZkNtcYoMqGQQlzCTndFTPc9geaI8
         IkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xj8icIvejGwsanHl7uf5Vf1isdc38/vb+8pGosmEsUE=;
        b=SYr51oiMuzlU0qK+W1qWQHc865dLA6FzXghehr284UpWXVYkinDF9LtHq2S6hy7V2P
         9PLgoam1ezhnv41A8dTqZqhK7QtRNwZcqXjhjVcEBG1B1ShU6RZKchXDDSboyI60DTc8
         P4GX+8P2T13COLqEWKQhF/hU+NAhtImIeo3pBoZjBaozliJJbpvv1TreW9SLfIq2Z1Ic
         vJSq7Yhlw9MuH/DfWuvWcauxKiKWWeLXdRwdGs9g4sAPq4LbRAmuJMyH0Px0fFnt6iiC
         GhiGVCHP3a0cGAG19KhynJvCZzU21GKc+7nRWRyQcJmjGvYoQiXnylpphUxe437KzoCL
         Xvfw==
X-Gm-Message-State: AOAM530mQA5gqZAXyTplsuyLoRT9WUiFYDGLwFSuWlPBQMSP6dy4qYCl
        j4KdBr3GQhHpHJ8POTy2lU+PPwYhAMbwrA==
X-Google-Smtp-Source: ABdhPJwTLETYPPSA0rFpI0nzfavKHfDdOGmUgZiqYykv+iIil0CZik0Rb5NwHqkKexlu/TN1NjCtLg==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr8020319wma.171.1622203909580;
        Fri, 28 May 2021 05:11:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:49 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/31] merge: use config-based hooks for post-merge hook
Date:   Fri, 28 May 2021 14:11:12 +0200
Message-Id: <patch-10.31-201c654bb0c-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
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
index 5a10f6e3c96..a9363b94065 100644
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
2.32.0.rc1.458.gd885d4f985c

