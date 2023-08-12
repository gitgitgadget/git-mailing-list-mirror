Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C75BC001DB
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbjHLABA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbjHLAA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:00:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425019AE
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so1907518b3a.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798453; x=1692403253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0om6oTRhRZlYIB5yxY0zTqTBjQ35baScSmZNkTE/e7M=;
        b=GEqhNl3NeRsDVvoqOFuT7L1lhw9wp7vv8aEvNAGJL6/cnjtljDapAmEBHqccdfPctZ
         4uA0FXWmEMyz3W2glPvhtiXQ+usOHCk6Vhqt7GalyYO9hkC47b8anMWA2LUktPLuaaJK
         TAhXxm/R+gut7GW4qWgUygF5oBtkyOJ70g+bQtbilOIO2+gcZ932o2xovJflPiddeU+Y
         PwhpdfbfL4O9CgbeU55+wfcjGV2uCeE5H+es2zST0fmlBh1csn1MPIBBmWMMB9WUfXE/
         aRWtC4St7VniiGf8Jsjtx3Nt5MJmG+bB7uUI19v8jAxc3Hbb1HfYCWcMkYG4h/fQ9wcd
         NLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798453; x=1692403253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0om6oTRhRZlYIB5yxY0zTqTBjQ35baScSmZNkTE/e7M=;
        b=HEkV/OExRrzh2gIO1jIZXlqongqpEklxkRaD/jB11kq+meHx1+QbLleWxNbhzh0wqe
         oyp1jFwOAUfXImaubIUxMCxnGwabUoNwzz0w59NX5SBpQFBw8kg6ABHzWa/Iy6pxCN53
         BekJ1MhwoL+WUmtPJnJ5phj5/UhalhJIrH8LZzqe4ZUbngB5BXw+i+OXYrudBA/PH/M0
         SvOhJavV2+zq0iUKuL8t6rLST0G/TaNngvudLYgzULjpi2CwvNpO4weoB7+yw45DjYtt
         JAZCUi1o2vUwUzXpwa23WLHwzNPoLDLOSWRbfFX46FO4Py8ww83cdebT0dstTmsWqGNG
         gxRw==
X-Gm-Message-State: AOJu0Yxq3EjMNlzVLqOE8hp4+H2ZTdA3+wE9zuD2MZqBkzm3cvowwn1s
        xWz4ETS/bAam2HLUTqxukRUYe6oLnrYxBg==
X-Google-Smtp-Source: AGHT+IHd0C0c6JkRlCwvJOiQgFzFhhZhPZIcBCh4cTnG1msa6RaQ2+f4CRBzxikbqvRuBkcBC4zw7w==
X-Received: by 2002:a05:6a21:4847:b0:137:8ddf:464b with SMTP id au7-20020a056a21484700b001378ddf464bmr3149860pzc.36.1691798452651;
        Fri, 11 Aug 2023 17:00:52 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 6/8] gc: add `gc.repackFilter` config option
Date:   Sat, 12 Aug 2023 02:00:09 +0200
Message-ID: <20230812000011.1227371-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit has implemented `git repack --filter=<filter-spec>` to
allow users to filter out some objects from the main pack and move them
into a new different pack.

Users might want to perform such a cleanup regularly at the same time as
they perform other repacks and cleanups, so as part of `git gc`.

Let's allow them to configure a <filter-spec> for that purpose using a
new gc.repackFilter config option.

Now when `git gc` will perform a repack with a <filter-spec> configured
through this option and not empty, the repack process will be passed a
corresponding `--filter=<filter-spec>` argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/gc.txt |  5 +++++
 builtin/gc.c                |  6 ++++++
 t/t6500-gc.sh               | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index ca47eb2008..2153bde7ac 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -145,6 +145,11 @@ Multiple hooks are supported, but all must exit successfully, else the
 operation (either generating a cruft pack or unpacking unreachable
 objects) will be halted.
 
+gc.repackFilter::
+	When repacking, use the specified filter to move certain
+	objects into a separate packfile.  See the
+	`--filter=<filter-spec>` option of linkgit:git-repack[1].
+
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
diff --git a/builtin/gc.c b/builtin/gc.c
index 19d73067aa..9b0984f301 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -61,6 +61,7 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
+static char *repack_filter;
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
@@ -170,6 +171,8 @@ static void gc_config(void)
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
+	git_config_get_string("gc.repackfilter", &repack_filter);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -355,6 +358,9 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
 	if (keep_pack)
 		for_each_string_list(keep_pack, keep_one_pack, NULL);
+
+	if (repack_filter && *repack_filter)
+		strvec_pushf(&repack, "--filter=%s", repack_filter);
 }
 
 static void add_repack_incremental_option(void)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 69509d0c11..232e403b66 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -202,6 +202,19 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
+test_expect_success 'gc.repackFilter launches repack with a filter' '
+	test_when_finished "rm -rf bare.git" &&
+	git clone --no-local --bare . bare.git &&
+
+	git -C bare.git -c gc.cruftPacks=false gc &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+
+	GIT_TRACE=$(pwd)/trace.out git -C bare.git -c gc.repackFilter=blob:none \
+		-c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&
+	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
+	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
+'
+
 prepare_cruft_history () {
 	test_commit base &&
 
-- 
2.42.0.rc1.8.ga52e3a71db

