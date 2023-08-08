Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B14DC04E69
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbjHHSYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjHHSXl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:23:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9B383C4
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:35:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso93777931fa.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691516129; x=1692120929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unIVzuS1NxxcnhWzEsndtCDHSpznWrWXZhlx7CoSc+M=;
        b=i8goD1ciPgfpxJB4sxyTSBITmy1YsvRQsKxaYlE5VjAQVmudLx2CZkTLoX5Mkj7whc
         WylNTx1omW/M/ft0S/2ZhGmssqNsOXXWB0r/dyYWGe8DM4CWABAst6Kye76yPrLOGtxP
         OuFXHIZaQHM2ZKbWH/cr8y7qM1PGptszqi+AoNCrdJK6FtUBVeF2p73pWmg8F3wPJIAK
         8wCTsBNzgebnV3Ksd58cx8jftzY8Iw4EsBdpB6zcb5mr3z4Iaq4q2liUAedefLP7LWgv
         1KyNACBx0o6nXDeo7qsg1UqreusqfPl+vnM+ihPh5+m199e8wh05JbeYF4ynQTZsDOM/
         yzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516129; x=1692120929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unIVzuS1NxxcnhWzEsndtCDHSpznWrWXZhlx7CoSc+M=;
        b=jDP49fcuDUfbmS+A8f9/M5OkWfIufFRrcvnr67h0hMpOOrkv6FqWOaCsGV1CFFiCnZ
         9eGwEFZzAw73HRRXkLhSVACf8A5WsKnt+cRG/S13cmHu57HIAn7sg0XmkUZ4Xz0aqUn/
         Fi2shX5K9PjoUf+Tr6EUtYx7FGeXLgB7pe6b2LTFVpQZbnVvt1eVnUiMOwpHFEeEWVhO
         x7qmrzb9IlpYdE699eefQtL/Fy8gMzqaN3XHFC0sFUaKnDr69d/JWNR3YABkEfkvsYUT
         l7+oX8IQvAUiAqZZMCM7S9QUDNkozXvBxp/k9R+HP04B8Ce12vhaJZd+hojZgjPVOuT6
         5Kdw==
X-Gm-Message-State: AOJu0Yys2Y49XNayGC8QgAO2fmG4UKabLWZSKnkebPrm75If9mkaIhV5
        yS+gtSgy0SA9pxUWY06etI3D4g5X9C0=
X-Google-Smtp-Source: AGHT+IFd7jfFPNDX9+50N3gPHySZTs+x51MJgsYOcgSI82e7TP3moqwi9j/53JQvuEPwWA1qVV9TZw==
X-Received: by 2002:a7b:cb90:0:b0:3fc:3e1:7105 with SMTP id m16-20020a7bcb90000000b003fc03e17105mr9177821wmi.24.1691483194996;
        Tue, 08 Aug 2023 01:26:34 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:34 -0700 (PDT)
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
Subject: [PATCH v4 6/8] gc: add `gc.repackFilter` config option
Date:   Tue,  8 Aug 2023 10:26:06 +0200
Message-ID: <20230808082608.582319-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
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
2.42.0.rc0.8.g76fac86b0e

