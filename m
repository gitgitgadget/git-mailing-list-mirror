Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9493C001DB
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbjHLABD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbjHLABB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:01:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0F171D
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:01:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bb7b8390e8so18780435ad.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798460; x=1692403260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEBJbf6/3phuZ6h9in+X12qWnHu3Bx/RG3Utf7mBgQU=;
        b=VCqw3wd+uTU3TSsfq2sqsY26S5Fv8tO8fv7LcTbBbSG/QlobykghFRU4OhsQHSVa4l
         w4XQ2iZJqLX2jtvvrHnPn1RP78DjR5/9jDjj5Fy6Q/zdnuc1LO7zhJmrQQ3KO7qPkWhh
         Ucb6959BUs5Apt/+UWt1SDHoRPmE6/CC9WvBNHJncX4yGCanGy9R75tSL6JAQ8tgnMvM
         xEVqrpgHZC8wqK9gOkRY2Sl5G9XpU6tL6GEbJm1eSUXCLQLUEpZTlwlWlmuZN1hub0gH
         khZVss2hF98AmvmroC70Cy34pkUBzkHZ2l91Np/LmvgPGyhynz7zNSnuMGxBp2TMDHJf
         zNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798460; x=1692403260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEBJbf6/3phuZ6h9in+X12qWnHu3Bx/RG3Utf7mBgQU=;
        b=FaWMniYkOJNo2DB7p64lpRhO/fyA6ZD57+zbYsEmb9haCU6YHB974S7Z4qBcqokPxM
         J4hjiAk40uwvm1GRiQ2ldQa2MIR8YwXahfQVHXlCXiDsyEnvmJ+waq94N9eipOFbpgC0
         xDMuj5UZyXMhCi9cfqr1952yRjaTMFsj3CkUyj9v9kW9zuflL+h3GZb5LBYlx94FXDl1
         om+/3jo757q8qYn4OPdYAVr90Edp6PjmVCicCzURvD+1H2Si/F4h06oHrbVwehhhzUma
         6QFVZsfMoufes1XeFydJ4WehnC6ErxU/agZTIgJcUGa1CUGsf78Xq0E82vdA1+OnIi0l
         Cvtw==
X-Gm-Message-State: AOJu0YxqdLJvCmMiCib1Uu4MfprRPxCxOmVLGlBDYVaTFzAYOG1w5I1h
        p3X4hCzpjjdXse3rBsNvUII3wfHT9RmmOQ==
X-Google-Smtp-Source: AGHT+IEyWGEcZvEEu93PX3MMhLtQ8NpHQ0hZmoupxKOCuelPnHurMFmxC01HmwynHaowgr/Zmc/hPg==
X-Received: by 2002:a17:903:246:b0:1bc:7001:6e58 with SMTP id j6-20020a170903024600b001bc70016e58mr3375679plh.33.1691798459901;
        Fri, 11 Aug 2023 17:00:59 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:59 -0700 (PDT)
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
Subject: [PATCH v5 8/8] gc: add `gc.repackFilterTo` config option
Date:   Sat, 12 Aug 2023 02:00:11 +0200
Message-ID: <20230812000011.1227371-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
 <20230812000011.1227371-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit implemented the `gc.repackFilter` config option
to specify a filter that should be used by `git gc` when
performing repacks.

Another previous commit has implemented
`git repack --filter-to=<dir>` to specify the location of the
packfile containing filtered out objects when using a filter.

Let's implement the `gc.repackFilterTo` config option to specify
that location in the config when `gc.repackFilter` is used.

Now when `git gc` will perform a repack with a <dir> configured
through this option and not empty, the repack process will be
passed a corresponding `--filter-to=<dir>` argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/gc.txt | 11 +++++++++++
 builtin/gc.c                |  4 ++++
 t/t6500-gc.sh               | 13 ++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 2153bde7ac..466466d6cc 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -150,6 +150,17 @@ gc.repackFilter::
 	objects into a separate packfile.  See the
 	`--filter=<filter-spec>` option of linkgit:git-repack[1].
 
+gc.repackFilterTo::
+	When repacking and using a filter, see `gc.repackFilter`, the
+	specified location will be used to create the packfile
+	containing the filtered out objects. **WARNING:** The
+	specified location should be accessible, using for example the
+	Git alternates mechanism, otherwise the repo could be
+	considered corrupt by Git as it migh not be able to access the
+	objects in that packfile. See the `--filter-to=<dir>` option
+	of linkgit:git-repack[1] and the `objects/info/alternates`
+	section of linkgit:gitrepository-layout[5].
+
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
diff --git a/builtin/gc.c b/builtin/gc.c
index 9b0984f301..1b7c775d94 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -62,6 +62,7 @@ static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 static char *repack_filter;
+static char *repack_filter_to;
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
@@ -172,6 +173,7 @@ static void gc_config(void)
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
 	git_config_get_string("gc.repackfilter", &repack_filter);
+	git_config_get_string("gc.repackfilterto", &repack_filter_to);
 
 	git_config(git_default_config, NULL);
 }
@@ -361,6 +363,8 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
 	if (repack_filter && *repack_filter)
 		strvec_pushf(&repack, "--filter=%s", repack_filter);
+	if (repack_filter_to && *repack_filter_to)
+		strvec_pushf(&repack, "--filter-to=%s", repack_filter_to);
 }
 
 static void add_repack_incremental_option(void)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 232e403b66..e412cf8daf 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -203,7 +203,6 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 '
 
 test_expect_success 'gc.repackFilter launches repack with a filter' '
-	test_when_finished "rm -rf bare.git" &&
 	git clone --no-local --bare . bare.git &&
 
 	git -C bare.git -c gc.cruftPacks=false gc &&
@@ -215,6 +214,18 @@ test_expect_success 'gc.repackFilter launches repack with a filter' '
 	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
 '
 
+test_expect_success 'gc.repackFilterTo store filtered out objects' '
+	test_when_finished "rm -rf bare.git filtered.git" &&
+
+	git init --bare filtered.git &&
+	git -C bare.git -c gc.repackFilter=blob:none \
+		-c gc.repackFilterTo=../filtered.git/objects/pack/pack \
+		-c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&
+
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+	test_stdout_line_count = 1 ls filtered.git/objects/pack/*.pack
+'
+
 prepare_cruft_history () {
 	test_commit base &&
 
-- 
2.42.0.rc1.8.ga52e3a71db

