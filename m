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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE979C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 18:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E5620733
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 18:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YiBTpX/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBISgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 13:36:41 -0500
Received: from mout.web.de ([212.227.15.14]:60299 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbgBISgl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 13:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581273398;
        bh=lpu3vkeu80Blzk5xIGdZ5nWYJddfZo3jpdLf7+BDCDg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YiBTpX/8p6oY2oIZIDlr8EqzHCHf0fwk+sRoO1mtdVJ9MuqxvqCCSnT0DcXsJH+K9
         8v0mQQx3QR1lcJMHnnsUMyggrqY+lt4vFjEQgFFQnIu4c/7DPvBJCa9w/VwWrZ8Y4I
         qwGuSEBmDbHwDu+DzUrzDYnm2vvpCWD1CKywiomo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9ui8-1jBu3h3Lzc-00B73J; Sun, 09
 Feb 2020 19:36:37 +0100
Subject: Re: [PATCH 2/4] parse-options: factor out parse_options_count()
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de>
 <c729aaab-68d7-9cfa-8981-97eaa72a5ebe@web.de>
 <CAPig+cQpzc6eZyOo9N=4sR3pBFza299rRn_wP0w2W7Zf5CWThg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4577baea-0cc6-5fd9-a1c4-699b15dae380@web.de>
Date:   Sun, 9 Feb 2020 19:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQpzc6eZyOo9N=4sR3pBFza299rRn_wP0w2W7Zf5CWThg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3iw43YuqagYb98hTClkIdVAAvL6UBz7e5PtM+Hg41OV7v0IJWml
 m9OSQVFDjlvg2VwhveUQPQdI/qAKoJH421uDVnEx6YY7eELvAYdlZwGCj09FOFdSFZQXvKf
 3MX0DRl81xo39oCgBTzSOIc4bJy8RZ7GTJal4q/5WfgXOAl0tSrmBLOrQSQkpxSUDA77iSN
 GWseLmzFT/O6m4UhVV73g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLe1bkHnwDQ=:tLmI0Gn2KdLxUVm5zXFtVn
 tsDj6JniLSbDMiIxCOy2KoAtAyjrCYR5m+TyYuqawO2vDpSgSXptbU1G5Y7m4R6OZT2KoukBA
 lkIH7hfORHzGqtKx6zxrJtJaSUmY+cZyymGffLvZJ+8Zpboc0a18jimA/nlYfZgd5I4/ppGYe
 X6WeJo+xmiwgS50PgVol+m4SOz/YGD3tSj9PqZG/jC2vtXTxVj/h9g11Dai8sKpPk+ETBthIH
 OBRTvq6QP0A24SVVntjWnlbMyrFCNx3xdxeCF9i4inYFm5Br6aWfyWNIPNyKi8F+0w66FADmt
 OGDucgXc82MsgmJGB0mJ6e8xcBLbs8bmKpRUJRbG5XM3UOTaCetlRyJLUIChOm7SH0cb8DqNq
 ZRKGgH2gY90dZs2LiHQ/JYOyDl87KHmGli0hfRQLW06BLQidsAp25S3yyP7jSzBMLObQuqKif
 ICEH1umT1RDtchaYin3KBLk8F0z0mw7LEQByFs1Bxhr/y79eQrBt9/k5pX2Bspt5Yr6myJ16r
 IXVr0BhWtlLpjmlNPJQU3VgdUp3/E5nuZpJpcwzGGWbBtfPVhbIlirQ3oY4nbukwTDpKM0fIk
 amyqSchWOtdu2XADRuRi6OLktCzFXL+KCILtlHum6czh+BfxjBgKbFwDK+vuEdKkoILNEXP57
 3zKDCuPQn7bchgeNFRVFb2RExP7EnEwtIAsNJt8gOAK896VwTZQxPYVJIyPmcqTr2dMFLfFqK
 TXlLBWQKjR6+vBrvXNgLKoJ8I7jnr1/+dUUjuNV+lHt0lIOB2CQdQXKyzspaXJptsf1N9ldM6
 P0hlfastFeVrMwl5V7TrfgwzW8D8dkKmBwK7oXIRYuVh+Er/d4echZpbaBiyDVnkYP65s9zPQ
 b8bIk9OEEdJn93wXdwODy+nwsQFRIyroxb89TX/Di6LUSHY9dH+G6R+OVyKRTbX+VnEaRvpDj
 6fe9CDCQTYTX4lXifYMg6chkAaQR+/8YN8QM2oGXjTTVs8aHDjU2ybaEUvzXz1nJaBN0ocjqq
 NMZacHEyx/ugLMF+PrmXphMBvPN/wEp611danZNat/nIek/mux54KNyBkVlBCxVyeO4Q5DLBt
 +EqR4eiBoWgkgGuXHq/wqior+U5i357fLvHR2adyOPbkEFZElvi5keTJiMlNCPM+rllmA15XH
 3HM9y/sdjnQuyMYfKAVxfwrvG+LUzK/CupFfWU5bkesvJnlM5SrRpsjSAAHnR8asbz785GYyD
 3JslKmx2S5HB6oQQT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.02.20 um 18:56 schrieb Eric Sunshine:
> On Sun, Feb 9, 2020 at 10:56 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Add a helper function to count the number of options (excluding the
>> final OPT_END()) and use it to simplify parse_options_dup() and
>> parse_options_concat().
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/parse-options-cb.c b/parse-options-cb.c
>> @@ -159,16 +159,20 @@ int parse_opt_tertiary(const struct option *opt, =
const char *arg, int unset)
>>  struct option *parse_options_dup(const struct option *o)
>>  {
>>         const struct option *orig =3D o;
>>         struct option *opts;
>> -       int nr =3D 0;
>> -
>> -       while (o && o->type !=3D OPTION_END) {
>> -               nr++;
>> -               o++;
>> -       }
>> +       size_t nr =3D parse_options_count(o);
>>
>>         ALLOC_ARRAY(opts, nr + 1);
>>         COPY_ARRAY(opts, orig, nr);
>
> This could use a little more cleanup. After this change, 'o' is never
> again consulted or changed, and 'orig' points at the original value of
> 'o', which means 'o' and 'orig' have the same value now always.
> Therefore, the additional cleanup would be to drop the declaration and
> assignment of 'orig' and reference 'o' in COPY_ARRAY() rather than
> 'orig'.

True, but that would go beyond the purpose of this patch, which is to
extract a count function.  While it enables the cleanup you mentioned,
the latter should go into its own patch.  The last one in the series
takes care of it.

Ren=C3=A9
