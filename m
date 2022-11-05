Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345EDC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 22:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKEWcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKEWcX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 18:32:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1D311A05
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 15:32:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so21489988ejb.13
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eD/AyKY85/AZ8ufO2zEwOIjzf7bKt5u2sn28Ngh5nKY=;
        b=pfjrHXY19KHw99SCK5fuDz3miR5qJx0sdKIZEDDHjMsf05IziHIfdwV1ExhZBaeBP6
         jV545TXqnyhVfBaGK7Z9NUSVLpv1S1B4Cmhh1PME3RFbM8z65UPql/tBJISyEXCPQ9L+
         j9iwhlBz0pjao0bRdRdi+f1fLV2Pf58l8GCA8YPR0JFo97eyQAxW0ODgxiP+zxAyflCh
         LSLi6MRmURYN7eru8oe/DJ4TIUhwTMJrvlYNdfowprXrfW2wvKHeHLSm5P7bAIsCgud6
         o6q19ghAyR3rofG2Y2zsY2iPIHtbQS7X0aBjQmyUx0IAEY65N1tn4EguhB8CwJXfRtCK
         tiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eD/AyKY85/AZ8ufO2zEwOIjzf7bKt5u2sn28Ngh5nKY=;
        b=kRhLsrP1/m1/tNAxh/3qLqjzh6QZvCCIv7VOEZaMbHcR5Ez8v2+w6l1MVz/r9ihzjp
         86F30HBpySfwGvkwPLB0UDSLo//E/OLlg6aThQjC/+lByr3yUJWZ5Smdf1Qltgh1dyuL
         03BzhL822fd2OA5zFwUE5cLNXOgN2SCjf9dz7qa0waFyoECvTAnlyJAtg4wfBVsrrKAH
         dfz2e05fRqx+WmAowXtTXwbkcoMbmGboyal6+WVn3yRGDNJgBxI9OD6yFuKtfnEk3ftA
         bxYarEvC9njs81GeLNimf7Cn4Woh4aLdx5pyCJGAFRBuPBtU1GcEynNgZifr+E7HeZoQ
         tV0w==
X-Gm-Message-State: ACrzQf1yOzQHlJoo0q1dMAUr56Hhzefa8DmB3G51LQEhw5pIJ9HH9EoO
        EKiUD7zmIHDZGW3izt+C5H4=
X-Google-Smtp-Source: AMsMyM4PBC0zan+tLwTODUOo0hTX3HEIhF+jeJDld9yDGLnX43KIfdXGfOoBf2enhQRShVBygccOmQ==
X-Received: by 2002:a17:907:80d:b0:73d:1e3f:3d83 with SMTP id wv13-20020a170907080d00b0073d1e3f3d83mr39367791ejb.372.1667687540727;
        Sat, 05 Nov 2022 15:32:20 -0700 (PDT)
Received: from gmgdl (31-151-3-230.dynamic.upc.nl. [31.151.3.230])
        by smtp.gmail.com with ESMTPSA id w6-20020a056402070600b0046191f5e946sm1754001edx.21.2022.11.05.15.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 15:32:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1orRi7-000SFU-1r;
        Sat, 05 Nov 2022 23:32:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict
 OPT_SUBCOMMAND() to one *_fn type
Date:   Sat, 05 Nov 2022 22:59:07 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
 <1b158749-44b1-34e0-5b52-1d3bfad9bc9a@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <1b158749-44b1-34e0-5b52-1d3bfad9bc9a@dunelm.org.uk>
Message-ID: <221105.86sfixvxqk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 05 2022, Phillip Wood wrote:

> On 05/11/2022 13:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, Nov 05 2022, Ren=C3=A9 Scharfe wrote:
>>=20
>>> Am 04.11.22 um 14:22 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>> diff --git a/parse-options.h b/parse-options.h
>>>> index b6ef86e0d15..61e3016c3fc 100644
>>>> --- a/parse-options.h
>>>> +++ b/parse-options.h
>>>> @@ -128,19 +128,24 @@ typedef int parse_opt_subcommand_fn(int argc, co=
nst char **argv,
>>>>    *			 the option takes optional argument.
>>>>    *
>>>>    * `callback`::
>>>> - *   pointer to the callback to use for OPTION_CALLBACK
>>>> + *   pointer to the callback to use for OPTION_CALLBACK and OPTION_SU=
BCOMMAND.
>>>>    *
>>>>    * `defval`::
>>>>    *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
>>>>    *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the val=
ue when met.
>>>> + *   OPTION_SUBCOMMAND stores the pointer the function selected for
>>>> + *   the subcommand.
>>>> + *
>>>>    *   CALLBACKS can use it like they want.
>>>>    *
>>>>    * `ll_callback`::
>>>>    *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
>>>>    *
>>>>    * `subcommand_fn`::
>>>> - *   pointer to a function to use for OPTION_SUBCOMMAND.
>>>> - *   It will be put in value when the subcommand is given on the comm=
and line.
>>>> + *   pointer to the callback used with OPT_SUBCOMMAND() and
>>>> + *   OPT_SUBCOMMAND_F(). Internally we store the same value in
>>>> + *   `defval`. This is only here to give the OPT_SUBCOMMAND{,_F}()
>>>> + *   common case type safety.
>>>>    */
>>>>   struct option {
>>>>   	enum parse_opt_type type;
>>>> @@ -217,12 +222,24 @@ struct option {
>>>>   #define OPT_ALIAS(s, l, source_long_name) \
>>>>   	{ OPTION_ALIAS, (s), (l), (source_long_name) }
>>>>
>>>> +static inline int parse_options_pick_subcommand_cb(const struct optio=
n *option,
>>>> +						   const char *arg UNUSED,
>>>> +						   int unset UNUSED)
>>>> +{
>>>> +	parse_opt_subcommand_fn *fn =3D (parse_opt_subcommand_fn *)option->d=
efval;
>>>> +	*(parse_opt_subcommand_fn **)option->value =3D fn;
>>>
>>> ->defval is of type intptr_t and ->value is a void pointer.  The result
>>> of converting a void pointer value to an intptr_t and back is a void
>>> pointer equal to the original pointer if I read 6.3.2.3 (Pointers,
>>> paragraphs 5 and 6) and 7.18.1.4 (Integer types capable of holding
>>> object pointers) in C99 correctly.
>>>
>>> 6.3.2.3 paragraph 8 says that casting between function pointers of
>>> different type is OK and you can get your original function pointer
>>> back and use it in a call if you convert it back to the right type.
>>>
>>> Casting between a function pointer and an object pointer is undefined,
>>> though.  They don't have to be of the same size, so a function pointer
>>> doesn't have to fit into an intptr_t.  I wouldn't be surprised if CHERI
>>> (https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/) was an actual
>>> example of that.
>> I should have called this out explicitly. I think you're right as
>> far as
>> what you're summarizing goes.
>> To elaborate on it, paragraph 8 of 6.3.2.3 says:
>> 	A pointer to a function of one type may be converted to a
>> 	pointer to a function of another type and back again; the result
>> 	shall compare equal to the original pointer. If a converted
>> 	pointer is used to call a function whose type is not compatible
>> 	with the pointed-to type, the behavior is undefined.
>> And 7.18.1.4 says, when discussing (among other things) "intptr_t"
>> ("[such" added for clarity:
>> 	[...]any valid [such] pointer to void can be converted to this
>> 	type, then converted back to pointer to void, and the result
>> 	will compare equal to the original pointer:
>> But as you point out that doesn't say anything about whether a
>> pointer
>> to a function is a "valid .. pointer to void".
>> I think that's an "unportable" extension covered in "J.5 Common
>> extensions", specifically "J.5.7 Function pointer casts":
>> 	A pointer to an object or to void may be cast to a pointer to
>> a
>> 	function, allowing data to be invoked as a function
>
> This is a common extension, it is _not_ guaranteed by the standard and
> so still undefined behavior unless your compiler happens to have=20
> implemented that extension.

>> Thus, since the standard already establishes that valid "void *" and
>> "intptr_t" pointers can be cast'd back & forth, the J.5.7 bridges the
>> gap between the two saying a function pointer can be converted to
>> either.
>
> How does J.5.7 bridge the gap when compilers are not required to
> implement it?

I'm saying it bridges the gap in that explanation, i.e. reinforces that
the main standard body isn't referring to function pointer casts to void
* and intptr_t.

>> Now, I may be missing something here, but I was under the impression
>> that "intptr_t" wasn't special in any way here, and that any casting of
>> a function pointer to either it or a "void *" was what was made portable
>> by "J.5.7"
>
> How is it made portable by an "unportable" extension?

I'm just repeating the terminology the standard uses: "The following
extensions are widely used in many systems, but are not portable to all
implementations".

>> So I think aside from other concerns this should be safe to use, as
>> real-world data backing that up we've had a intptr_t converted to a
>> function pointer since v2.35.0: 5cb28270a1f (pack-objects: lazily set up
>> "struct rev_info", don't leak, 2022-03-28).
>
> Saying "it works so it is fine" is not a convincing argument that it
> is compliant with the standard.=20

I was saying, among other things, that it's standardized by POSIX, so
it's in the same category as ssize_t, not some hypothetical "happens to
work" undefined behavior.

But we also make use of it already, so that gives us some real-world
data on potential issues.
