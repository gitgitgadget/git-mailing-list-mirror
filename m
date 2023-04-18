Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC9C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjDRUlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjDRUlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:41:02 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80202CC3C
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:59 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b10so2497489ybk.9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850458; x=1684442458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fP+L07cwQTzkf6Cs7rGppdhtqqim7Hezjnkkp2v4+CA=;
        b=WPdQ2d0+iwlHKbynB/dLvAM/8jHbuU214DQZY4RBCZocNHiIkTaUVMnCUU4h9sscCs
         fpJr/wPobYgQu4hY3eakIjuGOWmk+yFngwWSz/WeCTjVsBmBgzSqb8M8PfVcwH/QCw5H
         VCVTICJZzrUL/bNgh91K29N3dLD+Q5UY3+sFS86kEJjdB/NFxo6SF792LN62XdNpYfBO
         i2vBTGtb1CAXlEQrXtCDyLtHrjL9u3faWTTvp54GdiyapZqKRwyaLy9ev/7exzxhzijl
         4BNhwIOXFpitkfneGwgcEGlUjxAmHvf7TMHBcfFlVD7b42AJys3h4lA41vt/Jsko2it6
         xmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850458; x=1684442458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP+L07cwQTzkf6Cs7rGppdhtqqim7Hezjnkkp2v4+CA=;
        b=UMFgYsskgFsa13EL899eT3yRwtYCGelFlnjThZucJI347oUfr7DUJqPcmw7cMhpKee
         iiywZpFseO1z010mDHIy8V8UtbsjQu1Wm4OJnT3f9nfK5Picp4qmUmYkWtf4ij2llSQC
         zCdT9ru9KSjCgxWMNtUsRQKSJIFgGs6C++amnfAglg3R+y+X7tw3i8q6yt/wW6hid+Dl
         KLC6Gl7QR57SKSXZOvJnOvp8wbNoYHvntqwzdoP6jva3crn36O8kjXtv9+6PL65335zI
         cSi+C588sP8JsV2svy0GxWLb1zeMbL/W3A+qIdG2U63Axz87SSQ8ICLrfBkLfHi5qW4n
         JL7g==
X-Gm-Message-State: AAQBX9f8HuS1hOMGNYQlmjAAMzpRRBavrrcNkNDxf2d06yvwbueqqfSD
        tnbeffLliwS+4aSF3hQF91spNgenW9hyGi6F7mAs2A==
X-Google-Smtp-Source: AKy350YW7UNabT6OKkxJZ+NYWmbGurTFwC+/JTaF7vxLBwMAz7IJaMTmhYfXfUCppokjKX7BufjWog==
X-Received: by 2002:a25:2407:0:b0:b95:ded1:7d99 with SMTP id k7-20020a252407000000b00b95ded17d99mr2258589ybk.27.1681850458506;
        Tue, 18 Apr 2023 13:40:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b14-20020a252e4e000000b00b8f6ec5a955sm3198301ybn.49.2023.04.18.13.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:58 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/10] builtin/gc.c: make `gc.cruftPacks` enabled by
 default
Message-ID: <b6784ddfe2906f7c04b3050bd9ba63a884ddb047.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 5b92477f89 (builtin/gc.c: conditionally avoid pruning objects
via loose, 2022-05-20), `git gc` learned the `--cruft` option and
`gc.cruftPacks` configuration to opt-in to writing cruft packs when
collecting or pruning unreachable objects.

Cruft packs were introduced with the merge in a50036da1a (Merge branch
'tb/cruft-packs', 2022-06-03). They address the problem of "loose object
explosions", where Git will write out many individual loose objects when
there is a large number of unreachable objects that have not yet aged
past `--prune=<date>`.

Instead of keeping track of those unreachable yet recent objects via
their loose object file's mtime, cruft packs collect all unreachable
objects into a single pack with a corresponding `*.mtimes` file that
acts as a table to store the mtimes of all unreachable objects. This
prevents the need to store unreachable objects as loose as they age out
of the repository, and avoids the problem of loose object explosions.

Beyond avoiding loose object explosions, cruft packs also act as a more
efficient mechanism to store unreachable objects as they age out of a
repository. This is because pairs of similar unreachable objects serve
as delta bases for one another.

In 5b92477f89, the feature was introduced as experimental. Since then,
GitHub has been running these patches in every repository generating
hundreds of millions of cruft packs along the way. The feature is
battle-tested, and avoids many pathological cases such as above. Users
who either run `git gc` manually, or via `git maintenance` can benefit
from having cruft packs.

As such, enable cruft pack generation to take place by default (by
making `gc.cruftPacks` have the default of "true" rather than "false).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/feature.txt |  3 ---
 Documentation/config/gc.txt      |  2 +-
 Documentation/git-gc.txt         |  5 +++--
 Documentation/gitformat-pack.txt |  4 ++--
 builtin/gc.c                     |  6 +-----
 t/t6500-gc.sh                    | 12 ++++--------
 6 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index e52bc6b858..17b4d39f89 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -14,9 +14,6 @@ feature.experimental::
 +
 * `fetch.negotiationAlgorithm=skipping` may improve fetch negotiation times by
 skipping more commits at a time, reducing the number of round trips.
-+
-* `gc.cruftPacks=true` reduces disk space used by unreachable objects during
-garbage collection, preventing loose object explosions.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 8d5353e9e0..7f95c866e1 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -84,7 +84,7 @@ gc.packRefs::
 gc.cruftPacks::
 	Store unreachable objects in a cruft pack (see
 	linkgit:git-repack[1]) instead of as loose objects. The default
-	is `false`.
+	is `true`.
 
 gc.pruneExpire::
 	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index fef382a70f..90806fd26a 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -54,9 +54,10 @@ other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
 
---cruft::
+--[no-]cruft::
 	When expiring unreachable objects, pack them separately into a
-	cruft pack instead of storing them as loose objects.
+	cruft pack instead of storing them as loose objects. `--cruft`
+	is on by default.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index e06af02f21..0c1be2dbe8 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -611,8 +611,8 @@ result of repeatedly resetting the objects' mtimes to the present time.
 
 If you are GC-ing repositories in a mixed version environment, consider omitting
 the `--cruft` option when using linkgit:git-repack[1] and linkgit:git-gc[1], and
-leaving the `gc.cruftPacks` configuration unset until all writers understand
-cruft packs.
+setting the `gc.cruftPacks` configuration to "false" until all writers
+understand cruft packs.
 
 === Alternatives
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 53ef137e1d..ece01e966f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -48,7 +48,7 @@ static const char * const builtin_gc_usage[] = {
 
 static int pack_refs = 1;
 static int prune_reflogs = 1;
-static int cruft_packs = -1;
+static int cruft_packs = 1;
 static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
@@ -608,10 +608,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
 		die(_("failed to parse prune expiry value %s"), prune_expire);
 
-	prepare_repo_settings(the_repository);
-	if (cruft_packs < 0)
-		cruft_packs = the_repository->settings.gc_cruft_packs;
-
 	if (aggressive) {
 		strvec_push(&repack, "-f");
 		if (aggressive_depth > 0)
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 3ba2ae5140..69509d0c11 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -216,11 +216,9 @@ assert_no_cruft_packs () {
 }
 
 for argv in \
-	"gc --cruft" \
+	"gc" \
 	"-c gc.cruftPacks=true gc" \
-	"-c gc.cruftPacks=false gc --cruft" \
-	"-c feature.experimental=true gc" \
-	"-c gc.cruftPacks=true -c feature.experimental=false gc"
+	"-c gc.cruftPacks=false gc --cruft"
 do
 	test_expect_success "git $argv generates a cruft pack" '
 		test_when_finished "rm -fr repo" &&
@@ -244,11 +242,9 @@ do
 done
 
 for argv in \
-	"gc" \
+	"gc --no-cruft" \
 	"-c gc.cruftPacks=false gc" \
-	"-c gc.cruftPacks=true gc --no-cruft" \
-	"-c feature.expiremental=true -c gc.cruftPacks=false gc" \
-	"-c feature.experimental=false gc"
+	"-c gc.cruftPacks=true gc --no-cruft"
 do
 	test_expect_success "git $argv does not generate a cruft pack" '
 		test_when_finished "rm -fr repo" &&
-- 
2.40.0.362.gc67ee7c2ff

