Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DAC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiJZUNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiJZUNo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:13:44 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC3148F46
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:13:43 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q75so4798129iod.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnZeO/Xqdx73zzkYXjpa27JKGB47yRh+FgOCbTcd9QA=;
        b=EiiMUym+fu8fJ0iRjLepjfkHYrwsezMzD80VkMR2XTDMi2GtrS14EEnWgHyyBFsrnP
         X2GZzH2pvpxSPlf/vzxTCq9vyNZ+OGLGDn5cwnHkqdMtEFyUeHoKBhxHuw4lGUZsX6Do
         PzCxFe0GhWJRJ6G8308FVflwE7jjQPO7nn3ETWTTIUxpxxVbVa/241dSuudPCl8qON+5
         ttg1i12xqIfXgq6+qXC7LPiXD0AldlcCfIqWC5w73LCKq/cWLHnNnd0qpWmPtlWJ78wv
         /ICkfDKLtofp8SHPvQXXGSZGOD8zcRtKBRM7hfGFLeL7aYKIku96rTq8K3trBYboiTe2
         rgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnZeO/Xqdx73zzkYXjpa27JKGB47yRh+FgOCbTcd9QA=;
        b=EHrjguAKBW6rMt7nUVFj9wOAC5UeWRpSz4jf6TJXOd9COC0Wn6t6ESL8waBlzHXCmY
         L2cGxUUGChExykNn8tWdjDXuzljehESigB7P5Xnrwu7XTxB9udRwJx2bnbIwlFnTlVDk
         N18hBHelfy0FZD3mIZWxPthtxX65CWloKe1Rv/5v8khB0TpZXUotsWyeoBUO51XIewuh
         3bu59fr63wShjYrhQXsn/7DYUvRrJj1TUnk/Ed3jBjtltxzZCK6p0QOOtoI8zLzKbP7Z
         wmPnGL/z/10y2HOW7ZYzY6cJ7Prr4pxoOjE/Hc06irm/LdOaVKSibK83p0DaYQ8fJSH1
         eiKg==
X-Gm-Message-State: ACrzQf3WtN2ci2ZXjkE4GhbkcTpwUsb5zupOyZaP+vwPX2umclgNOvwX
        z4ahOuJVmuKX0AOQde/eycbs3QFiG0cr7FFb
X-Google-Smtp-Source: AMsMyM7iyzDUk8BUXE53+cWb4lpj3vHV3Gk6A3wNIezrzkdhXru4zYdWXarZHX6dPQTHsarZPa0ZuA==
X-Received: by 2002:a05:6602:154f:b0:6bc:f701:cb37 with SMTP id h15-20020a056602154f00b006bcf701cb37mr27916597iow.136.1666815222548;
        Wed, 26 Oct 2022 13:13:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9-20020a027a09000000b003750f2bc28dsm1581062jac.3.2022.10.26.13.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:13:42 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:13:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
Message-ID: <eb151752b8de355ac334507e57dc95aadc9ef2bf.1666815209.git.me@ttaylorr.com>
References: <cover.1666815209.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666815209.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

We are interested in exploring whether gc.cruftPacks=true should become
the default value.

To determine whether it is safe to do so, let's encourage more users to
try it out.

Users who have set feature.experimental=true have already volunteered to
try new and possibly-breaking config changes, so let's try this new
default with that set of users.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/feature.txt |  3 +++
 builtin/gc.c                     |  7 ++++--
 repo-settings.c                  |  1 +
 repository.h                     |  1 +
 t/t6500-gc.sh                    | 41 ++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index cdecd04e5b..95975e5091 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -14,6 +14,9 @@ feature.experimental::
 +
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
++
+* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
+garbage collection, preventing loose object explosions.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/builtin/gc.c b/builtin/gc.c
index 243ee85d28..5a84f791ef 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -42,7 +42,7 @@ static const char * const builtin_gc_usage[] = {
 
 static int pack_refs = 1;
 static int prune_reflogs = 1;
-static int cruft_packs = 0;
+static int cruft_packs = -1;
 static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
@@ -593,6 +593,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
 		die(_("failed to parse prune expiry value %s"), prune_expire);
 
+	prepare_repo_settings(the_repository);
+	if (cruft_packs < 0)
+		cruft_packs = the_repository->settings.gc_cruft_packs;
+
 	if (aggressive) {
 		strvec_push(&repack, "-f");
 		if (aggressive_depth > 0)
@@ -704,7 +708,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		clean_pack_garbage();
 	}
 
-	prepare_repo_settings(the_repository);
 	if (the_repository->settings.gc_write_commit_graph == 1)
 		write_commit_graph_reachable(the_repository->objects->odb,
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
diff --git a/repo-settings.c b/repo-settings.c
index e8b58151bc..3021921c53 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -43,6 +43,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults modified by feature.* */
 	if (experimental) {
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		r->settings.gc_cruft_packs = 1;
 	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
diff --git a/repository.h b/repository.h
index 24316ac944..6c461c5b9d 100644
--- a/repository.h
+++ b/repository.h
@@ -34,6 +34,7 @@ struct repo_settings {
 	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
+	int gc_cruft_packs;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
 	int sparse_index;
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 9110a39088..628dfeb737 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -221,6 +221,11 @@ assert_cruft_pack_exists () {
 	done <packs
 }
 
+refute_cruft_packs_exist () {
+	find .git/objects/pack -name "*.mtimes" >mtimes &&
+	test_must_be_empty mtimes
+}
+
 test_expect_success 'gc --cruft generates a cruft pack' '
 	test_when_finished "rm -fr crufts" &&
 	git init crufts &&
@@ -245,6 +250,42 @@ test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
 	)
 '
 
+test_expect_success 'feature.experimental=true generates a cruft pack' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c feature.experimental=true gc &&
+		assert_cruft_pack_exists
+	)
+'
+
+test_expect_success 'feature.experimental=false allows explicit cruft packs' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
+		assert_cruft_pack_exists
+	)
+'
+
+test_expect_success 'feature.experimental=false avoids cruft packs by default' '
+	git init crufts &&
+	test_when_finished "rm -fr crufts" &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c feature.experimental=false gc &&
+		refute_cruft_packs_exist
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.38.0.16.g393fd4c6db
