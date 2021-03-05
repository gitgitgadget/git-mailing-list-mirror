Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3ECC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BB265074
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 19:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCETKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:10:44 -0500
Received: from mout.web.de ([212.227.17.11]:36623 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhCETKi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 14:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614971419;
        bh=qJV2IqgdOVAaLouTaC+grwTYdKybom6ipH5a7VjE6Fw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aCuq2FZ6Yl3ouLNc6vtuxFc7Ysfam5MSPboYbSTjzfYPklqZpS2jj9gPLBbXL7eRG
         6q1zM67AcgHMWhqcUFUWW/1el6miZzyrRdsF1t+al6Lf2secHvZKjn4PpVp9djLr9b
         SKKUeDjpPLShWmo7G+yGgpztXdbzmSKF/DI78S6s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LmLoU-1lqlNR2GYM-00ZxzF; Fri, 05 Mar 2021 20:10:19 +0100
Subject: Re: [PATCH v2 0/4] Makefile/coccicheck: fix bugs and speed it up
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>, Denton Liu <liu.denton@gmail.com>
References: <20210302205103.12230-1-avarab@gmail.com>
 <20210305170724.23859-1-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <3aac381e-2ce9-e35e-498c-9c26df235aed@web.de>
Date:   Fri, 5 Mar 2021 20:10:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305170724.23859-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FNWY63bjBVz1ASLN50eHCGK0JeOjzLzFYivf1GzvBOrlUR/9cif
 mIhx/uhWwu6AixU56gHHYjDL/rYvlNr7u/pJxvY+lroIdIJkqmur+0HvQMPq4zadD9iuYSk
 tzfztFXlJdPF5TT+Uqc4z4z8T/r3dXqzR5QJ4Ji6P1Zqea20o8K1i80BuPvbRA+vKxFndjD
 sG31v67dlUacPUhC/3OYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Zdrdfs55Us=:hhVLsWdSLIu1HbiAR/Psbe
 k+JIsYzPSIogqku087iNNG/cqN0L2j/K6lDt2s+uQbDzbZEfwNVsifQ13OUhObby10AwqJo5J
 k92M7qHL3AdQ8IbVQ3U6dc8fj6XX/saFmeiPrNXdxhAge4JEzqHor71Ij2kdM5q7Mm+Cl8Qd8
 fjB0gxibAGTGPXueufzTMOaTxXZKZ+UL06Xn0/oQ4bJPiOc5KUK20pZVeZbjxzu1FfzZwxSfU
 O15i3uCRbZG19tDYsoV1SnbPKgER/HeYEmL6SYYIpA3cHMefbPIHyJiqWGT8VIjflAPdHsf+f
 1M6ARHF79r0bIfEMEaKamDZE7AyEiFaSdtLR0Mwlu38FViFOQ8lrrOCOXxMWplB1AsAhQO9MF
 927SmU2sKnSYsAX92G6SoXuelhf2OMCW4p2eeADVi8AGnR6oBUevKTL0rovxZzXUoACXBY7cU
 1p31Zhbko6jZu38HE6IV14pJ73vhNrKXY/2hRyReLAk42o2jG0W5PLVTuO1yhUJ4nxYtp0hRA
 4OxBKk+k6AkxWcRhDneaF6O7bZKw1MvZ0jUbrh5sMPK+uCT0pw67CtBK94dXT7vDQkBsHiui9
 1CvVGWRRAdiRnjUFhnLTGrej8cqTiiyq1AJaPjID4mOcthmszZJc6idSdu8JTL6ppNegaVIRM
 p/0tjXv2+fHe6Vb9PFTgYo+8/dw5BNVXdcGetoGHGwvBE6ieYMU2EEKo7M74oLI3n6kZE38Qa
 /b9RWfL2xDtt0GsZVbgEx1QCG3cL9NGJo5ybZ9she/sbk7h6O3GaUr4TtmnatsHTuh1SFB5l1
 4AHdg00AMjGIYBWbOdhx6/h6mQg2+Y4v7Ydhy130t8ESEmsSAHtm3j/xm2equYkVw6QYoo9Un
 O3vHmY1l18XEkf14eYDQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.21 um 18:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Addresses feedback on v1:
>
>  - The removal of the "cat $@.log" is gone.
>  - Split up into N changes.
>  - Explained why 960154b9c17 (coccicheck: optionally batch spatch
>    invocations, 2019-05-06) broke things and produced duplicate hunks
>    in 2/4: tl;dr: spatch does its own locking etc., xargs -n trips it
>    up.
>  - Set number of batch processes to 8, as suggested by Jeff King.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>   Makefile/coccicheck: add comment heading for all SPATCH flags
>   Makefile/coccicheck: speed up and fix bug with duplicate hunks
>   Makefile/coccicheck: allow for setting xargs concurrency
>   Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>
>  Makefile | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

This speeds up "make coccicheck" after "make clean" as advertized for
me:

   before: 572.64s user 33.08s system 622% cpu 1:37.30  total
   after:  195.40s user  9.97s system 629% cpu   32.612 total

However, it also misses several conversions that coccicheck generated
without this series for the example added by the patch at the bottom.
Here's the difference of diffstats (< before, > after):

   $ diff <(diffstat b | sort) <(diffstat a | sort) | grep '^[<>]' | sort =
-k2 -k1
   >  27 files changed, 55 insertions(+), 57 deletions(-)
   <  36 files changed, 70 insertions(+), 71 deletions(-)
   <  attr.c                   |    2 +-
   >  blame.c                  |   15 +++++++--------
   <  blame.c                  |   17 ++++++++---------
   <  bloom.c                  |    2 +-
   <  cache-tree.c             |    2 +-
   >  combine-diff.c           |   18 +++++++++---------
   <  combine-diff.c           |   20 ++++++++++----------
   <  decorate.c               |    2 +-
   <  diffcore-rename.c        |    2 +-
   >  diffcore-rename.c        |    3 +--
   <  ewah/bitmap.c            |    2 +-
   <  hashmap.c                |    2 +-
   >  midx.c                   |    4 ++--
   <  midx.c                   |    8 ++++----
   <  pack-objects.c           |    2 +-
   <  pathspec.c               |    2 +-
   >  read-cache.c             |    2 +-
   <  read-cache.c             |    4 ++--
   >  ref-filter.c             |    2 +-
   <  ref-filter.c             |    4 ++--
   <  remote.c                 |    2 +-

That's with the current spatch version 1.1.0-00072-g3dc5d027.


diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 46b8d2ee11..1f26da007a 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -88,3 +88,16 @@ expression n;
 @@
 - ptr =3D xmalloc((n) * sizeof(T));
 + ALLOC_ARRAY(ptr, n);
+
+@@
+type T;
+T *ptr;
+expression n !=3D 1;
+@@
+(
+- ptr =3D xcalloc(n, \( sizeof(*ptr) \| sizeof(T) \));
++ CALLOC_ARRAY(ptr, n);
+|
+- ptr =3D xcalloc(\( sizeof(*ptr) \| sizeof(T) \), n);
++ CALLOC_ARRAY(ptr, n);
+)
