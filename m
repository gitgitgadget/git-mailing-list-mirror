Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9CB71FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971290AbdDUKpJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:45:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:57213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971277AbdDUKpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:45:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5LJv-1c5Jje0Ae7-00zZTR; Fri, 21
 Apr 2017 12:45:01 +0200
Date:   Fri, 21 Apr 2017 12:45:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 0/9] Introduce timestamp_t for timestamps
In-Reply-To: <cover.1492721487.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1492771484.git.johannes.schindelin@gmx.de>
References: <cover.1492721487.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:m0BCgvGDBtlZ7ZYp+S/0fAbtt7SCmpgKcnEGuXxbzdOdAdjjy0X
 Sw9btWk2qMQbK9ZKENJNwYrDxKISp0cSgGMKG89+GnzOyUJaEiYS8M8uRRrTfLbUWrk5Snw
 TjIhdXmlxOPIgHQpLH0nRVJU/2xIs8ExSdSQ1Xy6r/Fg2gpPtZOjnuxxSo9hiURNvAuDFLg
 xM4gu62zbwGNJZA7rBHlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sRJvPt0FDP0=:OiDXiLrowbVI2J+4VKeQ/m
 JluB6VNByRmwXTh8vsXZy5qMfq8yhR47P4HbIPJqTt1R+l0tUQup7wvShefs0vuNPO8TCsLbF
 Ox3WwmXH2unTLBZbM39VcLWpD25s1QIKvey/IYXHmXJxqcV/85kSF96M9C9A54Vmw5OfPiydg
 M0jzLiV06IQZ5+LXIkExYP0jDBQqigwainLc1L4tT1YNGWfxP2VaNzLjKan1cpJGn0j/us/Iw
 RYr2nNisBst8TcG0lyZhugOQ1nKe1ow97kiA26bOBI7LYuTZuRyDZ+dCteO3A6K1T3ywsE99S
 UKg9erkhUAzfa5+nV2Rvej61wnhiPet9c1SKL1t3n9N0O3GSDjqR5U1bR9fx/Wb2QXL0Tu5CZ
 9lDXy3LKIdPJKK0xwcZTsMqXEjIO/ILTRMvekWjv3jKcsdCR7il6QBuYCqjd7niWcooxnOgYa
 eH9urWpGYOBgcz5Vu8gOxqQoZcyFHBZwMzffBtjdF4RfTU+uJ4g8RCUJVlNtAIh+Xk4gWM8d/
 GkdEv0mCPMAhJoZwCc+nmZZNeIf5MGr/QS9zcItcd9Kea9T6K+WQcjoDEAxhs9hMOXQ973VCg
 wa8BYqYpgfrPQ2qsYgdAZIcO+IELi78Hr0unMCV1nl44CzPq4faR+8bcsQz/MeFY+qa6jkgl5
 W4LdLsZdkcwm04fNxYBd51ERCoC3WKh4G92VEm1EWa/jKZ+EdqRSh7pxrm+CqMVznOWBXsy5D
 OpXJz8/Yk1P0LOIwmXEQfq0Nrz9zB2+xvFOGgszEV091Mv5RkmPNbN/NmKLNo+F2+rWDqslW6
 qHI2C9j
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

This iteration has two fixes for issues reported by Travis CI (thank
deity for Continuous Testing, eh?), one by the MacOSX nodes (but not by
the Linux nor the Windows nodes), the other by the windows node (which
reminds me to run tests after rebasing to `master` not only in a Linux
VM but also on Windows, even if it takes ages there due to the heavy
shell scripting).

After reading Junio's comments on the cover letter of v2, I had another
look at the usage of date_overflows() and was able to relax two of them.

Changes since v3:

- fixed the fix in archive-zip.c that tried to report a too large
  timestamp (and would have reported the uninitialized time_t instead)

- adjusted the so-far forgotten each_reflog() function (that was
  introduced after v1, in 80f2a6097c4 (t/helper: add test-ref-store to
  test ref-store functions, 2017-03-26)) to use timestamp_t and PRItime,
  too

- removed the date_overflows() check from time_to_tm(), as it calls
  gm_time_t() which already performs that check

- the date_overflows() check in show_ident_date() was removed, as we do
  not know at that point yet whether we use the system functions to
  render the date or not (and there would not be a problem in the latter
  case)


Johannes Schindelin (9):
  ref-filter: avoid using `unsigned long` for catch-all data type
  t0006 & t5000: prepare for 64-bit timestamps
  t0006 & t5000: skip "far in the future" test when time_t is too
    limited
  Specify explicitly where we parse timestamps
  Introduce a new "printf format" for timestamps
  Introduce a new data type for timestamps
  Abort if the system time cannot handle one of our timestamps
  Use uintmax_t for timestamps
  show_date_ident(): defer date overflow check

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
 commit.c                                      |  18 ++---
 commit.h                                      |   2 +-
 config.c                                      |   2 +-
 credential-cache--daemon.c                    |  12 +--
 date.c                                        | 106 ++++++++++++++------------
 fetch-pack.c                                  |   8 +-
 fsck.c                                        |   2 +-
 git-compat-util.h                             |   9 +++
 http-backend.c                                |   4 +-
 parse-options-cb.c                            |   4 +-
 pretty.c                                      |  16 ++--
 reachable.c                                   |   9 +--
 reachable.h                                   |   4 +-
 ref-filter.c                                  |  22 +++---
 reflog-walk.c                                 |   8 +-
 refs.c                                        |  14 ++--
 refs.h                                        |   8 +-
 refs/files-backend.c                          |   8 +-
 revision.c                                    |   6 +-
 revision.h                                    |   4 +-
 sha1_name.c                                   |   6 +-
 t/helper/test-date.c                          |  18 +++--
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
 55 files changed, 257 insertions(+), 227 deletions(-)


base-commit: 6a2c2f8d34fa1e8f3bb85d159d354810ed63692e
Published-As: https://github.com/dscho/git/releases/tag/time_t-may-be-int64-v4
Fetch-It-Via: git fetch https://github.com/dscho/git time_t-may-be-int64-v4

Interdiff vs v3:

 diff --git a/archive-zip.c b/archive-zip.c
 index bb117a74d45..68df3d64402 100644
 --- a/archive-zip.c
 +++ b/archive-zip.c
 @@ -551,7 +551,8 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
  	struct tm *t;
  
  	if (date_overflows(*timestamp))
 -		die("Timestamp too large for this system: %"PRItime, time);
 +		die("timestamp too large for this system: %"PRItime,
 +		    *timestamp);
  	time = (time_t)*timestamp;
  	t = localtime(&time);
  	*timestamp = time;
 diff --git a/date.c b/date.c
 index db3435df3e4..75f6335cd09 100644
 --- a/date.c
 +++ b/date.c
 @@ -43,12 +43,12 @@ static time_t gm_time_t(timestamp_t time, int tz)
  {
  	int minutes;
  
 -	if (date_overflows(time))
 -		die("Timestamp too large for this system: %"PRItime, time);
 -
  	minutes = tz < 0 ? -tz : tz;
  	minutes = (minutes / 100)*60 + (minutes % 100);
  	minutes = tz < 0 ? -minutes : minutes;
 +
 +	if (date_overflows(time + minutes * 60))
 +		die("Timestamp too large for this system: %"PRItime, time);
  	return (time_t)time + minutes * 60;
  }
  
 @@ -59,12 +59,7 @@ static time_t gm_time_t(timestamp_t time, int tz)
   */
  static struct tm *time_to_tm(timestamp_t time, int tz)
  {
 -	time_t t;
 -
 -	if (date_overflows(time))
 -		die("Timestamp too large for this system: %"PRItime, time);
 -
 -	t = gm_time_t((time_t)time, tz);
 +	time_t t = gm_time_t(time, tz);
  	return gmtime(&t);
  }
  
 diff --git a/pretty.c b/pretty.c
 index 587d48371b0..35fd290096a 100644
 --- a/pretty.c
 +++ b/pretty.c
 @@ -410,14 +410,10 @@ const char *show_ident_date(const struct ident_split *ident,
  
  	if (ident->date_begin && ident->date_end)
  		date = parse_timestamp(ident->date_begin, NULL, 10);
 -	if (date_overflows(date))
 -		date = 0;
 -	else {
 -		if (ident->tz_begin && ident->tz_end)
 -			tz = strtol(ident->tz_begin, NULL, 10);
 -		if (tz >= INT_MAX || tz <= INT_MIN)
 -			tz = 0;
 -	}
 +	if (ident->tz_begin && ident->tz_end)
 +		tz = strtol(ident->tz_begin, NULL, 10);
 +	if (tz >= INT_MAX || tz <= INT_MIN)
 +		tz = 0;
  	return show_date(date, tz, mode);
  }
  
 diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
 index 2d84c45ffe9..9077ec2c330 100644
 --- a/t/helper/test-ref-store.c
 +++ b/t/helper/test-ref-store.c
 @@ -138,10 +138,10 @@ static int cmd_for_each_reflog(struct ref_store *refs, const char **argv)
  }
  
  static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 -		       const char *committer, unsigned long timestamp,
 +		       const char *committer, timestamp_t timestamp,
  		       int tz, const char *msg, void *cb_data)
  {
 -	printf("%s %s %s %lu %d %s\n",
 +	printf("%s %s %s %"PRItime" %d %s\n",
  	       oid_to_hex(old_oid), oid_to_hex(new_oid),
  	       committer, timestamp, tz, msg);
  	return 0;

-- 
2.12.2.windows.2.406.gd14a8f8640f

