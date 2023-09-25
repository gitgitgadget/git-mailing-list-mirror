Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF9DCE7A8C
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjIYP0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjIYP0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:26:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770511B
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so805792566b.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655554; x=1696260354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lll2BDbSt0U0/11zMPrvLfBYK7pXQOtx0KJ+okIhu8=;
        b=h73SUAoB/k2MaQYNchG+2FWRCOLxbRa65rb3tgWRkRLQUX9NwcyYW9CjNzwH1UIS3h
         QDVPynUA1FwThMnIvRXAjVO/nvaRW4zWKWl4/q8dibgf7KqhLlv4qvD0sWzdXtowHbN5
         orUnNXE/Ms+BHysAhXoxlx+YDfAhio049EQ3V70pUp0yKXM/dSLTRMtj9Ym9mnz9DYwR
         +7dXCd1b5lPPkUo7/wL10mbTYjzXMkzipAUZA9vxnOP3V3fRLMNOHnCdM0m3xrzfqnEx
         uXmXcZta6t/k51AGQjtqlyWPbu3ElHh/3Gg0zjUsJFo4pXR1YlUQnT1++iiiSj2wFIM6
         adew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655554; x=1696260354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lll2BDbSt0U0/11zMPrvLfBYK7pXQOtx0KJ+okIhu8=;
        b=B/BEIEB0dU4shVfSUVhTklMaSbKqReDLm45EzzAq1r9Piz5HGwAHhQ4PY/KYRBrSbJ
         a/j6K0YvuG58trYDRIF7XbLV/D37j1IWUjOUYHN9ioHRSw3pLhjDlVKim3UDs+UlftMF
         dvdO+5wPNwg4x0xDW3QAW/XZ9r1Kl/VVBGkWQ4qPHxYNG3VWKADjDjpvd9NcDy1OUzz8
         FZsfrXhZymfLdWFG91rHF/7kda1S+n8/FCWzFWh985yAKLeWK+bH3sQJsWMaDFq2gN5m
         8h+5warseWgaDVdgl4oIqr7emIsD8tPflmt9BVmbNzpvT+4BHe9YAuwwyxt096MWhChq
         gDBg==
X-Gm-Message-State: AOJu0YwirraQZJSHueigjFjnAtGDG404qEAMkiuUS0iBouDslRhhJYEF
        CU2hwrpxWtVIHYMyHHaKfdG10vxGIc4qLg==
X-Google-Smtp-Source: AGHT+IGRN5NnKdU51rhqczG5ogxegWQcGQu+cGo0Ch6S4xLUU74d3vFKwyHIOYD36GjG8kWu5OaoQQ==
X-Received: by 2002:a17:907:7e8c:b0:9ae:5370:81d5 with SMTP id qb12-20020a1709077e8c00b009ae537081d5mr8762378ejc.41.1695655554508;
        Mon, 25 Sep 2023 08:25:54 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:53 -0700 (PDT)
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
Subject: [PATCH v7 9/9] gc: add `gc.repackFilterTo` config option
Date:   Mon, 25 Sep 2023 17:25:17 +0200
Message-ID: <20230925152517.803579-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
 <20230925152517.803579-1-christian.couder@gmail.com>
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
2.42.0.279.g57b2ba444c

