Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10397C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjHHUhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjHHUhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:37:34 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0972272B
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691525158; x=1692129958; i=l.s.r@web.de;
 bh=Qc3yQFitvmIU+sir8LNEnZ2AQD/eyLR8SUolxgE4ucw=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=HK2DupyAbSBPZeTtDtOk9YceqTngDXSxCoeWba1dpnaJrL9FrqQMoB9pC4XJuVaJMCob2th
 NUFx5a3JBgvNvgnB+swdvfZPRokK/i2o9MGMxwFxfYmQsb/u8j/Ni5xOzic3aHiVB/x0k5vSX
 1LYm4Q9GJaViAWN+xg6wr1p+y6sMSeibahL7zRXqvOoSXh8GdIzV6G1Bgtf5dbRBI6+LaR+vd
 KbdAL1efUvU90Z5fhTifWH9iYPalNazvHElA1P6WIme02rg0PqrGzTvDbaijc4ByVQFslTcGM
 Rk4jAXlj0p5Y4Ctms6+Mo09IfVqGbCtUChVVQSX1Fitrg9jTNFrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc8o-1prxQU1A1w-00gFfJ for
 <git@vger.kernel.org>; Tue, 08 Aug 2023 22:05:58 +0200
Message-ID: <c4cd1591-3a83-920a-6a80-19ffbfe3089d@web.de>
Date:   Tue, 8 Aug 2023 22:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] parse-options: disallow negating OPTION_SET_INT 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bVv0X6aZdFzThDt9FWYt8ftlIIkQwEbahSkZ0brq51FFEwzz3Vb
 yRmS2jIV7JnPzAJitnA7rTZ6bR0ekZhgsmEhp+fbPmkGV/TdkeWgMvdL7hNAr6r0jMld+eu
 YHMdytcOjrViBu5QMN2J7HXlxOpNe1DGEwE/KlNfpdSgsNb9ZBxT7vmcgkOtws1gG3a96f1
 sM6Ma0LsJblLZZdY+j1aw==
UI-OutboundReport: notjunk:1;M01:P0:MbvFR8Bumm0=;KpbEfKgll2wmyhRE/nXlSK0qNTo
 KD2oqIPf5Oo1jAh6ERsZsTJ3g4+4aNYPS+1TcC3e1I3LIYp9nflhuyuuMqvFq0eM9uD1O/UKZ
 QM+phiPL8pXY09ND65XBmbEkomRbjChPLg3hOx4lR5gxDruRw/qwp9MTJAhwEndJRHfxMiBEW
 bUl58/k0N8Db8KfQuSUWW5xEnF0EuLi1vJnNeizoHuhEXFuDMae750xn1EJSQkWGZ9Z196YnA
 NzB6tx+NtU2PHXAFZ0CRAWcVJBjSXsbQp3OVCowpvV+kyFubU/ALoZY4Zwat8FClzdgHrNGRm
 3oeyf4CQgrtMo/sDLaNVYGjVKTvvqHHYLWWqi/YROTga+JTDSSEpOCUnDdnOh5q/7ljthlSQY
 LOFh6cM4YZXwXnmz5h/2wED98QJIe66FT4b3CcaD7UMe/NCVfYPfYI6FPCIB4dw3ehOzY92Jh
 MFh1R5anSNVP+5zcL23HIRdqV9WTx++cMcIqub6SbqiFWHTcMOkF+csQKbG2KD9vm2rRcSS62
 xHvEELeElEcVkFmIJcZpMpEX39BdHA7h9zM/8lvY02mwRoCwZhwlOjKLkEfwjMKzAvpbwel9P
 a9aki4fS8cRjllLz90J1GWrrcWLoXT9BNBsMiFtd13tLE6lpX5d0YafZitJ7OiOexUkFMeIIL
 Aa+seh9fT7bitOp97eXkfATDVwPYXDDKo+fWMiGLQxM8hOL/lazeukjQ1h9SVPzx/+oPFU+TU
 HGdruv3gyqQb8oDYZIhaYhg2FGo4eH/R9MPs3iBmAVpHS3CrhWbB6OekLa3A0YJ5EJwyTYJJw
 0oiMwtbCx6qqFa2AA7791hRBBwKIm67/C1RKk350ySS/3UpX1UAzYYr7FVwacM7LQgCWY89gd
 0Ql92qD9QHxs0UV7+VOmx0CHLiy+D9NtPSmRhuC6G7MFuRqMqLbeVTPaj7F74BwSP4ekuJUVk
 OtGGRQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An option of type OPTION_SET_INT can be defined to set its variable to
zero.  It's negated variant will do the same, though, which is
confusing.  Several such options were fixed by disabling negation,
changing the value to set or using a different option type:

991c552916 (ls-tree: fix --no-full-name, 2023-07-18)
e12cb98e1e (branch: reject "--no-all" and "--no-remotes" early, 2023-07-18=
)
68cbb20e73 (show-branch: reject --[no-](topo|date)-order, 2023-07-19)
3821eb6c3d (reset: reject --no-(mixed|soft|hard|merge|keep) option, 2023-0=
7-19)
36f76d2a25 (pack-objects: fix --no-quiet, 2023-07-21)
3a5f308741 (pack-objects: fix --no-keep-true-parents, 2023-07-21)
c95ae3ff9c (describe: fix --no-exact-match, 2023-07-21)
d089a06421 (bundle: use OPT_PASSTHRU_ARGV, 2023-07-29)

Check for such options that allow negation in parse_options_check() and
report them to find future cases quicker.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 87c9fae634..60224cf8d0 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -480,6 +480,9 @@ static void parse_options_check(const struct option *o=
pts)
 		     opts->long_name))
 			optbug(opts, "uses feature "
 			       "not supported for dashless options");
+		if (opts->type =3D=3D OPTION_SET_INT && !opts->defval &&
+		    opts->long_name && !(opts->flags & PARSE_OPT_NONEG))
+			optbug(opts, "OPTION_SET_INT 0 should not be negatable");
 		switch (opts->type) {
 		case OPTION_COUNTUP:
 		case OPTION_BIT:
=2D-
2.41.0
