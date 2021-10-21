Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A74C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E2D61183
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJUDmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJUDm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:29 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F3EC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:13 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i189so27313015ioa.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpvvQvuQ18oOAqf45FNM/Vpxbukc7mObImDdLSArQWU=;
        b=guudpp4L1SCz9yoTm/hdc28swINKlC/cByuNHuZSu+XNwSw4qL2npsAPkxIJjjG5vC
         yENeJ8188iNMQToSqPCEPTEL8WO8B71vugdEFBgJGB1wC0ZVWc/++rPULFlGyTiCQLTg
         iSrgBlD95BhsUNCUQoOIEULAxPkWrv3UOEmsHNtyfdwDu7j1qq3aPNj2hc6bytDtjs0T
         +wiblTiJDR1OUhZylTr4j/CQ0yi7NNlo3wQK5lQV2RFsknp3VFweM005Jac6RjwqX37E
         HMj9J2Pldsbt2Etks+eBz7KjCamoQNMcUANnXisvtdI5QzKfPTXlJAgm3IwqcRlVOMAa
         VS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpvvQvuQ18oOAqf45FNM/Vpxbukc7mObImDdLSArQWU=;
        b=Einkm4ldhbjL052CVwhxzKPUhWWbNb3A5nwc0UVFFiIFphsCOxdnL1ZonSzicdBaOk
         wN4QC5byNp3+SDMm10z9iclT1HXe8V5zrdJzDm2/cK4FJG8a5fnVXIHknDC8B85l9ogt
         tvdFXd7cA/EzjH9KRUH0rEMHD7zCOifu/stSxnva2R/KoXJr7McjYejfN+pE3b3mIEaL
         xjP+VWSyKxjdOGQ6/8AFZWNLGYjXb1ZZOW+niDMbEIKoOdHuoC1K+DZfQ0rVKtkqj+p3
         yyU+q5+IiqS69CmUnUebJZPX1RFk9huoR9q31rFLBLEYlwR0IbaSrVok37aeyn2+1ZbM
         AvTg==
X-Gm-Message-State: AOAM533oFwQMjUymuQd1PoKAhk9cC3LBu2YR66UjOG5Tt3UX5aNohOiw
        YJgK6y61Jp8MlM6SLjIunb3A9fJ+C5ABng==
X-Google-Smtp-Source: ABdhPJzXv62O7jCUFes1Hfy7IhwrYMulfQllnlLeB+w6HkRJl/J5GM/6FeXdiH2QZlCyHgfCdPyPsA==
X-Received: by 2002:a6b:cd87:: with SMTP id d129mr2202694iog.28.1634787613182;
        Wed, 20 Oct 2021 20:40:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u15sm2013900ilv.85.2021.10.20.20.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:40:12 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:40:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 11/11] t5319: UNLEAK() the remaining leaks
Message-ID: <f1bb8b73ffdb78995dc5653791f9a64adf216e21.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This resolves the remaining leaks uncovered by running t5319 when
building with SANITIZE=leak. All of the leaks below are related to
allocated memory stored in 'struct rev_info' which is never freed.

We could alternatively implement a function which frees all allocated
memory associated with the rev_info struct, but doing this properly is a
bigger undertaking than I want to deal with right now.

Instead, let's just UNLEAK() the few ones that are holding up t5319,
which enables us to mark that test as TEST_PASSES_SANITIZE_LEAK.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/log.c               | 1 +
 builtin/pack-objects.c      | 1 +
 builtin/rev-list.c          | 2 ++
 pack-bitmap-write.c         | 2 ++
 t/t5319-multi-pack-index.sh | 1 +
 5 files changed, 7 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index f75d87e8d7..ad6dfacf77 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -757,6 +757,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	opt.revarg_opt = REVARG_COMMITTISH;
 	opt.tweak = log_setup_revisions_tweak;
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
+	UNLEAK(rev);
 	return cmd_log_walk(&rev);
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 857be7826f..6128a2e2a5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3759,6 +3759,7 @@ static void get_object_list(int ac, const char **av)
 		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
 			die(_("bad revision '%s'"), line);
 	}
+	UNLEAK(revs);
 
 	warn_on_object_refname_ambiguity = save_warning;
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 36cb909eba..df3811e763 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -549,6 +549,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
+	UNLEAK(revs);
+
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
 	if (revs.bisect)
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cab3eaa2ac..742bae4f57 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -234,6 +234,8 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 
+	UNLEAK(revs);
+
 	while ((commit = get_revision(&revs))) {
 		struct commit_list *p = commit->parents;
 		struct bb_commit *c_ent;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index a3c72b68f7..9cfc3d6661 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,6 +3,7 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+TEST_PASSES_SANITIZE_LEAK=true
 GIT_TEST_MULTI_PACK_INDEX=0
 objdir=.git/objects
 
-- 
2.33.0.96.g73915697e6
