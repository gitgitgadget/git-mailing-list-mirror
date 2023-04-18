Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF304C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjDRUkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDRUko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:40:44 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07663C164
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:41 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54c12009c30so581295537b3.9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850441; x=1684442441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSULjQeZr6EERLMdQ3oz0fdM8+pujbGzD2Wwp37zZXA=;
        b=n1pZj1pJo2Ez96fc9nRf84dcFfUm1b2GRAJHdmi2MUCSTyK/M7K/AyDBLu2LYQ3gu/
         7udo0PtHnh8wp501fVJFsMqN06gxWcz7LPpJ8SaQCLYQ412UJ6tFOn46/Pq43G+vqCLG
         FVx4hUYyCeBFI0d9uAW0nKpTHs/UKMysZFnH091PvXD7G6H/vs1ClZ3g5msxpUqctaaf
         nrcwy/G2wHcvN82ObqbZ0K2HypimSrgqk0UkrhUERrdf+uRLqKZtdqNDirSYt+81p8zg
         Uqk2rPa9Pdv48kaw8cFKON2t7QUbLmKWnGQJMBECaOvqUgQ4h6ZNoulTKETyqV29K/gf
         imXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850441; x=1684442441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSULjQeZr6EERLMdQ3oz0fdM8+pujbGzD2Wwp37zZXA=;
        b=QPYtKqaImm9IDG1m69zhEtO0W0R8SdAN4ZA+4FhqU44WjiuAgjBTNR8T2wy2710eNT
         9YtYnisIQZYXugDm2rxg6RogBr7cWMvZrm6asDq3BhbgugSFRO2/WmdqVwoibCSfDp8w
         mMtVzfKoJ0ZXz22DKKP6aioBKYLJgMV8Uz+4CK0Kb5WW2vUzlN0fq+UQ+tSHA9eziW+k
         P8VMOTWQVwWJYtLpYzw7hsqiYPdAL50xdmJcqFnw7nb7tGf/6J4/S6yAi2osUefWGj4Z
         5GYjBI84O+h/A1/68JNtNBwdNHCfSnf4J9bZ17hnbqj3hp7DRm5ZBoOWiNLfdWdPP3Wp
         0ohg==
X-Gm-Message-State: AAQBX9eVY1FKOi6Opz68NCbrT9C4/BaLzIgH66fi/ZYVGuByZ12+mnsg
        WLgg8uOl67bxvE6WCaWhGglPFvO6uBrx/aC/NcJpUw==
X-Google-Smtp-Source: AKy350bIppEknWnRrph6K8w/Qye7NNeuev29y4CAGsHju8XKnTeF/4XQ4MXmjA8iGUQRL0vQdpmxhQ==
X-Received: by 2002:a81:6c15:0:b0:54f:b6b6:1906 with SMTP id h21-20020a816c15000000b0054fb6b61906mr1210611ywc.24.1681850439463;
        Tue, 18 Apr 2023 13:40:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d63-20020a814f42000000b0054f8b7b8514sm4074644ywb.128.2023.04.18.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:39 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/10] builtin/gc.c: ignore cruft packs with
 `--keep-largest-pack`
Message-ID: <63b9ee8e2e398abb4a7cb435589b080dd26c266d.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cruft packs were implemented, we never adjusted the code for `git
gc`'s `--keep-largest-pack` and `gc.bigPackThreshold` to ignore cruft
packs. This option and configuration option share a common
implementation, but including cruft packs is wrong in both cases:

  - Running `git gc --keep-largest-pack` in a repository where the
    largest pack is the cruft pack itself will make it impossible for
    `git gc` to prune objects, since the cruft pack itself is kept.

  - The same is true for `gc.bigPackThreshold`, if the size of the cruft
    pack exceeds the limit set by the caller.

In the future, it is possible that `gc.bigPackThreshold` could be used
to write a separate cruft pack containing any new unreachable objects
that entered the repository since the last time a cruft pack was
written.

There are some complexities to doing so, mainly around handling
pruning objects that are in an existing cruft pack that is above the
threshold (which would either need to be rewritten, or else delay
pruning). Rewriting a substantially similar cruft pack isn't ideal, but
it is significantly better than the status-quo.

If users have large cruft packs that they don't want to rewrite, they
can mark them as `*.keep` packs. But in general, if a repository has a
cruft pack that is so large it is slowing down GC's, it should probably
be pruned anyway.

In the meantime, ignore cruft packs in the common implementation for
both of these options, and add a pair of tests to prevent any future
regressions here.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/gc.txt | 10 ++++-----
 Documentation/git-gc.txt    |  7 +++---
 builtin/gc.c                |  2 +-
 t/t6500-gc.sh               | 43 +++++++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 38fea076a2..8d5353e9e0 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -43,11 +43,11 @@ gc.autoDetach::
 	if the system supports it. Default is true.
 
 gc.bigPackThreshold::
-	If non-zero, all packs larger than this limit are kept when
-	`git gc` is run. This is very similar to `--keep-largest-pack`
-	except that all packs that meet the threshold are kept, not
-	just the largest pack. Defaults to zero. Common unit suffixes of
-	'k', 'm', or 'g' are supported.
+	If non-zero, all non-cruft packs larger than this limit are kept
+	when `git gc` is run. This is very similar to
+	`--keep-largest-pack` except that all non-cruft packs that meet
+	the threshold are kept, not just the largest pack. Defaults to
+	zero. Common unit suffixes of 'k', 'm', or 'g' are supported.
 +
 Note that if the number of kept packs is more than gc.autoPackLimit,
 this configuration variable is ignored, all packs except the base pack
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index a65c9aa62d..fef382a70f 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -77,9 +77,10 @@ be performed as well.
 	instance running on this repository.
 
 --keep-largest-pack::
-	All packs except the largest pack and those marked with a
-	`.keep` files are consolidated into a single pack. When this
-	option is used, `gc.bigPackThreshold` is ignored.
+	All packs except the largest non-cruft pack, any packs marked
+	with a `.keep` file, and any cruft pack(s) are consolidated into
+	a single pack. When this option is used, `gc.bigPackThreshold`
+	is ignored.
 
 AGGRESSIVE
 ----------
diff --git a/builtin/gc.c b/builtin/gc.c
index edd98d35a5..53ef137e1d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -219,7 +219,7 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 	struct packed_git *p, *base = NULL;
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
-		if (!p->pack_local)
+		if (!p->pack_local || p->is_cruft)
 			continue;
 		if (limit) {
 			if (p->pack_size >= limit)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index d9acb63951..df6f2e6e52 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -298,6 +298,49 @@ test_expect_success 'feature.experimental=false avoids cruft packs by default' '
 	)
 '
 
+test_expect_success '--keep-largest-pack ignores cruft packs' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Generate a pack for reachable objects (of which there
+		# are 3), and one for unreachable objects (of which
+		# there are 6).
+		prepare_cruft_history &&
+		git gc --cruft &&
+
+		mtimes="$(find .git/objects/pack -type f -name "pack-*.mtimes")" &&
+		sz="$(test_file_size "${mtimes%.mtimes}.pack")" &&
+
+		# Ensure that the cruft pack gets removed (due to
+		# `--prune=now`) despite it being the largest pack.
+		git -c gc.bigPackThreshold=$sz gc --cruft --prune=now &&
+
+		assert_no_cruft_packs
+	)
+'
+
+test_expect_success 'gc.bigPackThreshold ignores cruft packs' '
+	test_when_finished "rm -fr repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Generate a pack for reachable objects (of which there
+		# are 3), and one for unreachable objects (of which
+		# there are 6).
+		prepare_cruft_history &&
+		git gc --cruft &&
+
+		# Ensure that the cruft pack gets removed (due to
+		# `--prune=now`) despite it being the largest pack.
+		git gc --cruft --prune=now --keep-largest-pack &&
+
+		assert_no_cruft_packs
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.40.0.362.gc67ee7c2ff

