Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F2C0015E
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGEGJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGEGIn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E210E3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbac8b01b3so2330995e9.1
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537320; x=1691129320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eCxC6VmngybrcGM5jlxofbrLSLE9kKwNVVAU4IdBnw=;
        b=H3Kw2MOIDxMSI9kwfMgfPSgnCCuJPkEXoXUCu879ckXOZY//szzliTGV+lcwEcbUvb
         XgcMRtcLNrlmgcrIvgX6JsOX4IbLJ3ADjiouLhEjJIXs2R9AikiEPcpBcG9tUm3ZDMY2
         BlMes2pkWUYW24wkmTdAHXmdTacFhi/yzn++ed1bE7Vec9kMoYBzdokV78KTF6fSxKxA
         TF28VPloyuU4RQz8QjK0YfbZ1GBGmHCkk2n4eTET98wyDFqU2JDD5G2qPhJedzIVc75V
         /HVcFM3vx0s5bgZzY+41rxQbFmu/BusPNRpT2nsEaBI1c4Gz0xngspKV92VDyx564JwG
         GB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537320; x=1691129320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eCxC6VmngybrcGM5jlxofbrLSLE9kKwNVVAU4IdBnw=;
        b=NaUEXAd144uP1XdJBMnqpK5SRcSCwwEmF1JSyiSBU0L44gN5iXDY56zrkXi+APXt/1
         p1KwpZcO4EApVGLdTjF96H31/vb3vw/V2E/XJlcM/swGQlnb6s5rELxsUf2/2IErrGXa
         9Lv8UtAYFK7/l3Z9pLj4DK19thR/C9yTkuPTp1GvpAlhSlK5bRr23tMdBuQ6kTogbAki
         aWg7f9mxeYKAZM5x/IwpyUNU34uhKlf5xVEnELDe2IBtDVXsw+4qYsjzai4Qt05W0WMF
         pY1NdjLa0+AX6vif/bcWd7BZd3XM7Q6bNN6jhqPKytTdWPwo7A6BilPlJ7hGd2tgvxtj
         fRgw==
X-Gm-Message-State: ABy/qLZf1p7Cy1ZYF3pqqlXWf1cPu9SpY6aKv3rjEJD0NOaEDA/Y6XTV
        jMYFE+LaslR3eu08uZ4zmnHkVNkpjzo=
X-Google-Smtp-Source: APBJJlEyN+zHPVQa3eobi9kVvy/PF3MEvmsy7ulLO2s08YJkOcrroz5hT7bBtX3RFkjbpz2mS26B9w==
X-Received: by 2002:a7b:ce8c:0:b0:3f9:fd12:a8b0 with SMTP id q12-20020a7bce8c000000b003f9fd12a8b0mr1006929wmj.20.1688537320163;
        Tue, 04 Jul 2023 23:08:40 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:39 -0700 (PDT)
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
Subject: [PATCH v2 8/8] gc: add `gc.repackFilterTo` config option
Date:   Wed,  5 Jul 2023 08:08:12 +0200
Message-ID: <20230705060812.2865188-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com>
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
 Documentation/config/gc.txt |  6 ++++++
 builtin/gc.c                |  4 ++++
 t/t6500-gc.sh               | 13 ++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 2153bde7ac..0e32007502 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -150,6 +150,12 @@ gc.repackFilter::
 	objects into a separate packfile.  See the
 	`--filter=<filter-spec>` option of linkgit:git-repack[1].
 
+gc.repackFilterTo::
+	When repacking and using a filter, see `gc.repackFilter`, the
+	specified location will be used to create the packfile
+	containing the filtered out objects.  See the
+	`--filter-to=<dir>` option of linkgit:git-repack[1].
+
 gc.rerereResolved::
 	Records of conflicted merge you resolved earlier are
 	kept for this many days when 'git rerere gc' is run.
diff --git a/builtin/gc.c b/builtin/gc.c
index 046147fdcc..f31167be6d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -63,6 +63,7 @@ static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 static char *repack_filter;
+static char *repack_filter_to;
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
@@ -173,6 +174,7 @@ static void gc_config(void)
 	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
 	git_config_get_string("gc.repackfilter", &repack_filter);
+	git_config_get_string("gc.repackfilterto", &repack_filter_to);
 
 	git_config(git_default_config, NULL);
 }
@@ -362,6 +364,8 @@ static void add_repack_all_option(struct string_list *keep_pack)
 
 	if (repack_filter && *repack_filter)
 		strvec_pushf(&repack, "--filter=%s", repack_filter);
+	if (repack_filter_to && *repack_filter_to)
+		strvec_pushf(&repack, "--filter-to=%s", repack_filter_to);
 }
 
 static void add_repack_incremental_option(void)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 5b89faf505..37056a824b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -203,7 +203,6 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 '
 
 test_expect_success 'gc.repackFilter launches repack with a filter' '
-	test_when_finished "rm -rf bare.git" &&
 	git clone --no-local --bare . bare.git &&
 
 	git -C bare.git -c gc.cruftPacks=false gc &&
@@ -214,6 +213,18 @@ test_expect_success 'gc.repackFilter launches repack with a filter' '
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
2.41.0.244.g8cb3faa74c

