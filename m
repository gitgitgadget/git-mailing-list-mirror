Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5743C54E4B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE07B206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLQQc5dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgEKL41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729365AbgEKL4Y (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:56:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E84C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m24so8142346wml.2
        for <git@vger.kernel.org>; Mon, 11 May 2020 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FQxwetCeYCdUaVsgwO1aVa9uHHwmNe9cZO7E7weGhaA=;
        b=GLQQc5dJin+ATdpROT8iqS/7knR/mWGnce0zGNRIuazv9+6ECmcF8BvwqON/2GAA4j
         JpdEYg50W8OmeerfqlSLOX5flj5zAx2dSR74bp16yitFeaMADROMB9UjQJLJOYMJXsUk
         Bz3Ds4SsXlrhJOuG9BFwSNmpvEqgaZHp/h6zfnevftMxSdLMy25qhu54En0aP9WRPoyk
         I+LYxlPfLOy0jWn8xmuXDthpS9bAOrrq38oNBE9SXD/a4Iqxh9N5E/zExC8PzfdkGiqJ
         JYp3q2y5uJzUvLNcNezOAXxA5aZgG1aTzLYY8P99pPu6DzDM/hijS/5ypNoagj8spgBA
         BZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FQxwetCeYCdUaVsgwO1aVa9uHHwmNe9cZO7E7weGhaA=;
        b=DPWKfQXsIq4y59KC+RWy5oIk98e+8FRERg+eTvbbaGPJoxS7RqdUXRPyVq6vaxEAAM
         J9HNEBKJC0ypn9mRkz4wDZxJxR1f12C+pZSFcBK8mqrrvVCifI3CuTixOiZfa7TXfGag
         jimeOFQxn4GyuyPMpr/SE0xYqpam7XaK737tqAhOIwJ5FCAGPAkC1nnM9u5yuwWvIWKF
         hQJm3e1Ye6Gi6AQWuBXCIi8GS8W4sOv672liggi2E4NFwMkTga6Ob+bs8a+c/JUfenBT
         309z6ZZVBeltPQh+cnphpKP5JotYxlZcK0QUcnmFT49peHBC2v1aPXeAnOPRsN7MVbJP
         ug4A==
X-Gm-Message-State: AGi0Pub1uTX8dGnNBatB8z3QwGQdF/Wih4rECu5icrefg5Jkw3MOeHB4
        AmQW4hxWHJQMLmxZVoaLONpGCBv6
X-Google-Smtp-Source: APiQypKSiuFHBiv08WVSbvTSUdcGtoRrplET9qnv1508LA6d7KJ/HP2/loE4JRyF2AiXDfmoGGcW+Q==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr22974574wmj.100.1589198181423;
        Mon, 11 May 2020 04:56:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm17032141wre.11.2020.05.11.04.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:56:20 -0700 (PDT)
Message-Id: <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
In-Reply-To: <pull.622.git.1588347029.gitgitgadget@gmail.com>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 11:56:07 +0000
Subject: [PATCH v2 00/12] Integrating line-log and changed-path Bloom filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The best way to learn how a feature works is to build on it. That's also the
best way to find defects.

I started on this patch series with two goals:

 1. Understand and submit Szeder's incremental line-log RFC [1].
 2. Integrate changed-path Bloom filters with line-log.

[1] https://lore.kernel.org/git/20190818182801.7580-1-szeder.dev@gmail.com/

Since I knew a lot about the Bloom filters and not much about line-log.c, I
expected to learn a lot that could contribute to improving Szeder's patches.
Instead, I discovered some deficiencies in the Bloom filter code, including
a few meaningful bugs that should be fixed before the topic is merge to
master.

This series is organized as follows:

 * Patches 1-4 are minor Bloom filter cleanups, including a documentation
   bug.
   
   
 * Patch 5 fixes a problem where the Bloom filters use much larger filters
   than expected.
   
   
 * Patch 6 fixes a bug related to the short-circuit of large diffs from
   e369698016 (diff: halt tree-diff early after max_changes, 2020-03-30).
   The condition for halting the diff computation is different than the
   check in bloom.c to see if that short-circuit was hit, which leads to
   some commits with large diffs getting an incomplete Bloom filter. This
   happened on the root commit of the Linux kernel repo, for example.
   
   
 * Patches 7-11 are Szeder's RFC, with my sign-off added. I have not changed
   the code from those submissions because I didn't find anything wrong with
   them as I was testing. However, I will take responsibility to respond to
   the feedback in this series.
   
   
 * Patch 12 integrates Bloom filters with the line-log code.
   
   

I organized these patches so patches 1-6 could be split into its own topic,
if beneficial to take earlier than the line-log changes.

The end result of this combined effort is the following: git log -L commands
feel much more responsive to a terminal user because Szeder's changes make
the computation incremental, and they have better end-to-end performance
because of the integration with Bloom filters to reduce time spent running
tree diffs for TREESAME commits.

The following table is also in patch 12, but it summarizes the results of
this series. These are timings for running git log -L 1,10:$path for these
recently-edited paths. The "Entire History" columns wait for the full
command to complete. The "First Result" columns add "-n 1" to the command,
so we see the benefits of the incremental algorithm. Thus, the performance
improvements from "Entire History" to "First Result" are due entirely to
Szeder's patches. The performance improvements from "Before" to "After" are
due to the changed-path Bloom filters.

|                              | Entire History  | First Result    |
| Path                         | Before | After  | Before | After  |
|------------------------------|--------|--------|--------|--------|
| MAINTAINERS                  | 4.26 s | 3.87 s | 0.41 s | 0.39 s |
| fs/namei.c                   | 1.99 s | 0.99 s | 0.42 s | 0.21 s |
| arch/x86/kvm/cpuid.c         | 5.28 s | 1.12 s | 0.16 s | 0.09 s |
| fs/io_uring.c                | 4.34 s | 0.99 s | 0.94 s | 0.27 s |
| arch/x86/kvm/vmx/vmx.c       | 5.01 s | 1.34 s | 0.21 s | 0.12 s |
| arch/x86/kvm/x86.c           | 2.24 s | 1.18 s | 0.21 s | 0.14 s |
| fs/btrfs/disk-io.c           | 1.82 s | 1.01 s | 0.06 s | 0.05 s |
| Documentation/scsi/index.rst | 3.30 s | 0.89 s | 1.46 s | 0.03 s |

Some splashy numbers include a 110x speedup for finding the first result for
Documentation/scsi/index.rst. That's certainly an outlier, but the rest have
an at least 10x speedup.

Update in V2: Modified commit messages according to Taylor's feedback.

Thanks, -Stolee

Derrick Stolee (7):
  bloom: fix whitespace around tab length
  test-bloom: fix usage typo
  bloom: parse commit before computing filters
  Documentation: changed-path Bloom filters use byte words
  bloom: de-duplicate directory entries
  bloom: use num_changes not nr for limit detection
  line-log: integrate with changed-path Bloom filters

SZEDER Gábor (5):
  completion: offer '--(no-)patch' among 'git log' options
  line-log: remove unused fields from 'struct line_log_data'
  t4211-line-log: add tests for parent oids
  line-log: more responsive, incremental 'git log -L'
  line-log: try to use generation number-based topo-ordering

 .../technical/commit-graph-format.txt         |  8 +--
 bloom.c                                       | 61 ++++++++++++-----
 bloom.h                                       |  5 +-
 contrib/completion/git-completion.bash        |  1 +
 line-log.c                                    | 43 +++++++++++-
 line-log.h                                    |  5 +-
 revision.c                                    | 43 ++++++++++--
 t/helper/test-bloom.c                         |  2 +-
 t/t0095-bloom.sh                              |  6 +-
 t/t4211-line-log.sh                           | 68 +++++++++++++++++++
 10 files changed, 201 insertions(+), 41 deletions(-)


base-commit: 1b4c57fa87e121f155863f898dc39d06cf4a1d99
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-622%2Fderrickstolee%2Flog-l-on-bloom-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-622/derrickstolee/log-l-on-bloom-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/622

Range-diff vs v1:

  1:  89625b0efae =  1:  89625b0efae bloom: fix whitespace around tab length
  2:  572d0508fe0 =  2:  572d0508fe0 test-bloom: fix usage typo
  5:  ef4c08e401b !  3:  0e08cec78d3 bloom: parse commit before computing filters
     @@ bloom.c: struct bloom_filter *get_bloom_filter(struct repository *r,
       	diff_setup_done(&diffopt);
       
      +	/* ensure commit is parsed so we have parent information */
     -+	parse_commit(c);
     ++	repo_parse_commit(r, c);
      +
       	if (c->parents)
       		diff_tree_oid(&c->parents->item->object.oid, &c->object.oid, "", &diffopt);
  3:  03b2c84db36 !  4:  61f78a2b0dd Documentation: changed-path Bloom filters use byte words
     @@ Commit message
          In Documentation/technical/commit-graph-format.txt, the definition
          of the BIDX chunk specifies the length is a number of 8-byte words.
          During development we discovered that using 8-byte words in the
     -    Murmur3 hash algorithm causes issues with Big-Endian versus Little-
     -    Endian machines. Thus, the hash algorithm was adapted to work on a
     +    Murmur3 hash algorithm causes issues with big-endian versus little-
     +    endian machines. Thus, the hash algorithm was adapted to work on a
          byte-by-byte basis. However, this caused a change in the definition
          of a "word" in bloom.h. Now, a "word" is a single byte, which allows
          filters to be as small as two bytes. These length-two filters are
  4:  07d0a25f1c4 =  5:  ba0d8c1f539 bloom: de-duplicate directory entries
  6:  7d5561575d5 !  6:  8278b5c0918 bloom: use num_changes not nr for limit detection
     @@ Commit message
          total number of changed paths is strictly larger than max_changes.
          This includes the directories that changed, not just the file paths.
          However, only the file paths are reflected in the resulting diff
     -    queue "nr" value.
     +    queue's "nr" value.
      
          Use the "num_changes" from diffopt to check if the diff terminated
          early. This is incredibly important, as it can result in incorrect
  7:  35d2901957e =  7:  05f8ee14752 completion: offer '--(no-)patch' among 'git log' options
  8:  1f326612da0 =  8:  c3f87ec4379 line-log: remove unused fields from 'struct line_log_data'
  9:  4e3d7233095 !  9:  69c2c2f775f  t4211-line-log: add tests for parent oids
     @@ Metadata
      Author: SZEDER Gábor <szeder.dev@gmail.com>
      
       ## Commit message ##
     -     t4211-line-log: add tests for parent oids
     +    t4211-line-log: add tests for parent oids
      
          None of the tests in 't4211-line-log.sh' really check which parent
          object IDs are shown in the output, either implicitly as part of
 10:  d9991d6158d ! 10:  009da4b93f6 line-log: more responsive, incremental 'git log -L'
     @@ Commit message
      
          To be clear: this patch doesn't actually optimize the line-level log,
          but merely moves most of the work from the preprocessing step to the
     -    history travelsal, so the commits modifying the line range can be
     +    history traversal, so the commits modifying the line range can be
          shown as soon as they are processed, and the traversal can be
          terminated as soon as the given number of commits are shown.
          Consequently, listing the full history of a line range, potentially
     @@ Commit message
          commits. In addition to that edit frequency, the file itself is quite
          large (~18,700 lines). This means that a significant portion of the
          computation is taken up by computing the patch-diff of the file. This
     -    patch improves the time it takes to output the first result quite a
     -    bit:
     +    patch improves the real time it takes to output the first result quite
     +    a bit:
      
          Command: git log -L 100,200:MAINTAINERS -n 1 >/dev/null
           Before: 3.88 s
 11:  3abc7130924 ! 11:  da087d2acbb line-log: try to use generation number-based topo-ordering
     @@ Commit message
      
          Additional testing by Derrick Stolee: Since this patch improves
          the performance for the first result, I repeated the experiment
     -    from the previous patch on the Linux kernel repository:
     +    from the previous patch on the Linux kernel repository, reporting
     +    real time here:
      
              Command: git log -L 100,200:MAINTAINERS -n 1 >/dev/null
               Before: 0.71 s
 12:  7e0c2871cf7 ! 12:  305f1eb0982 line-log: integrate with changed-path Bloom filters
     @@ Commit message
      
          (along with a bogus first result). It appears that the path
          arch/x86/kvm/svm.c was renamed, so we ignore that entry. This leaves the
     -    following results:
     +    following results for the real command time:
      
          |                              | Entire History  | First Result    |
          | Path                         | Before | After  | Before | After  |

-- 
gitgitgadget
