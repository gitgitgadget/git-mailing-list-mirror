Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171BA2018E
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756594AbcH2IEW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:49876 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756124AbcH2IEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LyEJp-1b1HcB0ng5-015ZRD; Mon, 29 Aug 2016 10:03:42
 +0200
Date:   Mon, 29 Aug 2016 10:03:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/22] Prepare the sequencer for the upcoming rebase -i
 patches
Message-ID: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EdSnqyJkxYmt8kleptZq2NNLDB1nrflHEKP18W5ZHmRz6bvI37b
 xVQ6RcI6bhRPqrEFEjZmJs1hrpUhahux2Sku4fDnWh60cnebRjnfB1boIkh2AvPzzMGGbWt
 avYa9MLwqS+I45IFLaC1nt3U5+KrrF1la1brmsoLPTuMPbG+AcGcMXbnzW2KtQmQUH+rCJ3
 46tWlmzr05BTZt+8vi/Lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J3EG7HPdPd4=:q5P1ENlfdsw1sJHJhZSAlo
 tAw1zYtuHd57YbdnOyViZXLICvr/VJ+R4qlrOnhNSPF87dbb5eFtbSV+No7rrZ4RaFHCLtx8G
 wrU9cAzINZNmxF75rh/yuxs4etBjJMlGhItG/6POlLDMdLcEFq5DycppxWkwlaQvkxqdPLsOU
 bKqM1LdRwrdL4c1CL8CKbtLSn3tI0isdZRMNIcmphZv7yiLJ5MuWk+DWe5EinTxJZSd6AYrSX
 0pVDZCYki+38+QQTp2tj5HOepX7H2sgBxMu8PuwSSK3We3exaVMjsll7rmfJTmYHC+Kz8KeGy
 cuCCikoich/c+4TqlC9lYSnPvDWdL3pE2gAUnBGNsrx1LLQHEOwaVnFzytxfdXwqyTTf4yId/
 kHV5y3iv3TY2V1ykmWplEGp7pwkF1gDuqcquo9DQiZgXXDgouV1QgaB6uikSMTO+SHyoujiFu
 X736VzAZyPO2O3B+svU8FFg/eVlM2zSrfXJ7tTdpw/3HXWF9IidyeeVZK3O38gz7zkI9IeIx+
 J9U312X6fD0BYDBiefjwLJJxOaje64tVndiivtlnG9v7y8OlDY00+R32mLUKK+jBfErZSJ6Z5
 kmMtPIZ1YAeNIwLdWvuXDsCDL/v5Id513nRZzWl2eo698AUUwcxWn803kPJvgE4LXyb7BY2GC
 u9RNdUObKys8K3qRCvdEAGdIktTkN3N+iFBALCKTXeb5MjYyrKiIJ6mP/WXl5IgM4npDTLzXE
 Us5UNLZ2dkiHzV0u52Bj505rBkkW0cepEzdt5zXKY8blJU4Cc/SGm+b4TDYt0tUkj5I6sEW6g
 ENkVAcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series marks the  '4' in the countdown to speed up rebase -i
by implementing large parts in C. It is based on the `libify-sequencer`
patch series that I submitted last week.

The patches in this series merely prepare the sequencer code for the
next patch series that actually teaches the sequencer to run an
interactive rebase.

The reason to split these two patch series is simple: to keep them at a
sensible size.

The two patch series after that are much smaller: a two-patch "series"
that switches rebase -i to use the sequencer (except with --root or
--preserve-merges), and a couple of patches to move several pretty
expensive script processing steps to C (think: autosquash).

The end game of this patch series is a git-rebase--helper that makes
rebase -i 5x faster on Windows (according to t/perf/p3404). Travis says
that even MacOSX and Linux benefit (4x and 3x, respectively).

I have been working on this since early February, whenever time allowed,
and it is time to put it into the users' hands. To that end, I will most
likely submit the remaining three patch series in the next two days, and
integrate the whole shebang into Git for Windows 2.10.0.

Therefore I would be most grateful for every in-depth review.


Johannes Schindelin (22):
  sequencer: use static initializers for replay_opts
  sequencer: use memoized sequencer directory path
  sequencer: avoid unnecessary indirection
  sequencer: future-proof remove_sequencer_state()
  sequencer: allow the sequencer to take custody of malloc()ed data
  sequencer: release memory that was allocated when reading options
  sequencer: future-proof read_populate_todo()
  sequencer: remove overzealous assumption
  sequencer: completely revamp the "todo" script parsing
  sequencer: avoid completely different messages for different actions
  sequencer: get rid of the subcommand field
  sequencer: refactor the code to obtain a short commit name
  sequencer: remember the onelines when parsing the todo file
  sequencer: prepare for rebase -i's commit functionality
  sequencer: introduce a helper to read files written by scripts
  sequencer: prepare for rebase -i's GPG settings
  sequencer: allow editing the commit message on a case-by-case basis
  sequencer: support amending commits
  sequencer: support cleaning up commit messages
  sequencer: remember do_recursive_merge()'s return value
  sequencer: left-trim the lines read from the script
  sequencer: refactor write_message()

 builtin/commit.c                |   2 +-
 builtin/revert.c                |  42 ++-
 sequencer.c                     | 573 +++++++++++++++++++++++++++-------------
 sequencer.h                     |  27 +-
 t/t3510-cherry-pick-sequence.sh |  11 -
 5 files changed, 428 insertions(+), 227 deletions(-)

Based-On: libify-sequencer at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git libify-sequencer
Published-As: https://github.com/dscho/git/releases/tag/prepare-sequencer-v1
Fetch-It-Via: git fetch https://github.com/dscho/git prepare-sequencer-v1

-- 
2.10.0.rc1.114.g2bd6b38

base-commit: 2d6d71e2a2d410b12d783f0a8edd22791f303c12
