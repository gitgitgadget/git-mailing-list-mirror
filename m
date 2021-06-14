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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD2C4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A13C61451
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhFNKi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhFNKgi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5984C061145
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f2so13966462wri.11
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxTOlilJr02pS+bL23nf+Nd5rH4EnQu2BKg+lQcykEA=;
        b=obtgBGnxvBBixR64vhi2HPAyxwyNd5TyemL0H3bDXHCpah2RbjeTN3J559xfy9unDR
         9tDVuIlYkPoGI7it/tZHwzwIGT64XbnQ21KCNb57ZNl+dEGH5Q83WdNVQ9lzbIax/9TO
         pFrVODPU7L2NXNUf5lOjelJvI3/BpwzOu4OtWWobqo21vfosgBNlWPjqOMMdVOh0HyPJ
         IO3ffi6ywm2YXKVbsVOnsZfnH0uWCl26Cic+Y9TwfaTrR+a71MWLcKojho6h/CEvnPE8
         xuYmeJzVLvR668SGTfRMLH8wVO27HesEBEfAkdMeX3xaSzeVGKvqwhzsS3uZOdl8zxSG
         nssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxTOlilJr02pS+bL23nf+Nd5rH4EnQu2BKg+lQcykEA=;
        b=bmFs7bMpkpPwOt6lm+TUIdCC10R5WW47obyjcnk0rgKXnH7+/Pb0Q5K/KlkIeFVLP7
         dztNHwWDheJQnB8548EfjcJswVoIwlXWDXT/+rqTXD7fR9dggBKPOB2pSWd7bPHlNf9R
         xa+yjsaDWt50z9GKmAD82oH3A7Ff2VavbM4AsqojVdmvkwHKHcL4bN0W93vO9DMRRLXG
         AGXjuct6DA15ARR741C7aDIE+Wzh9iWYyBiA7/CA6bx1was29lBQQVjP0YsRIiFgZjWP
         DuvR03QY6MzjKqlSHNGy05ip8D/PpCk9mJCnB+539X7Q6iJ1kiX9yMZj/J5DTu9iCxKv
         N7Uw==
X-Gm-Message-State: AOAM530ktUeDCRy10sc0SbS9YdYN5sByouTWvSFlrLcIhkxx5/RjspIK
        uihwJIm1Pc1kvFWe565qDW9z4/UQ62vN+w==
X-Google-Smtp-Source: ABdhPJy9ep3kjdl3q6SADT2D9v4WMGO2L9C5Ph97ZCmctQneVFG5t4bzp3U+W93ns6GOlayypgOECQ==
X-Received: by 2002:adf:c442:: with SMTP id a2mr17850913wrg.277.1623666831394;
        Mon, 14 Jun 2021 03:33:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:51 -0700 (PDT)
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
Subject: [PATCH v2 08/30] merge: use config-based hooks for post-merge hook
Date:   Mon, 14 Jun 2021 12:32:57 +0200
Message-Id: <patch-08.30-ad6e7507841-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
index be98d66b0a8..6128b60942f 100644
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
2.32.0.rc3.434.gd8aed1f08a7

