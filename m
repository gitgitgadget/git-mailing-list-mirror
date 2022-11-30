Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDBC4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiK3SEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiK3SEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:04:20 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635827062A
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669831448; bh=ULKjAoU9yDQjzsXoPz2U6xbYLnHuFks+NR39y5wNP8Q=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=CWJjWlKgPPDlhZBgH8D6zOYPoT14i1aun5znETOb23W0wFj0ZSxBteqaNfv7SDqCC
         WFHN/hTbptcjGx5uw9sDQIMxfMWp9E5nWpbtD6+wED01HCwhaSEWKe3pArLAwa2K5n
         MsVy5TJRysyShMfzf+g9VEflSOCwdSyssUhXwvX3HiNoOsoH6lq8DqYj9LvcF8fA0G
         PMYuBZbJ/ms7c8MHjBJ0uZWOhJAWE8kp6/Pr0fPsozf6fnq6/fGOnoH4hxxKugPk5c
         S3O0gCDOykBO4iG1M4I70VVzCRK2blUBScWL69UMvZDDgZZpb3mqKWlagrnOti5O5A
         Lod9y9MR9VAOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7aP-1pRD8R3Akx-00UUtw; Wed, 30
 Nov 2022 19:04:08 +0100
Message-ID: <b5f611f5-86e2-6b11-20a4-a847c97b145f@web.de>
Date:   Wed, 30 Nov 2022 19:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH 2/3] diff: let prep_parse_options() return parseopt array
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
In-Reply-To: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OLHQ0ypof7sUGyAboeOGdNJfGnXJdgC9GasGPtT1DhOZuDpA/X+
 nRfn2kULna9I/ErnScV0IFz6qZyZvMJY0Jo0MsduFRONiyZyFt0/a1l+Wr1zJGxSdTdz7rl
 Hrx7QATnesctUKB8mcNcBRj5MQCG+4wAb5uyUb3WbarAwQGNIvfgAh91meYKRoqs4lrjIx3
 OyYTkzk9dkZDeXPM4hZNg==
UI-OutboundReport: notjunk:1;M01:P0:x5ewp7ErxyU=;XjteSdSwKn0+shy0AgDz40BP2I6
 CdlfYlDc8cXy8EDs/Fn4RHdsL6D13ag6um6Xim7X6h6HOsD7UTKOp8j0zYw60mSHtWyvgXCZE
 31oQRCUVX/XY0VIOHPAWi1doIznaykknz4Izt9TWtQ4mmkL2hYtjPUo8e4lnuoWt5Y/09PJnK
 yyniYXS4voQ1NCuBBcI+TQZEXxgIk7cduCcxOvt9LMFGpiDc1yBmJTJAITTI6RCjkLKSiSRMW
 fHQubNOhdgnDVXzAk6g/hQBQxqGYnWKxvVNn1bA08Y0HSnx22q7HWMrlXavxNp9S+s2GJEtLU
 mqnatiR8bGOPWbnE1RUx1UvqIwMr+Mxd0tGWONddImamVvX3axyCtU5Zh96n5GjuXWuChZiVs
 6Lq1nWhjkA7mxIKUdX/pHEXIjhKxP/g2L00uFbce/5OLJTgK6F63X+6WDZyQnkKsPmDPyoZu5
 t66VqKwc4P7dZceq9p+ZkMGtFI98iEcfio1bywM0cwuENS81UcLa0PRtUARm7FdvQdD1USbRm
 35PMGpkp5YLeVX6sfx57xMw5kZRpmlxCT8JZX35eoWvmY9Ql5UOdlRflqc84X64v8debscl+K
 eKM1gni3kSR69BiXThdFBnnTugh3R1GoywAulU1FO/j25y42bgAGmyyhQaIXHEGTogtcfUmyQ
 NaEJgx5DOadRzt8PmOuUOeWdvX5goi459q53yQKEtA4lkbFX0Icj6XgcFjVGJnIsjj8jGzK9n
 kR2jQt2xdDk4HK6LN0W+ioRPi3R4zuUivuiBEr0BerMWl91HW89icZfc3s+O+vn8YGZeC+CNK
 Lw8cXpxT6ExLkNDzUVDrwfQAgHfjiybVQwwCzF2DhCNR7j6vCHWE2r2QrZD0cTHJ9pC+wq812
 Pm2jzEDc5bKBOcuu1YekoGymqgIgZqzmd0X7tt1mYbOuvUUZ0yt6DcbwjLKIY2UYDe39f7atg
 6HYAwwzH6rk27xJ/Wx1GqwcyNyY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prep_parse_options() sets the parseopts member of struct diff_options.
Let it return the pointer instead and have its caller do the assignment
instead and rename the function to get_diff_parseopts() to reflect that
change.  This allows using it in other places and with other variables.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index e01129f0ea..e469d5d2a0 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4615,7 +4615,7 @@ static void run_checkdiff(struct diff_filepair *p, s=
truct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }

-static void prep_parse_options(struct diff_options *options);
+static struct option *get_diff_parseopts(struct diff_options *options);

 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
@@ -4663,7 +4663,7 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)
 	options->color_moved =3D diff_color_moved_default;
 	options->color_moved_ws_handling =3D diff_color_moved_ws_default;

-	prep_parse_options(options);
+	options->parseopts =3D get_diff_parseopts(options);
 }

 static const char diff_status_letters[] =3D {
@@ -5419,7 +5419,7 @@ static int diff_opt_rotate_to(const struct option *o=
pt, const char *arg, int uns
 	return 0;
 }

-static void prep_parse_options(struct diff_options *options)
+static struct option *get_diff_parseopts(struct diff_options *options)
 {
 	struct option parseopts[] =3D {
 		OPT_GROUP(N_("Diff output format options")),
@@ -5689,8 +5689,7 @@ static void prep_parse_options(struct diff_options *=
options)
 		OPT_END()
 	};

-	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
-	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+	return parse_options_dup(parseopts);
 }

 struct option *add_diff_options(const struct option *parseopts,
=2D-
2.38.1
