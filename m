Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FA3C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhLIKdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLIKdq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:46 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FAAC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d24so8950831wra.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IN4xCsLAJXlPU569HaZTxOyjd2x1Ko14Bxrnp5etYhg=;
        b=mjCz4rHXtMid3heTzG3OilM1Nkxln/ShN37plfwdsBM6D+SDMpZ2T0Yz11W4Od5Ddx
         SvaHPhCaY8NESVQU0BqBXdD3A9lJAkrHAuJh3SDIPjVr+BmY842sSEx//Gwu1/mqpslz
         mHo4h/wjH60C6nQ7kBpCB/HiOJMmOC8e/OzGCHLI5KMTqYzwsB0hL5mZMnMBtKcq7Afy
         YCPtNAN1UxUACMORAwwT7DsIPqV3rbnVFXmZX90HGpCLeHcPNpzoLyn25jiwwkBfZJPx
         1hWM1SkNniv9JKtTlgNEJk3BdwUqvr1uAgsnYPjOwKdbY6eSjUNolXqRpDgUA3Nq68lg
         UW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IN4xCsLAJXlPU569HaZTxOyjd2x1Ko14Bxrnp5etYhg=;
        b=ripXt+w9yY4/rBJFKQ5Wj9OkgmmQVFBddNPzczpG4tyH5n2nccBGOtJpEv6Tg96FwW
         KL1A/O6pdYcVZzpV9d3Go8xm46e0rlFAG4EWIlmSU++PlBH8YbzGg/Vp/97Xe51PraX0
         KeqcTZ5LWIiCDUWEHTNUuUbOQKi7epedjdpCUuilO6LVhthufk2osWSXFyDkgyu8/bdS
         Qh9LjEXVN5Ah1qy6mLQUuKQxnCvTEnJ+3oGJkPwL2x4QaNphw2w0x24qkTFWAXv0dnq+
         PcsW455RboawfTObJVTdoJ7/NaccV3kurEc+EeZxjJtcscYf2VCM+Odvvn/tYtZlpVel
         TE3g==
X-Gm-Message-State: AOAM531Cw3lldJE92PrM4eO1z4iKRkmlw8+bMi8sWlcMtvUeeNzWTCSO
        Bmo5uaSzkaaey3j+p3n0wv8NKlTYnCg=
X-Google-Smtp-Source: ABdhPJytPPkovGENaPjX4J/gOHpgaHnGLqjsVhf1oNS5gtjgjUJpnNGFe5wxH878ckeLzdKNpUK3ZA==
X-Received: by 2002:adf:d092:: with SMTP id y18mr5493229wrh.523.1639045811293;
        Thu, 09 Dec 2021 02:30:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n184sm8355317wme.2.2021.12.09.02.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:10 -0800 (PST)
Message-Id: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:29:54 +0000
Subject: [PATCH v5 00/15] diff --color-moved[-ws] speedups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Dscho for his comments on V3. Changes since V4:

 * Fixed a typo in the commit message to patch 6

Changes since V3:

 * Patch 1 now allows the user to choose different endpoints for the diff
   perf tests to facilitate testing with different repositories.
 * Fixed the alignment of the perf results column headers in a couple of
   patches.

Changes since V2:

 * Patches 1-3 are new and fix an existing bug.
 * Patch 8 includes Peff's unused parameter fix.
 * Patch 11 has been updated to fix a bug fix in V2.
 * Patch 13 has an expanded commit message explaining a change in behavior
   for lines starting with a form-feed.
 * Updated benchmark results.

The bug fix in patch 3 degrades the performance, but by the end of the
series the timings are the same as V2 - see the range diff.

V2 Cover Letter: Thanks to Ævar and Elijah for their comments, I've reworded
the commit messages, addressed the enum initialization issue in patch 2 (now
3) and added some perf tests.

There are two new patches in this round. The first patch is new and adds the
perf tests suggested by Ævar, the penultimate patch is also new and coverts
the existing code to use a designated initializer.

I've converted the benchmark results in the commit messages to use the new
tests, the percentage changes are broadly similar to the previous results
though I ended up running them on a different computer this time.

V1 cover letter:

The current implementation of diff --color-moved-ws=allow-indentation-change
is considerably slower that the implementation of diff --color-moved which
is in turn slower than a regular diff. This patch series starts with a
couple of bug fixes and then reworks the implementation of diff
--color-moved and diff --color-moved-ws=allow-indentation-change to speed
them up on large diffs. The time to run git diff --color-moved
--no-color-moved-ws v2.28.0 v2.29.0 is reduced by 33% and the time to run
git diff --color-moved --color-moved-ws=allow-indentation-change v2.28.0
v2.29.0 is reduced by 88%. There is a small slowdown for commit sized diffs
with --color-moved - the time to run git log -p --color-moved
--no-color-moved-ws --no-merges -n1000 v2.29.0 is increased by 2% on recent
processors. On older processors these patches reduce the running time in all
cases that I've tested. In general the larger the diff the larger the speed
up. As an extreme example the time to run diff --color-moved
--color-moved-ws=allow-indentation-change v2.25.0 v2.30.0 goes down from 8
minutes to 6 seconds.

Phillip Wood (15):
  diff --color-moved: add perf tests
  diff --color-moved: clear all flags on blocks that are too short
  diff --color-moved: factor out function
  diff --color-moved: rewind when discarding pmb
  diff --color-moved=zebra: fix alternate coloring
  diff --color-moved: avoid false short line matches and bad zebra
    coloring
  diff: simplify allow-indentation-change delta calculation
  diff --color-moved-ws=allow-indentation-change: simplify and optimize
  diff --color-moved: call comparison function directly
  diff --color-moved: unify moved block growth functions
  diff --color-moved: shrink potential moved blocks as we go
  diff --color-moved: stop clearing potential moved blocks
  diff --color-moved-ws=allow-indentation-change: improve hash lookups
  diff: use designated initializers for emitted_diff_symbol
  diff --color-moved: intern strings

 diff.c                           | 431 +++++++++++++------------------
 t/perf/p4002-diff-color-moved.sh |  57 ++++
 t/t4015-diff-whitespace.sh       | 205 ++++++++++++++-
 3 files changed, 437 insertions(+), 256 deletions(-)
 create mode 100755 t/perf/p4002-diff-color-moved.sh


base-commit: 211eca0895794362184da2be2a2d812d070719d3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-981%2Fphillipwood%2Fwip%2Fdiff-color-moved-tweaks-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-981/phillipwood/wip/diff-color-moved-tweaks-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/981

Range-diff vs v4:

  1:  48ee03cf52a =  1:  48ee03cf52a diff --color-moved: add perf tests
  2:  47c652716e8 =  2:  47c652716e8 diff --color-moved: clear all flags on blocks that are too short
  3:  99e38ba9de9 =  3:  99e38ba9de9 diff --color-moved: factor out function
  4:  9ca71db61ae =  4:  9ca71db61ae diff --color-moved: rewind when discarding pmb
  5:  56bb69af36e =  5:  56bb69af36e diff --color-moved=zebra: fix alternate coloring
  6:  10b11526206 !  6:  ed62b980225 diff --color-moved: avoid false short line matches and bad zerba coloring
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    diff --color-moved: avoid false short line matches and bad zerba coloring
     +    diff --color-moved: avoid false short line matches and bad zebra coloring
      
          When marking moved lines it is possible for a block of potential
          matched lines to extend past a change in sign when there is a sequence
  7:  c2e7b347257 =  7:  b8db6a1af7d diff: simplify allow-indentation-change delta calculation
  8:  d7bbc0041e0 =  8:  eeb633063b7 diff --color-moved-ws=allow-indentation-change: simplify and optimize
  9:  c3e5dce1910 =  9:  fb413cab3a8 diff --color-moved: call comparison function directly
 10:  9eb8cecd52a = 10:  ec8764082d5 diff --color-moved: unify moved block growth functions
 11:  35e204e1578 = 11:  6199a014547 diff --color-moved: shrink potential moved blocks as we go
 12:  ec329e7946d = 12:  1db84490ee4 diff --color-moved: stop clearing potential moved blocks
 13:  6ec94134aaf = 13:  3e769bab78c diff --color-moved-ws=allow-indentation-change: improve hash lookups
 14:  d44c5d734c3 = 14:  b8869659664 diff: use designated initializers for emitted_diff_symbol
 15:  5177f669423 = 15:  350fa55ce5e diff --color-moved: intern strings

-- 
gitgitgadget
