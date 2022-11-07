Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0754CC43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiKGSgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiKGSgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AAD209B5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h9so17613722wrt.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bKF2V+CUKt6G51qJQnkNIUqHLivlUCCMBGedw58uzq0=;
        b=kxLOK+SPzACuPpnKsOs076weBfdYO24Wx/G9Ac3oqDmBt1V7mESEY4V6DM/Fg1XSEg
         KK+OmJHr/2w9Bz6zAL/nL0iKd2wGOHQoAR3DtDB80t8GJPeCk0DSGjV03B4CnYCgbZhA
         RcQat6gXol2/bpeGljr0+jumljkZIHyvKkWIkYbOYblfcvWZ9yd6Emez9FvX3n0Eytjo
         iJe6xN8mqXBVMSaCgNXK22D6Xnbaalmx5vvfPFPP+tVUnEYpwdGetamluG+dR0aFrfSE
         6mo+PAo5bUDu0dbX9qrfcUy8FQULPCmemYGh0ExRX1yOeu0dNzCuFutVEf4wjWxzrmsJ
         mS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKF2V+CUKt6G51qJQnkNIUqHLivlUCCMBGedw58uzq0=;
        b=aG729qbZI946IpVmuDyQ8VkslsnoCcCQByVZKPHpyXAhi1+H4BBiOwQx6+ukzduAVR
         UR/bznCYzMwQV9q2yVxx81fZYh8DRTTogH42umu9RSB30Kbm+8huAK36UvBtlFEdMczX
         TblD3rtW06whu1qQCCy0qtuVu5CuXX3b6+7AYNFrz4oWeVkCSkqIebQexKl8gvHGKWv0
         anxJ6NZ6WpAlLmlLdi5hTvuikjPbEQOzlBSOioeQ+YiaFPoTKEGWHV7mJfThZp4m0Blj
         vlrPoROqMi72IAJhNWyU3mfMgBdpJbFJ7aPnU+aH9H5OsuSt3y6aPb0Q+8xu+iA8t7D3
         IYkQ==
X-Gm-Message-State: ACrzQf3w4y7xqib7h54CbapgXIJ//+EtxGp9Z+mFHBz8tR4ZMV2RWQUI
        lg436+5bjVLz/aE75BXYx0Z94K4tQbU=
X-Google-Smtp-Source: AMsMyM65a6ZRId4Qaw5kgY28et0bQEFwJdmwWlh4YOSlsdP8N7sGYQdbwL84yHifhnRZf4RNGW73BA==
X-Received: by 2002:adf:d84b:0:b0:236:e0da:61b7 with SMTP id k11-20020adfd84b000000b00236e0da61b7mr24008151wrl.79.1667846166500;
        Mon, 07 Nov 2022 10:36:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c3b9500b003b4c979e6bcsm13253383wms.10.2022.11.07.10.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:05 -0800 (PST)
Message-Id: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:34 +0000
Subject: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Introduction
============

I became interested in our packed-ref format based on the asymmetry between
ref updates and ref deletions: if we delete a packed ref, then the
packed-refs file needs to be rewritten. Compared to writing a loose ref,
this is an O(N) cost instead of O(1).

In this way, I set out with some goals:

 * (Primary) Make packed ref deletions be nearly as fast as loose ref
   updates.
 * (Secondary) Allow using a packed ref format for all refs, dropping loose
   refs and creating a clear way to snapshot all refs at a given point in
   time.

I also had one major non-goal to keep things focused:

 * (Non-goal) Update the reflog format.

After carefully considering several options, it seemed that there are two
solutions that can solve this effectively:

 1. Wait for reftable to be integrated into Git.
 2. Update the packed-refs backend to have a stacked version.

The reftable work seems currently dormant. The format is pretty complicated
and I have a difficult time seeing a way forward for it to be fully
integrated into Git. Personally, I'd prefer a more incremental approach with
formats that are built for a basic filesystem. During the process, we can
create APIs within Git that can benefit other file formats within Git.

Further, there is a simpler model that satisfies my primary goal without the
complication required for the secondary goal. Suppose we create a stacked
packed-refs file but only have two layers: the first (base) layer is created
when git pack-refs collapses the full stack and adds the loose ref updates
to the packed-refs file; the second (top) layer contains only ref deletions
(allowing null OIDs to indicate a deleted ref). Then, ref deletions would
only need to rewrite that top layer, making ref deletions take O(deletions)
time instead of O(all refs) time. With a reasonable schedule to squash the
packed-refs stack, this would be a dramatic improvement. (A prototype
implementation showed that updating a layer of 1,000 deletions takes only
twice the time as writing a single loose ref.)

If we want to satisfy the secondary goal of passing all ref updates through
the packed storage, then more complicated layering would be necessary. The
point of bringing this up is that we have incremental goals along the way to
that final state that give us good stopping points to test the benefits of
each step.

Stacking the packed-refs format introduces several interesting strategy
points that are complicated to resolve. Before we can do that, we first need
to establish a way to modify the ref format of a Git repository. Hence, we
need a new extension for the ref formats.

To simplify the first update to the ref formats, it seemed better to add a
new file format version to the existing packed-refs file format. This format
has the exact lock/write/rename mechanics of the current packed-refs format,
but uses a file format that structures the information in a more compact
way. It uses the chunk-format API, with some tweaks. This format update is
useful to the final goal of a stacked packed-refs API, since each layer will
have faster reads and writes. The main reason to do this first is that it is
much simpler to understand the value-add (smaller files means faster
performance).


RFC Organization
================

This RFC is quite long, but the length seemed necessary to actually provide
and end-to-end implementation that demonstrates the packed-refs v2 format
along with test coverage (via the new GIT_TEST_PACKED_REFS_VERSION
variable).

For convenience, I've broken each section of the full RFC into parts, which
resembles how I intend to submit the pieces for full review. These parts are
available as pull requests in my fork, but here is a breakdown:


Part I: Optionally hash the index
=================================

[1] https://github.com/derrickstolee/git/pull/23 Packed-refs v2 Part I:
Optionally hash the index (Patches 1-2)

The chunk-format API uses the hashfile API as a buffered write, but also all
existing formats that use the chunk-format API also have a trailing hash as
part of the format. Since the packed-refs file has a critical path involving
its write speed (deleting a packed ref), it seemed important to allow
apples-to-apples comparison between the v1 and v2 format by skipping the
hashing. This is later toggled by a config option.

In this part, the focus is on allowing the hashfile API to ignore updating
the hash during the buffered writes. We've been using this in microsoft/git
to optionally speed up index writes, which patch 2 introduces here. The file
format instead writes a null OID which would look like a corrupt file to an
older 'git fsck'. Before submitting a full version, I would update 'git
fsck' to ignore a null OID in all of our file formats that include a
trailing hash. Since the index is more short-lived than other formats (such
as pack-files) this trailing hash is less useful. The write time is also
critical as the performance tests demonstrate.


Part II: Create extensions.refFormat
====================================

[2] https://github.com/derrickstolee/git/pull/24 Packed-refs v2 Part II:
create extensions.refFormat (Patches 3-7)

This part is a critical concept that has yet to be defined in the Git
codebase. We have no way to incrementally modify the ref format. Since refs
are so critical, we cannot add an optionally-understood layer on top (like
we did with the multi-pack-index and commit-graph files). The reftable draft
[6] proposes the same extension name (extensions.refFormat) but focuses
instead on only a single value. This means that the reftable must be defined
at git init or git clone time and cannot be upgraded from the files backend.

In this RFC, I propose a different model that allows for more customization
and incremental updates. The extensions.refFormat config key is multi-valued
and defaults to the list of files and packed. In the context of this RFC,
the intention is to be able to add packed-v2 so the list of all three values
would allow Git to write and read either file format version (v1 or v2). In
the larger scheme, the extension could allow restricting to only loose refs
(just files) or only packed-refs (just packed) or even later when reftable
is complete, files and reftable could mean that loose refs are the primary
ref storage, but the reftable format serves as a drop-in replacement for the
packed-refs file. Not all combinations need to be understood by Git, but
having them available as an option could be useful for flexibility,
especially when trying to upgrade existing repositories to new formats.

In the future, beyond the scope of this RFC, it would be good to add a
stacked value that allows a stack of files in packed-refs format (whose
version is specified by the packed or packed-v2 values) so we can further
speed up writes to the packed layer. Depending on how well that works, we
could focus on speeding up ref deletions or sending all ref writes straight
to the packed-refs layer. With the option to keep the loose refs storage, we
have flexibility to explore that space incrementally when we have time to
get to it.


Part III: Allow a trailing table-of-contents in the chunk-format API
====================================================================

[3] https://github.com/derrickstolee/git/pull/25 Packed-refs v2 Part III:
trailing table of contents in chunk-format (Patches 8-17)

In order to optimize the write speed of the packed-refs v2 file format, we
want to write immediately to the file as we stream existing refs from the
current refs. The current chunk-format API requires computing the chunk
lengths in advance, which can slow down the write and take more memory than
necessary. Using a trailing table of contents solves this problem, and was
recommended earlier [7]. We just didn't have enough evidence to justify the
work to update the existing chunk formats. Here, we update the API in
advance of using in the packed-refs v2 format.

We could consider updating the commit-graph and multi-pack-index formats to
use trailing table of contents, but it requires a version bump. That might
be worth it in the case of the commit-graph where computing the size of the
changed-path Bloom filters chunk requires a lot of memory at the moment.
After this chunk-format API update is reviewed and merged, we can pursue
those directions more closely. We would want to investigate the formats more
carefully to see if we want to update the chunks themselves as well as some
header information.


Part IV: Abstract some parts of the v1 file format
==================================================

[4] https://github.com/derrickstolee/git/pull/26 Packed-refs v2 Part IV:
abstract some parts of the v1 file format (Patches 18-21)

These patches move the part of the refs/packed-backend.c file that deal with
the specifics of the packed-refs v1 file format into a new file:
refs/packed-format-v1.c. This also creates an abstraction layer that will
allow inserting the v2 format more easily.

One thing that doesn't exist currently is a documentation file describing
the packed-refs file format. I would add that file in this part before
submitting it for full review. (I also haven't written the file format doc
for the packed-refs v2 format, either.)


Part V: Implement the v2 file format
====================================

[5] https://github.com/derrickstolee/git/pull/27 Packed-refs v2 Part V: the
v2 file format (Patches 22-35)

This is the real meat of the work. Perhaps there are ways to split it
further, but for now this is what I have ready. The very last patch does a
complete performance comparison for a repo with many refs.

The format is not yet documented, but is broken up into these pieces:

 1. The refs data chunk stores the same data as the packed-refs file, but
    each ref is broken down as follows: the ref name (with trailing zero),
    the OID for the ref in its raw bytes, and (if necessary) the peeled OID
    for the ref in its raw bytes. The refs are sorted lexicographically.

 2. The ref offsets chunk is a single column of 64-bit offsets into the refs
    chunk indicating where each ref starts. The most-significant bit of that
    value indicates whether or not there is a peeled OID.

 3. The prefix data chunk lists a set of ref prefixes (currently writes only
    allow depth-2 prefixes, such as refs/heads/ and refs/tags/). When
    present, these prefixes are written in this chunk and not in the refs
    data chunk. The prefixes are sorted lexicographically.

 4. The prefix offset chunk has two 32-bit integer columns. The first column
    stores the offset within the prefix data chunk to the start of the
    prefix string. The second column points to the row position for the
    first ref that has name greater than this prefix (the 0th prefix is
    assumed to start at row 0, so we can interpret the prefix range from
    row[i-1] and row[i]).

Between using raw OIDs and storing the depth-2 prefixes only once, this
format compresses the file to ~60% of its v1 size. (The format allows not
writing the prefix chunks, and the prefix chunks are implemented after the
basics of the ref chunks are complete.)

The write times are reduced in a similar fraction to the size difference.
Reads are sped up somewhat, and we have the potential to do a ref count by
prefix much faster by doing a binary search for the start and end of the
prefix and then subtracting the row positions instead of scanning the file
between to count refs.


Relationship to Reftable
========================

I mentioned earlier that I had considered using reftable as a way to achieve
the stated goals. With the current state of that work, I'm not confident
that it is the right approach here.

My main worry is that the reftable is more complicated than we need for a
typical Git repository that is based on a typical filesystem. This makes
testing the format very critical, and we seem to not be near reaching that
approach. The v2 format here is very similar to existing Git file formats
since it uses the chunk-format API. This means that the amount of code
custom to just the v2 format is quite small.

As mentioned, the current extension plan [6] only allows reftable or files
and does not allow for a mix of both. This RFC introduces the possibility
that both could co-exist. Using that multi-valued approach means that I'm
able to test the v2 packed-refs file format almost as well as the v1 file
format within this RFC. (More tests need to be added that are specific to
this format, but I'm waiting for confirmation that this is an acceptable
direction.) At the very least, this multi-valued approach could be used as a
way to allow using the reftable format as a drop-in replacement for the
packed-refs file, as well as upgrading an existing repo to use reftable.
That might even help the integration process to allow the reftable format to
be tested at least by some subset of tests instead of waiting for a full
test suite update.

I'm interested to hear from people more involved in the reftable work to see
the status of that project and how it matches or differs from my
perspective.

The one thing I can say is that if the reftable work had not already begun,
then this is RFC is how I would have approached a new ref format.

I look forward to your feedback!

Thanks,

 * Stolee

[6]
https://github.com/git/git/pull/1215/files#diff-a30f88b458b1f01e7a67e72576584b5b77ddb0362e40da6f7bf4a9ddf79db7b8R41-R48
The draft version of extensions.refFormat for reftable.

[7] https://lore.kernel.org/git/4696bd93-9406-0abd-25ec-a739665a24d5@web.de/
Re: [PATCH 00/15] Refactor chunk-format into an API (where René recommends a
trailing table of contents)

Derrick Stolee (30):
  hashfile: allow skipping the hash function
  read-cache: add index.computeHash config option
  extensions: add refFormat extension
  config: fix multi-level bulleted list
  repository: wire ref extensions to ref backends
  refs: allow loose files without packed-refs
  chunk-format: number of chunks is optional
  chunk-format: document trailing table of contents
  chunk-format: store chunk offset during write
  chunk-format: allow trailing table of contents
  chunk-format: parse trailing table of contents
  refs: extract packfile format to new file
  packed-backend: extract add_write_error()
  packed-backend: extract iterator/updates merge
  packed-backend: create abstraction for writing refs
  config: add config values for packed-refs v2
  packed-backend: create shell of v2 writes
  packed-refs: write file format version 2
  packed-refs: read file format v2
  packed-refs: read optional prefix chunks
  packed-refs: write prefix chunks
  packed-backend: create GIT_TEST_PACKED_REFS_VERSION
  t1409: test with packed-refs v2
  t5312: allow packed-refs v2 format
  t5502: add PACKED_REFS_V1 prerequisite
  t3210: require packed-refs v1 for some tests
  t*: skip packed-refs v2 over http tests
  ci: run GIT_TEST_PACKED_REFS_VERSION=2 in some builds
  p1401: create performance test for ref operations
  refs: skip hashing when writing packed-refs v2

 Documentation/config.txt            |   2 +
 Documentation/config/extensions.txt |  76 ++-
 Documentation/config/index.txt      |   8 +
 Documentation/config/refs.txt       |  13 +
 Documentation/gitformat-chunk.txt   |  26 +-
 Makefile                            |   2 +
 cache.h                             |   2 +
 chunk-format.c                      | 109 +++-
 chunk-format.h                      |  18 +-
 ci/run-build-and-tests.sh           |   1 +
 commit-graph.c                      |   2 +-
 csum-file.c                         |  14 +-
 csum-file.h                         |   7 +
 midx.c                              |   2 +-
 read-cache.c                        |  22 +-
 refs.c                              |  24 +-
 refs/files-backend.c                |   8 +-
 refs/packed-backend.c               | 880 +++++++---------------------
 refs/packed-backend.h               | 281 +++++++++
 refs/packed-format-v1.c             | 456 ++++++++++++++
 refs/packed-format-v2.c             | 624 ++++++++++++++++++++
 refs/refs-internal.h                |   9 +
 repository.c                        |   2 +
 repository.h                        |   7 +
 setup.c                             |  26 +
 t/perf/p1401-ref-operations.sh      |  52 ++
 t/t1409-avoid-packing-refs.sh       |  22 +-
 t/t1600-index.sh                    |   8 +
 t/t3210-pack-refs.sh                |   8 +-
 t/t3212-ref-formats.sh              | 100 ++++
 t/t5502-quickfetch.sh               |   2 +-
 t/t5539-fetch-http-shallow.sh       |   7 +
 t/t5541-http-push-smart.sh          |   7 +
 t/t5542-push-http-shallow.sh        |   7 +
 t/t5551-http-fetch-smart.sh         |   7 +
 t/t5558-clone-bundle-uri.sh         |   7 +
 t/test-lib.sh                       |   4 +
 37 files changed, 2157 insertions(+), 695 deletions(-)
 create mode 100644 Documentation/config/refs.txt
 create mode 100644 refs/packed-format-v1.c
 create mode 100644 refs/packed-format-v2.c
 create mode 100755 t/perf/p1401-ref-operations.sh
 create mode 100755 t/t3212-ref-formats.sh


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1408%2Fderrickstolee%2Frefs%2Frfc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1408/derrickstolee/refs/rfc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1408
-- 
gitgitgadget
