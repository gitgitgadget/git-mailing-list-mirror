Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F9C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D26C20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt+X7fiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgE2Iva (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgE2Iv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F575C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v19so2339444wmj.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgCDjDXcRZ3DF8Ikw8mIO/UrMskL6fM/dl5eNBNLf/k=;
        b=gt+X7fiI6gnS+mC/IwtQ8ud0Y0INz9O3PV/7OWdT2zmxguQYq5vS5L3YWV2GUTku4s
         OUI51ErgHCrKcfXKveYUiSb9tRj5PnYZTt8VZTPpfgTah+E310SfF5pe8YtNMDx1dew3
         2GTkxcdz/H6tJqaAjwSJ0/vq3ZGH7oGspDlwHxt6oppkgylIueV1uoW5WjvBu5tXENf8
         vRJEr571TzMAYSxt+TIF0eur+QJ4PIicYTl7wWXuqqR7mMwOGoHQCsgQlzbSnbIPCTBZ
         Z2S7o+W0i5Is51j8mDWbq0WoiFSVN9xd/okjbDoPn4EC9M40hYdsyEo2GRsnw2UoB2GJ
         DIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgCDjDXcRZ3DF8Ikw8mIO/UrMskL6fM/dl5eNBNLf/k=;
        b=IqFEFWIWa4FPtI5MIuO7EJeKn1Vg1ZASQB7ocvgyO1LMGf2DMOcrmcZecped5DrXLz
         UREJ1ua0Kqm7FA7457X0InGixCGH3YBEjWBDb+aXOEiq0jbr1c/b4MJnwcde9Hlwd60B
         13ubdU/W8xhiCZaWM8xXhdeS487zr6FnWNDdUglzHTfIqnIvNOitmXU2gPIlaptjVMD/
         H18hgRNDRJsg/My03M4h5dtN/5QAp0MHQ/Xo2cWj4c0+I6FeBHujRlBp2EQjYwRacVZm
         DEvQQgwcGF/Qd0E2tkLS8sJJP6CPkz0CwwyK9dbfeZITXQRzsIGNcVIl7iHM28iBXwTU
         sb5g==
X-Gm-Message-State: AOAM530zz92+BpaZEL09kZPLFkhJoDmBpF6Vm0DMh2B1vu70J0mUfO0b
        a7LLrmCG5CyZvwPukffxPCZ6Wjao
X-Google-Smtp-Source: ABdhPJy91kBn1gCpmWyn2BpmEesEp9aRD66fghambCgLMPjpxNwp9TqVmSRAvQNCyWZqa+ClX1BcpA==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr7912174wmf.5.1590742279679;
        Fri, 29 May 2020 01:51:19 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 15/34] commit-graph-format.txt: document the modified path Bloom filter chunks
Date:   Fri, 29 May 2020 10:50:19 +0200
Message-Id: <20200529085038.26008-16-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During a pathspec-limited revision walk, e.g. 'git log -- dir/file',
Git spends a significant part of its runtime in the tree-diff
machinery, checking whether the given path was modified between
subsequent commits.  By using Bloom filters to store the paths
modified by each commit we can quickly tell that a commit didn't
modify the given path without invoking tree-diff, thus considerably
reduce this diffing overhead, along with the runtime and memory usage.
This patch extends the commit-graph file format with additional chunks
to store those modified path Bloom filters.

The rest of this log message takes a closer look at the problem and
explains why these new chunks look like they do.

In the following the terms "file" and "path" are not used
interchangeably.  If a commit modified 'dir/subdir/foo.c', then it
modified that one file, but it modified three paths (namely 'dir',
'dir/subdir', and 'dir/subdir/foo.c').

Furthermore, unless otherwise noted, "a lot of paths" means 5000
randomly selected paths that have existed at one time or another
during the history of the corresponding repository's default branch
[1], except for git it means all 5089 paths that have ever existed
during the history of v2.25.0, and for homebrew-cask and homebrew-core
all 7307 and 6535 paths, respectively, that have ever existed in the
history of their default branches some time ago.

About pathspec-limited revision walks
-------------------------------------

So, during a pathspec-limited revision walk Git spends a significant
part of its runtime in the tree-diff machinery, checking whether the
given path was modified between subsequent commits.  The table below
shows the average runtime of 'git rev-list HEAD -- $path' for "a lot
of paths" in a couple of repositories, and how much of that runtime is
spent in diff_tree_oid().  It also shows the potential average
speedup, should we be able to reduce the tree-diff overhead to zero
without introducing some other overhead (spoiler alert: we won't be
able to achieve that, of course, but still will achieve even higher
average speedup in several cases).

                 Average    Average            Potential
                 runtime   diff time            speedup
  -------------------------------------------------------
  android-base   0.8780s    0.7320s    83.37%     6.14x
  cmssw          0.3143s    0.2800s    88.95%     9.19x
  cpython        0.7453s    0.6602s    88.58%     8.76x
  elasticsearch  0.1492s    0.1351s    90.55%    10.58x
  gcc            7.1852s    6.9432s    96.63%    29.69x
  gecko-dev      4.6113s    4.0964s    88.83%     8.96x
  git            0.6180s    0.5911s    95.65%    22.97x
  glibc          0.5618s    0.5313s    94.57%    18.42x
  go             0.4913s    0.4469s    90.96%    11.07x
  jdk            0.0482s    0.0431s    89.42%     9.45x
  linux          0.7043s    0.6163s    87.50%     8.00x
  llvm-project   2.6844s    2.2607s    84.22%     6.34x
  rails          0.2784s    0.2372s    85.20%     6.76x
  rust           0.7757s    0.7349s    94.74%    19.01x
  tensorflow     0.6258s    0.5735s    91.64%    11.96x
  webkit         1.9137s    1.6580s    86.64%     7.48x

Notice that the average time spent diffing in the Linux and Git
repositories is quite close (0.6163s vs 0.5911s), although the Linux
repository contains about 15x more commits and 25x more files; more on
this later.

Instrumenting the tree-diff machinery and gathering some stats about
the number of diff calls, tree object comparisons and decoded tree
entries revealed some interesting, perhaps even counterintuitive
things:

  - The number of scanned tree entries can be more important than the
    number of tree comparisons.

    Here are four paths from two repositories, two each in the same
    frequently-modified directory, with one near the beginning and one
    at the end of that directory.  When listing the commits modifying
    these paths, i.e. 'git rev-list HEAD -- $path', the number of tree
    comparisons is (nearly) the same, but the number of scanned tree
    entries differs by over two orders of magnitude.

                                      Average   Nr of scanned   Nr of tree
      Repository          $path      diff time   tree entries  comparisons
      --------------------------------------------------------------------
      git            .clang-format     0.188s          40115       18055
      git            zlib.c            0.729s       10705983       17120
      homebrew-core  Formula/a2ps.rb   8.390s        2122937      326758
      homebrew-core  Formula/zzz.rb   80.495s     1235547836      326758

    This is also noticeable when looking at the average number of
    scanned tree entries and tree comparisons when running 'git
    rev-list HEAD -- $path' for "a lot of paths":

                                Average nr      Average      Average
                     Average    of scanned     nr of tree   nr of diff
                    diff time  tree entries   comparisons      calls
      ----------------------------------------------------------------
      jdk            0.0431s       204466         5520         3702
      elasticsearch  0.1351s       720393        17212        13457
      rails          0.2372s      1299221        43369        33670
      cmssw          0.2800s      1938067        24798        23739
      go             0.4469s      3207155        76432        42346
      glibc          0.5313s      6555231        40442        29208
      tensorflow     0.5735s      3914851        97227        47262
      git            0.5911s      7480371        21789        18168
      linux          0.6163s      4004067        79514        58145
      cpython        0.6602s      4695754        88408        70439
      android-base   0.7320s      4312043       122280        96376
      rust           0.7349s      5084683        68110        29847
      webkit         1.6580s      9395349       303105       218906
      llvm-project   2.2607s     11773792       469801       330250
      gecko-dev      4.0964s     42396246       415843       387162
      gcc            6.9432s     84853083       286904       174218

    Note that although we have a lot less tree comparisons in the git
    than in the linux repository, it has almost double the amount of
    scanned tree entries, because the git repository has some
    frequently modified biggish directories (notably its root dir, 't'
    or 'Documentation').  As a result the average time spent diffing
    in the two repositories is roughly the same, although the linux
    repository is much larger.

    Or that we spend the most time diffing in the gcc repository,
    because it has by far the most scanned tree entries, even though
    it has less tree comparisons than any of the next three slowest
    repositories.

  - The number of path components in the pathspec, i.e. its depth in
    the directory tree seems to be irrelevant.

    When checking whether a path somewhere deep in the directory tree
    has been modified between a commit and its parent the tree-diff
    machinery can short-circuit, and it returns as soon as it finds
    the first leading directory that hasn't been modified.  And more
    often than not it can short-circuit already while comparing the
    root trees, as all the <1.5 values in the "Average tree
    comparisons per diff call" column show.

                     Average   Average tree     Average      Average
                    pathspec    comparisons    nr of diff   nr of tree
                      depth    per diff call      calls    comparisons
      ----------------------------------------------------------------
      android-base    5.78         1.26          96376       122280
      cmssw           4.28         1.04          23739        24798
      cpython         3.72         1.25          70439        88408
      elasticsearch   9.13         1.28          13457        17212
      gcc             5.13         1.64         174218       286904
      gecko-dev       6.25         1.07         387162       415843
      git             2.30         1.19          18168        21789
      glibc           4.17         1.38          29208        40442
      go              4.60         1.80          42346        76432
      jdk             8.45         1.49           3702         5520
      linux           4.49         1.36          58145        79514
      llvm-project    5.45         1.42         330250       469801
      rails           5.43         1.28          33670        43369
      rust            4.70         2.28          29847        68110
      tensorflow      5.56         2.06          47262        97227
      webkit          6.33         1.38         218906       303105

    Note the 2.xy average tree comparisons per diff call in the rust
    and tensorflow repositories.  In the rust repository over 98% of
    the paths are in the 'src' directory and over 93% of commits
    modify a file under that directory, while in the tensorflow
    repository over 92% of paths are in the 'tensorflow' directory and
    over 90% of commits modify a file under that directory.
    Consequently, the tree-diff machinery can only rarely
    short-circuit while comparing the root trees of two subsequent
    commits, but has to dive down and compare the contents of the
    'src' or 'tensorflow' directories most of the time as well.  I
    suspect that we would get a similar ~2 value in the homebrew-core
    repository as well, because over 99.7% of all commits modify the
    'Formula' directory, which contains over 90% of paths in the
    repository.

Bloom filters intro
-------------------

Quoting the (quite good) Wikipedia article, "A Bloom filter is a
space-efficient probabilistic data structure [...] that is used to
test whether an element is a member of a set. False positive matches
are possible, but false negatives are not – in other words, a query
returns either 'possibly in set' or 'definitely not in set'".

A Bloom filter is a bit array, initially all bits set to 0.  To add an
element to a Bloom filter, the element is hashed using 'k' independent
hash functions, the resulting hashes are turned into 'k' array
positions, and the bits at those positions in the filter are set to 1.
To query for an element, the element is hashed using the same 'k' hash
functions, the resulting hashes are turned into 'k' array positions,
and the values of the bits at those positions are checked.  If all
those bits are set, then the element is 'possibly in set'.  If even
one of those bits is unset, then the element is 'definitely not in
set'.

Some of the for us relevant properties of Bloom filters are:

  - A Bloom filter doesn't store the elements themselves, it only sets
    a couple of bits based on the elements' hashes.  Consequently, a
    Bloom filter can't tell which elements it contains; it can't even
    tell the number of elements in there.

  - A bit in the Bloom filter's bit array might be set by more than
    one element.  This is where the probabilistic nature and the
    possibility of false positives come from: it is possible that some
    elements in the set happen to have set all 'k' bits that would
    indicate the presence of a particular element, even though that
    element itself is not part of the set.

  - Elements can't be removed from a Bloom filter: the 'k' bits
    indicating the presence of an element can't simply be unset,
    because that might unset bits that were set by other elements as
    well.
    There are enhanced Bloom filter variants that allow removal of
    elements, like a counting Bloom filter, but they come with
    additional complexity and require considerably more space.

  - Bloom filters can't be resized, because turning the hashes into
    positions in the bit array critically depends on the size of the
    bit array (usually pos[i] = hash[i] % bit_array_size).

  - Bloom filters of the same size can be bitwise OR-ed to create the
    union of the sets of elements in the filters.

  - When playing long enough with probabilities and making some
    reasonable assumptions and approximations it can be shown (see the
    Wikipedia article) that for a desired false positive probability
    'p' there is an optimal number of 'k' hash functions:

      k = -log₂(p)    (that's a base 2 logarithm there)

    For 1% false positive probability k = 6.64, but of course there
    can only be an integral number of hash functions, so 7 it is.

    Note that this value is independent both from the size of the
    Bloom filter and from the number of elements in there.

    Inversely, when using a properly sized bit array, then the false
    positive probability falls exponentially as 'k' increases.

  - To store 'n' elements in a Bloom filter with a desired false
    positive probability using the optimal number of 'k' bits/hash
    functions, we need a bit array with approximate size 'm':

      m ≈ n * k / ln(2) ≈ n * k * 10 / 7

    When using 7 hash functions to aim for < 1% false positive
    probability this simplifies down to:

      m ≈ n * 7 * 10 / 7 = 10 * n

    i.e. approx. 10 bits per element.

  - In general the more elements, IOW the more set bits there are in a
    Bloom filter of certain size, the higher the probability of false
    positives.  Similarly, the larger the size of a Bloom filter's bit
    array for a certain number of elements, the lower the probability
    of false positives.

  - A Bloom filter with all bits set appears to contain "everything",
    because all queries will return 'possibly in set'.

Modified Path Bloom Filters
---------------------------

We'll use Bloom filters to store modified paths and will store them in
the Modified Path Bloom Filters chunk.  Yes, plural: we'll use a lot
of small Bloom filters, each one storing all paths modified by one
commit compared to one of its parents (see the Alternatives section
near the end for reasons for not using one big Bloom filter).  Then as
the pathspec-limited revision walk iterates over all commits it will
query each modified path Bloom filter to see whether the given
pathspec is in there, and if it is 'definitely not in set', then we
can spare a tree-diff call and skip the commit right away, but if it's
'possibly in set', then we must do the tree-diff to make sure.

Each modified path Bloom filter consists of:

  - 4 bytes specifying the number of bits in the Bloom filter's bit
    array.

    For practical purposes 32 bit is more than sufficient to store the
    number of bits in the Bloom filter's array.  When using k = 7
    hashes, i.e. 10 bits per path, then we could store over 400
    million paths in a single Bloom filter; with k = 32 hashes we'd
    use 46 bit per path, which is still over 93 million paths.

  - The actual bit array.  See the next and the Hashing scheme
    sections for details about how this bit array is used.

All modified path Bloom filters will use the same k number of hashes
per path, so we won't have to store that in each Bloom filter.  I
suspect that having modified path Bloom filters with different k
number of hashes wouldn't bring enough benefit to justify storing that
value in each and every filter.

The order of modified path Bloom filters in this chunk is unspecified
on purpose, so implementations can experiment with writing them in
history or topological order, which may bring performance benefits
through better locality.

[Somewhere in the middle of this section the length of this commit
message surpassed the length of 72441af7c4 (tree-diff: rework
diff_tree() to generate diffs for multiparent cases as well,
2014-04-07), the mother of all commit messages from the great Kirill
Smelkov, yay! :)]

Modified Path Bloom Filter Index
--------------------------------

Since modified path Bloom filters vary in size, we can't have an array
of modified path Bloom filters indexed by the position of the commit
OID in the OID Lookup chunk, but we'll need a level of indirection
between the commit OID position and the position of the associated
modified path Bloom filter.

So the Modified Path Bloom Filter Index chunk will contain an array of
offsets to quickly map commit OID positions to offsets in the Modified
Path Bloom Filters chunk, i.e. its Nth entry contains the offset for
the commit whose OID is Nth in the OID Lookup chunk.

Since the commit-graph file can store information about 2^31-1
commits, a merely 4 byte offset per commit is clearly insufficient.
However, surely noone want to have lots of gigabyte-sized modified
path Bloom filters, so a standard 8 byte file offset will be
underutilized.  This allows us to use a few bits from those 8 bytes
for special purposes.  For now we'll have two special purpose bits:

  - The most significant bit indicates that the entry is not an offset
    into the Modified Path Bloom Filters chunk, but an "embedded"
    modified path Bloom filter containing all paths modified by the
    commit compared to its first parent; see the next section.

  - The second most significant bit indicates that modified path Bloom
    filters are stored not only for the first parent of a merge
    commit, but for all its parents, and the entry is neither an
    offset nor an "embedded" modified path Bloom filter, but an array
    index into the Modified Path Bloom Filter Merge Index chunk; see
    the "Merges" section below.

  - [TODO: perhaps we might want to reserve one or two more bits for
    special purposes?]

Make these offsets relative to the start of the Modified Path Bloom
Filters chunk, so they will depend neither on the number of chunks nor
on the combined size of any other chunks that are written before the
Modified Path Bloom Filters chunk, thus allowing implementations to
calculate all these offsets without knowing anything about those other
chunks.  Furthermore, if the offsets were relative to the beginning of
the file, then some huge chunks could make the offsets grow too large,
and would mess up those special purpose bits (though, arguably, an
exabyte sized commit-graph file is just too unlikely to be worried
about...).

An "all bits set" index entry can be used to indicate that there is no
modified path Bloom filter stored for the corresponding commit.  A
reader implementation can either special-case such an entry, or
interpret it as an embedded modified path Bloom filter that replies
'possibly in set' to all queries, the result is the same: it has to
resort to running tree-diff for that commit.

These embedded modified path Bloom filters have implications on the
low-level Bloom filter format in the Modified Path Bloom Filters chunk
as well, namely:

  - Their array contains only 63 bits, not 64, i.e. not 8 full bytes.
    Therefore, for simplicity, we'll store the size of the bit array
    as the number of bits, not bytes.

  - Assigning special purpose to the most significant bits of the
    index entries is convenient when the entry is an offset into the
    Modified Path Bloom Filters chunk.  OTOH, it makes indexing into
    the Bloom filter's array awkward if we try to treat it like an
    ordinary array, i.e. whose 0th element comes first, because we'd
    have to account for the special purpose bits.  Therefore, we'll
    store the bit array kind of in big endian byte order, i.e. the
    most significant byte first and the 0th byte last.

In addition, this chunk will start with a small header storing a bit
of metadata that applies to all modified path Bloom filters in all
related chunks.  The reason for storing this header in the Modified
Path Bloom Filter Index chunk is that only this chunk is essential to
use modified path Bloom filters (if all commits modify so few files
that their modified path Bloom filters can all be embedded into the
index chunk, then the Modified Path Bloom Filters chunk will contain
nothing and thus can be omitted; e.g. the two homebrew repositories
come quite close to this, as shown below).

This header contains:

  - One byte storing the number of 'k' hashes per path.

    Using a single byte is more than sufficient: as 'k' increases the
    false positive probability falls exponentially, and quickly
    becomes unnecessarily low (i.e. with k = 31 even a full
    commit-graph containing 2^31-1 commits is expected to have only a
    single false positive).

  - [TODO: What else?  We might want to have a version byte, though if
    a format change becomes necessary, then we could simply rename the
    chunks just as well...]

Embedded Modified Path Bloom Filters
------------------------------------

The ideal size of a Bloom filter to store a set of 6 or 7 elements
with 7 hash functions is approximately 60 or 70 bits, respectively.
So in the space of a 8 byte Modified Path Bloom Filter Index entry we
could comfortably store 6 entries by using one bit to indicate that
the entry is not a file offset but an "embedded" modified path Bloom
filter and the remaining 63 bits as the Bloom filter's bit array.

As the table below shows, a significant portion or even the vast
majority of commits modify no more than 6 paths, so we can embed a lot
of modified path Bloom filters into the Modified Path Bloom Filter
Index chunk.  (Also note the unusually large percentage of empty diffs
in the android-base and cpython repositories.)

        Percentage of commits modifying <=N (or =N) paths compared to their first parents
                   0      <=1      <=2      <=3      <=4      <=5      <=6      <=7      <=8
                          (=1)     (=2)     (=3)     (=4)     (=5)     (=6)     (=7)     (=8)
  --------------------------------------------------------------------------------------------
  elasticsearch  0.70%   4.00%    5.67%    8.50%   13.17%   16.55%   18.32%   21.18%   27.47%
                        (3.30%)  (1.67%)  (2.83%)  (4.67%)  (3.37%)  (1.77%)  (2.86%)  (6.29%)
  jdk            0.26%   3.47%   10.60%   13.99%   15.62%   19.02%   26.62%   34.30%   40.57%
                        (3.20%)  (7.14%)  (3.39%)  (1.63%)  (3.40%)  (7.60%)  (7.68%)  (6.27%)
  webkit         0.05%   0.07%    0.77%    2.14%    9.15%   26.66%   38.42%   47.34%   52.83%
                        (0.02%)  (0.71%)  (1.37%)  (7.01%) (17.51%) (11.76%)  (8.92%)  (5.49%)
  android-base  13.20%  13.62%   14.23%   18.55%   20.91%   35.18%   42.32%   50.82%   62.05%
                        (0.42%)  (0.62%)  (4.32%)  (2.36%) (14.28%)  (7.14%)  (8.49%) (11.23%)
  llvm-project   0.12%   0.12%    0.94%    6.45%   25.24%   46.68%   53.60%   60.97%   67.33%
                        (0.00%)  (0.81%)  (5.51%) (18.79%) (21.44%)  (6.92%)  (7.37%)  (6.36%)
  gecko-dev      0.14%   0.96%    1.88%   15.44%   32.42%   46.12%   54.54%   61.37%   66.65%
                        (0.82%)  (0.92%) (13.56%) (16.98%) (13.70%)  (8.42%)  (6.82%)  (5.28%)
  tensorflow     0.09%   1.26%    2.72%    5.00%   26.30%   42.36%   55.17%   63.11%   69.70%
                        (1.17%)  (1.46%)  (2.28%) (21.27%) (16.07%) (12.81%)  (7.94%)  (6.59%)
  rails          0.10%   2.09%    5.79%   16.03%   35.57%   51.47%   58.71%   65.15%   72.96%
                        (1.99%)  (3.70%) (10.23%) (19.54%) (15.90%)  (7.24%)  (6.44%)  (7.82%)
  rust           0.07%   2.20%    5.11%   22.81%   42.35%   52.50%   59.29%   65.33%   70.02%
                        (2.13%)  (2.91%) (17.70%) (19.54%) (10.15%)  (6.79%)  (6.04%)  (4.69%)
  glibc          0.02%   7.33%   14.03%   30.86%   42.22%   52.53%   61.59%   68.50%   73.68%
                        (7.31%)  (6.70%) (16.83%) (11.36%) (10.32%)  (9.06%)  (6.91%)  (5.19%)
  gcc            0.00%   0.24%   10.92%   26.61%   39.85%   54.97%   63.80%   69.37%   76.52%
                        (0.24%) (10.68%) (15.69%) (13.24%) (15.13%)  (8.82%)  (5.57%)  (7.14%)
  go             0.00%   0.96%    9.09%   19.35%   39.97%   53.16%   65.31%   72.10%   77.36%
                        (0.95%)  (8.13%) (10.26%) (20.63%) (13.19%) (12.15%)  (6.79%)  (5.26%)
  cmssw          0.15%   0.19%    0.20%    2.43%   45.35%   56.49%   67.58%   73.17%   77.99%
                        (0.03%)  (0.01%)  (2.23%) (42.92%) (11.15%) (11.08%)  (5.59%)  (4.83%)
  linux          0.01%   0.66%    3.97%   23.49%   46.15%   62.97%   72.79%   79.16%   83.57%
                        (0.65%)  (3.30%) (19.52%) (22.66%) (16.82%)  (9.82%)  (6.37%)  (4.41%)
  cpython        3.07%   4.97%   27.73%   59.54%   70.34%   77.48%   81.91%   86.76%   89.34%
                        (1.91%) (22.75%) (31.82%) (10.80%)  (7.13%)  (4.43%)  (4.85%)  (2.59%)
  git            0.11%  27.54%   55.92%   73.79%   81.90%   87.05%   90.28%   92.29%   93.82%
                       (27.43%) (28.38%) (17.87%)  (8.11%)  (5.15%)  (3.23%)  (2.01%)  (1.53%)
  homebrew-cask  0.40%   0.94%   95.41%   97.42%   98.11%   98.40%   98.61%   98.79%   98.93%
                        (0.54%) (94.46%)  (2.01%)  (0.70%)  (0.29%)  (0.21%)  (0.18%)  (0.14%)
  homebrew-core  0.01%   0.07%   98.81%   99.35%   99.56%   99.75%   99.81%   99.84%   99.86%
                        (0.07%) (98.74%)  (0.53%)  (0.22%)  (0.19%)  (0.06%)  (0.03%)  (0.02%)

This saves space, because the Modified Path Bloom Filters chunk will
contain a lot less Bloom filters (albeit those would be rather small
filters).

It reduces the probability of false positives, because all commits
modifying 1-6 paths will have larger than strictly necessary modified
path Bloom filters.

Finally, it makes the Bloom filter query ever so slightly faster,
partly because there is no redirection into the Modified Path Bloom
Filters chunk, and partly because we can check all bit positions in a
63 bit modified path Bloom filter using a 64 bit mask at once, instead
of checking those bit positions one by one, and we can use the same
mask to check all embedded Bloom filters.

The number of paths that can be stored in a 63 bit Bloom filter
depending on the number of hashes per path:

  k     |  3   |  4   |  5  |  6  |  7  |  8  | 9 - 11 | 12 - 14 | 15 - 22 | 23 - 44
  ------+------+------+-----+-----+-----+-----+--------+---------+---------+--------
  paths | <=14 | <=11 | <=8 | <=7 | <=6 | <=5 |  <=4   |   <=3   |   <=2   |   <=1

Hashing scheme
--------------

We need to map each modified path to 'k' independent bit positions in
the Bloom filters bit array.  We want the hash function and hashing
scheme that results in the lowest false positive rate and has the
lowest probability of "colliding" paths (see below), but it should
still be fast to compute, and should be widely available for
alternative Git implementations.

At this point we don't care about the runtime of pathspec-limited
revision walks here.  Lower false positive rate inherently leads to
lower runtime, though we are reaching diminishing returns on common
setups as the false positive rate gets lower and lower... and e.g. in
the webkit repository we'll reach an average false positive rate of
~0.001% with only k = 7 hashes per path.  However, on unusual
setups/configurations accessing tree objects might be considerably
more expensive than accessing commit objects, especially when using
only commit info stored in the commit-graph.  E.g. consider a future
where we can distribute commit-graphs with modified path Bloom filters
to partial clones containing only commit objects for most of the
history: any tree-diff will be really expensive, because the tree
objects must be fetched from the promisor.  In such a setup every
avoidable tree-diff call counts, and low false positive rate is
king.

For now I went with 32 bit MurmurHash3 used in enhanced double hashing
scheme with 32 bit unsigned integer arithmetic, though as I will show
below it seems that this is not the best option.

So, to map each modified path to 'k' bit positions in the Bloom
filter's array we first need 'k' independent hashes.  In general,
hashing a path 'k' times with the same hash function but using 'k'
different seeds produces hashes that are independent enough.  In
practice, to reduce the overhead of hashing, especially for larger 'k'
values, some variant of double hashing is often used to generate the
'k' independent-ish hashes from the results of only two hash function
calls with different seeds.  In general:

  h1 = h(seed1, path)
  h2 = h(seed2, path)
  for (i = 0; i < k; i++)
      pos[i] = (h1 + i * h2 + f(i)) % nr_bits

Depending on how the f(i) term is defined there are a few named
variants:

  - Double hashing: f(1) = 0:

      pos[i] = (h1 + i * h2) % nr_bits

  - Improved double hashing: f(i) adds a simple quadratic term:

      pos[i] = (h1 + i * h2 + i^2) % nr_bits

  - Enhanced double hashing: f(i) adds a not-so-simple cubic term:

      pos[i] = (h1 + i * h2 + (i^3 - i) / 6) % nr_bits

    This cubic term is equal to the following sequence of numbers,
    starting from i = 0:

      0, 0, 1, 4, 10, 20, 35, 56, 84, 120, etc.

    These are almost the same as tetrahedral numbers, except that the
    mathematical definition starts with 1, 4, 10..., while the OEIS
    A000292 sequence starts with 0, 1, 4, 10...

    I'm puzzled by this term being 0 not only for i = 0, but for i = 1
    as well, because this means that if (h2 % nr_bits == 0) (see
    below), then both pos[0] = h1 and pos[1] = h1, IOW in that case
    the path has one less bit set.  We'll take a look at whether
    starting the sequence with a single 0 makes a difference (it does)
    and how that affects the false positive rate (slightly increases
    it overall), and this will be labeled "enhanced double hashing
    variant #1" below.

    This sequence is supposed to be just as good as a simple i^3 term,
    but this can easily be calculated incrementally without
    multiplication, using only addition.  We'll take a look at how a
    simple cubic term affects the false positive rate (it increases
    it), and this will be labeled "enhanced double hashing variant
    #2" below.

These hashing schemes usually work fairly well in practice, but in
practice Bloom filters are primarily used to check whether an element
is part of _one_ _big_ set, and, consequently, most of the wisdom and
experience out there applies to big Bloom filters.

We, however, will repeatedly check whether a particular element (i.e.
path) is part of a large number of mostly very small sets, and our use
case does challenge those best practices.

In our use case it is important when two paths "collide", i.e. when
one path in itself sets all the bit positions that (falsely) indicate
the presence of another path in a modified path Bloom filter, so let's
have a look at that.  And let's hope against hope that I don't mess up
the math...

So, if we have k truly independent hashes for each path, then:

  (1) The probability of two paths mapping to the same k separate bit
      positions in a Bloom filter of size nr_bits is nr_bits! /
      ((nr_bits - k)! * k!).

  (2) The probability of a path setting only a single bit position is
      1 / nr_bits^(k-1), and the probability of a path setting one
      particular bit position is k / nr_bits (assuming that it does
      set k separate bits), so the probability of a path setting a bit
      position that happens to be the only bit position set by an
      other path is k / nr_bits^k.

In case of our 63 bit embedded modified path Bloom filters and k = 7
the probabilities of these two cases are about 1.81 * 10^(-9) and
1.77 * 10^(-12), respectively.  I think that these are low enough not
to worry about.

However, the hashes in the various double hashing schemes are far from
being independent.  When starting out with unsigned 32 bit hashes
(like we'll do) and using 64 bit arithmetic, then there is no integer
overflow, because neither i nor f(i) are large enough for that.  Then,
due to the distributivity of the modulo operation (and because i <
nr_bits), all double hashing schemes are equivalent to:

  pos[i] = (h1 % nr_bits + i * (h2 % nr_bits) + f(i) % nr_bits) % nr_bits

For the above mentioned two colliding cases this means:

  (1) if (h(seed1, "foo") % nr_bits == h(seed1, "bar") % nr_bits &&
          h(seed2, "foo") % nr_bits == h(seed2, "bar") % nr_bits)

      then all double hashing variants will work as if both paths were
      hashed to the same h1 and h2 values, and, consequently, both
      paths will be mapped to the same bit positions.  This has the
      probability of 1 / nr_bits^2.

  (2) if (h2 % nr_bits == 0)

      then the i * h2 term will basically amount to nothing and this
      term can be simplified away, and all bit positions will depend
      only on h1; this has the probability of 1 / nr_bits.

      In case of double hashing the f(i) term is 0 as well, meaning
      that the path maps to a single bit position.  The probability of
      a path setting a bit position that happens to be the only bit
      position set by an other path is k / nr_bits^2.

      The quadratic or cubic f(i) terms in improved or enhanced double
      hashing ensure that a path is mapped to multiple bit positions
      even in this case, though those bit positions are not nearly as
      random as one would like.

In case of 63 bit Bloom filters and k = 7, the probabilities of these
two cases are 1 / 3969 and 1 / 567, respectively.

When using 32 bit unsigned integer arithmetic, then an integer
overflow is definitely possible, so the double hashing formula
becomes:

  pos[i] = (h1 + i * h2 + f(i)) % 2^32 % nr_bits

If nr_bits is a power of two, then the "% 2^32" term can be simplified
away, and we end up with the same formula as with 64 bit arithmetic,
and the probabilities of cases (1) and (2) above remain the same.

If nr_bits is not a power of two, then...  well, I don't offhand know
how to approach that formally :)  Anyway:

  (1) This type of collision seems to occur if that two-liner
      condition above is true and for both paths there is an overflow
      for the same values of i, which has the approximate probability
      of 1 / ((k - 1) * nr_bits^2).

  (2) This type of collision seems to occur if (h2 % nr_bits == 0) and
      there is either no integer overflow for any values of i or if
      there is an overflow for all values of i, which has the
      approximate probability of k / ((k - 1) * nr_bits^2).

In case of 63 bit Bloom filters and k = 7 the probabilities of these
two cases are 1 / 23814 and 1 / 3402, respectively.

There are several other colliding cases, e.g. with double hashing
variants its more probable that a path maps only to 2, 3, etc. bit
positions instead of 'k' than with 'k' truly independent hashes,
though I haven't looked into how the probabilities work out.

Anyway, all the above already shows that:

  - These colliding cases are several orders of magnitude more likely
    with any double hashing variant than with k truly independent hash
    functions.

  - When using some sort of double hashing, then these colliding cases
    can happen with a high enough probability that we can't just
    ignore them.

  - These colliding cases can happen much more frequently with double
    hashing than with improved or enhanced double hashing.

  - Using 64 vs 32 bit arithmetic while calculating various double
    hashing schemes makes a difference, and suggests that 32 bit
    arithmetic has lower false positives probability.

  - Bloom filters whose size is a power of two might have higher false
    positive probability.

All this is important, because there are repositories out there that
modify the same path in the majority of commits, e.g.:

  - homebrew-core: contains 6535 paths, and over 99.5% of commits
    modify the 'Formula' directory and have an embedded modified path
    Bloom filter.

  - homebrew-cask: contains 7307 paths, and over 95.5% of commits
    modify the 'Casks' directory and have an embedded modified path
    Bloom filter.

  - rust: contains 58k+ paths, and almost 93% of commits modify the
    'src' directory, though only over 54% of commits modify that
    directory and have an embedded modified path Bloom filter.

  - tensorflow: contains 47k+ paths, and almost 91% of commits modify
    the 'tensorflow' directory, though only about 51% of commits
    modify that directory and have an embedded modified path Bloom
    filter.

  - go: contains 22k+ paths, and almost 84% of commits modify the
    'src' directory, though only over 50% of commits modify that
    directory and have an embedded modified path Bloom filter.

So e.g. if we were to look for commits modifying a path in the
homebrew-core repository, which happens to map to the same bit
positions in a 63 bit Bloom filter as the 'Formula' directory, then
Boom! we would get over 99.5% false positive rate, effectively
rendering modified path Bloom filters useless for that particular
path.

The table below shows the number of paths that happen to collide with
the repository's frequently modified directory in embedded modified
path Bloom filters using different hash functions and hashing schemes
with 32 bit unsigned integer arithmetic and 64 bit arithmetic (the
latter in parentheses):

                |    Double hashing   |      Enhanced     |      7 seeds
                |                     |   double hashing  |
                |  Murmur3 |  xxHash  | Murmur3 |  xxHash | Murmur3 | xxHash
  --------------+----------+----------+---------+---------+---------+--------
  homebrew-core |  4  (15) |  5  (17) |  0  (0) |  0  (2) |    0    |    0
  homebrew-cask |  2  (21) |  6  (14) |  0  (2) |  1  (1) |    0    |    0
  rust          | 18 (143) | 38 (144) |  1 (15) |  6 (24) |    0    |    0
  tensorflow    | 20 (110) | 18 (105) |  4 (15) |  0 (12) |    0    |    0
  go            |  9  (66) | 12  (62) |  0  (1) |  3  (8) |    0    |    0
  --------------+----------+----------+---------+---------+---------+--------
  all           | 53 (355) | 79 (342) |  5 (33) | 10 (47) |    0         0

The effect of embedded modified path Bloom filters on these colliding
cases can be both beneficial and harmful:

  - We use a larger than necessary Bloom filter to hold 1-6 paths,
    which lowers the probability of these cases considerably.

    This is especially important for the homebrew repositories.  E.g.
    in homebrew-core over 98.6% of commits modify a single file in the
    'Formula' directory, i.e. two paths in total.  To store 2 paths
    using 7 hashes per path we would need a Bloom filter with a 20 bit
    array, which we would round up to 24 bits to use full bytes, i.e.
    those 98.6% of commits would have merely 24 bit Bloom filters.
    This makes those colliding cases all the more probable: 1 / 3456
    for case (1) and 1 / 493.7 for case (2) with 32 bit arithmetic).

  - We use Bloom filters of the same size to hold 1-6 paths, so if a
    path were to run into these cases, then more Bloom filter queries
    would return false positives than when using appropriately sized
    Bloom filters.

Now, there is a simple trick that can, to some extent, alleviate these
collision issues: check all leading directories of the pathspecs, i.e.
while looking for commits modifying 'dir/subdir/file', then query the
modified path Bloom filters not only for the full path, but for all
its leading directories 'dir/subdir' and 'dir' as well.  This way we
would only get a false positive if all bit positions of all leading
directories were set as well, which can significantly reduce the
probability of a pathspec running afoul of these colliding cases, and,
in general, can reduce the false positive rate by an order of
magnitude or three as well (see later in this patch series).

Checking all leading directories is not a silver bullet, though,
because it can only help if the pathspec does actually have leading
directories, and the deeper the pathspec in the directory tree, i.e.
the more leading directories it has, the lower the false positive
rate becomes.

  - So this doesn't help pathspecs in the root tree, because they
    obviously don't have any leading directories.

  - Furthermore, this doesn't help pathspecs that are immediately
    below such a frequently modified directory, because their only
    leading directory is modified in the majority of commits.

    This means that it can't help in the homebrew repositories,
    because 85% or 90% of their paths are directly under their
    frequently modified directories.

The only thing that can help even in these cases is hashing the paths
k times using k different seeds.

Phew.  Let's see some actual benchmarks, shall we?

The following tables in this section show the average false positive
rate of various hash functions and hashing schemes while listing the
histories of "a lot of paths", i.e. 'git rev-list HEAD -- $path'.  A
'*' denotes the lowest value in each row.  All cases use k = 7 hashes
per path, use the same basically random seeds of immense historical
significance, store 6 path in embedded modified path Bloom filters,
and check all leading directories of the given pathspec.

The table below compares the average false positive rate of 64 bit and
32 bit unsigned integer arithmetic using double hashing and enhanced
double hashing with the MurmurHash3 hash function:

                    Double hashing     | Enhanced double hashing
                   32 bit     64 bit   |    32 bit     64 bit
  -------------------------------------+------------------------
  android-base   0.008539%  0.015709%  | *0.004155%  0.004961%
  cmssw          0.006022%  0.013334%  | *0.003953%  0.004109%
  cpython        0.036840%  0.079816%  | *0.016607%  0.019330%
  elasticsearch  0.004069%  0.005297%  |  0.003249% *0.003101%
  gcc            0.016982%  0.034096%  | *0.008919%  0.011152%
  gecko-dev      0.001058%  0.002691%  | *0.000725%  0.000829%
  git            0.144256%  0.331346%  | *0.069921%  0.079405%
  glibc          0.026480%  0.053838%  | *0.016389%  0.017902%
  go             0.021930%  0.050348%  | *0.012616%  0.014178%
  homebrew-cask  0.097523%  0.508175%  | *0.009096%  0.042034%
  homebrew-core  0.120860%  0.556014%  | *0.005360%  0.026810%
  jdk            0.006085%  0.007526%  |  0.006431% *0.005911%
  linux          0.010908%  0.019081%  | *0.007494%  0.007896%
  llvm-project   0.006417%  0.009327%  | *0.003913%  0.004050%
  rails          0.024997%  0.046829%  |  0.013134% *0.012361%
  rust           0.038579%  0.056852%  | *0.025509%  0.027068%
  tensorflow     0.013732%  0.023307%  | *0.008243%  0.008848%
  webkit         0.002212%  0.002950%  | *0.001007%  0.001065%
  -------------------------------------+------------------------
  all            0.028395%  0.110075%  | *0.006085%  0.006675%
  w/o homebrew   0.010940%  0.021286%  | *0.005968%  0.011023%

The 64 bit unsigned arithmetic does indeed fare worse in almost every
case, and significantly worse in the two homebrew repositories.

So it seems that if using some form of double hashing, then 32 bit
unsigned integer arithmetic is the way to go, even though several
programming languages lack support for unsigned types (though thanks
to the distributivity of the modulo operation, they can simply and
cheaply implement it using 64 bit arithmetic and a '& (2^32-1)' mask).

The table below compares the average false positive rate of various
hashing schemes using 32 bit unsigned integer arithmetic and the
MurmurHash3 hash function:

                              Enhanced   Enhanced   Enhanced
                               double     double     double    Improved
                               hashing    hashing    hashing    double     Double
                   7 seeds   (original)  variant 1  variant 2   hashing    hashing
  ---------------------------------------------------------------------------------
  android-base    0.004214%  *0.004155%  0.004853%  0.005193%  0.008252%  0.008539%
  cmssw          *0.003344%   0.003953%  0.003546%  0.004732%  0.004226%  0.006022%
  cpython         0.016120%   0.016607% *0.015896%  0.020259%  0.020311%  0.036840%
  elasticsearch  *0.003167%   0.003249% *0.003164%  0.003531%  0.003553%  0.004069%
  gcc             0.010281%  *0.008919%  0.010359%  0.010642%  0.012166%  0.016982%
  gecko-dev       0.000804%   0.000725% *0.000646% *0.000648%  0.000822%  0.001058%
  git            *0.063025%   0.069921%  0.067643%  0.080744%  0.091423%  0.144256%
  glibc          *0.016278%   0.016389%  0.018660%  0.021094%  0.025596%  0.026480%
  go              0.013009%  *0.012616%  0.013301%  0.014316%  0.016345%  0.021930%
  homebrew-cask  *0.007199%   0.009096%  0.009070%  0.010722%  0.016617%  0.097523%
  homebrew-core  *0.003041%   0.005360%  0.005277%  0.005148%  0.016150%  0.120860%
  jdk             0.005873%   0.006431% *0.005326%  0.005955%  0.006984%  0.006085%
  linux           0.007764%  *0.007494%  0.007714%  0.008709%  0.009429%  0.010908%
  llvm-project   *0.003367%   0.003913%  0.003730%  0.004064%  0.004809%  0.006417%
  rails          *0.012708%   0.013134%  0.013929%  0.016316%  0.014358%  0.024997%
  rust           *0.024245%   0.025509%  0.025045%  0.028204%  0.032491%  0.038579%
  tensorflow     *0.007907%   0.008243%  0.008670%  0.009913%  0.010115%  0.013732%
  webkit         *0.000999%  *0.001007%  0.001142%  0.001113%  0.001274%  0.002212%
  ---------------------------------------------------------------------------------
  all            *0.005646%   0.006085%  0.006226%  0.006928%  0.009264%  0.028395%
  w/o homebrew   *0.005888%   0.005968%  0.006152%  0.006899%  0.007807%  0.010940%

Double hashing and improved double hashing have higher average false
positive rates than enhanced double hashing; note in particular the
significantly higher false positive rate with double hashing in the
two homebrew repositories.  Enhanced double hashing is only slightly
worse than 7 different seeds, at least in this particular case (i.e.
MurmurHash3 and these specific seeds).

Comparing these hashing schemes using a different hash function
(xxHash or FNV1a) shows a similar trend; for brevity I won't include
those tables here.

The table below compares the average false positive rate of different
32 bit hash functions when used in enhanced double hashing scheme with
k = 7 and 32 bit unsigned int arithmetic, or with 7 different seeds:

                     Enhanced double hashing     |             7 seeds             |  7 uint32
                  Murmur3     xxHash     FNV1a   |  Murmur3     xxHash     FNV1a   |   SHA256
  -----------------------------------------------+---------------------------------+-----------
  android-base   0.004155%  0.005556%  0.006113% | 0.004214% *0.004101%  0.005918% | 0.004168%
  cmssw          0.003953%  0.003775%  0.005087% | 0.003344%  0.003677%  0.004353% |*0.003322%
  cpython        0.016607%  0.015919%  0.021957% | 0.016120% *0.015238%  0.023649% | 0.017632%
  elasticsearch  0.003249%  0.003589%  0.004616% | 0.003167%  0.003360%  0.003586% |*0.003027%
  gcc           *0.008919%  0.009376%  0.010555% | 0.010281%  0.009157%  0.011882% | 0.010338%
  gecko-dev      0.000725%  0.000721%  0.000932% | 0.000804% *0.000611%  0.000911% | 0.000737%
  git            0.069921%  0.063449%  0.083097% |*0.063025%  0.069137%  0.087132% | 0.063763%
  glibc          0.016389%  0.017477%  0.024321% | 0.016278% *0.016062%  0.022641% | 0.017241%
  go             0.012616%  0.012449%  0.016728% | 0.013009% *0.011692%  0.017214% | 0.012489%
  homebrew-cask  0.009096%  0.025104%  0.011073% | 0.007199%  0.007343%  0.009037% |*0.007050%
  homebrew-core  0.005360%  0.007940%  0.005450% |*0.003041%  0.003832%  0.004888% | 0.003884%
  jdk            0.006431% *0.005451%  0.007428% | 0.005873%  0.005738%  0.006654% | 0.005749%
  linux         *0.007494%  0.008266%  0.009917% | 0.007764%  0.007723%  0.009256% | 0.007939%
  llvm-project   0.003913%  0.003727%  0.004584% | 0.003367% *0.003247%  0.005115% | 0.003664%
  rails          0.013134%  0.011277%  0.014103% | 0.012708% *0.010389%  0.015928% | 0.012506%
  rust           0.025509%  0.024596%  0.032983% |*0.024245%  0.025697%  0.031593% | 0.024794%
  tensorflow     0.008243%  0.008743%  0.011499% |*0.007907%  0.008089%  0.011922% | 0.008033%
  webkit         0.001007%  0.001155%  0.001401% | 0.000999% *0.000962%  0.001291% | 0.001054%
  -----------------------------------------------+---------------------------------+----------
  all            0.006085%  0.007327%  0.007518% | 0.005646% *0.005554%  0.007591% | 0.005857%
  w/o homebrew   0.005968%  0.005979%  0.007545% | 0.005888% *0.005660%  0.007855% | 0.006039%

MurmurHash3 and xxHash are neck and neck, be it enhanced double
hashing or 7 different seeds, at least when we ignore the unusually
high false positive rate of enhanced double hashing with xxHash in the
homebrew-cask repository (it stumbles upon one of those colliding
cases discussed above).

FNV1a has a decidedly higher average false positive rate than any of
the others.

I was curious to see whether using 7 unsigned integers from SHA256
offers any benefits (being a cryptographic hash function, it should
provide some high quality hash values), but apparently it doesn't fare
any better than MurmurHash3 and xxHash.  This leads me to believe that
both MurmurHash3 and xxHash are as good as it gets, and I would not
expect that any other hash function could achieve notably lower false
positive rates.

Now let's see how these hash functions and hashing schemes fare when
writing commit-graph files with '--reachable' and with modified path
Bloom filters from scratch at the end of this patch series.  Hash
functions tend to praise themselves about how fast they can process
huge chunks of data, but we'll use them to hash many tiny strings...

                         Total runtime of writing a commit-graph file
                         with modified path Bloom filters from scratch
                                    (Time spent hashing)

                     Enhanced double hashing     |             7 seeds             |  7 uint32
                  Murmur3     xxHash     FNV1a   |  Murmur3     xxHash     FNV1a   |   SHA256
  -----------------------------------------------+---------------------------------+----------
  android-base    40.880s    40.368s    40.569s  |  41.375s    40.557s    41.843s  |  42.706s
                  (0.627s)   (0.484s)   (0.777s) |  (1.467s)   (0.886s)   (2.138s) |  (3.682s)
  cmssw           25.691s    25.224s    25.645s  |  26.715s    25.998s    27.762s  |  29.527s
                  (0.894s)   (0.650s)   (1.179s) |  (2.083s)   (1.235s)   (3.259s) |  (5.077s)
  cpython          8.951s     8.929s     9.067s  |   9.072s     9.015s     9.008s  |   9.275s
                  (0.057s)   (0.042s)   (0.045s) |  (0.112s)   (0.067s)   (0.102s) |  (0.324s)
  elasticsearch   14.470s    14.320s    14.703s  |  14.983s    14.588s    15.948s  |  16.720s
                  (0.407s)   (0.300s)   (0.622s) |  (0.991s)   (0.594s)   (1.760s) |  (2.332s)
  gcc             36.917s    36.724s    37.251s  |  37.971s    37.449s    38.178s  |  38.332s
                  (0.313s)   (0.230s)   (0.346s) |  (0.694s)   (0.418s)   (0.919s) |  (1.796s)
  gecko-dev       97.729s    96.791s    97.233s  |  99.215s    97.158s   101.403s  | 105.332s
                  (1.730s)   (1.267s)   (2.099s) |  (3.902s)   (2.344s)   (5.773s) |  (9.553s)
  git              5.245s     5.401s     5.412s  |   5.518s     5.457s     5.474s  |   5.494s
                  (0.022s)   (0.017s)   (0.018s) |  (0.045s)   (0.027s)   (0.040s) |  (0.124s)
  glibc            4.146s     4.156s     4.187s  |   4.267s     4.201s     4.278s  |   4.495s
                  (0.060s)   (0.045s)   (0.057s) |  (0.128s)   (0.079s)   (0.144s) |  (0.331s)
  go               3.565s     3.563s     3.564s  |   3.631s     3.582s     3.607s  |   3.727s
                  (0.040s)   (0.030s)   (0.035s) |  (0.084s)   (0.051s)   (0.084s) |  (0.221s)
  homebrew-cask   29.818s    29.936s    30.279s  |  30.316s    30.435s    29.942s  |  29.939s
                  (0.025s)   (0.020s)   (0.019s) |  (0.049s)   (0.032s)   (0.038s) |  (0.153s)
  homebrew-core   55.478s    55.534s    56.248s  |  56.551s    56.100s    56.445s  |  55.641s
                  (0.031s)   (0.024s)   (0.023s) |  (0.062s)   (0.038s)   (0.047s) |  (0.195s)
  jdk             19.418s    19.151s    20.246s  |  21.270s    20.037s    24.073s  |  25.916s
                  (1.260s)   (0.878s)   (2.105s) |  (3.154s)   (1.833s)   (6.133s) |  (7.732s)
  linux          100.837s   100.130s   101.244s  | 103.775s   101.645s   103.856s  | 109.365s
                  (2.027s)   (1.498s)   (2.030s) |  (4.319s)   (2.682s)   (5.316s) | (11.075s)
  llvm-project    31.188s    31.392s    31.442s  |  31.895s    31.479s    31.984s  |  32.863s
                  (0.334s)   (0.251s)   (0.345s) |  (0.724s)   (0.437s)   (0.895s) |  (1.794s)
  rails            5.607s     5.639s     5.694s  |   5.742s     5.720s     5.865s  |   6.087s
                  (0.084s)   (0.063s)   (0.095s) |  (0.189s)   (0.116s)   (0.252s) |  (0.467s)
  rust            13.250s    13.206s    13.422s  |  13.701s    13.426s    13.680s  |  13.949s
                  (0.163s)   (0.122s)   (0.169s) |  (0.359s)   (0.217s)   (0.440s) |  (0.880s)
  tensorflow      11.808s    11.608s    11.915s  |  12.379s    11.966s    12.860s  |  13.588s
                  (0.368s)   (0.267s)   (0.497s) |  (0.860s)   (0.517s)   (1.369s) |  (2.081s)
  webkit          30.469s    30.735s    30.945s  |  32.005s    31.004s    32.401s  |  33.303s
                  (0.501s)   (0.376s)   (0.733s) |  (1.212s)   (0.725s)   (2.084s) |  (3.044s)

So xxHash is indeed the fastest, even in our use case, and MurmurHash3
comes in second.  The time spent hashing with 7 seeds tends to be
around twice as much as with enhanced double hashing when using the
same hash function.  However, the time spent hashing is only a
fraction of the total runtime, and while its effect on total runtime
is measurable both in best-of-five and average, it tends to be smaller
than run-to-run noise.

As for availability of hash functions:

  - MurmurHash3 is widely available; both the reference implementation
    and a streaming-capable ANSI C implementation is in the public
    domain.

  - xxHash is allegedly available in a variety of programming
    languages, as shown on www.xxhash.com (supposedly, but I haven't
    been able to load that page since months... some cloudflare host
    error persists)

  - SHA256 is widely available, and it must be part of every Git
    implementation in the near future anyway, but it's slower than the
    others, and, more importantly, it doesn't scale for k > 8.

  - FNV1a is so simple that anyone can implement a variant that
    incrementally computes two hashes up to the next directory
    separator in one go in about 20 lines of code (though note that
    the above benchmarks didn't use such an implementation).  Alas,
    because of its higher false positive rate it's out anyway.

Conclusion: we should seriously consider using MurmurHash3 (or xxHash)
and hashing each path k times with k different seeds instead of any
double hashing scheme.

Merges
------

It's not clear whether it's worth computing, storing and using
modified path Bloom filters for all parents of merge commits.

  - The number of paths modified between a merge commit and its
    second..nth parents is in general considerably larger than between
    any commit and its first parent.  E.g. a lot of files are modified
    in Git's master branch while a topic cooks for a few weeks, and
    much more in Linux when a branch started from the previous release
    is merged near the end of the next merge window.

                                 Average number of
                                   modified paths
                    Percentage      compared to:
                     of merge     first    second
                      commits     parent   parent
      --------------------------------------------
      android-base     73.6%       14.1    1553.6
      cmssw            11.0%       16.1     977.4
      cpython          11.7%        5.1     933.7
      elasticsearch     8.4%       40.1     246.5
      gecko-dev         3.5%       23.5     602.0
      git              25.3%        4.0     394.8
      homebrew-cask     9.6%        2.7      42.8
      jdk              25.0%      184.1     408.2
      linux             7.4%       26.1    2268.0
      rails            22.2%        9.6     101.0
      rust             27.0%       15.7     397.3
      tensorflow        9.1%       39.2    1057.4

    Consequently:

      - The tree-diff machinery has to work that much more to gather
        modified paths for all parents of merge commits, significantly
        increasing the runtime of writing the commit-graph file.

      - Storing modified path Bloom filters for all parents of merge
        commits significantly increases the size of the Modified Path
        Bloom Filters chunk, though depending on the percentage of
        merge commits and on the size of the other chunks the relative
        size increase of the whole commit-graph file might not be all
        that much.

      - [TODO: A few old test results suggest that pathspec-limited
        revision walks with default history simplification using a
        commit-graph file storing modified path Bloom filters for all
        merge parents are a few percents slower than when storing
        Bloom filters only for first parents.  Even fewer old test
        results suggest that writing all Bloom filters for first
        parents first, and then all for second..nth parents might
        eliminate much of that runtime difference.
        Definitely need more benchmarking.]

  - During a pathspec-limited revision walk Git's default history
    simplification only checks whether the given path was modified
    between a merge commit and its second..nth parents when the path
    was modified between that merge commit and its first parent.  This
    usually happens rarely, though these second..nth parent diffs tend
    to be more expensive than first parent diffs (because of the
    considerably more modified paths the tree-diff machinery can't
    short-circuit that early).  Anyway, the potential speedup is low.

  - However, with '--full-history', i.e. without any history
    simplification, all merge commits are compared to all their
    parents, and typical additional speedups are in the range of
    2x-3x, while in some cases over 7x or 11x can be achieved by using
    modified path Bloom filters for all parents of merge commits.

Does it worth it?  For me personally it doesn't, but I don't know how
often others use '--full-history' and what trade-offs they might be
willing to make.

So the file format described here adds _optional_ support for storing
modified path Bloom filters for all parents of merge commits, and the
users can make this decision themselves.

[TODO: describe it!]

Deduplication
-------------

Some commits have identical modified path Bloom filters, because they
modify the same set of paths (or because they modify different set of
paths but happen to end up setting the same bit positions in the Bloom
filter).  By omitting duplicates from the Modified Path Bloom Filters
chunk its size can be reduced typically by around 5-20%, and in case
of the android-base repository by over 69%.

Explicitly allow that multiple entries of the Modified Path Bloom
Filter Index chunk can refer to the same offset in the Modified Path
Bloom Filters chunk.  This is important, because even if an
implementation doesn't perform this deduplication while writing the
commit-graph file, it must be prepared for multiple index entries
referring to the same offset in commit-graph file written by a
different implementation.

Modified Path Bloom Filter Excludes
-----------------------------------

Some repositories contain leading directories that are modified in the
great majority of commits, e.g. the homebrew-core repository's
'Formula' directory is modified in over 99.7% of commits, while
homebrew-cask's 'Casks' and rust's 'src' are modified in over 93% of
commits.  And there is 'src/main/java/com/company/division/project' in
convention-following Java projects...

Modified path Bloom filters can't speed up revision walks when the
pathspec is such a frequently modified leading directory, because
because of potential false positives we'll have to run tree-diff for
the majority of commits anyway.  And it doesn't really make sense to
query the history of such a leading directory in practice, because it
will list the majority of commits, so one might as well look straight
at the output of a pathspec-less 'git log'.

However, adding those frequently modified leading directories to the
modified path Bloom filters requires more space and increases the
probability of false positives.

So the file format described here adds support for excluding specific
paths from modified path Bloom filters by listing them in the Modified
Path Bloom Filter Excludes chunk.

[TODO: Figure out the details!]

Limitations
-----------

Because of the possibility of false positives, if a modified path
Bloom filter query returns 'possibly in set', then we have to invoke
tree-diff to make sure that the path in question was indeed modified
by the given commit.  Consequently, Bloom filters can't improve
performance that much when looking for the history of a frequently
modified path, because a lot of tree-diff invocations can't be
eliminated.  In the extreme case when looking for the history of a
path modified in every commit, then using Bloom filters will only add
extra overhead.

A modified path Bloom filter doesn't store the names of modified
paths, it only sets a couple of bits based on those paths' hashes.
Consequently, it can only be used when looking for the history of a
concrete path, and:

  - It can't be used with a pathspec containing wildcards like 'git
    log -- "*.h"'.

    However, it could still be used when the pathspec contains leading
    directories without wildcards, e.g. 'git log --
    "arch/x86/include/*.h", by limiting tree-diff only to commits
    modifying the 'arch/x86/include/' directory.

  - It can't tell which paths were modified by a given commit; for
    that we would still have to run tree-diff for the full tree.

Submodules [TODO]
-----------------

No modified path Bloom filters should be stored for commits modifying
submodules.

This is questionable, but is necessary to produce the same output with
and without modified path Bloom filters.  If 'dir/submod' is a gitlink
file, then currently 'git rev-list HEAD -- dir/submod/whatever' lists
all commits touching 'dir/submod', even when that 'whatever' has never
existed.  And that 'whatever' can be basically anything, so we will
not find them in any of our modified path Bloom filters, therefore in
a Bloom-filter-assisted revision walk we won't list any commits.

The only way around this is to not not write any modified path Bloom
filters for commits modifying submodules.

Note, however, that once upon a time that command wouldn't list
anything, either, but the behavior changed with commit 74b4f7f277
(tree-walk.c: ignore trailing slash on submodule in
tree_entry_interesting(), 2014-01-23) to what we have now.  As
74b4f7f277's log message only talks about handling 'dir/submod/' and
'dir/submod' (i.e. with and without trailing slash) consistently, I
suspect that this behavior change with 'dir/submod/anything' is an
unintended and undesired side effect.  However, as it involves
submodules I would rather not have an opinion :)

In any case, someone with more clues about submodules should take a
closer look and decide whether this is a bug or not, before this
modified path Bloom filter thing goes much further.  If it is a bug
indeed, then it should be fixed and the remark about submodules should
be removed from the modified path Bloom filter specs.  If the current
behavior is desired, then the remark about submodules should be
updated to use proper English (IMO it must be part of the spec,
because this is a subtle issue that developers of other
implementations (JGit, libgit2, etc.) might easily overlook).

Threats to validity
-------------------

  - Random paths are... random.  Picking random paths can
    over-represent rarely modified files.  Since modified path Bloom
    filters bring more benefits to rarely modified paths, the reported
    speedups later in the series might be higher than what the users
    will usually see.  (I suppose that users more often check the logs
    of frequently modified files than of rarely modified ones.)

    Though some of these random paths made me stumble upon the issue
    with submodules discussed above, so...

  - Bugs :)  It's not that hard to make subtle bugs that don't affect
    correctness, because the probabilistic nature of Bloom filters
    cover them up.  However, bugs like incorrectly calculating the
    size of a Bloom filter or having an off-by-one error in the
    filter's array handling affect the false positive rate and in turn
    the runtime of pathspec-limited revision walks.

Alternatives considered
-----------------------

Here are some alternatives that I've considered but discarded and
ideas that I haven't (yet) followed through:

  - One Bloom filter to rule them all?  No.

    While the first proof of concept implementation [2] demonstrated
    that by combining hashes of modified pathnames with commit and
    parent object ids it is possible to use a single big Bloom filter
    and achieve notable speedups, that approach has several drawbacks:

      - Poor locality: The bit positions that are set for any element
        are supposed to be random, so we need to access random parts
        of the big Bloom filter array for each checked commit and
        path, which is bad for the caches.  Furthermore, we would
        likely need to read the whole big Bloom filter array even when
        looking for only a handful of commits, e.g. for 'git log -3 --
        dir/file'.

      - Need to grow: As the repository grows, more and more paths
        will be added to the modified path Bloom filter, thus lowering
        its false positive rate.  Eventually we'll reach a point where
        we would need to increase the size of the Bloom filter, but a
        Bloom filter can't be resized, so we'll have to create a
        larger Bloom filter and re-fill it from scratch.  This is a
        considerably more expensive operation than creating a
        modified-path-Bloom-filter-less commit-graph from scratch.

      - Expired commits: Unreachable commits are eventually pruned by
        'git gc', but elements can't be removed from a Bloom filter.
        Consequently, all the bits set for paths modified by expired
        commits will remain set, slightly increasing the probability
        of false positives until the Bloom filter is eventually
        resized/rewritten.  There are enhanced Bloom filter variants
        that allow removal of elements, like a counting Bloom filter,
        but they come with additional complexity and require
        considerably more space.

      - Excluded commits: Sometimes we can't or just don't want to
        record the paths modified by a particular commit, so we need a
        way to record which commits don't have entries in the big
        Bloom filter.

      - There are plans for split commit-graph files, because
        rewriting the whole commit-graph file in big repositories to
        add only relatively few new commits seems to impose
        considerable overhead.  We would need a big modified path
        Bloom filter in each of the split commit-graph files that
        we'll combine together when the split commit-graph files are
        combined.  Bloom filters of the same size can be quickly
        combined by bitwise OR-ing their arrays, but this implies that
        the split commit-graph files holding only a few commits would
        have to contain as large a Bloom filter as is used in the
        shared commit-graph file holding most of the commits in the
        repository, wasting valuable storage space.  (Though the false
        positive rate for commits stored in the split commit-graph
        should be spectacularly low).

    Using a small Bloom filter for each commit avoids these issues,
    though, as discussed earlier, not without introducing issues of
    its own.

  - Xor filters "are a faster and more concise alternative to Bloom
    filters", but they turned out to be too large in our use case.

    Each Xor filter consists of a header and an array: the header
    contains a 64 bit seed and a 64 bit blocklength, while the array
    contains 3 * blocklength bytes.  Consequently, the space advantage
    of Xor filters compared to Bloom filters is only true for large
    filters, where the header's size is negligible compared to the
    array's size.  We, however, have a lot of very small filters, and
    all those extra headers cause an unacceptable size increase
    (partly because the Xor filter's header is 4 times the size of the
    header of our modified path Bloom filters, and partly because
    their headers make Xor filters too large to be embedded in the
    index chunk).

                     MPBF chunk      Total
                        size       Xor Filter
                     (no dedup)       size
      ------------------------------------------------
      android-base     8620198      28840220     +334%
      cmssw           10347018      21538283     +208%
      cpython           526381       6393731    +1214%
      elasticsearch    4733274       9101088     +192%
      gcc              3724544      14637474     +393%
      gecko-dev       20591010      56887518     +276%
      git               160718       3115827    +1938%
      glibc             759132       3162898     +416%
      go                458375       2676306     +584%
      homebrew-cask      94383       5272317    +5586%
      homebrew-core      27823       8051585   +28938%
      jdk             13213208      15574498     +117%
      linux           26575278      69577374     +261%
      llvm-project     3988133      20235803     +507%
      rails             958691       5172643     +539%
      rust             1985782       7082949     +356%
      tensorflow       4173570       8333062     +200%
      webkit           5891751      15927504     +270%

    https://github.com/FastFilter/xor_singleheader

  - fastrange is "a fast alternative to the modulo reduction", but it
    turned out to significantly increase the average false positive
    rate when using (enhanced) double hashing.

    The traditional way to fairly map an integer value to the range
    [0,m) is the modulo reduction, i.e. 'h % m'.  Alas, integer
    division is a costly instruction, and we have to do it a lot while
    checking modified path Bloom filters for every commit.  Fastrange
    proposes to use the combination of an integer multiplication and a
    shift as: '((uint64_t)h * (uint64_t)m) >> 32', as it is supposed
    to be faster while being just as fair.

    In my benchmarks fastrange did indeed reduce the time spent
    checking modified path Bloom filters by up to ~10% (no table about
    this), though that's usually only a fraction of the total runtime
    of a pathspec-limited revision walk.  Unfortunately, as the table
    below shows, it also increased the average false positive rate by
    about 5x when using enhanced double hashing.  I haven't yet
    investigated why this happens.  However, fastrange is a viable
    option when using the same hash function with 'k' different seeds,
    as in that case it's on par with the good old % operator, and in
    fact its false positive rate happens to be slightly lower.

                           Enhanced        |
                        double hashing     |        7 seeds
                                           |
                    % operator  fastrange  | % operator  fastrange
      -------------------------------------+----------------------
      android-base  *0.004155%  0.013987%  |  0.004214%  0.004873%
      cmssw          0.003953%  0.006129%  | *0.003344%  0.005513%
      cpython        0.016607%  0.033979%  | *0.016120%  0.018069%
      elasticsearch  0.003249% *0.003149%  |  0.003167%  0.003333%
      gcc            0.008919%  0.013098%  |  0.010281% *0.007324%
      gecko-dev      0.000725%  0.000923%  |  0.000804% *0.000631%
      git            0.069921%  0.106424%  | *0.063025%  0.065347%
      glibc          0.016389%  0.025323%  | *0.016278%  0.016796%
      go            *0.012616%  0.020914%  |  0.013009%  0.012915%
      homebrew-cask  0.009096%  0.182016%  |  0.007199% *0.006937%
      homebrew-core  0.005360%  0.092957%  | *0.003041%  0.004251%
      jdk            0.006431%  0.005732%  |  0.005873% *0.005673%
      linux          0.007494%  0.013862%  |  0.007764% *0.007127%
      llvm-project   0.003913%  0.004829%  |  0.003367% *0.002943%
      rails          0.013134%  0.019524%  | *0.012708%  0.012979%
      rust           0.025509%  0.029824%  | *0.024245%  0.025174%
      tensorflow     0.008243%  0.012485%  | *0.007907%  0.008120%
      webkit        *0.001007%  0.001044%  | *0.000999%  0.001220%
      -------------------------------------+----------------------
      all            0.006085%  0.029034%  |  0.005646% *0.005579%
      w/o homebrew   0.005968%  0.009478%  |  0.005888% *0.005662%

    https://github.com/lemire/fastrange

  - fastmod "is a header file for fast 32-bit division remainders on
    64-bit hardware", promising faster computation when the same
    divisor is (re)used for multiple remainder calculations.  This is
    exactly what we are doing when checking a modified path Bloom
    filter, as we have to map a bunch of unsigned 32 bit hash values
    to bit positions with pos = hash % nr_bits, using the same nr_bits
    for all hash values.

    However, benchmarking has not shown conclusive improvements: while
    fastmod slightly reduces the time spent checking modified path
    Bloom filters in some repositories, it slightly increases in
    others, and any effect on the runtime of the whole
    pathspec-limited revision walk is below the noise.  Perhaps we
    have too many "embedded" modified path Bloom filters that we can
    check with a mask.  Or perhaps my CPU is too old and its integer
    multiplication instruction is not that much faster compared to
    integer division.

    https://github.com/lemire/fastmod

  - Varints.  Using 4 bytes for the size of each Bloom filter in the
    Modified Path Bloom Filters chunk is a lot more than necessary.
    How much space can be saved by using varints?  How much is the
    runtime overhead of decoding those varints?  How can we ensure
    that varint decoding doesn't read past the end of the mmapped
    memory region?

  - Path-depth-dependent number of hash functions.
    As shown later in this patch series, we can drastically reduce the
    average false positive rate by checking the presence of the
    pathspec's leading directories as well.  With that change the
    false positive rate will depend on the depth of the path in the
    directory tree as well: the deeper the path (i.e. the more leading
    directories can be checked), the lower the false positive rate,
    sometimes maybe even unnecessarily low (0% is not an
    approximation, but there was not a single false positive, though
    the number of checked paths at those depths is quite low):

                     linux.git                  webkit.git

               Number of                    Number of
      Path      checked   Average false      checked   Average false
      depth    paths at   positive rate     paths at   positive rate
      depth   that depth  at that depth    that depth  at that depth
      --------------------------------------------------------------
        1           2      0.31974050%          0       n/a
        2          97      0.06539501%         16       0.04927891%
        3        1052      0.01782569%        176       0.00472128%
        4        1674      0.00396338%        586       0.00399830%
        5        1315      0.00350913%        775       0.00089653%
        6         548      0.00149110%       1396       0.00025000%
        7         113      0.00057555%       1004       0.00004777%
        8         124      0.00085726%        397       0.00001380%
        9          34      0.00025182%        311       0.00001468%
       10          14      0%                 250       0.00000182%
       11           8      0%                  45       0%
       12          19      0%                  39       0%
       13           0      n/a                  3       0%
       14           0      n/a                  1       0%
       15           0      n/a                  1       0%
      --------------------------------------------------------------
      all        5000      0.007607%         5000       0.001012%

    So we could use fewer hashes when adding deep paths to modified
    path Bloom filters, saving same space while still achieving quite
    low false positive rate.  Or when aiming for consistently lower
    false positive rate, then we could use more hashes only for
    shallower paths.

[1] The repositories used in the above benchmarks are:

    android-base:
      https://android.googlesource.com/platform/frameworks/base
    cmssw:
      https://github.com/cms-sw/cmssw
    cpython:
      https://github.com/python/cpython
    elasticsearch:
      https://github.com/elastic/elasticsearch
    gcc:
      git://gcc.gnu.org/git/gcc.git
    gecko-dev:
      https://github.com/mozilla/gecko-dev
    git:
      https://git.kernel.org/pub/scm/git/git.git
    glibc:
      git://sourceware.org/git/glibc.git
    go:
      https://github.com/golang/go
    homebrew-cask:
      https://github.com/homebrew/homebrew-cask
    homebrew-core:
      https://github.com/homebrew/homebrew-core
    jdk:
      https://github.com/openjdk/jdk
    linux:
      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    llvm-project:
      https://github.com/llvm/llvm-project.git
    rails:
      https://github.com/rails/rails
    rust:
      https://github.com/rust-lang/rust
    tensorflow:
      https://github.com/tensorflow/tensorflow
    webkit:
      git://git.webkit.org/WebKit.git

[2] First PoC Bloom filter experiment:
    https://public-inbox.org/git/20181009193445.21908-1-szeder.dev@gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .../technical/commit-graph-format.txt         | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index efd0f99d8b..6b041f94ee 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -99,6 +99,131 @@ CHUNK DATA:
       file's OID Lookup chunk is equal to i plus the number of commits in all
       base graphs.  If B is non-zero, this chunk must exist.
 
+  Modified Path Bloom Filter Index (ID: {'M', 'P', 'B', 'I'}) [Optional]
+    2 + (N * 8) bytes
+
+    * 1-byte number (K) of hashes per path
+
+    * An array of 8 byte entries, one for each N commits stored in the
+      commit-graph, with the ith entry associated to the ith commit in the
+      OID Lookup chunk.
+      Each entry should be interpreted as follows:
+
+      - If all bits in the 8 bytes are set, then there is no modified path
+	Bloom filter stored for this commit.
+
+	Thou shalt not store a modified path Bloom filter for a commit that
+	modifies a submodule (gitlink file)!
+
+      - If the most significant bit of the first byte is set, then the
+	remaining 63 bits represent the bit array of an "embedded" Bloom
+	filter containing the set of paths that were modified between the
+	associated commit and its first parent, or in case of a root commit
+	between the associated commit and the empty tree.  All embedded
+	modified path Bloom filters use the same hashing scheme that is
+	used in the Modified Path Bloom Filters chunk, see below.
+
+      - If the second most significant bit of the first byte is set, then
+	the last four bytes form an array position into the Modified Path
+	Bloom Filter Merge Index chunk.  The remaining bits in the first
+	four bytes should be set to 0.  This can optionally be used to
+	store Bloom filters for all parents of merge commits.
+	[TODO: Only the last four bytes?  Shouldn't that be last 62 bits?!]
+
+      - If the two most significant bits of the first byte are unset, then
+	the entry represents an 8 byte offset pointing to a Bloom filter
+	in the Modified Path Bloom Filters chunk, which contains the set
+	of paths that were modified between the associated commit and its
+	first parent, or in case of a root commit between the associated
+	commit and the empty tree.  This offset is relative to the start
+	of the Modified Path Bloom Filters chunk.  Multiple entries can
+	point to the same offset.
+
+  Modified Path Bloom Filter Merge Index (ID: {'M', 'P', 'B', 'M'}) [Optional]
+      An array of 8 byte entries.
+      If a merge commit's entry in the Modified Path Bloom Filter Index
+      chunk stores an array position into this chunk, then the entry at
+      that position is associated with that merge commit and its first
+      parent, the next entry with that merge commit and its second parent,
+      etc. for all parents of that merge commit.
+
+      Each entry should be interpreted as follows, similar to the entries
+      in the Modified Path Bloom Filter Index chunk:
+
+      - If all bits in the 8 bytes are set, then there is no modified path
+	Bloom filter stored for the associated merge commit and its
+	corresponding parent.
+
+      - If the MSB of the first byte is set, then the remaining 63 bits
+	represent the bit array of an "embedded" Bloom filter containing
+	the set of paths that were modified between the associated merge
+	commit and its corresponding parent.  All embedded modified path
+	Bloom filters use the same hashing scheme that is used in the
+	Modified Path Bloom Filters chunk, see below.
+
+      - If the most significant bit of the first byte is unset, then the
+	entry represents an 8 byte offset pointing to a Bloom filter in
+	the Modified Path Bloom Filters chunk, which contains the set of
+	paths that were modified between the associated merge commit and
+	its corresponding parent.  This offset is relative to the start of
+	the Modified Path Bloom Filters chunk.  Multiple entries can point
+	to the same offset.
+
+      This chunk should not exist if the commit-graph file doesn't contain
+      a Modified Path Bloom Filter Index chunk.  This chunk can be omitted
+      if the Modified Path Bloom Filter Index doesn't contain any array
+      indexes pointing into it.  This chunk can be omitted even when the
+      commit-graph contains merge commits.
+
+  Modified Path Bloom Filters (ID: {'M', 'P', 'B', 'F'}) [Optional]
+      A number of consecuive modified path Bloom filters of varying sizes.
+      Each Bloom filter consists of 4 + M bytes:
+
+      - The first 4 bytes specify the number of m bits in the Bloom
+	filter's bit array.
+
+      - The next M bytes hold the Bloom filter's bit array of m bits.
+
+      The bits in the array are indexed in network byte order, i.e. the
+      array's 0th bit is the least significant bit of the last byte, and
+      the (m-1)th bit is in the first byte.  If m is not a multiple of 8,
+      then the unused leading bits should be set to 0.
+
+      For each path (including leading directories) modified between a
+      commit and its parent K bit positions should be set using the
+      following hashing scheme:
+
+	for i in [0, K)
+	  bit_pos[i] = (hash1 + i * hash2 + (i * i * i - i) / 6) % m
+
+      where hash1 and hash2 are the 32 bit MurmurHash3 hashes of the path
+      with seeds 0xe83c5163 and 0x3b376b0c, respectively.  These bit
+      positions should be calculated using 32 bit unsigned integer
+      arithmetic.  The directory separator is a single '/'.  Directories
+      should be added without a trailing '/'.
+
+      The order of Bloom filters in this chunk is unspecified.  Multiple
+      entries in the Modified Path Bloom Filter Index or Modified Path
+      Bloom Filter Merge Index chunks can point to the same Bloom filter
+      in this chunk.
+
+      This chunk should not exist if the commit-graph doesn't contain a
+      Modified Path Bloom Filter Index chunk.  This chunk can be omitted
+      if neither the Modified Path Bloom Filter Index nor the Modified
+      Path Bloom Filter Merge Index chunks contain any offsets pointing
+      into it.
+
+  Modified Path Bloom Filter Excludes (ID: {'M', 'P', 'B', 'X'}) [Optional]
+      A number of consecutive null terminated strings in memcmp() order.
+      Paths in these strings should not be added to any modified path
+      Bloom filters.
+      [TODO: Clarify!  Only literal matches, or should we support
+      globbing/patterns as well?  Only full match, or leading directories
+      as well?]
+
+      This chunk should not exist if the commit-graph doesn't contain a
+      Modified Path Bloom Filter Index chunk.
+
 TRAILER:
 
 	H-byte HASH-checksum of all of the above.
-- 
2.27.0.rc1.431.g5c813f95dc

