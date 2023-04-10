Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D6C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjDJWx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDJWxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:53:45 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA2212E
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:43 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54c12009c30so233389577b3.9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681167222; x=1683759222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WPfbEcaOwGFeNtY9Wa7/E9QTZEQLc5FFABXfxZzDLWA=;
        b=6icYCugtnp+tMUayyASz65lzeqQ04JQ5L/6AZo/NRjL8BxEhDTDpvzpKOWN3tGFbPN
         viCR0wuqtfd8noQqPD5Pr4TFULCrz3nkhPecjujOkxVPLVbif/KB0HLlWG6TPKnIZ7ZV
         1OCGQGZXporUB1d1d+YJNvQYfG7R6cVlAk28dmMi/mLOynag7QvOiUWkl7CagOtfg850
         O6oPzoQZOENf9G+44Qi4ngAYFmYYO9W1Sy4NVEslxurmwCt5CN/9DBolmFTjAX14zCe+
         dUtU2xqWIc1pM+xJnTabudyQL7ajdtMofAGzZh0I4YIzksfouSpVCu6Zu5GLSausvFrn
         9Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167222; x=1683759222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPfbEcaOwGFeNtY9Wa7/E9QTZEQLc5FFABXfxZzDLWA=;
        b=3c9SUPXV5hMp398X9wWWJYka6SeGt2SA9hSyzPa//nGB1CmX35uj1sAy1qGzEKlEBZ
         efgIB8ES1M5rTeM/9u+YNCZA+EfbQOmw+QF8KsauiLSZYe+8ycabGp9ixbfnjUjSGc9o
         emBWBCvA0iih1nlilBcdnJsO++uj2Mrg8VO6vYCCeBCY619xjdP3owy9VoLdInG5UsRc
         ++V1kVJ5e2e9C8WBVvONrLPZD6N+cdjFlzgHEDe3MjN7TU/+NGrGSnGSIEqqnJy261BD
         DzXS8DRazuneKkmb9vy6qcWHPT0aFH/spjHwPy67Bmkon3nMvt+dlBF0eOcjc71ObOhp
         SQLg==
X-Gm-Message-State: AAQBX9c3KwqO9UNuuHAiP5/F1WA+KK2L9oUXyQ7a1TzSvhZyJbttjC6g
        LpriiG1nJ1AvdvLqOpo3UTuTybyaUkV4bsRKg9Vchg==
X-Google-Smtp-Source: AKy350a4XvlgW3BbIGYo/2z4FYe7jntpp8YYsm/KyG0J0fgz6MsQjt3iTbuYgUgDCnPXYH4U3UeQKA==
X-Received: by 2002:a81:728a:0:b0:533:9c8d:81d1 with SMTP id n132-20020a81728a000000b005339c8d81d1mr10290780ywc.3.1681167222012;
        Mon, 10 Apr 2023 15:53:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 82-20020a810a55000000b00545a0818486sm3106418ywk.22.2023.04.10.15.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:53:41 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:53:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] config: enable `pack.writeReverseIndex` by default
Message-ID: <56a0fc0098e0b0551e01414c8e67c17fb1ba3054.1681166596.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in e37d0b8730 (builtin/index-pack.c: write reverse indexes,
2021-01-25), Git learned how to read and write a pack's reverse index
from a file instead of in-memory.

A pack's reverse index is a mapping from pack position (that is, the
order that objects appear together in a ".pack")  to their position in
lexical order (that is, the order that objects are listed in an ".idx"
file).

Reverse indexes are consulted often during pack-objects, as well as
during auxiliary operations that require mapping between pack offsets,
pack order, and index index.

They are useful in GitHub's infrastructure, where we have seen a
dramatic increase in performance when writing ".rev" files[1]. In
particular:

  - an ~80% reduction in the time it takes to serve fetches on a popular
    repository, Homebrew/homebrew-core.

  - a ~60% reduction in the peak memory usage to serve fetches on that
    same repository.

  - a collective savings of ~35% in CPU time across all pack-objects
    invocations serving fetches across all repositories in a single
    datacenter.

Reverse indexes are also beneficial to end-users as well as forges. For
example, the time it takes to generate a pack containing the objects for
the 10 most recent commits in linux.git (representing a typical push) is
significantly faster when on-disk reverse indexes are available:

    $ { git rev-parse HEAD && printf '^' && git rev-parse HEAD~10 } >in
    $ hyperfine -L v false,true 'git.compile -c pack.readReverseIndex={v} pack-objects --delta-base-offset --revs --stdout <in >/dev/null'
    Benchmark 1: git.compile -c pack.readReverseIndex=false pack-objects --delta-base-offset --revs --stdout <in >/dev/null
      Time (mean ± σ):     543.0 ms ±  20.3 ms    [User: 616.2 ms, System: 58.8 ms]
      Range (min … max):   521.0 ms … 577.9 ms    10 runs

    Benchmark 2: git.compile -c pack.readReverseIndex=true pack-objects --delta-base-offset --revs --stdout <in >/dev/null
      Time (mean ± σ):     245.0 ms ±  11.4 ms    [User: 335.6 ms, System: 31.3 ms]
      Range (min … max):   226.0 ms … 259.6 ms    13 runs

    Summary
      'git.compile -c pack.readReverseIndex=true pack-objects --delta-base-offset --revs --stdout <in >/dev/null' ran
	2.22 ± 0.13 times faster than 'git.compile -c pack.readReverseIndex=false pack-objects --delta-base-offset --revs --stdout <in >/dev/null'

The same is true of writing a pack containing the objects for the 30
most-recent commits:

    $ { git rev-parse HEAD && printf '^' && git rev-parse HEAD~30 } >in
    $ hyperfine -L v false,true 'git.compile -c pack.readReverseIndex={v} pack-objects --delta-base-offset --revs --stdout <in >/dev/null'
    Benchmark 1: git.compile -c pack.readReverseIndex=false pack-objects --delta-base-offset --revs --stdout <in >/dev/null
      Time (mean ± σ):     866.5 ms ±  16.2 ms    [User: 1414.5 ms, System: 97.0 ms]
      Range (min … max):   839.3 ms … 886.9 ms    10 runs

    Benchmark 2: git.compile -c pack.readReverseIndex=true pack-objects --delta-base-offset --revs --stdout <in >/dev/null
      Time (mean ± σ):     581.6 ms ±  10.2 ms    [User: 1181.7 ms, System: 62.6 ms]
      Range (min … max):   567.5 ms … 599.3 ms    10 runs

    Summary
      'git.compile -c pack.readReverseIndex=true pack-objects --delta-base-offset --revs --stdout <in >/dev/null' ran
	1.49 ± 0.04 times faster than 'git.compile -c pack.readReverseIndex=false pack-objects --delta-base-offset --revs --stdout <in >/dev/null'

...and savings on trivial operations like computing the on-disk size of
a single (packed) object are even more dramatic:

    $ git rev-parse HEAD >in
    $ hyperfine -L v false,true 'git.compile -c pack.readReverseIndex={v} cat-file --batch-check="%(objectsize:disk)" <in'
    Benchmark 1: git.compile -c pack.readReverseIndex=false cat-file --batch-check="%(objectsize:disk)" <in
      Time (mean ± σ):     305.8 ms ±  11.4 ms    [User: 264.2 ms, System: 41.4 ms]
      Range (min … max):   290.3 ms … 331.1 ms    10 runs

    Benchmark 2: git.compile -c pack.readReverseIndex=true cat-file --batch-check="%(objectsize:disk)" <in
      Time (mean ± σ):       4.0 ms ±   0.3 ms    [User: 1.7 ms, System: 2.3 ms]
      Range (min … max):     1.6 ms …   4.6 ms    1155 runs

    Summary
      'git.compile -c pack.readReverseIndex=true cat-file --batch-check="%(objectsize:disk)" <in' ran
       76.96 ± 6.25 times faster than 'git.compile -c pack.readReverseIndex=false cat-file --batch-check="%(objectsize:disk)" <in'

In the more than two years since e37d0b8730 was merged, Git's
implementation of on-disk reverse indexes has been thoroughly tested,
both from users enabling `pack.writeReverseIndexes`, and from GitHub's
deployment of the feature. The latter has been running without incident
for more than two years.

This patch changes Git's behavior to write on-disk reverse indexes by
default when indexing a pack, which should make the above operations
faster for everybody's Git installation after a repack.

(The previous commit explains some potential drawbacks of using on-disk
reverse indexes in certain limited circumstances, that essentially boil
down to a trade-off between time to generate, and time to access. For
those limited cases, the `pack.readReverseIndex` escape hatch can be
used).

[1]: https://github.blog/2021-04-29-scaling-monorepo-maintenance/#reverse-indexes

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt     | 2 +-
 builtin/index-pack.c              | 1 +
 builtin/pack-objects.c            | 1 +
 t/perf/p5312-pack-bitmaps-revs.sh | 3 +--
 t/t5325-reverse-index.sh          | 1 +
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 7db7fed466..d4c7c9d4e4 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -182,4 +182,4 @@ pack.writeReverseIndex::
 	linkgit:gitformat-pack[5])
 	for each new packfile that it writes in all places except for
 	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
-	Defaults to false.
+	Defaults to true.
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b17e79cd40..323c063f9d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1753,6 +1753,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	fsck_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
+	opts.flags |= WRITE_REV;
 	git_config(git_index_pack_config, &opts);
 	if (prefix && chdir(prefix))
 		die(_("Cannot come back to cwd"));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 77d88f85b0..dbaa04482f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4293,6 +4293,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	reset_pack_idx_option(&pack_idx_opts);
+	pack_idx_opts.flags |= WRITE_REV;
 	git_config(git_pack_config, NULL);
 	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
 		pack_idx_opts.flags |= WRITE_REV;
diff --git a/t/perf/p5312-pack-bitmaps-revs.sh b/t/perf/p5312-pack-bitmaps-revs.sh
index 0684b690af..ceec60656b 100755
--- a/t/perf/p5312-pack-bitmaps-revs.sh
+++ b/t/perf/p5312-pack-bitmaps-revs.sh
@@ -12,8 +12,7 @@ test_lookup_pack_bitmap () {
 	test_perf_large_repo
 
 	test_expect_success 'setup bitmap config' '
-		git config pack.writebitmaps true &&
-		git config pack.writeReverseIndex true
+		git config pack.writebitmaps true
 	'
 
 	# we need to create the tag up front such that it is covered by the repack and
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 66171c1d67..149dcf5193 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -14,6 +14,7 @@ packdir=.git/objects/pack
 test_expect_success 'setup' '
 	test_commit base &&
 
+	test_config pack.writeReverseIndex false &&
 	pack=$(git pack-objects --all $packdir/pack) &&
 	rev=$packdir/pack-$pack.rev &&
 
-- 
2.40.0.323.g9c80379958

