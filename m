Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5EFEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbjFNT0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjFNT01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:27 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79362695
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso9272384e87.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770770; x=1689362770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2EmGX+RKtKhvL0xMR2AvOlsq4xQkoy74mEscLcHois=;
        b=qfqHVQLNlkbICsmYZOyqb4w/BK6wWYnWxVP/lviN50NwXVPY6j0Hl253HKB5WVJJ2y
         kextBSqeg5Bhb0QNBOdWVxeZHgiZ7lpXh8aUKx8sxkUNNKcvQMSHBhhf3FPoYzn4UTHB
         +mkP+ZgtvUvC+GkuvUU1hA/E6POXCCYDcSwICMnMzzmpfbOn83EKRDSwpqdYQi1XHFh7
         UxYCxfJi5byZGq7n0qi7uT4k8vZvVOF9zfXMtHCKDZ/YW6RpEBQ0w8U7AZ+qOhWd+MCs
         pGu7PSJTmz52gLD6ZKt2QajI+GpZwRxGcspjYVzIV/3LAWgb9f31bQjcUijxgik9rfJv
         7Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770770; x=1689362770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2EmGX+RKtKhvL0xMR2AvOlsq4xQkoy74mEscLcHois=;
        b=In/tNPH2aBuOenaUXg03cBjMFaF/+6f3oKrBNYMaXUKPUS/bl1ZcvfYUt4nQ7jcvmR
         RbZ/5eWuPUgrSjR8RY3YabuX+J9bl7r0ClwvoQ4ZaAs5DbQHBV+iHuzpsGRLeib/qg6x
         I8WcavKwEkuVZuTYjnLCl5hMuKYZXuWWCUxMYW8MYI4+5cTYcTTOeDfVOMP2TRDVdNs0
         g8fCmHuto9/Rtop1fFkuu6P48Hn5YyxRfWPo5hGaCJxlZ+JAeamDRJwWQaf8ydrMY+0u
         75ZEmToy0jKd4nZ4h2TLSDKCTmBqe5+cneM4b7GdNdIn3xrmGwNnj1emVZ+PtO4KcMlz
         UCGg==
X-Gm-Message-State: AC+VfDzWTGK8wGSi9JSfZLRwZ7NtTFes+MCanYdzoJ03GmkC9wXCPz9v
        xfoeoFPER7iGNTeidyuFn68CfaV6iwE=
X-Google-Smtp-Source: ACHHUZ55vkERdr/ZboYwFWPswf+ku4UEZ1eXYjO0UZqAujhK/7mIomaZjDh0It0RVfpFsMb3wSRn4Q==
X-Received: by 2002:a2e:9d43:0:b0:2b3:4442:50da with SMTP id y3-20020a2e9d43000000b002b3444250damr2693444ljj.9.1686770770203;
        Wed, 14 Jun 2023 12:26:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:09 -0700 (PDT)
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
Subject: [PATCH 7/9] gc: add `gc.repackFilter` config option
Date:   Wed, 14 Jun 2023 21:25:39 +0200
Message-ID: <20230614192541.1599256-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
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
index 7f95c866e1..055c4e0db6 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -130,6 +130,11 @@ or rebase occurring.  Since these changes are not part of the current
 project most users will want to expire them sooner, which is why the
 default is more aggressive than `gc.reflogExpire`.
 
+gc.repackFilter::
+	When repacking, use the specified filter to move certain
+	objects into a separate packfile.  See the
+	`--filter=<filter-spec>` option of linkgit:git-repack[1].
+
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
diff --git a/builtin/gc.c b/builtin/gc.c
index f3942188a6..1c57913214 100644
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
2.41.0.37.gae45d9845e

