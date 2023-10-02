Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B6E748FB
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjJBQzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbjJBQzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4BF0
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so21998573a12.2
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265736; x=1696870536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgndZkQPDQIo1GHzSCM/s3yh+5pQEtkV39B8KuAzcxs=;
        b=b6SoNVrbw137bc4bb/Lah0xz7FcNbSVdVnviouRhKJ8BM6DSeifAfkpxHhkApw+8lE
         Sx1xaB/DYV8w1+GuD067AjxsFeAvqOSgMiv1a73hTNU+9FL7QvJFp4GR6crHhJKSKYop
         Aequ8nrrGAIKjAEi63kk2nCTgP28Izkf00MR4LJavZlJ3A9pXug/FMls5XHePCKyKBIv
         1RqGJe694m/D4FtjORUnlGYswyqXUorZ0vPLh7hZEy31ZNNJbZZS3KrX7TCliFQ1Y8L/
         JikmTxWdnHiLHEGggmbdaWaX0iWkkH9OPR07gLaFFY/P3r5HQouasMc03jZgiXfgILVH
         /YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265736; x=1696870536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgndZkQPDQIo1GHzSCM/s3yh+5pQEtkV39B8KuAzcxs=;
        b=p5xOpUKq66FEjGdb1gq/zaEQ09En+VovAWqjQNQkWQPbmrhWOUgaMVa5QzHfL308eF
         GZfup9nzQ3CnsYXvfFV6SW6PMIubtaVvvBfWISSLJpR5LP2Hx/3PjIYaQ/rsy5rFMNsz
         rrSQ0RYX4gQCNOwvaCjGGbpgKzx4nZG1YHK0MQrWFBhhtQ2v/OxcSuF9DMElBBCqrr9Y
         dWlMA2rPaj7RL8QiKf9A5Ee6Rqii1c9dp7zF3a8WXK7707HAQCr5k4To4JDH1Y2fsk/2
         dWtWHtDzSW79AB2PnxMJrkyPkwl5Ink521as0AVJlKH5nXXpf4C3hC/BPBFEiRul7ELx
         RoKw==
X-Gm-Message-State: AOJu0YyqaEGnBUBtd3ZA1+CmWS+q8VDFd2Mzh51MOlXkYY7Bmjz4Thd7
        jcszewmS8e457jpbfa/DlP0r8MjYaqnLEw==
X-Google-Smtp-Source: AGHT+IFyRCduWPl7+MLHerOA94xNNZmCdDmWLW5PFOYkAb5D+1d4QGZBmfvSnWEOOI8Z2HOT2V5QVQ==
X-Received: by 2002:aa7:d98e:0:b0:527:251e:1be8 with SMTP id u14-20020aa7d98e000000b00527251e1be8mr10080317eds.13.1696265736342;
        Mon, 02 Oct 2023 09:55:36 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:35 -0700 (PDT)
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
Subject: [PATCH v8 7/9] gc: add `gc.repackFilter` config option
Date:   Mon,  2 Oct 2023 18:55:02 +0200
Message-ID: <20231002165504.1325153-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
index 00192ae5d3..98148e98fe 100644
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
2.42.0.305.g5bfd918c90

