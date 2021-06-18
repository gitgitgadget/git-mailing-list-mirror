Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64B8C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB0961351
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 10:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhFRKxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhFRKxR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 06:53:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29C3C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 03:51:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id df12so5556883edb.2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qKbv+nApDMetyhHDI0Ibmgd8iEqeaFI9chJly+tz97A=;
        b=TOZok8E2Ruq3vBtHcjJLj/Ri+Iuw727LIG73eznA6ZGW6QZ8g61n+fTrTtkMzZVCDU
         0jVAoGN64ttF9uWd0Du9wS1o3qHAnaT0D7rEjCA1KqS2449FaBQjiwnqYhMr6CgQLihj
         GHyEZBV3cqFkGXUcvmSZ7xgAHyZcQieuPREeKwr/oMuAv0zmmpvtyMyGBAXQzJ0H2VEM
         qOXA22RLnlndcqtLNR1SV0W7uzTrMkORVJ4ZtRfcAkHZA3HCEwUrlt+KgMIRLUBAysax
         pDjIYGPgoZN8+ztBEGOxNfNTEOHmkh5MfdyKTXN6JcmcFP2SP/gTyx7m3S7vbUrVkSEE
         NbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qKbv+nApDMetyhHDI0Ibmgd8iEqeaFI9chJly+tz97A=;
        b=jlCPRoAF+nY/wf82mcB/fsyE382wV94hxUIEOZrWTmMOtIfhuQaoiEtLvZ2hVzfZ0z
         Hm7zTABegjSLi1q7SiLp0N/9TYy5Klx08Cj5D16r7xFkpaW2AnKFqXmiRO9OBQB/PHmh
         3WPwhIst0flHa9C6AIZC2t3Vw702wnvRzqnsv9TJ7XNAJTXOvlApB3IY4tp+iZgKM2JD
         rtinEO93hurDa8Fak+fk0O0VKF1WYIGwOYxtWTnGmPnpJHE+Zrj+a44/FZNl+C6KnMKQ
         77Xcv9GGimK725JaKxHvDaP+RlBlQfDaXm5eG4M0AlrjGyjapIOFrNyttxDWWAGwGE32
         +OEw==
X-Gm-Message-State: AOAM5338Upcjd9tGwOiJbiFIWpD94DCwjnWnvBCGh7Zk6tTspuKeoeg6
        1gkuTXSL//TXBXZXo+ZT5NEqO35mhZgbhQ==
X-Google-Smtp-Source: ABdhPJy9yV+hloUlYVwHIBGAnqDSxNStSudH6ZVrJyJFWoEVhCoLIVp0KNgHAt1ISRQGS7JjHY/fzw==
X-Received: by 2002:a05:6402:3458:: with SMTP id l24mr4089476edc.320.1624013465845;
        Fri, 18 Jun 2021 03:51:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q20sm920499ejb.71.2021.06.18.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 03:51:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] [GSOC] ref-filter: add %(raw) atom
Date:   Fri, 18 Jun 2021 12:49:02 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
 <875yydx8oo.fsf@evledraar.gmail.com>
 <CAOLTT8TMOs-FF+EcTZBbxfGnKQipe_nx_eZon=S=PWRTNT4CjA@mail.gmail.com>
 <87r1h0wnwg.fsf@evledraar.gmail.com>
 <CAOLTT8SGkObKWMZax-k4KXgsN+7ezvOMkRU-zt+c2zon2Ta3pA@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAOLTT8SGkObKWMZax-k4KXgsN+7ezvOMkRU-zt+c2zon2Ta3pA@mail.gmail.com>
Message-ID: <87r1gz4faf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 18 2021, ZheNing Hu wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:45=E5=
=86=99=E9=81=93=EF=BC=9A
>>
>>
>> On Thu, Jun 17 2021, ZheNing Hu wrote:
>>
>> >
>> > Yes, strbuf is a suitable choice when using <str,len> pair.
>> > But if replace v->s with strbuf, the possible changes will be larger.
>>
>> I for one would like to see it done that way, those changes are usually
>> easy to read. Also it seems a large part of 2/8 is extra new code
>> because we didn't do that, e.g. getting length differently if something
>> is a strbuf or not, passing char*/size_t pairs to new functions etc.
>>
>
> After some refactoring, I found that there are two problems:
> 1. There are a lot of codes like this in ref-filter to fill v->s:
>
> v->s =3D show_ref(...)
> v->s =3D copy_email(...)
>
> It is very difficult to modify here: We know that show_ref()
> or copy_email() will allocate a block of memory to v->s, but
> if v->s is a strbuf, what should we do? In copy_email(), we
> can pass the v->s to copy_email() and use strbuf_add()/strbuf_addstr()
> instead of xstrdup() and xmemdupz(). But show_ref() will call
> external functions like shorten_unambiguous_ref(), we don=E2=80=99t know
> whether it will return us NULL or a dynamically allocated memory.
> If continue to pass v->s to the inner function, it is not a feasible
> method. Or we can use strbuf_attach() + strlen(), I'm not sure
> this is a good method.
>
> 2. See:
>
> -       for (i =3D 0; i < used_atom_cnt; i++) {
> +       for (i =3D 0; i < used_atom_cnt; i++) {
>                 struct atom_value *v =3D &ref->value[i];
> -               if (v->s =3D=3D NULL && used_atom[i].source =3D=3D SOURCE=
_NONE)
> +               if (v->s.len =3D=3D 0 && used_atom[i].source =3D=3D SOURC=
E_NONE)
>                         return strbuf_addf_ret(err, -1, _("missing
> object %s for %s"),
>
> oid_to_hex(&ref->objectname), ref->refname);
>         }
>
> In the case of using strbuf, I don=E2=80=99t know how to distinguish betw=
een an empty
> strbuf and NULL. It can be easily distinguished by using c-style "const c=
har*".

Yes, sometimes it's just too much of a hassle, looking at
shorten_unambiguous_ref() which returns a xstrdup()'d value that could
indeed be strbuf_attach'd. I haven't tried the conversion myself,
perhaps it's too much hassle.

Just a suggestion from reading your patch in isolation.


>> >
>> > Not python safe. See [1].
>> > Regarding the perl language, I support Junio's point of view: it can be
>> > re-supported in the future.
>>
>> Ah, I'd missed that. Anyway, if it's easy it seems you discovered that
>> Perl deals with it correctly, so we could just have it support this.
>>
>
> Well, it's ok, support for perl will be put in a separate commit.
>
>> >>
>> >> > +test_expect_success 'basic atom: refs/tags/testtag *raw' '
>> >> > +     git cat-file commit refs/tags/testtag^{} >expected &&
>> >> > +     git for-each-ref --format=3D"%(*raw)" refs/tags/testtag >actu=
al &&
>> >> > +     sanitize_pgp <expected >expected.clean &&
>> >> > +     sanitize_pgp <actual >actual.clean &&
>> >> > +     echo "" >>expected.clean &&
>> >>
>> >> Just "echo" will do, ditto for the rest. Also odd to go back and forth
>> >> between populating expected.clean & actual.clean.
>> >>
>> >
>> > Are you saying that sanitize_pgp is not needed?
>>
>> No that instead of:
>>
>>     echo "" >x
>>
>> You can do:
>>
>>     echo >x
>>
>> And also that going back and forth between populating different files is
>> confusing, i.e. this:
>>
>>
>>     echo a >x
>>     echo c >y
>>     echo b >>x
>>
>> is better as:
>>
>>     echo a >x
>>     echo b >>x
>>     echo c >y
>>
>>
>
> Thanks, I get what you meant now.
>
>> >>
>> >> > +test_expect_success 'set up refs pointing to binary blob' '
>> >> > +     printf "a\0b\0c" >blob1 &&
>> >> > +     printf "a\0c\0b" >blob2 &&
>> >> > +     printf "\0a\0b\0c" >blob3 &&
>> >> > +     printf "abc" >blob4 &&
>> >> > +     printf "\0 \0 \0 " >blob5 &&
>> >> > +     printf "\0 \0a\0 " >blob6 &&
>> >> > +     printf "  " >blob7 &&
>> >> > +     >blob8 &&
>> >> > +     git hash-object blob1 -w | xargs git update-ref refs/myblobs/=
blob1 &&
>> >> > +     git hash-object blob2 -w | xargs git update-ref refs/myblobs/=
blob2 &&
>> >> > +     git hash-object blob3 -w | xargs git update-ref refs/myblobs/=
blob3 &&
>> >> > +     git hash-object blob4 -w | xargs git update-ref refs/myblobs/=
blob4 &&
>> >> > +     git hash-object blob5 -w | xargs git update-ref refs/myblobs/=
blob5 &&
>> >> > +     git hash-object blob6 -w | xargs git update-ref refs/myblobs/=
blob6 &&
>> >> > +     git hash-object blob7 -w | xargs git update-ref refs/myblobs/=
blob7 &&
>> >> > +     git hash-object blob8 -w | xargs git update-ref refs/myblobs/=
blob8
>> >>
>> >> Hrm, xargs just to avoid:
>> >>
>> >>     git update-ref ... $(git hash-object) ?
>> >>
>> >
>> > I didn=E2=80=99t think about it, just for convenience.
>>
>> *nod*, Junio had a good suggestion.
>>
>
> ok.
>
> Thanks.

