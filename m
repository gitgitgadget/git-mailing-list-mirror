Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14270C47092
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F8F60FF2
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFBLB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFBLBN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:01:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19412C0613CE
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 03:59:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e18so3201662eje.5
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fRWKbhTpokZjVqZcRhgLdQgvel9SgYa3e3NsP6CBwv4=;
        b=EXhpVUB+3kNyAF0spQ8f+bUXaa4Htvd7wdyQPpcVZ78JhzVzz7Xgc18rOMR2ZmJc7c
         5iHUP3yxz+n1ZR7CdBgjqm37kxa+cEGiabqmWZr2K/vL8AeIV9Ai71LyPWsTwUey3A4z
         EQaOjYxqQVlT5xMwi+VJKEatufieiH2U8mIukAHDj+99ft3jXsOggcQOkuoHBcXjH56t
         Jy3DAfk4A/d/YnAc/PFcLiqt+pT4ow9c/ggIhFblDi4ECwMEAzJ3KUXtWRT1VIx1Z72S
         xItq+9/I7tiZjOzzTzMXK5HSlnvCO6QuKOZSuMXSHjVf0Z0lYp2K5RfGbEOuDm3YHSP2
         waMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fRWKbhTpokZjVqZcRhgLdQgvel9SgYa3e3NsP6CBwv4=;
        b=GidavqGXzxCuO7t/4niOr15S1TnTOe2DG124jmQCHc3cpt71I81J1224nR++7Ccj26
         pFnF4FXSSYsUSfScbw7EQIoFoGdu8o+klAUpbRFag0QifRn4kXNjaydPLY7VGgHYJO3f
         aoHBKiHbd+GkxQrafAm85zxSJtN7vLmcMf8UzFFNj2pXwEcsR6VhsHSVi5t9gOlS2mSf
         UiC8zBSKA/ll4oKnV9tTComOvWIFN61WO4GGzidsBdBb3jtE7O9+yB+VDQfibl71Zb5T
         yobLpY3YH2BI7LJP3NXzhYGZe+o3UfXzIskB8tWyANXRTwYwftI3ZWkPPJEEwYjxhMUX
         bRAA==
X-Gm-Message-State: AOAM530oCqxa8D0kSal7yBncjzz1jv7J13f1Kwb4Nyyh+TABDKFbWp5m
        dAbpWI7dmXsWifofWKSWeDA=
X-Google-Smtp-Source: ABdhPJwz4Zru4cuz9miHFddd/HutfLjYqu5iaqSBsnGnEtsPe6epfhBYU77iXcYsC7GRkxdzDU4PnA==
X-Received: by 2002:a17:906:6bd8:: with SMTP id t24mr27053621ejs.501.1622631560598;
        Wed, 02 Jun 2021 03:59:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u4sm8407611eje.81.2021.06.02.03.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:59:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Date:   Wed, 02 Jun 2021 12:50:53 +0200
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com> <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLbgi0jQn8BJ1ue2@danh.dev>
Message-ID: <87pmx47cs9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2021-05-31 16:01:01+0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>>=20
>> On Thu, May 27 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> > On Wed, May 26 2021, Matheus Tavares wrote:
>> >
>> >> t2080 makes a few copies of a test repository and later performs a
>> >> branch switch on each one of the copies to verify that parallel check=
out
>> >> and sequential checkout produce the same results. However, the
>> >> repository is copied with `cp -R` which, on some systems, defaults to
>> >> following symlinks on the directory hierarchy and copying their target
>> >> files instead of copying the symlinks themselves. AIX is one example =
of
>> >> system where this happens. Because the symlinks are not preserved, the
>> >> copied repositories have paths that do not match what is in the index,
>> >> causing git to abort the checkout operation that we want to test. This
>> >> makes the test fail on these systems.
>> >>
>> >> Fix this by copying the repository with the POSIX flag '-P', which
>> >> forces cp to copy the symlinks instead of following them. Note that we
>> >> already use this flag for other cp invocations in our test suite (see
>> >> t7001). With this change, t2080 now passes on AIX.
>> >>
>> >> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> >> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> >> ---
>> >>  t/t2080-parallel-checkout-basics.sh | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-c=
heckout-basics.sh
>> >> index 7087818550..3e0f8c675f 100755
>> >> --- a/t/t2080-parallel-checkout-basics.sh
>> >> +++ b/t/t2080-parallel-checkout-basics.sh
>> >> @@ -114,7 +114,7 @@ do
>> >>=20=20
>> >>  	test_expect_success "$mode checkout" '
>> >>  		repo=3Dvarious_$mode &&
>> >> -		cp -R various $repo &&
>> >> +		cp -R -P various $repo &&
>> >>=20=20
>> >>  		# The just copied files have more recent timestamps than their
>> >>  		# associated index entries. So refresh the cached timestamps
>> >
>> > Thanks for the quick fix, I can confirm that this makes the test pass =
on
>> > AIX 7.2.
>>=20
>> There's still a failure[1] in t2082-parallel-checkout-attributes.sh
>> though, which is new in 2.32.0-rc*. The difference is in an unexpected
>> BOM:
>>=20=20=20=20=20
>>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash=
\ directory.t2082-parallel-checkout-attributes/encoding/A.internal=20
>>     efbbbf74657874
>>     avar@gcc119:[/scratch/avar/git/t]perl -nle 'print unpack "H*"' trash=
\ directory.t2082-parallel-checkout-attributes/encoding/utf8-text=20=20
>>     74657874
>>=20
>> I.e. the A.internal starts with 0xefbbbf. The 2nd test of t0028*.sh also
>> fails similarly[2], so perhaps it's some old/iconv/whatever issue not
>> per-se related to any change of yours.
>
> The 0xefbbbf looks interesting, it's BOM for utf-8.
>
>> I tried compiling with both NO_ICONV=3DY and ICONV_OMITS_BOM=3DY, both h=
ave
>> the same failure.
>
> I didn't check the code-path for NO_ICONV=3DY but ICONV_OMITS_BOM=3DY only
> affects output of converting *to* utf-16 and utf-32.
>
> So, I think AIX iconv implementation automatically add BOM to utf-8?
>
> Perhap we need to call skip_utf8_bom somewhere?

I debugged this a bit more, it's probably *also* an issue in our use of
libiconv, but it goes wrong just with our test setup with
iconv(1). I.e. on my boring linux box:
=20=20=20=20
    echo x | iconv -f UTF-8 -t UTF-16 | perl -0777 -MData::Dumper -ne 'my @=
a =3D map { sprintf "0x%x", $_ } unpack "C*"; print Dumper \@a'
    $VAR1 =3D [
              '0xff',
              '0xfe',
              '0x78',
              '0x0',
              '0xa',
              '0x0'
            ];


On the AIX box to get the same I need to do that as:

    (printf '\376\377'; echo x | iconv -f UTF-8 -t UTF-16LE) | [...]

I.e. we omit the BOM *and* AIX's idea of our UTF-16 is little-endian
UTF-16, a plain UTF-16 gives you the big-endian version. To make things
worse the same is true of UTF-32, except "iconv -l" lists no UTF-32LE
version. So it seems we can't get the same result at all for that one.

So from the outset the code added around 79444c92943 (utf8: handle
systems that don't write BOM for UTF-16, 2019-02-12) needs to be more
careful (although this looked broken before), i.e. we should test exact
known-good bytes and see if UTF-16 is really what we think it is,
etc. This is likely broken on any big-endian non-GNUish iconv
implementation.
