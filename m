Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80667EB64DB
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjFNT0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFNT01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4A26A4
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8d5262dc8so222345e9.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770773; x=1689362773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8AjKnqmHXvW0/kE5+ku/lIt6XDqaH9ZIMcIxFtwt8c=;
        b=goplzWAl1Jr3IP1PzjloHhTuaIEJ2w3ieWsVlOdVcGwni5mJR7xarlQ/KorNdYqjuc
         +XQQJawZ3xl+fKILDgX10mCMvA1Jbj7G+m2Z6qCIz1nkk8A5WC20zJ1OUJQppNLTHC/J
         FbfY8APAULXOmkGE9tJExg+1P64VXQb6qAS9Ghh0JL9PivKCSssHFTJCZCTwZlB6WVw1
         edzJUX0XPDc43Qfj4Pzk37boXUyKp7MOTQkODs58w7fmX0ZK33VZdCTUd0YkQU/yGcpL
         M0a3by+5l7LjefjWll04XlUaEaBCWs5FXbS9FlubOycBpL8bZRUBU6z7JCLiBObD3slx
         0veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770773; x=1689362773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8AjKnqmHXvW0/kE5+ku/lIt6XDqaH9ZIMcIxFtwt8c=;
        b=IdRcg4tsU9xS7dLYXN1vRshWDRKPktVVpr8DPS6FLZ2Nnn/Kgq2bQ0MnuaNxN2gNG/
         Kj8FYAcSM/eq5Slo9BaclzI1ufyizbfb2I/f7vzILPG1N+XYRMoMzLZsPmsRU5UnuIxs
         Vtnp5McMdeo7KfzT0wdHOPpkolhGVmYmKeTrkdyKLJxa/S2se/+Xfc+JLHA45RpC/NKe
         XgRxtj5FKyWOQbyKjYvku6zOwI9VCpPcOl4qlkZfXtaSDXgbpCqR/elc/6O/AOk7c851
         aX7t1YMl6MidmU7kEjPOGvPtYtB+WzI0WGdNyRVj9/4b2T7GddUs8XhaZrYEcNdbtVfx
         ZMlA==
X-Gm-Message-State: AC+VfDxL3LwSKFxuAsw7pwIeOucp2RFvudm+vQ84PSQ4znzcjPyC+Ivv
        FH3jobnOBFdMJGd5BJ/AcRGpv+xhsb8=
X-Google-Smtp-Source: ACHHUZ5ggnoo2+FHeZJHR8o/D+jcJDHHR7+GQKxZ0vnszDJQ4BilEoqt3IJZvl7BC1GuYventFW8fw==
X-Received: by 2002:a05:600c:204e:b0:3f8:1dda:209e with SMTP id p14-20020a05600c204e00b003f81dda209emr2274722wmg.10.1686770772844;
        Wed, 14 Jun 2023 12:26:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:26:11 -0700 (PDT)
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
Subject: [PATCH 9/9] gc: add `gc.repackFilterTo` config option
Date:   Wed, 14 Jun 2023 21:25:41 +0200
Message-ID: <20230614192541.1599256-10-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
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
index 055c4e0db6..699ad887b3 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -135,6 +135,12 @@ gc.repackFilter::
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
index 1c57913214..87f5fc6946 100644
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
2.41.0.37.gae45d9845e

