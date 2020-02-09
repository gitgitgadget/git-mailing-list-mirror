Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B376C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A0B20715
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="loegrE+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBIP6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 10:58:46 -0500
Received: from mout.web.de ([212.227.15.4]:41321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgBIP6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 10:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581263922;
        bh=gVpJwl2EREnaPklYJGzt87BmVM5DZK/FdVv8qmL/Scw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=loegrE+aNR+AxM6FIn5eXcclCgTTxFjA8sznAkPZzCJE8Rhs20Wx5VFhp7GK2jF4+
         p6IglanzChDyJDktza6jsDO+w28WQ2L8RHvh+t1Xl0aqLiOclNLMpxAvv6BoOD524E
         20BH88/LhdFcsk40q5yefR3Ha15/aBdjg7SLfD7o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSIwN-1iv4lF2ypn-00TSSB; Sun, 09
 Feb 2020 16:58:42 +0100
Subject: [PATCH 4/4] parse-options: simplify parse_options_dup()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Message-ID: <162fb36a-6dd1-c178-9032-d3f4213930a6@web.de>
Date:   Sun, 9 Feb 2020 16:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BYT0sHuf9N7U3ue32XIVwt3rATgiEyTyHJNey2yPj4sdcJGEihj
 7lOUi8LORPocoei6DO5b33WAK0D5N+F1O8r1TWtBC9Jy3cw8jHMEQBEHn457QAvsNB7PtvR
 DGV2YeVW25v+NEOUIhoa8HHaqg0yj0my1gJqERDeHikf9ujt0/nYVyjslkX8mVR4cJXZ6gs
 oswGON6hUqCo1TsuYJ3Fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:77Ox6AoB1ek=:DDza2jmpZkCKajcuB+9FzY
 D+2Z/Q4gMt70tuc1qL55TO6emBJ9fB4srpflYOz47BpskYLySM5EawgCE/B1jVvExVPNwjH/t
 A93hiWgjT0S1tvdtPmFpCUaxxeSFCwxO6PUZD4GVSpr5ot8DNfMbm/R6EUkvMKLzm3Apss77I
 xj5oZShW6EXh5S/XlP6IbpAPnQnfsGZsmirwlSf8XWIujz5zCnsUXO+d4NqDmx/A4gDANe/0V
 PhcopM3v9lSK45j2k3eFyO3tjrDo/t8jxYd6+V7qjNMMvcoLypc9acP8rx86dY4/gpPBotjLr
 fop8326V6qwd+DeNvykNpsx6rJYhJ/hNVugyn7i3Ni7lC+rTPeXYoTQbvyIkJ6LinUdNZGXPN
 ReA75iwRn3yLx1IkG7D2fi6pA2Dv9kwKMFYxKsSJRzyTYGVvU9aybjatFWCylsBvYyA4ldDMB
 AUyxCniSAEA7KR9AaIa1MwNGz+MWm17OAm4PAKQdw5EY6eqgqK+XWydyLRAVPNLbTkdce1bch
 +jicJqRGLeVa8A0tTph4ELbovBh+JB3mLgE1K3+XwzfEIS1JAe4BbiA0nI7H1EUDTXLlTMX4c
 W3INieBWNd1UFxi5sh0jGkwdu0ORRvctkoIpYFbzOFJ0d4uaZKfmpoSJ56c8890jAS1eoJ55C
 Bw7/q9MVT1fSiEb7jYOOqDwEtH8V3ff2Tl5ritJPJBOzliWbVBawazq1hjMu2iz/nIXHFONrL
 jjU8EtBTjQo1twA6Qk43/6egpWTJUvQ7I8bCgs09S4Cd+q5yr2mGDeKVSxf5ed1vBPy+7uKA/
 7v8h24/TU4DfL6mxkPt3npqEo6ZZk/8sG5JSLGfXahAuYNWHFfTICHXvXnHYceUuicTZjdkcU
 Vd1K+7MKfOWcVO6ELVWClRiRvxFmDmQi5sqHPBdCuXdX5RFEFpWg4g25N+Z5Qwnt8r9PUbDpl
 J37Kl5oH5mipzP4lA86qYbiW0GIaVIyobtmxbvnEj8p7VIcnN7Hz1k9uoXKN6CiyS3oxwTGvx
 SBvzNt3AkTg/k5xZfGljsHX7WjK+nMnfv+eDaey65QKMPDC/SWIQj72sqQN71iZV42zEqANgH
 TPa5dG+D8Pmxml1g6erUPEyshdAZdDqkfMRsdxEyx2KTKKDPblZMF8PHTv8HNN5Gv+7OMXG0J
 TyNrBznIhdm1sC2YByyVhqpUO6AUlLu8oTuRk9CiERLpoB4vLS7C04U3jhTEx8uKxxVo3szO2
 EnqOrIk3locxrWH1h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify parse_options_dup() by making it a trivial wrapper of
parse_options_concat() by making use of the facts that the latter
duplicates its input as well and that appending an empty set is a no-op.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options-cb.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 7d56681130..a28b55be48 100644
=2D-- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -170,15 +170,9 @@ static size_t parse_options_count(const struct option=
 *opt)

 struct option *parse_options_dup(const struct option *o)
 {
-	const struct option *orig =3D o;
-	struct option *opts;
-	size_t nr =3D parse_options_count(o);
-
-	ALLOC_ARRAY(opts, nr + 1);
-	COPY_ARRAY(opts, orig, nr);
-	memset(opts + nr, 0, sizeof(*opts));
-	opts[nr].type =3D OPTION_END;
-	return opts;
+	struct option no_options[] =3D { OPT_END() };
+
+	return parse_options_concat(o, no_options);
 }

 struct option *parse_options_concat(const struct option *a,
=2D-
2.25.0
