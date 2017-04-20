Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFE9207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033644AbdDTUwV (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:52:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:50630 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033455AbdDTUwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:52:18 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8vJ-1bv38h1e1Z-016gEY; Thu, 20
 Apr 2017 22:52:06 +0200
Date:   Thu, 20 Apr 2017 22:52:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 0/8] Introduce timestamp_t for timestamps
In-Reply-To: <cover.1491159939.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1492721487.git.johannes.schindelin@gmx.de>
References: <cover.1491159939.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vHYyks1EwaDE3LPsOfJXDvio5SbDofSGRWGtd1N5G2T6gR/fkL0
 s/DziDoJK1KZMTN5FJ1EQqDeltE2LWQbhyS6lVgqtlLisouYcIZU4UH5WEDT5kVhUWWszV0
 t1DWJdq04Eg0FTN3OPhFkQtSdcB+QCaue42hlk7Le+ALbjiP+VCKNwlNxpsFSiMY9LtfSzu
 X9Nfmg1WcXAs7ZI/k7E2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tw5IfKqL0N4=:zdBV5q09iUJ9Sj15iuKCDL
 rhudkr0U3J7I4PJXQ02wk+tEYyeQ98towDi7UXbPcQ+Wn9VWf6vEkKJxIITzyQMEJt8iftRCM
 Bv0VJcTvlOBedxp5Pw8YC0QtHQzF0izvpd4pZCBE1XiRuXNcp7VQQwQAtxI0zot537BbdD4LH
 UItDqY9xO9Cb97ynF5Yo0iV3staBuLLfBeqTlLhy/FH4vjR1MWEQ83wF2ScBq4gsHtRarjuQS
 nqPrUhbH6JCcklKuTQhCxP02UJR5efJboTsYnjZC0TFaS03TxYsd6PshrSiRFEkGty5FQ50ra
 5gNXavp0koKndo8XFaFg/AheTVjgYL7PGNq3Km7ZT/vZKB9BXuizCTKAhXIjLthKKt9+rDQ0Y
 K3d3Foghc64iVeCRsUDvKMr7zMhUmZQ5owUYNH4VSxLC2AzkERQm67W5a3E53UHpPz36NOCJN
 wone/OhclY7tfHtJo6zr4Z/RayqILb88UMGtJoxfT7PsN93XJexn/JWouvF1HHPnnyooDAd/R
 vtE3WgVNnoZiRRPCb860WlYRwgaQIsW1PZf6obiWNhtVGA0ME6IUOke1q/CXTkuDoe2dNdIX/
 f7Msv8U7Y75YSAsJlopYiZFek09ZGAZgHqdlwysW34j49isMKDasGGuf00QZ6QHu+G135JUqP
 YapA6UQSiVt940pbHP+YlfCvFPaOb3tAJ34yeMGqZTaQRQs8a6i6GQ9nvKHKTNMWFAintP+hO
 VxnN7RGHs2fOMcxUarYE9K0ScvCsPWoPg7CJb29mqIV5+sGuWkxYYZpCQVZR1P0raNPBvGa6+
 p7Y21up
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git v2.9.2 was released in a hurry to accomodate for platforms like
Windows, where the `unsigned long` data type is 32-bit even for 64-bit
setups.

The quick fix was to simply disable all the testing with "absurd" future
dates.

However, we can do much better than that, as we already make use of
64-bit data types internally. There is no good reason why we should not
use the same for timestamps. Hence, let's use uintmax_t for timestamps.

Note: while the `time_t` data type exists and is meant to be used for
timestamps, on 32-bit Linux it is *still* 32-bit. An earlier iteration
used `time_t` for that reason, but it came with a few serious downsides:
as `time_t` can be signed (and indeed, on Windows it is an int64_t),
Git's expectation that 0 is the minimal value does no longer hold true,
introducing its own set of interesting challenges. Besides, if we *can*
handle far in the future timestamps (except for formatting them using
the system libraries), it is more consistent to do so.

The upside of using `uintmax_t` for timestamps is that we do a much
better job to support far in the future timestamps across all platforms,
including 32-bit ones. The downside is that those platforms that use a
32-bit `time_t` will barf when parsing or formatting those timestamps.

This iteration has no new changes, only conflict resolutions necessary
due to `master` introducing nearby changes. Maybe this iteration will
be noticed enough to make it into `pu`?

Changes since v2:

- resolved merge conflicts while rebasing to the current `master`

- fixed a bug where archive-zip.c's dos_time() was passing an
  uninitialized time_t to localtime()


Johannes Schindelin (8):
  ref-filter: avoid using `unsigned long` for catch-all data type
  t0006 & t5000: prepare for 64-bit timestamps
  t0006 & t5000: skip "far in the future" test when time_t is too
    limited
  Specify explicitly where we parse timestamps
  Introduce a new "printf format" for timestamps
  Introduce a new data type for timestamps
  Abort if the system time cannot handle one of our timestamps
  Use uintmax_t for timestamps

 Documentation/technical/api-parse-options.txt |   8 +-
 archive-tar.c                                 |   5 +-
 archive-zip.c                                 |  11 ++-
 archive.h                                     |   2 +-
 builtin/am.c                                  |   4 +-
 builtin/blame.c                               |  14 ++--
 builtin/fsck.c                                |   6 +-
 builtin/gc.c                                  |   2 +-
 builtin/log.c                                 |   4 +-
 builtin/merge-base.c                          |   2 +-
 builtin/name-rev.c                            |   6 +-
 builtin/pack-objects.c                        |   4 +-
 builtin/prune.c                               |   4 +-
 builtin/receive-pack.c                        |  14 ++--
 builtin/reflog.c                              |  24 +++---
 builtin/rev-list.c                            |   2 +-
 builtin/rev-parse.c                           |   2 +-
 builtin/show-branch.c                         |   4 +-
 builtin/worktree.c                            |   4 +-
 bundle.c                                      |   4 +-
 cache.h                                       |  14 ++--
 commit.c                                      |  18 ++--
 commit.h                                      |   2 +-
 config.c                                      |   2 +-
 credential-cache--daemon.c                    |  12 +--
 date.c                                        | 113 ++++++++++++++------------
 fetch-pack.c                                  |   8 +-
 fsck.c                                        |   2 +-
 git-compat-util.h                             |   9 ++
 http-backend.c                                |   4 +-
 parse-options-cb.c                            |   4 +-
 pretty.c                                      |   4 +-
 reachable.c                                   |   9 +-
 reachable.h                                   |   4 +-
 ref-filter.c                                  |  22 ++---
 reflog-walk.c                                 |   8 +-
 refs.c                                        |  14 ++--
 refs.h                                        |   8 +-
 refs/files-backend.c                          |   8 +-
 revision.c                                    |   6 +-
 revision.h                                    |   4 +-
 sha1_name.c                                   |   6 +-
 t/helper/test-date.c                          |  18 ++--
 t/helper/test-parse-options.c                 |   4 +-
 t/t0006-date.sh                               |   4 +-
 t/t5000-tar-tree.sh                           |   6 +-
 t/test-lib.sh                                 |   3 +
 tag.c                                         |   6 +-
 tag.h                                         |   2 +-
 upload-pack.c                                 |   8 +-
 vcs-svn/fast_export.c                         |   8 +-
 vcs-svn/fast_export.h                         |   4 +-
 vcs-svn/svndump.c                             |   2 +-
 wt-status.c                                   |   2 +-
 54 files changed, 256 insertions(+), 218 deletions(-)


base-commit: 6a2c2f8d34fa1e8f3bb85d159d354810ed63692e
Published-As: https://github.com/dscho/git/releases/tag/time_t-may-be-int64-v3
Fetch-It-Via: git fetch https://github.com/dscho/git time_t-may-be-int64-v3

Interdiff vs v2:

 diff --git a/archive-zip.c b/archive-zip.c
 index 4f715d40450..bb117a74d45 100644
 --- a/archive-zip.c
 +++ b/archive-zip.c
 @@ -548,9 +548,14 @@ static void write_zip_trailer(const unsigned char *sha1)
  static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
  {
  	time_t time;
 -	struct tm *t = localtime(&time);
 +	struct tm *t;
  
 +	if (date_overflows(*timestamp))
 +		die("Timestamp too large for this system: %"PRItime, time);
 +	time = (time_t)*timestamp;
 +	t = localtime(&time);
  	*timestamp = time;
 +
  	*dos_date = t->tm_mday + (t->tm_mon + 1) * 32 +
  	            (t->tm_year + 1900 - 1980) * 512;
  	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;

-- 
2.12.2.windows.2.406.gd14a8f8640f

