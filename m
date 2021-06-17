Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86486C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61961613B9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFQOrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFQOrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:47:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F59C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:45:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t3so4370893edc.7
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xl6Hlr+cJ7NygvlgAcTK3UgAjuYS+t3XmrNbCJ2TUrc=;
        b=oWtBAgnF+OuuvCtTCnFKrYIJNuUV/OEwionNW5cyMRO5K/xtKfGX1a91TRCV72gama
         KJ7vN7BLYQ3VFruIztJtssqJdUmjFjmxoEK2PLp6s8W614w/4fH4lzgl+uM5pzBbl3uD
         KLDFXezuFcEezQMAU2NzMxQbD+WxHpI92ZrqU15Xyz2gd3JlO+YgmojDdYJraQihG1+b
         2T4N02gSYzLyKnyanzhCRsKne70+vqtUPLcCGEzLtXLRsHWkQiR3WW2fVSYKHJm8N3gX
         BYaVcVuhrA8P4zfeiemCy6ywcvri+ojkBLMexAIw5JNnLR6r/ARY4WCdMqvHQMu7LMFM
         1yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xl6Hlr+cJ7NygvlgAcTK3UgAjuYS+t3XmrNbCJ2TUrc=;
        b=X5kCaBTuI5coBSP5MQNPk5AyGwqy2DlqscZd84RA4MC/j3RXdLAYqyxXCLVsG7cKrv
         XCtANa0juMgmzIHjNu3AO4UAGg/hD0gFyaWney+cR2cXR37TSwXZq5LgvZV7JWzn3A29
         lxl8EkwkUlRxiMorhEtfoMFK7JI/Y+Y3EGkbmvX92Ps3uFzKfFMoW2T2dflgHIEWd7Ek
         sDQ/8nWelVeXKEq6h2XFv6ae3SUUkx7Ab02DsxCQWku/nfVyJSM338R6ZLKckLahqF71
         Gr3v62ovHqlORtteNSlulS+WrcPBDZyP83UuzbBi3g0fN/g98eL0/Wf+Dgx4xBSuBoM8
         858g==
X-Gm-Message-State: AOAM5321MENGRWU7BArTrH1AuWMB2OAG0zgTH8Lf4iUB3tif+QqB/gBA
        NHOAnuftWUy+J854714EHA6q4WUWVDVhww==
X-Google-Smtp-Source: ABdhPJznSxFvaofqCHyyha1nNM0HMQOk1n3zRg4gsQPO3Zv01K7Kn5vxxMg0KFCG9SgYakGILu9Arw==
X-Received: by 2002:aa7:d892:: with SMTP id u18mr7153207edq.196.1623941121181;
        Thu, 17 Jun 2021 07:45:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id t14sm1814748edr.36.2021.06.17.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:45:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] [GSOC] ref-filter: add %(raw) atom
Date:   Thu, 17 Jun 2021 16:37:34 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
 <875yydx8oo.fsf@evledraar.gmail.com>
 <CAOLTT8TMOs-FF+EcTZBbxfGnKQipe_nx_eZon=S=PWRTNT4CjA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAOLTT8TMOs-FF+EcTZBbxfGnKQipe_nx_eZon=S=PWRTNT4CjA@mail.gmail.com>
Message-ID: <87r1h0wnwg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, ZheNing Hu wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:16=E5=
=86=99=E9=81=93=EF=BC=9A
>>
>> > The raw data of blob, tree objects may contain '\0', but most of
>> > the logic in `ref-filter` depends on the output of the atom being
>> > text (specifically, no embedded NULs in it).
>> >
>> > E.g. `quote_formatting()` use `strbuf_addstr()` or `*._quote_buf()`
>> > add the data to the buffer. The raw data of a tree object is
>> > `100644 one\0...`, only the `100644 one` will be added to the buffer,
>> > which is incorrect.
>> >
>> > Therefore, add a new member in `struct atom_value`: `s_size`, which
>> > can record raw object size, it can help us add raw object data to
>> > the buffer or compare two buffers which contain raw object data.
>>
>> Most of the functions that deal with this already use a strbuf in some
>> way, before we had a const char *, now there's a size_t to go along with
>> it, why not simply use a strbuf in the struct for the data? You'll then
>> get the size and \0 handling for free, and any functions to deal with
>> conversion can stick to the strbuf API, there seems to be a lot of back
>> and forth now.
>>
>
> Yes, strbuf is a suitable choice when using <str,len> pair.
> But if replace v->s with strbuf, the possible changes will be larger.

I for one would like to see it done that way, those changes are usually
easy to read. Also it seems a large part of 2/8 is extra new code
because we didn't do that, e.g. getting length differently if something
is a strbuf or not, passing char*/size_t pairs to new functions etc.

>> > Beyond, `--format=3D%(raw)` cannot be used with `--python`, `--shell`,
>> > `--tcl`, `--perl` because if our binary raw data is passed to a variab=
le
>> > in the host language, the host language may not support arbitrary bina=
ry
>> > data in the variables of its string type.
>>
>> Perl at least deals with that just fine, and to the extent that it
>> doesn't any new problems here would have nothing to do with \0 being in
>> the data. Perl doesn't have a notion of "binary has \0 in it", it always
>> supports \0, it has a notion of "is it utf-8 or not?", so any encoding
>> problems wouldn't be new. I'd think that the same would be true of
>> Python, but I'm not sure.
>>
>
> Not python safe. See [1].
> Regarding the perl language, I support Junio's point of view: it can be
> re-supported in the future.

Ah, I'd missed that. Anyway, if it's easy it seems you discovered that
Perl deals with it correctly, so we could just have it support this.

>>
>> > +test_expect_success 'basic atom: refs/tags/testtag *raw' '
>> > +     git cat-file commit refs/tags/testtag^{} >expected &&
>> > +     git for-each-ref --format=3D"%(*raw)" refs/tags/testtag >actual =
&&
>> > +     sanitize_pgp <expected >expected.clean &&
>> > +     sanitize_pgp <actual >actual.clean &&
>> > +     echo "" >>expected.clean &&
>>
>> Just "echo" will do, ditto for the rest. Also odd to go back and forth
>> between populating expected.clean & actual.clean.
>>
>
> Are you saying that sanitize_pgp is not needed?

No that instead of:

    echo "" >x

You can do:

    echo >x

And also that going back and forth between populating different files is
confusing, i.e. this:


    echo a >x
    echo c >y
    echo b >>x

is better as:

    echo a >x
    echo b >>x
    echo c >y


>>
>> > +test_expect_success 'set up refs pointing to binary blob' '
>> > +     printf "a\0b\0c" >blob1 &&
>> > +     printf "a\0c\0b" >blob2 &&
>> > +     printf "\0a\0b\0c" >blob3 &&
>> > +     printf "abc" >blob4 &&
>> > +     printf "\0 \0 \0 " >blob5 &&
>> > +     printf "\0 \0a\0 " >blob6 &&
>> > +     printf "  " >blob7 &&
>> > +     >blob8 &&
>> > +     git hash-object blob1 -w | xargs git update-ref refs/myblobs/blo=
b1 &&
>> > +     git hash-object blob2 -w | xargs git update-ref refs/myblobs/blo=
b2 &&
>> > +     git hash-object blob3 -w | xargs git update-ref refs/myblobs/blo=
b3 &&
>> > +     git hash-object blob4 -w | xargs git update-ref refs/myblobs/blo=
b4 &&
>> > +     git hash-object blob5 -w | xargs git update-ref refs/myblobs/blo=
b5 &&
>> > +     git hash-object blob6 -w | xargs git update-ref refs/myblobs/blo=
b6 &&
>> > +     git hash-object blob7 -w | xargs git update-ref refs/myblobs/blo=
b7 &&
>> > +     git hash-object blob8 -w | xargs git update-ref refs/myblobs/blo=
b8
>>
>> Hrm, xargs just to avoid:
>>
>>     git update-ref ... $(git hash-object) ?
>>
>
> I didn=E2=80=99t think about it, just for convenience.

*nod*, Junio had a good suggestion.

>> > +test_expect_success '%(raw) with --python must failed' '
>> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --python
>> > +'
>> > +
>> > +test_expect_success '%(raw) with --tcl must failed' '
>> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --tcl
>> > +'
>> > +
>> > +test_expect_success '%(raw) with --perl must failed' '
>> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --perl
>> > +'
>> > +
>> > +test_expect_success '%(raw) with --shell must failed' '
>> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --shell
>> > +'
>> > +
>> > +test_expect_success '%(raw) with --shell and --sort=3Draw must failed=
' '
>> > +     test_must_fail git for-each-ref --format=3D"%(raw)" --sort=3Draw=
 --shell
>> > +'
>>
>> s/must failed/must fail/, but see question above about encoding in these
>> languages...
>
>
> [1]: https://lore.kernel.org/git/CAOLTT8QR_GRm4TYk0E_eazQ+unVQODc-3L+b4V5=
JUN5jtZR8uA@mail.gmail.com/
>
> Thanks for a review.

