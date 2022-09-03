Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F99ECAAD4
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 05:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiICFjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiICFjk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 01:39:40 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086C91B7BB
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 22:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662183574;
        bh=4Uig4r45GIp09ued0mtOlJCZDqd4y3iCuk6ixYMqbRk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=K7h+5cwNKbQvdCqRsHrqzCFSxpv4sTWWQSQzoTVI9lKXo8F+BvJ7b6SlBgDSTrY//
         sLNInjzjbEN/bG04couAI2kEU5jyV7ii7e+rYCtPfps9Ig9LD93IymM8gqPIrvrCHT
         8imQ7uInGXV4kg0p45/cgesJFdfQ1hHrtns4I6AQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Ez3-1oXvJb2sY9-003WyV; Sat, 03
 Sep 2022 07:39:34 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 1/2] diff.c: When appropriate, use utf8_strwidth(), part1
Date:   Sat,  3 Sep 2022 07:39:31 +0200
Message-Id: <20220903053931.15611-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:je6geN4/IXfZB447OaSRaL2wnp1l2UxmEoNKTT4z3xsx9aWkEFa
 U3ppj+9wC3cB0CeoikGq8Zz6QnhuNsEhN3W9BmpMvoiad5ZU4HdS9UbgfHVz/cZ57tQa+Pu
 YgPTMX1lSctKXfCoudkyLynLyFXoJS0KxQdzNuFEVxvT/nqTA0sLU8hi+1bNSDVeWuLUpvz
 /kr7olyP9t9MOM2oHTESw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aIUdwmRkl2g=:bAa+52ChI9FvWmrXGV0Kxo
 PGRGpH4QtXcjPQeHABZYusRXa8e3VdS1CTWGpvS2qV8ALECrOxBgqdjtHGDubVmIl07boIGpm
 D/k4azBuvHyiW7622+bVfbW2AblEaNnDUXjtMyDcmb8V0Ucuyl2QOan46vpppDor/6NzFIZgF
 ZUsvJDHaZ0TG8/Umyl+fnJTdcwdD/9RU+DOEqEmsBsu5jMP1D09PuC5l1SlkGJVrT4/stW40P
 1PcwuGndOKi5+8JuRUfYa13AUeV92KTghKGcnoM2v0+VDM5S+EhExLL7dTh38pJA97p3xjXut
 GN1BWKqCA0/OVNGEWDgm4n9RKEEVd16EDQ0fg56GOn5vwVNwMTKmUTGXj6FQrfB4tjo91T1LD
 8c2t2dR9x4k86eQnWr2Beb+8fmB32PmbHfev50HkG+NEmZ6LZsjXyywki/27L9ulukc60Hwgs
 sOrk5kQXV2B7jjO7Ua5HWmuGpBkDNGPL0zPt3cuOt4uYQJKQBfWf1iyCdLsMvFXH4FfAljTex
 J+bnoa7g/F4ntcZ5DT5vgtyaNXVekI79Q+nPZAdGhPFEqs+IWoB73GJjejbrssnSvsXI8ilNY
 Q87FpVNV6EYtEf53XficgWPXYmZMUPCC5TM263mwF0LvTd1cDa0H1TutHhIEHA3iux+x/fyfD
 lGrz57pOYi/o+OU7Ucusrsek5tFjBNyGjivDA9wZ1Kq5lmYjqFt3M7B9GA+XMDaVtmrK+aZyp
 B6AaPdNOpuT3GbFpqM0NWh8VXJ7SXI/LA5P4YeqYBtsCZRhbXueFU3wBLZEeizIw9aAW2Tddb
 QIXxQpEIPYHA4nu2+NZvVHBgZM0y90dTu6OH+pvBjpIkMBq1MyEL5R8lYVt+DFvkdtueJes++
 nyiM8nDfKx4EAGIyBa+dYLMQOJzrvDnMc2y6wbBnFsA/KKaFsVJ3xjPG7VsrcnhzZZxKxu1RF
 5pBPkKmyj994TBEON/O1Tt1x+ABoQ8V8Jr88gLZcYox6TbhpreWwyGj8k42ixmjtAX9JbPc5D
 67kcLS4hOb2Kuxm0D1oiPSOxzU8bYLIN6SJoOZzKZ4vRTW13LWxVceaBsoTTXqy5rfhjA/Ria
 fKsHO4qEaCgtboeDlFGLMStdYljLdlddHSxHU4JAspKuUyAt9YITFjHdecceYkL/0oWaQJfVU
 /X3oo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

When unicode filenames (encoded in UTF-8) are used, the visible width
on the screen is not the same as strlen(filename).

For example, `git log --stat` may produce an output like this:

[snip the header]

 Arger.txt  | 1 +
 =C3=84rger.txt | 1 +
 2 files changed, 2 insertions(+)

A side note: the original report was about cyrillic filenames.
After some investigations it turned out that
a) This is not a problem with "ambiguous characters" in unicode
b) The same problem exists for all unicode code points (so we
  can use Latin based Umlauts for demonstrations below)

The '=C3=84' takes the same space on the screen as the 'A'.
But needs one more byte in memory, so the the `git log --stat` output
for "Arger.txt" (!) gets mis-aligned:
The maximum length is derived from "=C3=84rger.txt", 10 bytes in memory,
9 positions on the screen. That is why "Arger.txt" gets one extra ' '
for aligment, it needs 9 bytes in memory.
If there was a file "=C3=96", it would be correctly aligned by chance,
but "=C3=96h=C3=B6" would not.

The solution is of course, to use utf8_strwidth() instead of strlen()
when dealing with the width on screen.

Side note 1:
Needed changes for this fix are split into 2 commits:
This commit only changes strlen() into utf8_strwidth() in diff.c:
The next commit will add tests and further needed changes.

Side note 2:
Junio C Hamano suspects that there is probably more work to be done,
in a separate commit:
Code in diff.c::pprint_rename() that "abbreviates" overly long pathnames
and "transforms" renames lines like
"a/b/c -> a/B/c" into the shorter
"a/{b->B}/c" form, and IIRC this is all byte based.

Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a621..b5df464de5 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2620,7 +2620,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 			continue;
 		}
 		fill_print_name(file);
-		len =3D strlen(file->print_name);
+		len =3D utf8_strwidth(file->print_name);
 		if (max_len < len)
 			max_len =3D len;

@@ -2743,7 +2743,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		 * "scale" the filename
 		 */
 		len =3D name_width;
-		name_len =3D strlen(name);
+		name_len =3D utf8_strwidth(name);
 		if (name_width < name_len) {
 			char *slash;
 			prefix =3D "...";
=2D-
2.34.0

