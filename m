Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55ED31F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934163AbcIUSXc (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:23:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:63326 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933024AbcIUSXb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:23:31 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M03qC-1az5R93zSe-00uMn4; Wed, 21 Sep 2016 20:23:16
 +0200
Date:   Wed, 21 Sep 2016 20:23:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <cover.1473321437.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1474482164.git.johannes.schindelin@gmx.de>
References: <cover.1473321437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-965078724-1474482196=:129229"
X-Provags-ID: V03:K0:d/4D7Dxt1Yy8hO2VkP3c72o7zWdGURimIgx18wL9D2jKS6ONrQV
 d3I0cf4T5l0lkAdkHBzQMJ3bYr2q4C9qhx/GLS+MHmwwBUujJxUg4XK+OVSM2tLvOKpmlKN
 wFWbTK2qKFUMVRlIj+iCjmxr+Hz7O5JbPDmMhCDaiZDnOKxpm9+Ojy71b/AllQ3sUEJ7XYg
 ANOkHglwbMgiECjl0gs2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ITa+N3FU4LY=:CNwLAQQBnV83Kqalto8pPB
 /3M8VIRCBMdtMNTqLB4EzyQug9quhD70H5eg6Leoew0MEu6CiuW0JRoDMrfN8f6LvEZfd+Ks/
 M/32n94wl8wcTCvhY2lC6YsDhpuL2ktFoSf1BhytOc07yJ2zTE+NehadDCreT0V37cR9FIxJg
 FAvIPVdkp2UyTh6tAyoSNgHaiyluxtfmwC4nbohxBB/PuEaI2o94qGSaHCYBXgXLJ56q/pd+G
 zmkrN7jPBTvAk5F1+QXjry+2Ak4mJ2SFFiKkoMIXQsY1hbyOawtDjW/kqsDj54Eq2iXrQhHp7
 xLguaRy3R8jicWCqCRJwPfW1PGuwLYwEa2RNSPjVGsSfKUtYFcPbnugtDlP536K3Trpf5vztA
 fktwHtEObQS8eQPGp6F7pFoQrsg9saKrJColPArF4dqma8t62//8kViaDfj9+7v7oZKs/6AIS
 ekp3MoTbXhjppYS6adLM2y1lTIRS1+F1o2vp/82CEGHbyPj2z+H5uN9QKd5KhvQzs+Ka7U5QG
 yOKoPNhA73/g0VpqZPpKkmDHLTV8XFrM0e4rD+ssc5/iMqnJ7qI3KG1qgPeYt9JIqapU/kCmk
 IVPG9/zlyp1kTuXohLVWdYdZXaqLDUCf10/QA0x/tmSE9+fXhlMq4FHCgEjE+rIJjMU/R51MR
 3NRWj6WTyu5enLOB5bDP/s66UFnOV7ecc69lric7Or36dZX7c8C3r46mT5Eqc0AA2exK6ZKCf
 0lcZtzbCqF6kmZXGIzwBZ2bhcJvKJT6STnHbr4o4OwlSV45rFaLE64gtWV2+jPB+DWWdxoa9J
 SXVVdOP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-965078724-1474482196=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

[Cc:ing Benjamin Kramer & Ren=C3=A9 Scharfe because they both worked on
the REG_STARTEND code in grep.c that I replace in this iteration of the
patch series]

This patch series addresses a problem where `git diff` is called using
`-G` or `-S --pickaxe-regex` on new-born files that are configured
without user diff drivers, and that hence get mmap()ed into memory.

The problem with that: mmap()ed memory is *not* NUL-terminated, yet the
pickaxe code calls regexec() on it just the same.

This problem has been reported by my colleague Chris Sidi.

We solve this by introducing a helper, regexec_buf(), that takes a
pointer and a length instead of a NUL-terminated string.

This helper then uses REG_STARTEND where available, and falls back to
allocating and constructing a NUL-terminated string. Given the
wide-spread support for REG_STARTEND (Linux has it, MacOSX has it, Git
for Windows has it because it uses compat/regex/ that has it), I think
this is a fair trade-off.

Changes since v3:

- reworded the onelines as per Junio's suggestions.

- removed fallback when REG_STARTEND is not supported, in favor of
  requiring NO_REGEX.

- removed the regmatch() function from grep.c, in favor of using
  regexec_buf().


Johannes Schindelin (3):
  regex: -G<pattern> feeds a non NUL-terminated string to regexec() and
    fails
  regex: add regexec_buf() that can work on a non NUL-terminated string
  regex: use regexec_buf()

 Makefile                |  3 ++-
 diff.c                  |  3 ++-
 diffcore-pickaxe.c      | 18 ++++++++----------
 git-compat-util.h       | 13 +++++++++++++
 grep.c                  | 14 ++------------
 t/t4061-diff-pickaxe.sh | 22 ++++++++++++++++++++++
 xdiff-interface.c       | 13 ++++---------
 7 files changed, 53 insertions(+), 33 deletions(-)
 create mode 100755 t/t4061-diff-pickaxe.sh

Published-As: https://github.com/dscho/git/releases/tag/mmap-regexec-v4
Fetch-It-Via: git fetch https://github.com/dscho/git mmap-regexec-v4

Interdiff vs v3:

 diff --git a/Makefile b/Makefile
 index df4f86b..c6f7f66 100644
 --- a/Makefile
 +++ b/Makefile
 @@ -301,7 +301,8 @@ all::
  # crashes due to allocation and free working on different 'heaps'.
  # It's defined automatically if USE_NED_ALLOCATOR is set.
  #
 -# Define NO_REGEX if you have no or inferior regex support in your C libr=
ary.
 +# Define NO_REGEX if your C library lacks regex support with REG_STARTEND
 +# feature.
  #
  # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with t=
he
  # user.
 diff --git a/git-compat-util.h b/git-compat-util.h
 index 627ec5f..8aab0c3 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -977,25 +977,17 @@ void git_qsort(void *base, size_t nmemb, size_t size=
,
  #define qsort git_qsort
  #endif
 =20
 +#ifndef REG_STARTEND
 +#error "Git requires REG_STARTEND support. Compile with NO_REGEX=3DNeedsS=
tartEnd"
 +#endif
 +
  static inline int regexec_buf(const regex_t *preg, const char *buf, size_=
t size,
  =09=09=09      size_t nmatch, regmatch_t pmatch[], int eflags)
  {
 -#ifdef REG_STARTEND
  =09assert(nmatch > 0 && pmatch);
  =09pmatch[0].rm_so =3D 0;
  =09pmatch[0].rm_eo =3D size;
  =09return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
 -#else
 -=09char *buf2 =3D xmalloc(size + 1);
 -=09int ret;
 -
 -=09memcpy(buf2, buf, size);
 -=09buf2[size] =3D '\0';
 -=09ret =3D regexec(preg, buf2, nmatch, pmatch, eflags);
 -=09free(buf2);
 -
 -=09return ret;
 -#endif
  }
 =20
  #ifndef DIR_HAS_BSD_GROUP_SEMANTICS
 diff --git a/grep.c b/grep.c
 index d7d00b8..1194d35 100644
 --- a/grep.c
 +++ b/grep.c
 @@ -898,17 +898,6 @@ static int fixmatch(struct grep_pat *p, char *line, c=
har *eol,
  =09}
  }
 =20
 -static int regmatch(const regex_t *preg, char *line, char *eol,
 -=09=09    regmatch_t *match, int eflags)
 -{
 -#ifdef REG_STARTEND
 -=09match->rm_so =3D 0;
 -=09match->rm_eo =3D eol - line;
 -=09eflags |=3D REG_STARTEND;
 -#endif
 -=09return regexec(preg, line, 1, match, eflags);
 -}
 -
  static int patmatch(struct grep_pat *p, char *line, char *eol,
  =09=09    regmatch_t *match, int eflags)
  {
 @@ -919,7 +908,8 @@ static int patmatch(struct grep_pat *p, char *line, ch=
ar *eol,
  =09else if (p->pcre_regexp)
  =09=09hit =3D !pcrematch(p, line, eol, match, eflags);
  =09else
 -=09=09hit =3D !regmatch(&p->regexp, line, eol, match, eflags);
 +=09=09hit =3D !regexec_buf(&p->regexp, line, eol - line, 1, match,
 +=09=09=09=09   eflags);
 =20
  =09return hit;
  }

--=20
2.10.0.windows.1.10.g803177d

base-commit: f6727b0509ec3417a5183ba6e658143275a734f5
--8323329-965078724-1474482196=:129229--
