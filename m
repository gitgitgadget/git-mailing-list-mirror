Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8ABC41513
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjHHTFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjHHTFV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:05:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB6B0D74
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:49:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so9414795e87.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691516941; x=1692121741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yPRa/DkUNrLpoZ10EY6tZ8GYlEW0kCf8e/VL+uRwzU=;
        b=XhbV8GN6DjLpYB5bSjgdTs7Js8IjHbxrVHFcXnFe4+Dtg4j3HcqMfS0vDeyKqBpkDo
         1yt8iQwYWCqh6mebmbH4FlMPMCKjv6BDtJzE9Mq/+IsLMlv1yHyV/QDJdb+JcP2mQSOa
         MbAzqtOadEsrpKbNgGqkCG4on3UZA50CM7qjWpkm524FzQLxRs7kw0DZMe8nr1SVV0UP
         LQUNNjbOBnB1t9PIfD1hYLrfLNMhIAcCo7FXGfVviS12KMn4YYGuqIwrdFFf/NDIzAkd
         UHUoUh7zM3rtjRTKiSZ6iUTNpxp0FfmqhGa7uc3Z+Iw9mlZNpGKTykX+60sOdHFsztxq
         2lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516941; x=1692121741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yPRa/DkUNrLpoZ10EY6tZ8GYlEW0kCf8e/VL+uRwzU=;
        b=cm+ITneSHIiZV3TGSM5UZkX4wAJwQh3oo2cIyaqXqatu+zVeke21Z4kEORb60TpoHf
         POdPqUAfD6gMrN2rRFWpMimKXD4RgQoO9zGQJTUd2wlTCXHw6yzsMoJBMK0Y+DRGmduH
         /fFuh61aoDBHNpBhFPepIKhZbTqBggYQ5LqSOJRi3TiXCdHeJAbmuYbZFPQec4QBP6a7
         ylTnjW/2VXbm5uzC4nYmQkhjWaZVX538xEQVAvW5Hnq7/S/LD5MV2pRaBWUrlANbrz5X
         Eyf7iKQOsLZExTQ81SerFQx7ei8kLhQnlRd7e1cTHtyRf/xCUp7DeOygrq8Mg3zCDsny
         F41Q==
X-Gm-Message-State: AOJu0Yx6pUObI00z34gPTCovXfLGw3QyeMFg+jUa9/uVU/cf/2qvBqB9
        beyoGBiwkHS+jlqDE44oIcY3+06IgTE=
X-Google-Smtp-Source: AGHT+IFkd4rMhtZwLcwX3xI9Lm5aWQmYSqxtsgmfR4YlKAAUy3H3q66uUB7DzDwja+/nSVarVHEprQ==
X-Received: by 2002:a1c:4c15:0:b0:3fe:207c:1aea with SMTP id z21-20020a1c4c15000000b003fe207c1aeamr9103039wmf.23.1691483197624;
        Tue, 08 Aug 2023 01:26:37 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:36 -0700 (PDT)
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
Subject: [PATCH v4 8/8] gc: add `gc.repackFilterTo` config option
Date:   Tue,  8 Aug 2023 10:26:08 +0200
Message-ID: <20230808082608.582319-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230808082608.582319-1-christian.couder@gmail.com>
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
2.42.0.rc0.8.g76fac86b0e

