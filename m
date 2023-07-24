Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03979C001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 09:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGXJAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjGXI7t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275E11F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso1049557a12.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189183; x=1690793983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYpL/AvLoQi/zB7yvx8F+K7HS8X/XJAFUruyX1J25Dk=;
        b=MFnrEJeeNlRPpWrs6wr4SXmY8PWVVuZztWD9/gT1YI+YN9erYQSrsRyUV/QPRHyz0y
         XstemgTfvRA0Hz3x7uWtL0L/s2nXyQhodolBwt/aCrfYOyn+S8uWURw/5CDy866jyhDX
         9XxCDpgjx1xfdrB1RII6Si5TxfJde94vvNS+C10P/x1gkhyIx6skVz53zwiD7dWhcI82
         ZARnpotgNR1Cs72jHkKPTs9FRjS0dvgen3Vtlrhn4OSNNnJ/C5uyjZp4M7L6s5tYy4fG
         wAJn4hpAyKUTQBTb2zLLq5I03wFN9uB4cyWYb5MuoelrhJgY2pA13KNezwVKzfbf7JsA
         2xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189183; x=1690793983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYpL/AvLoQi/zB7yvx8F+K7HS8X/XJAFUruyX1J25Dk=;
        b=fzzffnaB2vY3eJHCwOCwB75s4uCBb1Ne/LY3crUCzoDZtvf9tUkWqWmZ9n2umvMCNS
         xIRDfH253Ci8enp2lQPKCrIyCngOiW/pGppkv6wpgzTrGyJNt34gpMEEhivg50OV9U5B
         SCzTpQAUVMOcd5OZUUhv7B30cUM4Cxypoa0fOyia0CpjwR+SP2YMI+iKcFI/ivWpQ5vG
         ObnrH13ag+UkmpNW2MYZvXOdy1TxQfJ0fQwAu04L6kaG521BtCDNEuGuMSkLQmAiuWlC
         kl6GoVIXUAA1j3G9sC+EqVbewLVxAyu1aavC4tC5MchgpU2zmddav4hfd9E3Ian9MADl
         KeHQ==
X-Gm-Message-State: ABy/qLY+DaHoIG3EKfkxVDGdGYzT1wAsAwFXbxoY82/mvlqhwc8BKwg1
        dfIIzPhYXiSelLj3afFzPIQoOVZ6xg4=
X-Google-Smtp-Source: APBJJlG4pBgmtS2Z/ZF13U9RzPsXJgzfyMZCuhijpD41yc819E4T5GckMx3iYGMu6JuMzgOnhN0bCw==
X-Received: by 2002:a17:906:d7:b0:99b:64d0:f6c8 with SMTP id 23-20020a17090600d700b0099b64d0f6c8mr10161051eji.50.1690189183033;
        Mon, 24 Jul 2023 01:59:43 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:42 -0700 (PDT)
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
Subject: [PATCH v3 6/8] gc: add `gc.repackFilter` config option
Date:   Mon, 24 Jul 2023 10:59:07 +0200
Message-ID: <20230724085909.3831831-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
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
 t/t6500-gc.sh               | 12 ++++++++++++
 3 files changed, 23 insertions(+)

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
index 69509d0c11..5b89faf505 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -202,6 +202,18 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
+test_expect_success 'gc.repackFilter launches repack with a filter' '
+	test_when_finished "rm -rf bare.git" &&
+	git clone --no-local --bare . bare.git &&
+
+	git -C bare.git -c gc.cruftPacks=false gc &&
+	test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
+
+	GIT_TRACE=$(pwd)/trace.out git -C bare.git -c gc.repackFilter=blob:none -c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&
+	test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
+	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
+'
+
 prepare_cruft_history () {
 	test_commit base &&
 
-- 
2.41.0.384.ged66511823

