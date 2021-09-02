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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6970C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44E5610D0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344960AbhIBNM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbhIBNMr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C9CC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so1431727wmi.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+MfU27IONT+Wl4J/FjuVyKZH2u4lvpxIGcH8Z4NxD8=;
        b=R6e+76F1LCBLwNgS4yeR2vKGMcP5NAt1f0Heit2yfSJLvjf0V1fTctOYeFgLzwFCte
         ISRjURdhy8pGoxsF8veKgoqKPJ/1c+DLJH1A+0DBvHPF4RJGye6/3D9msmAslYjb7lVd
         XSaVZ8rnCHLk6gFJa7KmVJ16aqmeR12eGlIVmu9YSXmN617/Nt5+UKMgnhX26DIGtrmM
         eQ9/Pj8IBIl+oOOBX7GgmDoBtLZprWJLvxXXwYmDZF+0ZD+btsqOBytd4jdgHbM9n/cy
         WFNpjkTKS5ejltCCrxiT01fOCSXFFaSS6L/9DWgeGPhuPmGujXxoytoNRKTlplbAO8L3
         WfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+MfU27IONT+Wl4J/FjuVyKZH2u4lvpxIGcH8Z4NxD8=;
        b=AMQ65vZ+ELxYIBnfStvJasGS+v5AR6q7tuAW9UsHck/i7uReBpuXt3TWsMbRu8jqoA
         sFGZpSJK1vSnumnf6vCbJydgZSQjEeurTLtY05RDvNWyQHCpMjPJBhC4bcNsy5YF3oWi
         zJZhQ00ad8C6IZz+sEeJVZhD3N0fkD1HzKKpVBOwcoGsBVGV2Ot/xnklGnahrnuGXEPR
         LSmy1WVbqMYNz6/bs0SsLH5ejtT5Yshg3ReqvkkgoJpDOOCz1vDRgQsNkRB4bcEaRTZw
         jIhzQaQj7FgtDaT2nf128xutodBlMn27Axd/qNex5wfLDFBz5Lz+I2VqU92NoviYTWig
         y4AA==
X-Gm-Message-State: AOAM533LJlH7mbhUhyxETfQ1nkB7LKT8b5KvqAviYHJRfsbituRRVYMb
        bgt6A7D/K8gEGfItF/Wysyx38yvRNaItwA==
X-Google-Smtp-Source: ABdhPJwHVBhCnAm+N2PIKlkm8Dqer8slNbrpa3LgGUY+dPnGAMtfjYMh8vUJOSkhq9fkCNUQXa6ATw==
X-Received: by 2002:a05:600c:4f46:: with SMTP id m6mr3149096wmq.133.1630588307479;
        Thu, 02 Sep 2021 06:11:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:47 -0700 (PDT)
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
Subject: [PATCH v5 06/36] hook.c users: use "hook_exists()" instead of "find_hook()"
Date:   Thu,  2 Sep 2021 15:11:06 +0200
Message-Id: <patch-v5-06.36-e99ec2e6f8f-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the new hook_exists() function instead of find_hook() where the
latter was called in boolean contexts. This make subsequent changes in
a series where we further refactor the hook API clearer, as we won't
conflate wanting to get the path of the hook with checking for its
existence.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c       | 2 +-
 builtin/merge.c        | 2 +-
 builtin/receive-pack.c | 2 +-
 sequencer.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 26c8fad6366..f6ca9d04c78 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1052,7 +1052,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
+	if (!no_verify && hook_exists("pre-commit")) {
 		/*
 		 * Re-read the index as pre-commit hook could have updated it,
 		 * and write it out as a tree.  We must do this before we invoke
diff --git a/builtin/merge.c b/builtin/merge.c
index 2fc78f54e43..d75a438298b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -850,7 +850,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	 * and write it out as a tree.  We must do this before we invoke
 	 * the editor and after we invoke run_status above.
 	 */
-	if (find_hook("pre-merge-commit"))
+	if (hook_exists("pre-merge-commit"))
 		discard_cache();
 	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 97aebdc15bd..91fa799b66e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1464,7 +1464,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
 
-	if (!find_hook(push_to_checkout_hook))
+	if (!hook_exists(push_to_checkout_hook))
 		retval = push_to_deploy(sha1, &env, work_tree);
 	else
 		retval = push_to_checkout(sha1, &env, work_tree);
diff --git a/sequencer.c b/sequencer.c
index 3214f02f393..8999edf8d7b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1446,7 +1446,7 @@ static int try_to_commit(struct repository *r,
 		}
 	}
 
-	if (find_hook("prepare-commit-msg")) {
+	if (hook_exists("prepare-commit-msg")) {
 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
 		if (res)
 			goto out;
-- 
2.33.0.816.g1ba32acadee

