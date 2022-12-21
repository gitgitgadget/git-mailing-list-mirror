Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88238C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 04:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiLUEFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 23:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiLUEFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 23:05:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1CD17E06
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y8so737047wrl.13
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 20:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qw18Se/n5FS5WvsxAGh1hXZyZ8m6t3Ryt3oHM1GO9J0=;
        b=gYHHevw9VEN91hK+i9wwKYaOYDvYuCJPHimyqMnaBCDKgNvBmU4M/d2tlpyKs2n2tr
         ejDFBMhUOYrVGj3L6lXlMoG9Q27ePUib8w3VWZJfVbso8hxIQ9FVHBR9rQ806VnN34u1
         xEiKGNpz4NMx1xKnbJtVdjkMHTmvP7QmArfu8kgVMx5aAYIZXFDZnwAnrZ3jo1mXcck+
         QamACTPBDqYfpAplBZNpWuQi6AkZ07UL8lSkeTweB5eqHHfMsRGnwjk0T7V4v4UjTVXW
         pPB/MPNit8gzvtmeE+d7fJN0s+dYOkyfqh5PZqLR+iEb/RHMu5fGhPAxiuMKqp7C5RQJ
         Kg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qw18Se/n5FS5WvsxAGh1hXZyZ8m6t3Ryt3oHM1GO9J0=;
        b=SeM2Q+m4hcV5DmBn91Bv1DqN6N26lnDVqWzyca0TnVM9crroukR4BpwAxP2O07aGu2
         sS/Zn15Gl/0huqm9ey0fMChsrcDXzZxnZXCX0opshktzfR7hg2ZRq7M7E1GUPJlGYOK3
         jDmlCVY+hikKNvIqzgUcHnruWk0ow+ZNDVbZAKJByDKQT5nD5MCs5CVkYMAMEYnK9A7H
         4FJMl+u+h5uJgxaI7WTPiBMLNE/WVNKt/CAIuGAl7vw4X/8GQTelGycMLA1KqLNACPAr
         ExAZix1zn9KZ+SeBLtSH3DtFbWfAX6e6mADl3VYrnuGOyzCSN8cVW59Ctq6/xCC9AsbP
         bKuw==
X-Gm-Message-State: AFqh2kqopDARtb3g297Nlc715I8sZBB0IUQ0n08cVag+/s696vRcVCXZ
        mBOasbZSLjVM/XSet195x6KEq7IAjFY=
X-Google-Smtp-Source: AMrXdXu/lRkxw69lZZFIpEQLd5YaUDpEIKFw1/uzIXLb1h+GKW0p6DSiciaRB/OoW5U1Lkox4MKK8A==
X-Received: by 2002:a05:6000:18cb:b0:242:63e5:2451 with SMTP id w11-20020a05600018cb00b0024263e52451mr2573828wrq.71.1671595508656;
        Tue, 20 Dec 2022 20:05:08 -0800 (PST)
Received: from Precision-5550.. ([2a04:cec0:1195:e411:35ab:b445:697e:1e87])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d4e09000000b00236c1f2cecesm16462298wrt.81.2022.12.20.20.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 20:05:08 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/3] gc: add gc.repackFilter config option
Date:   Wed, 21 Dec 2022 05:04:46 +0100
Message-Id: <20221221040446.2860985-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.39.0.59.g6bb98b4b00
In-Reply-To: <20221221040446.2860985-1-christian.couder@gmail.com>
References: <20221122175150.366828-1-christian.couder@gmail.com>
 <20221221040446.2860985-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit has implemented `git repack --filter=<filter-spec>` to
allow users to remove objects that are available on a promisor remote
but that they don't want locally.

Users might want to perform such a cleanup regularly at the same time as
they perform other repacks and cleanups, so as part of `git gc`.

Let's allow them to configure a <filter-spec> for that purpose using a
new gc.repackFilter config option.

Now when `git gc` will perform a repack with a <filter-spec> configured
through this option and not empty, the repack process will be passed a
corresponding `--filter=<filter-spec>` argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/gc.txt |  9 +++++++++
 builtin/gc.c                |  6 ++++++
 t/t6500-gc.sh               | 19 +++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 38fea076a2..9359136f14 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -130,6 +130,15 @@ or rebase occurring.  Since these changes are not part of the current
 project most users will want to expire them sooner, which is why the
 default is more aggressive than `gc.reflogExpire`.
 
+gc.repackFilter::
+	When repacking, use the specified filter to omit certain
+	objects from the resulting packfile. WARNING: this could
+	easily corrupt the current repo and lose data if ANY of the
+	omitted objects hasn't been already pushed to a remote. Be
+	very careful about objects that might have been created
+	locally! See the `--filter=<filter-spec>` option of
+	linkgit:git-repack[1].
+
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd7..bf28619723 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -52,6 +52,7 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
+static char *repack_filter;
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
@@ -161,6 +162,8 @@ static void gc_config(void)
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
+	git_config_get_string("gc.repackfilter", &repack_filter);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -346,6 +349,9 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
 	if (keep_pack)
 		for_each_string_list(keep_pack, keep_one_pack, NULL);
+
+	if (repack_filter && *repack_filter)
+		strvec_pushf(&repack, "--filter=%s", repack_filter);
 }
 
 static void add_repack_incremental_option(void)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index d9acb63951..b1492b521a 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -56,6 +56,7 @@ test_expect_success 'gc -h with invalid configuration' '
 '
 
 test_expect_success 'gc is not aborted due to a stale symref' '
+	test_when_finished "rm -rf remote client" &&
 	git init remote &&
 	(
 		cd remote &&
@@ -202,6 +203,24 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
+test_expect_success 'gc.repackFilter launches repack with a filter' '
+	test_when_finished "rm -rf server client" &&
+	test_create_repo server &&
+	git -C server config uploadpack.allowFilter true &&
+	git -C server config uploadpack.allowAnySHA1InWant true &&
+	test_commit -C server 1 &&
+	git clone --bare --no-local server client &&
+	git -C client config remote.origin.promisor true &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep -c "^?" objects) = 0 &&
+
+	GIT_TRACE=$(pwd)/trace.out git -C client -c gc.repackFilter=blob:none -c repack.writeBitmaps=false -c gc.pruneExpire=now gc &&
+
+	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out &&
+	git -C client rev-list --objects --all --missing=print >objects &&
+	test $(grep -c "^?" objects) = 1
+'
+
 prepare_cruft_history () {
 	test_commit base &&
 
-- 
2.39.0.59.g395bcb85bc.dirty

