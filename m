Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB95CE7A8C
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjIYP0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjIYPZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCE10A
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso820027666b.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655550; x=1696260350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e4Aqk/meUSmscAN+bYvQhR1eh5JYPT3g6SksH8pUko=;
        b=bcgyoVTY6yeayMEsSWMeurb7B1dzIeyRqtB6MZ+ePWx6IqI/cp7I3ys/P+TnYAM0LE
         RzhuRWZb3yp8Dp9BdAxYQk7f3todHDY7xTrl0Me8xmrpM13Dz+Gr04qlnarb7kJ4eXc2
         DgglcNTx2r0xReMsjwmhCXci0FJBwPIJDB12y62mzssPQ53qpZCzbl++XTy3hm2WBo6B
         LMWf7iWDfAXPmRhRifgzq7Zli7Y3t6JBI9Migt6ZzwIjM+BWalcXx+wxVsw73TPhlgf0
         TB/57y39GAxgOu8xOQG3vTC+UqtA/7k1oBYqUTvNQccBwLQqUuJCcoaqfM+8oNudnhzG
         zt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655550; x=1696260350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e4Aqk/meUSmscAN+bYvQhR1eh5JYPT3g6SksH8pUko=;
        b=CryauboAm0N9iYOncGrN6m3FE+N8fxZidZzMK1A4RlbKcEBmK+eE8NkjYJn0t+UBIu
         icnOZn4QpSU102ATe2Z4BlR5+v7F0p+YfhSH/X2A7bciSp3bR4YryXMeYpsIIG35kgLp
         WjpYJpED8CXk+/pbZx4Hos3pZQgQcRmE98GU68cyjcp3IuLcDKKych13XKP8aiPT+hOj
         8KFEDwgS8MwWB84ZFZpeYC/Yq2kyWS58i5hnM3qc+mibWbilTZfJka8kaJJWaMDDcCuq
         rJNDosAkak6APb3ygAccfx1KBEfYLVwpW/U0XsNJbf25qeB+xIKWPxFGS7omePOs7KfO
         UgwA==
X-Gm-Message-State: AOJu0YyOUgvoM3MqGRBFGT1CHs37xYNF6QB4KPU5tlNMhOe+wgP7Xy5H
        mlXRN7/8NJO6Ig4gnacLqMOLz00jaA7QPg==
X-Google-Smtp-Source: AGHT+IE/vvcn+xj/bHCvxfPNa8w2Y07RjzM2dmor77HMHkOwG3uyPgw53aOzev8eULHPtD6rqh84sw==
X-Received: by 2002:a17:906:6d14:b0:9a9:f17e:412f with SMTP id m20-20020a1709066d1400b009a9f17e412fmr6451973ejr.50.1695655550280;
        Mon, 25 Sep 2023 08:25:50 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:49 -0700 (PDT)
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
Subject: [PATCH v7 7/9] gc: add `gc.repackFilter` config option
Date:   Mon, 25 Sep 2023 17:25:15 +0200
Message-ID: <20230925152517.803579-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
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
2.42.0.279.g57b2ba444c

