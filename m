Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C731C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 19:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbhLRTxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 14:53:31 -0500
Received: from mout.web.de ([212.227.17.12]:59415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbhLRTxa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 14:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639857196;
        bh=EHEfFCfyKmxuwsNwnTYa5/cs7Xs6AwKkj4WgNFYHlYk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=oiZyypM0Qx2uAU+5u1Xbe9/iyK94qSTA1KF01rapA6r2+7I+ixgD2T42l8DGUSyIa
         bModl/b5MSkRRkaDzx1dg95sodBSvkjpKQJC7wh5eFyvcClQs5fxAbUS4FhsgJGpbm
         PMXy7he31nFV3XPttejZh++DHr2EUT70KO3meOIo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP382-1n8bwW21E4-00PgHo; Sat, 18
 Dec 2021 20:53:16 +0100
Message-ID: <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de>
Date:   Sat, 18 Dec 2021 20:53:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: [PATCH 2/2] grep/pcre2: factor out literal variable
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
In-Reply-To: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P2EBysGYGyBYlbImQLSfa2LCDXEmAPnbu71K0Ez3EV7Pk/3SR+l
 W2BaT9wOLLh7P1trpAlAxqlMPlzM1MMnitNKVlP9/GuZB41Y0ITzgiwn/P0NtYvXDl2Xik5
 dLguD1d92RWapgwIQvy/Y9y8Z0bdLm0GpMGQVdT4rEiRItxRwBGlBR/PJd2BdlYUU1WlKxD
 JmPeIzjPH7OM2liMcCtdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TxHmAShtIeQ=:i2mz1HIQjCc6TwIgX62QbF
 Mp7+rFq0q+u1qqj35jV5a6byuaVuCnhhMwPHdZCDVwVYWJ0kZy/RAnm4DQI2wnDqTJ3ARxTlW
 AGruUePClXzRs17XlhFqGXrdAGnrH9ROXKnvFaq2WoRLiLPG9cdF8qm8WoAk1O4TEqjst3ALP
 iUl9u85tKg+J+7YKK4s3x2evEVus5Eai+x1gls0ltypQNO84Dr6xDsZjVRD4m+3fkL5WsFXC5
 4z9uq+61OGB1nl1Je0pg/WUch4o4LaL0wnEYFqB2zJFkNl0g4CxLP6zZHbpGtgYR7wROqu18C
 vsh5ESu/IanMeiowAWt0k+ghZS/hkiP0hNAUHJgclAIy6J+PCsbl016atQijuYWHUgB+ASnpn
 vE2OHjKPS7bi3G3ndMPLM5dA8r+HlX3Xe8EtWSeaz46fCG5QNuoe/YO4ZoRBlPh9EXWKEXSLo
 R5mCntFPClIP4jsN9Cytpes6xHgDLm7U7As2ERv3OisGPZf4XU3kuR9CAHhZMTzX7Xm2OOdXC
 KyJkfnKK3HtSF77Zh0F0wB1rYj7S7HDtSDnsfH3W2VVHxEPyWurNmcCCNncLTmumZqWur8s4M
 ZKaPHTKgxzvljKoJmUJs4cKgXsEesZ3f2bj0rYqEkjmK00NCoZ8t1BOchSvwpjErYSIzubCZa
 7RqnBXe+Ts1E3h83O8lCpj5R7n9/zGeCKDhXmTwA9PQg3TrMZEUyHnp9NuynplrT91kRdUG/T
 jeJs0lDO+4I205L81HjAPHIjwx3epdWkRnnzAboYanrB/EnH3ewO4v7ANjIjvtf+yM9p7/FQd
 JvdgXyLMHl5SYqKcgZfkv9dRLkiZbhmz+3+wAuNF0PuIauXMg5cvA/7XjuXV3F/rMB9/vr5iO
 exRs4izhkNAhOUAijKZbWJmN+FIS8xdqvdKalhTa8h0ZMYZrXKz/HRWluUceT/b0atyNcatDm
 eXDHUxz4N25SfiYSln9Wr/JxViAOh1GtMdQPJhqirXwLXozjtEEcFGsKPjxpjyw14xNZh2oFd
 8wdDmIbHVTIk3wrWLoErB+N5QInHttCZD5+vEb9jWcCKyC1YYHdvAK7ABhF/Qn9z5HNu+bRy7
 YeYnsv1VHo43xU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patterns that contain no wildcards and don't have to be case-folded are
literal.  Give this condition a name to increase the readability of the
boolean expression for enabling the option PCRE2_UTF.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 5badb6d851..2b6ac3205d 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -362,6 +362,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, =
const struct grep_opt *opt
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
+	int literal =3D !opt->ignore_case && (p->fixed || p->is_fixed);

 	/*
 	 * Call pcre2_general_context_create() before calling any
@@ -382,8 +383,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, =
const struct grep_opt *opt
 		}
 		options |=3D PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() &&
-	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
+	if (!opt->ignore_locale && is_utf8_locale() && !literal)
 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);

 #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
=2D-
2.34.0

