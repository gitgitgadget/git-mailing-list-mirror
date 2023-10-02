Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2844DE784AB
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbjJBQzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbjJBQzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DEA9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so22354668a12.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265739; x=1696870539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNKP/Vfnf5kRJ5Yesm2cFwh3jAzoSFJ9JwdLJhVoEbg=;
        b=ZyYBxDjt5eb3Xc4oBRg1cj1SWoHedwwjFtAyjQqyvdW7eVBJmlgOB4BwcCdBMzg89k
         5IRda11AmT42WCALCwf/SLfPvb5iSx8fbLsliZgdnTlkzo0tPbchxweQk4qNKuZ5R7Wu
         RKlDMWBewoQz/9eUAY/XqyCPtdVzUDvuIxHeRRYrYoYp6onXUn/GcDf5Y52mI4rwR7Qw
         Vk/uq7bhgkO0K7d13alF8H+gcGspYHgqvCPN4mKs3mQOAimkfwiSBvhqQ+QXF2PF3eAc
         ZtNZ3O3777ORbO0tb/Qs+M8ZyVTU1s4ZurobTUtzAZO4lFtufiFU8/uUfNWcLGWH7LKX
         vFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265739; x=1696870539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNKP/Vfnf5kRJ5Yesm2cFwh3jAzoSFJ9JwdLJhVoEbg=;
        b=s+/YjAxVJgukeqmRpPpfg30Se112MIkg4d4YDfB7LoU8PPJZ4jJ0LJjAGReUlMKh2T
         QlGM6ihEe9eO2kd7bbt0J4W0ryExT+N2zmMn9XbpS60KoO99Y3PS+8ZA5VsEAKR02R0X
         igcEKSnIw4f5tuh3B0Laa3gm3QnmynSxs1QsV3xnFjJ83xE+3XSYd1SR9MY/4EdNqZMj
         q/Nn0eEX3sjrttrSIjiuk56jHxPoQgRJo/tSlRbgZxFHFTtQGS6vVZ4b8Q397znVDFst
         6UXrafD2JAZYuxDzy1qh9Ra+iMJ0Yk/jncg+q0JbHwXcBnDTr8gX8SoLhRnJc5/SzSpf
         3UfQ==
X-Gm-Message-State: AOJu0Yysm3Njw5llywHw4dbUrkK/ET01Iy48o8joHK1Fs8H6QVHYlRup
        rQ187KXuasV7f/QZ9aS0j4hvYFfSxIjQCw==
X-Google-Smtp-Source: AGHT+IHrx/WROprDScBs0iFTwI4/O6JPS9ZoEbPpeGGuhnZi3oBF0mgOdJ2TviHQ+cODlSsC8DGkCg==
X-Received: by 2002:a05:6402:785:b0:523:ae0a:a446 with SMTP id d5-20020a056402078500b00523ae0aa446mr12299324edy.24.1696265738830;
        Mon, 02 Oct 2023 09:55:38 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:38 -0700 (PDT)
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
Subject: [PATCH v8 9/9] gc: add `gc.repackFilterTo` config option
Date:   Mon,  2 Oct 2023 18:55:04 +0200
Message-ID: <20231002165504.1325153-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
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
index 98148e98fe..68ca8d45bf 100644
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
2.42.0.305.g5bfd918c90

