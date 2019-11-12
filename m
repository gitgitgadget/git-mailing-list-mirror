Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7715C1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 21:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLVlk (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 16:41:40 -0500
Received: from mout.web.de ([212.227.17.12]:55571 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfKLVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 16:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573594895;
        bh=ZLWl640KDSPyCRAi2GhMEZrlsOgu2deFWvr9DBLrd6o=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=O2LEgUE6oNTUXcGa5V9BdsdBKGKH+naLZaY1UaVph4nLtg9zR+T6y261nxHaJEuIn
         3GDxmFdeTfWebP7aMiTzITD4KvggYUfMuM1unJ7RH3eboNUeIIZCOSh63W2gG/YylK
         GrZ/c3Du2IWDMD4Rpd1ASdDeAVPbtWaOyRqb6aWE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrU4-1iUdup0G7E-000558; Tue, 12
 Nov 2019 22:41:35 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: parse-options: avoid arithmetic on pointer that's potentially NULL
Message-ID: <39a0b622-f725-9284-ea50-19cf4078209d@web.de>
Date:   Tue, 12 Nov 2019 22:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q3m5Ce68SX3Tedgf436CaPqnlZKOu6+755lJEMFMHpnQf8wkpJY
 ydua8DuirRuuUHAMOn+4WedssW2LWs96N4VRPisbuU5YrAeWBgbEJPM4g3cyhX8voDRRtfz
 EIXgrjTmBvJuMJXhXDtLrsfYQ8jx0WdecCM4FXMWsAUXTxewevQRgOPq/kgR6kumxvDKO1M
 RY92QF3ekeXpGZ58O0IYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IteZuPLwW3o=:HaQeTdunRl/3dfaBbJDqT5
 qfllj7giFoWQEw4UxSnkS2oW/J+fgxqgwGPH5Ep4pn4zQktWa+XoEyfY7Se4GfzYzKBYWzRaW
 iHkqhsFXbvQZaKL6S751+bmhqeKHET01ZASuQzjKTi2E8+IRiJ21EH9C2wSDYkVPSwec5oD30
 V0PJyFV6mk2k1IsRHLKp6n4Zzahn4BC1GGs3WzX21TyuCoOWnyxFT/fcO5pcU0Y9fgZUVF28e
 N6QKuPwwcooF4UjxJ5c+wsF1td3GONXCotW75Liar6UpsfLx9M0JVwK9q2iyRaJqqYTBBbcsG
 Xv3qnxcrIvKFzjf5jfu0Dtv0hKYbMO+kC7Az5v1usYIOZIX+GM3vAuWPpsCtcjPxt1+5by5M7
 L3Vl+ESzMgnJLqhrUKFH5cQ0O//YVYTC5X6QIGNMzu4BvclT1zWHwpLGS0H5W7cI1rojFZMkO
 ycygQjvE/0BNm01+8/26VVpcpX8cv43gCiYaPCsE0e59ZlDFvPRVThATlOtRXo90WpaMI41if
 9qXvH9io//RWjElLjzeyw3hyvo3/Dd8OP2y6+AiTnyh2Gd6ucAKyA+1INPNNTxs45SL35+nM/
 fSduvqbvF/x9BYoePZhXvpyhWFsH7pSjKJJGJJ0eOW0CIkU95XCMhQmRRWkXec68Bt6Gzf/xu
 A6N4F2s6G6S+Kak5RD/7eB9Tvqi8PlDXIAUtR4wetCTQtDP2j8yIZyw0nq2P38J4y6TBfGLOW
 rmKh5fJ2hx05brEBHc7a8cq8DNwqxX0/sns7nvtzC2P4cbm3MYfQF5/MgY5/MIwdaiUY4DFm1
 xfZMkqwLz5F5KEwCCeqZZbF4LLtNQGX2gpRzjmbipnef/95O570DXn2pkNo06cyxCflGWW5oP
 MzD+1F+hulkGXKNipvFqiZTwyO7meoMignVh8kUkMWKEV0TDqbhVlPtdKRVum7iuruccVPsoZ
 6v99BsuUtMi43WyA4HvR1UWU4d+C+oM4IopUXA1etAPQpS6ht6Sh/5vhNmY6HF8UaY7NIRSPm
 V4PyeSbe1KP1MgeewoRVe1MZLVn62FTVyxEkK3bm3kJeMy4VmyCeHOwwS9bxfbLDVsJ3/Elih
 agzQEwil2iijIawczHJLaB/8OiA74IUrgSw/p9VV8MQ9etY0ituezQxWHf3VdBdzvIGBJIrKb
 r/uwmTU+dtbHFPEu61APDlh8+ftJL/XPCGhVY8QbVXT1CKaxyTQs/3GxXpzMcPA86mVr1wGgi
 O0F8ek1J4yz7QhGQqesCqXzWoODYfRIK4jGC6gA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_options_dup() counts the number of elements in the given array
without the end marker, allocates enough memory to hold all of them plus
an end marker, then copies them and terminates the new array.  The
counting part is done by advancing a pointer through the array, and the
original pointer is reconstructed using pointer subtraction before the
copy operation.

The function is also prepared to handle a NULL pointer passed to it.
None of its callers do that currently, but this feature was used by
46e91b663b ("checkout: split part of it to new command 'restore'",
2019-04-25); it seems worth keeping.

It ends up doing arithmetic on that NULL pointer, though, which is
undefined in standard C, when it tries to calculate "NULL - 0".  Better
avoid doing that by remembering the originally given pointer value.

There is another issue, though.  memcpy(3) does not support NULL
pointers, even for empty arrays.  Use COPY_ARRAY instead, which does
support such empty arrays.  Its call is also shorter and safer by
inferring the element type automatically.

Coccinelle and contrib/coccinelle/array.cocci did not propose to use
COPY_ARRAY because of the pointer subtraction and because the source is
const -- the semantic patch cautiously only considers pointers and array
references of the same type.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with --function-context for easier review.

 parse-options-cb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 1240a8514e..c2062ae742 100644
=2D-- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -161,17 +161,18 @@ int parse_opt_tertiary(const struct option *opt, con=
st char *arg, int unset)

 struct option *parse_options_dup(const struct option *o)
 {
+	const struct option *orig =3D o;
 	struct option *opts;
 	int nr =3D 0;

 	while (o && o->type !=3D OPTION_END) {
 		nr++;
 		o++;
 	}

 	ALLOC_ARRAY(opts, nr + 1);
-	memcpy(opts, o - nr, sizeof(*o) * nr);
+	COPY_ARRAY(opts, orig, nr);
 	memset(opts + nr, 0, sizeof(*opts));
 	opts[nr].type =3D OPTION_END;
 	return opts;
 }
=2D-
2.24.0
