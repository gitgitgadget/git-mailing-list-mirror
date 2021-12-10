Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46890C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 12:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbhLJMre (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhLJMre (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 07:47:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FBC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:43:58 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so29170299edd.13
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 04:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DUkFL8Dq/1KpVga1qLQcX1aoJZk/Jost37Oo8L6ex7o=;
        b=C9pfBfg4z/2aK6JIydIoe4re0XF282+j5IWv/yu9IHFoPyw9yPHtxSgrptoWDg726y
         ILXE8AZdlKrTUcBItqp8DDRRZezoTlaCitj/hctjGFavVmA+xMgH7HWQfVtve0d/yJBN
         qv+o6AbFP7kJLndPQiPb/Ivb1X97pwRIWikcL/HpRTpUjIpNEYndRNMuHjVvDuLVhu79
         UXR+rKUDsZm51E1GHqPwaEplxIzodzU9K65R2ifkQNm2h7vU6gGODhTrvbDyQatLwo10
         ak9l0ZShf+IMriPDtdih6xbW73ORGFpWtLgW7mHNc38Nd7oTR4KRcgbuE6lUPDkiPNlJ
         GxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DUkFL8Dq/1KpVga1qLQcX1aoJZk/Jost37Oo8L6ex7o=;
        b=xtptiRzVKM7Q4iLyhPr4l9xb6eH+LNWhdwATkdjf2mlcq3VoELQdsVVRXHycR5owl1
         rJTgsTDz9eYZEXFDOMAS5P2CytOlyUpropMu3lFvcLOd78OUIL3FPM94awkKSHdcnNt/
         740DlYbKopGbjP7KOZ4IQ8EU1nUqrdpfr125bYz9NqAe0QF2gWKpZ1yX4lLDZImMkKQy
         Q3SExgWcxvlcH66+q2+ddzXS150kcKQ9OsJispmKkSzolB1Clqx9uLd6MOqhG9vwrIeG
         rqfyRMgaQ32ax3j3inFjMCeYxXheNa1Wi/gxyfxB+ev+YJdXovLW1DWT/hatA+bP4pXx
         joZA==
X-Gm-Message-State: AOAM530UVFwfUyZNUNuqQFFp9Gr8C8lSu1prj09+NOFKrwnCvz/u8AQI
        XhVLUJiLdAKAY8ywtuhzLVg=
X-Google-Smtp-Source: ABdhPJwfMYLRtb5p4A7DIFAMCFRJ9rkMsVJEBMd/6sBoMFYQKB1zhC7YS7qtBdw5fHAr/KXgyUUoMQ==
X-Received: by 2002:a05:6402:1808:: with SMTP id g8mr38121246edy.248.1639140237213;
        Fri, 10 Dec 2021 04:43:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m22sm1341058eda.97.2021.12.10.04.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:43:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvfFj-000Kv6-TR;
        Fri, 10 Dec 2021 13:43:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Date:   Fri, 10 Dec 2021 13:31:10 +0100
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
 <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
 <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
 <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
Message-ID: <211210.86czm4d3zo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Jeff King wrote:

> On Fri, Dec 10, 2021 at 11:22:59AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > Dropping the st_mult() does nothing to fix the actual problem (which is
>> > that this function should use a more appropriate type), but introduces
>> > new failure modes.
>>=20
>> Yes you're entirely right. I had some stupid blinders on while writing
>> this. FWIW I think I was experimenting with some local macros and
>> conflated a testing of the overflow of n*n in gdb with the caste'd
>> version, which you rightly point out here won't have the overflow issue
>> at all. Sorry.
>
> I'm not sure if this is helpful or not, but this is the minimal fix I
> came up with that runs the testcase I showed earlier. It's basically
> just swapping out "int" for "ssize_t" for any variables we use to index
> the arrays (though note a few are themselves held in arrays, and we have
> to cross some function boundaries).
>
> I won't be surprised if it doesn't hit all cases, or if it even hits a
> few it doesn't need to (e.g., should "phase" be dragged along with "i"
> and "j" in the first hunk?). I mostly did guess-and-check on the
> test-case, fixing whatever segfaulted and then running again until it
> worked. I didn't even really read the code very carefully.
>
> I think you _did_ do more of that careful reading, and broke down the
> refactorings into separate patches in your series. Which is good. So I
> think what we'd want is to pick out those parts of your series that end
> up switching the variable type. My goal in sharing this here is just to
> show that the end result of the fix can (and IMHO should) be around this
> same order of magnitude.
>
> [...]
>  void compute_assignment(int column_count, int row_count, int *cost,
> -			int *column2row, int *row2column);
> +			ssize_t *column2row, ssize_t *row2column);
>=20=20
>  /* The maximal cost in the cost matrix (to prevent integer overflows). */
>  #define COST_MAX (1<<16)
> diff --git a/range-diff.c b/range-diff.c
> index cac89a2f4f..f1e1e27bf9 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -308,9 +308,10 @@ static int diffsize(const char *a, const char *b)
>  static void get_correspondences(struct string_list *a, struct string_lis=
t *b,
>  				int creation_factor)
>  {
> -	int n =3D a->nr + b->nr;
> -	int *cost, c, *a2b, *b2a;
> -	int i, j;
> +	size_t n =3D a->nr + b->nr;
> +	int *cost, c;
> +	ssize_t *a2b, *b2a;
> +	size_t i, j;
>=20=20
>  	ALLOC_ARRAY(cost, st_mult(n, n));
>  	ALLOC_ARRAY(a2b, n);

I think I was just chasing butterflies making this intmax_t at all. I
just submitted a v2, and explained that case in a bit more detail in
https://lore.kernel.org/git/RFC-cover-v2-0.5-00000000000-20211210T122901Z-a=
varab@gmail.com

I *think* it fixes all the cases we plausible run into, i.e. storing the
"cost" in an "int" was enough, we just needed a size_t as an offset. It
passes the regression test you noted[3].

The first thing I tried when hacking on this some months ago (I picked
these patches up again after running into the segfault again) was this
s/int/ssize_t/ change.

I don't think using ssize_t like that is portable, and that we'd need
something like intmax_t if we needed this in another context.

Firstly it's not standard C, it's just in POSIX, intmax_t is standard C
as of C99, which and we have in-tree code that already depends on it
(and uintmax_t).

But more importantly it's not "as big as size_t, just signed" in
POSIX. size_t is "no greater than the width of type long"[1] and
LONG_MAX is at least 2^31-1 [2].

Whereas ssize_t is not a "signed size_t", but a type that stores
-1..SSIZE_MAX, and SSIZE_MAX has a minimum value of 2^15-1. I.e. I think
on that basis some implemenations would make it the same as a "short
int" under the hood.

On my linux system it's just mapped to the longest available signed
integer, but that doesn't seem to be a portable assumption.

1. https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_types.h.ht=
ml
2. https://pubs.opengroup.org/onlinepubs/009696899/basedefs/limits.h.html

3. B.t.w. a thing I ended up ejecting out of this was that I made a
   "test_commit_bulkier" which is N times faster than "test_commit_bulk",
   it just makes the same commit N times with the printf-repeating feature
   and feeds it to fast-import, but the test took so long in any case that
   I couldn't find a plausible way to get it in-tree).

