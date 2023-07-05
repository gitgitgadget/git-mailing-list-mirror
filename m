Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC488EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGEGI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjGEGIm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D3F3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f122ff663eso9852549e87.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537318; x=1691129318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvWVo8fhmCKUJdwdhCMkduSb3K45TkxWIrngoL3x54s=;
        b=O3zzKvgf2XmnKhPS4/jSYU9e6rRy/F4kuoJ9B0ibb+Jm9DS57gftAf6rU/zN/ms10V
         IGsgcpEWz7/6+VH+Rwtgyto6czn5OEEP11Hy+uJcSuqpdmONzAt5s9NKSoVaHPAQyCsk
         30k6zJknJpnzyoojzDCbCVule2EgRFte1OLjpQR9DsMS5ZR21SwitoUVjQASr/nDTz9r
         5eM1/Nu4fKMZk4dOs+0DgPQ7OALOcBYUIvg2GwiPVw2hpSZZBOXZC33Oado6n+t/fL3b
         FWUuyUxxbsa+7wc1ZIa52RZW6hCENYj6Mcs32bl8JfGTJ6H85UU24AGFU+ZrdamkbX9e
         aQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537318; x=1691129318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvWVo8fhmCKUJdwdhCMkduSb3K45TkxWIrngoL3x54s=;
        b=cngLb7IBiabl8PYXYSG54IczU0Wh1GCloehJETpC5tG+LAFQYH21hXKN5VMzvsXygd
         SaTOvUnB5OaAd/gSfWz/b681inD1FNGIPNT20Hs2PpmxHBzj14faf4qmVuLEA526dFdY
         Q7gM3p9iE06I5G3CGRtrB0Nj2a7bd1Kl8BBAX82818J90FHMT+zxmAkfFCRDhuEtdQMF
         d6p4dsokQvJviZE9KASh/VAfAclh1gsa5CHCtcHNJ9KK6JZp0ojNrqkH+2P9hFNDuYP3
         HXC5dRmvjIQIDjgezg/VLoVvbv3x4PvZ/FDwEqYXqVJzhiRsNGVDARnKxpT2z2rtSY7n
         LM9Q==
X-Gm-Message-State: ABy/qLa/WAwi6icp4QP6mTp3pkqdaLIbf1TjBebFTfqvmVFIKZ5/mde+
        sCwBT0KVaYi2+i5PcWCPS0R8sqqbt/I=
X-Google-Smtp-Source: APBJJlH1/N31RSlQqeByBTVPGyxmn5exvuMgnk19VBb4BdjIn2CFkNbPNzLytqoxczyJUx1OMl9EAA==
X-Received: by 2002:a05:6512:2250:b0:4fb:81f2:422b with SMTP id i16-20020a056512225000b004fb81f2422bmr11861649lfu.54.1688537318181;
        Tue, 04 Jul 2023 23:08:38 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:37 -0700 (PDT)
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
Subject: [PATCH v2 6/8] gc: add `gc.repackFilter` config option
Date:   Wed,  5 Jul 2023 08:08:10 +0200
Message-ID: <20230705060812.2865188-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
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
index 91eec7703a..046147fdcc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -62,6 +62,7 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
+static char *repack_filter;
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
@@ -171,6 +172,8 @@ static void gc_config(void)
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
+	git_config_get_string("gc.repackfilter", &repack_filter);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -356,6 +359,9 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
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
2.41.0.244.g8cb3faa74c

