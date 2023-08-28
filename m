Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECBC83F14
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjH1WtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjH1WtM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:49:12 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A511A
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:09 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5735282d713so1957806eaf.2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693262948; x=1693867748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=olN3KiS+MoHMfO0pFBF5q9zPvvk/HyiT/qH9c9t+GTQ=;
        b=wPOaju1Uf0gqmTdytFZ9FKiLxXaUz5dtJvL8OBeFZZyQhiIWTRgEmYrWvWuzrZnSyg
         35m3d4muivjkqEznf1h8NBSh0W7AzXFuUhPtLZ1WNb7F87DMYxvkvrvlLyO9+Mv9NGSJ
         OurwRxkHPlMeUrj/vpd1gET9k0mDUPri2NrD64Cqclh5/44LnyLkAIjsiPzzumwmZk+Z
         cw3wDV5urJVgHKIFQp4ZFK6XVlTxnnyeir/l1Oq8VhyXOcTOsfyDLfwXUgmNNkLagv/v
         m07WhYqqi77mDWaajUVkBLYr+NDiQ0gX2VEBonm0cAvxa5L+ZgV6cYuifhspFltVLpiO
         oryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262948; x=1693867748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olN3KiS+MoHMfO0pFBF5q9zPvvk/HyiT/qH9c9t+GTQ=;
        b=Ac8tjadaqWbb8Fr57X3c7OkFNkJe3QuTyi+DfsIkM9QsK3yB2QA90TvmCX4FM4fk1e
         Q/fzMItqu7nbrFW+11zJPZKpK/NeQ0RC5eNWfaEV43ndCGDicFOHYKy3oTZZE7owWH+q
         /aQbxzk3NB1BjybZNqg9qBFMtqaC0PNaCtIIOXvLt2bZb5Z+vH1jYhlRsbI/uSeaBuwp
         SkKGAvWw8V5uMRCJNvfevSl5rwbUhDkwLCvHsyFq8gWgjIdukEDFf9AY9efolRDeyhdP
         hCUx8A7CtYKS8BfpaVnDwS+TKtHVuqiFSgBRSYNv3hNU73Y4r6PUNYnJjs8YDuQXTetR
         OV3g==
X-Gm-Message-State: AOJu0YzYwMGxHoMth8ps2eeAXk7G747BAZqY71mUDLHFzI9HDLavuCBV
        2I92Z4snGpNTLhPdxsiO/syg5AHV6WEkTHzQ2jbYgQ==
X-Google-Smtp-Source: AGHT+IGEvkTYvjAzgSoQ9Z8MrqHBPQsIJXa7VnUOf4BRLbPlR527zgpTxwKc9jCYDHq+Am7Y0d7/Tw==
X-Received: by 2002:a05:6358:787:b0:13e:b477:8015 with SMTP id n7-20020a056358078700b0013eb4778015mr299226rwj.9.1693262948408;
        Mon, 28 Aug 2023 15:49:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x204-20020a0dd5d5000000b005897fd75c80sm2429073ywd.78.2023.08.28.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:49:08 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:49:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/4] builtin/pack-objects.c: support `--max-pack-size` with
 `--cruft`
Message-ID: <b6d945197faaef8243bddf78f672a340404e6ac4.1693262936.git.me@ttaylorr.com>
References: <cover.1693262936.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693262936.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pack-objects learned the `--cruft` option back in b757353676
(builtin/pack-objects.c: --cruft without expiration, 2022-05-20), we
explicitly forbade `--cruft` with `--max-pack-size`.

At the time, there was no specific rationale given in the patch for not
supporting the `--max-pack-size` option with `--cruft`. (As best I can
remember, it's because we were trying to push users towards only ever
having a single cruft pack, but I cannot be sure).

However, `--max-pack-size` is flexible enough that it already works with
`--cruft` and can shard unreachable objects across multiple cruft packs,
creating separate ".mtimes" files as appropriate. In fact, the
`--max-pack-size` option worked with `--cruft` as far back as
b757353676!

This is because we overwrite the `written_list`, and pass down the
appropriate length, i.e. the number of objects written in each pack
shard.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.txt |  4 +--
 builtin/pack-objects.c             |  7 ++--
 builtin/repack.c                   |  3 +-
 t/t5329-pack-objects-cruft.sh      | 54 ++++++++++++++++++++++++------
 4 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a9995a932c..dea7eacb0f 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -116,9 +116,7 @@ unreachable object whose mtime is newer than the `--cruft-expiration`).
 +
 Incompatible with `--unpack-unreachable`, `--keep-unreachable`,
 `--pack-loose-unreachable`, `--stdin-packs`, as well as any other
-options which imply `--revs`. Also incompatible with `--max-pack-size`;
-when this option is set, the maximum pack size is not inferred from
-`pack.packSizeLimit`.
+options which imply `--revs`.
 
 --cruft-expiration=<approxidate>::
 	If specified, objects are eliminated from the cruft pack if they
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 868efe7e0f..a046994a43 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1190,8 +1190,7 @@ static void write_pack_file(void)
 		unsigned char hash[GIT_MAX_RAWSZ];
 		char *pack_tmp_name = NULL;
 
-		if (pack_to_stdout)
-			f = hashfd_throughput(1, "<stdout>", progress_state);
+		if (pack_to_stdout) f = hashfd_throughput(1, "<stdout>", progress_state);
 		else
 			f = create_tmp_packfile(&pack_tmp_name);
 
@@ -4382,7 +4381,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (!HAVE_THREADS && delta_search_threads != 1)
 		warning(_("no threads support, ignoring --threads"));
-	if (!pack_to_stdout && !pack_size_limit && !cruft)
+	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
 	if (pack_to_stdout && pack_size_limit)
 		die(_("--max-pack-size cannot be used to build a pack for transfer"));
@@ -4414,8 +4413,6 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			die(_("cannot use internal rev list with --cruft"));
 		if (stdin_packs)
 			die(_("cannot use --stdin-packs with --cruft"));
-		if (pack_size_limit)
-			die(_("cannot use --max-pack-size with --cruft"));
 	}
 
 	/*
diff --git a/builtin/repack.c b/builtin/repack.c
index 2b43a5be08..6943c5ba11 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -720,7 +720,6 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 
 	strvec_push(&cmd.args, "--honor-pack-keep");
 	strvec_push(&cmd.args, "--non-empty");
-	strvec_push(&cmd.args, "--max-pack-size=0");
 
 	cmd.in = -1;
 
@@ -1048,6 +1047,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			cruft_po_args.depth = po_args.depth;
 		if (!cruft_po_args.threads)
 			cruft_po_args.threads = po_args.threads;
+		if (!cruft_po_args.max_pack_size)
+			cruft_po_args.max_pack_size = po_args.max_pack_size;
 
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 45667d4999..fc5fedbe9b 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -573,23 +573,54 @@ test_expect_success 'cruft repack with no reachable objects' '
 	)
 '
 
-test_expect_success 'cruft repack ignores --max-pack-size' '
+write_blob () {
+	test-tool genrandom "$@" >in &&
+	git hash-object -w -t blob in
+}
+
+find_pack () {
+	for idx in $(ls $packdir/pack-*.idx)
+	do
+		git show-index <$idx >out &&
+		if grep -q "$1" out
+		then
+			echo $idx
+		fi || return 1
+	done
+}
+
+test_expect_success 'cruft repack with --max-pack-size' '
 	git init max-pack-size &&
 	(
 		cd max-pack-size &&
 		test_commit base &&
+
 		# two cruft objects which exceed the maximum pack size
-		test-tool genrandom foo 1048576 | git hash-object --stdin -w &&
-		test-tool genrandom bar 1048576 | git hash-object --stdin -w &&
+		foo=$(write_blob foo 1048576) &&
+		bar=$(write_blob bar 1048576) &&
+		test-tool chmtime --get -1000 \
+			"$objdir/$(test_oid_to_path $foo)" >foo.mtime &&
+		test-tool chmtime --get -2000 \
+			"$objdir/$(test_oid_to_path $bar)" >bar.mtime &&
 		git repack --cruft --max-pack-size=1M &&
 		find $packdir -name "*.mtimes" >cruft &&
-		test_line_count = 1 cruft &&
-		test-tool pack-mtimes "$(basename "$(cat cruft)")" >objects &&
-		test_line_count = 2 objects
+		test_line_count = 2 cruft &&
+
+		foo_mtimes="$(basename $(find_pack $foo) .idx).mtimes" &&
+		bar_mtimes="$(basename $(find_pack $bar) .idx).mtimes" &&
+		test-tool pack-mtimes $foo_mtimes >foo.actual &&
+		test-tool pack-mtimes $bar_mtimes >bar.actual &&
+
+		echo "$foo $(cat foo.mtime)" >foo.expect &&
+		echo "$bar $(cat bar.mtime)" >bar.expect &&
+
+		test_cmp foo.expect foo.actual &&
+		test_cmp bar.expect bar.actual &&
+		test "$foo_mtimes" != "$bar_mtimes"
 	)
 '
 
-test_expect_success 'cruft repack ignores pack.packSizeLimit' '
+test_expect_success 'cruft repack with pack.packSizeLimit' '
 	(
 		cd max-pack-size &&
 		# repack everything back together to remove the existing cruft
@@ -599,9 +630,12 @@ test_expect_success 'cruft repack ignores pack.packSizeLimit' '
 		# ensure the same post condition is met when --max-pack-size
 		# would otherwise be inferred from the configuration
 		find $packdir -name "*.mtimes" >cruft &&
-		test_line_count = 1 cruft &&
-		test-tool pack-mtimes "$(basename "$(cat cruft)")" >objects &&
-		test_line_count = 2 objects
+		test_line_count = 2 cruft &&
+		for pack in $(cat cruft)
+		do
+			test-tool pack-mtimes "$(basename $pack)" >objects &&
+			test_line_count = 1 objects || return 1
+		done
 	)
 '
 
-- 
2.42.0.49.g03c54e21ee

