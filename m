Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0F5207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171915AbdDXN6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:58:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:54477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171906AbdDXN6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:58:04 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkv0-1chHKg2Hjq-00LSnS; Mon, 24
 Apr 2017 15:57:52 +0200
Date:   Mon, 24 Apr 2017 15:57:51 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 0/8] Introduce timestamp_t for timestamps
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493042239.git.johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yoixu54z8U8Thq/n1pj9/BMokQB4Lc7s2EVPEd8jbstMxcdUY2G
 aswj1JxyTQggZAlGPpJVttH1E77lv8H17QmoUQWe5ha+mrv09s9n+ziN+5bcpL4v5IAmROv
 AJHv8OJxwIrbK8Phg2k0Jg/Apgfa4Cy2yuyxZp8x9J4Wa8Gky2PsgCo4cCyU1RzZf3e5T0H
 3Ekfp+ZqmSF10eVSfGaag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e9Op3IgpaxQ=:4MtVptZoAS5J3aj+5VPGOO
 C8zNL+rgNc7eeeV81u+29LRFMTVgulX0bSpcXpdqKDjs5pSqXbUbTKfaC4gVvHXCc6wlb4hxT
 sSpQZRu9VWflK3VQsmE0skMBAOVJLztAgQnGmFnJbz4wfWx7gcJH0LhJlNypbYAbnaTve7Pnl
 VUwnOvPrrUA4B0H+fVqODXmErR6MxolCZ1v2dQx+57PMZwy/y+rcOkrxPBMldnflYPUrYUuL2
 X7TBUoGGKG/r3Q3TKl/dtnvBQbVQQ8Jwd9JWOGiz33qMmnmTZLubeRwY4AR/WbeoSYn8Hec1E
 oEr418tw3RSmCiwwTUlwzrjZBXwu13IdiTRUUfSyDYkCg5i1LyzUVetupFrc4rP5UGdqFBABL
 VGGzqhU9mDzvwOYhMkF0oDaFqZCeCtmvwUpzSBsddXc7mguLRP8Z6BEsnflrKuZZ+ITo88Ufp
 i8n2FDrBABuLRZzm9Ym6EOAriCGLapxzpUQTFPQPKglp8EiAwgxiWahqgBoEWX4+VCxHDNTln
 uNSEePGmwCXBDdA3BrcdjfR6FW+bYbChbzkUvl0ofAr34evUjbuAVnK4x+t7MCgt6EZO5IzJF
 KD+8nuy2AItQBfhq76DNrxc7EipiPep+4tZ3289B5QmtdeapgXHjUStXBAH4xKmmPqZI1hynG
 +mZGM2ieb4GAIMS+asUUgqErzB1vL3vG5FRCRv5VRxPnZxwJyxlg2OZe4QH3pNTu99aGQkWUo
 mBL8HjrBbD/1k27lKQZacZkr+BJFLkBA99rUPnwptEkK1ip971xhVcHv77023mCvY8b3qOGzM
 Vc373Dp
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

This iteration makes the date_overflows() check more stringent again.

It is arguably a bug to paper over too-large author/committer dates and
to replace them with Jan 1 1970 without even telling the user that we do
that, but this is the behavior that t4212 verifies, so I reinstated that
behavior. The change in behavior was missed because of the missing
unsigned_add_overflows() test.

Changes since v4:

- in gm_time_t(), we now test specifically that the timezone adjustment
  neither underflows nor overflows.

- the patch introduced in v4 that tried to defer the date_overflows()
  check to gm_time_t() rather than replacing the ident timestamp by a 0
  without any warning was dropped again: it broke t4212.


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
 archive-zip.c                                 |  12 ++-
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
 t/helper/test-ref-store.c                     |   4 +-
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
 55 files changed, 260 insertions(+), 219 deletions(-)


base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
Published-As: https://github.com/dscho/git/releases/tag/time_t-may-be-int64-v5
Fetch-It-Via: git fetch https://github.com/dscho/git time_t-may-be-int64-v5

Interdiff vs v4:

 diff --git a/date.c b/date.c
 index 75f6335cd09..63fa99685e2 100644
 --- a/date.c
 +++ b/date.c
 @@ -47,9 +47,16 @@ static time_t gm_time_t(timestamp_t time, int tz)
  	minutes = (minutes / 100)*60 + (minutes % 100);
  	minutes = tz < 0 ? -minutes : minutes;
  
 -	if (date_overflows(time + minutes * 60))
 +	if (minutes > 0) {
 +		if (unsigned_add_overflows(time, minutes * 60))
 +			die("Timestamp+tz too large: %"PRItime" +%04d",
 +			    time, tz);
 +	} else if (time < -minutes * 60)
 +		die("Timestamp before Unix epoch: %"PRItime" %04d", time, tz);
 +	time += minutes * 60;
 +	if (date_overflows(time))
  		die("Timestamp too large for this system: %"PRItime, time);
 -	return (time_t)time + minutes * 60;
 +	return (time_t)time;
  }
  
  /*
 diff --git a/pretty.c b/pretty.c
 index 35fd290096a..587d48371b0 100644
 --- a/pretty.c
 +++ b/pretty.c
 @@ -410,10 +410,14 @@ const char *show_ident_date(const struct ident_split *ident,
  
  	if (ident->date_begin && ident->date_end)
  		date = parse_timestamp(ident->date_begin, NULL, 10);
 -	if (ident->tz_begin && ident->tz_end)
 -		tz = strtol(ident->tz_begin, NULL, 10);
 -	if (tz >= INT_MAX || tz <= INT_MIN)
 -		tz = 0;
 +	if (date_overflows(date))
 +		date = 0;
 +	else {
 +		if (ident->tz_begin && ident->tz_end)
 +			tz = strtol(ident->tz_begin, NULL, 10);
 +		if (tz >= INT_MAX || tz <= INT_MIN)
 +			tz = 0;
 +	}
  	return show_date(date, tz, mode);
  }
  

-- 
2.12.2.windows.2.406.gd14a8f8640f

