Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C5EC001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 09:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjGXJAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjGXI7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4981FE6F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992dcae74e0so699692366b.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189186; x=1690793986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWI/z40HSt5Nf7v9CbTY6e2vkZf+4HjzOcQOciiO+uk=;
        b=dXySMJyV6K4hQKBcAMUFGQYl67wGPQ5ZW8nO00Ztn9HqOwGw0BJTqc0Gp+1NCGOSPi
         qAJUxqDUoc1sCJCINiq/9aavf/HvDmmO2gN6Wn24GQDGaTVOR/7iKt09eVphIcoLAJnZ
         Ry7vpeWzxyjmP6ugJ7vKH5A0MMbqGquil8vIM4BhV7mrm6I4b+1t2H8esOs9x/F3d+rp
         NU1zwbgthzec6HelMJDapdpdoNrfc90ode9li0AKoGI0NPccdbFaRBaL9ab/z9Yx94Vi
         v7HEV5xHo8Oh5hCT8iIX9CeHzcg56fsAqRoMzXOICtF8HFCc4rj7PYgmA0Ny3X0k4vx8
         LTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189186; x=1690793986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWI/z40HSt5Nf7v9CbTY6e2vkZf+4HjzOcQOciiO+uk=;
        b=LzTjVSn5fkqHSs9vU/0W+Iqgdq1m2ucqDGTcsHd3ca0yvQFU3/5Klxh/7rs1uJfCE3
         8GIG9uB9mZEzhF8a/b7lBGueGwpwpYmIL7VTQS68Jvb+uYfVuVqFbPadEZ9vEL+nuGBT
         aFd0cbwwlHgYxaXyW8G7cE3zkYi7omSHO7LddUw866+rwZOIl5dcFWNd5ZycDOo7ft04
         TlrakAMH39K3ZSwKlRrLPYAzbZXv8v8DP2nFcOCHjFDuKt/5jC2mccw2c4xq7dxw4anV
         RmY9m3/2cIC1ABc1CYmiE02DlYDJ8/GW/tBLDtjNt+Eg4BsGNvmApkmAuBe6kBQh4bur
         7TTg==
X-Gm-Message-State: ABy/qLZzWqhVTbtCsl2mrQ8HC7TAkmvrMfCqPvCAoHHbUYUWvhUoAa9J
        RlpUg8TJp6rvoSs+ysG3bGU0I9lZGvk=
X-Google-Smtp-Source: APBJJlHrPujlyBLxYvfbEmjFr54i28YSu4/4EdzbzxuHS7GOJGZqfztzNA5QUub6CDRvy19buynbjA==
X-Received: by 2002:a17:906:538f:b0:991:bf04:204f with SMTP id g15-20020a170906538f00b00991bf04204fmr9254161ejo.60.1690189186215;
        Mon, 24 Jul 2023 01:59:46 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:45 -0700 (PDT)
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
Subject: [PATCH v3 8/8] gc: add `gc.repackFilterTo` config option
Date:   Mon, 24 Jul 2023 10:59:09 +0200
Message-ID: <20230724085909.3831831-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
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
2.41.0.384.ged66511823

