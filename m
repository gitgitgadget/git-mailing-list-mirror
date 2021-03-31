Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBAC43600
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E40A6108B
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 18:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbhCaSbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhCaSb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 14:31:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50827C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 11:31:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so31478530ejo.13
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=29iZnl/zTaHIAFxAW9dlirv8pFIs9DQFY9u4BxzWdrM=;
        b=f+p+DtF8yInlzem2mvDhAa0+irJMzOPy1y68x8gR6ODFuIzKJNSPsgVc7ZIiFq+Fyo
         2MW6z/LaxBFkJLzhNWEkhJRj+WVIOppTDryXrg1pqXAzqKgwYl2w4KvG5MauXNboXZCF
         vA7GtbZCmJeGK7+2f4zj63FwiReQ1CDabFh458gR12v17P1nB4jJA2y9Cchj8gpd2ire
         azV/btUpbgKRGqarlr/UgiONhlgUvsUMcNMJ/8BprZX/ov1PnNUVIR8wBMt+EFKOTjYi
         1kQUBn3ezPV2dzvVqudlBathG/R4nQUbeBYYKHt4xHnwcplky3trBRHICxPRrkNf0m+i
         COdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=29iZnl/zTaHIAFxAW9dlirv8pFIs9DQFY9u4BxzWdrM=;
        b=iBSrGU3cemqODIKaV52pQz0eQDuqSrsakcrKWA0CHMMEaNG9vi8qHJzLOO2biNfA7N
         EOveiCdPRZN7zfxs+QaEd8Q5UMvaUiVLN7miLrDwB479aSICfBPGZwwwftuUxvuoDLM2
         U6gISadVUM3tBZyAzLeU4tByAA8EutN6aTqL3DiafA0Nr4vgQde7g+mieT9Mpzd1Eyrb
         cc2liJHxhJ4qHDRPdUQ+stsDwTWFbiLmvUrscsPSv/xhdlmVJMsDNe0MRlWbE25VtmO9
         pC1kx7Y4KaqB7XwoEK+6Du9SEaNV+4T5Kmbgu89rxDLpc8Pfsyun3ORnkQXsNmF4Fhbk
         sa/A==
X-Gm-Message-State: AOAM531lzUBsl2hSJ9VAAI3P5GDhWcUFTwXOMOhN4aFIIoJJTzn0LT+s
        SaJ0KE3KgbV54ZjB733MVxY=
X-Google-Smtp-Source: ABdhPJyAwy4Q/f40Ne8/DCD+Pv0KXuPBl7Q7yPUZ5/t4WqiMdc23kaApL5/gBwz5YxVmKvBoAO5QqQ==
X-Received: by 2002:a17:907:3d8a:: with SMTP id he10mr5047650ejc.184.1617215482948;
        Wed, 31 Mar 2021 11:31:22 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r17sm1621747ejz.109.2021.03.31.11.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 11:31:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
 <xmqq35wdfaw5.fsf@gitster.g> <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
Date:   Wed, 31 Mar 2021 20:31:16 +0200
Message-ID: <87k0pnkwej.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 31 2021, Jeff King wrote:

> On Mon, Mar 29, 2021 at 10:50:18PM -0700, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>=20
>> > Fix a regression in 89e4202f982 ([PATCH] Parse tags for absent
>> > objects, 2005-06-21) (yes, that ancient!) and correctly report an
>> > error on a tag like:
>> >
>> >     object <a tree hash>
>> >     type commit
>> >
>> > As:
>> >
>> >     error: object <a tree hash> is tree, not a commit
>> >
>> > Instead of our long-standing misbehavior of inverting the two, and
>> > reporting:
>> >
>> >     error: object <a tree hash> is commit, not a tree
>> >
>> > Which, as can be trivially seen with 'git cat-file -t <a tree hash>'
>> > is incorrect.
>>=20
>> Hmph, I've always thought it is just "supposed to be a" missing in
>> the sentence ;-)
>
> So going with the discussion elsewhere in the thread, I'd probably say
> something like:
>
>   error: object <oid> seen as both a commit and a tree
>
> which precisely says what we do know, without implying which is correct.
>
> =C3=86var's patch tries to improve the case where we might _know_ which is
> correct (because we're actually parsing the object contents), but of
> course it covers only a fraction of cases. I'm not really opposed to
> that per se, but I probably wouldn't bother myself.

What fraction of cases? As far as I can tell it covers all cases where
we get this error.

If there is a case like what you're describing I haven't found it.

I.e. it happens when we have an un-parsed "struct object" whose type is
inferred, and parse it to find out it's not what we expected.

It's not ambigious at all what the object actually is. It's just that
the previous code was leaking the *assumption* about the type at the
time of emitting the error, due to an apparent oversight with parsed
v.s. non-parsed.

Or in other words, we're leaking the implementation detail that we
pre-allocated an object struct of a given type in anticipation of
holding a parsed version of that object soon.

>   Side note: this is all making the assumption that what is in the
>   object itself is "correct", but of course that is not necessarily
>   true, even. All of these cases are the result of bugs, so it is
>   possible that the bug was in the writing of the original object
>   contents, and not the object that is referring to it. Likewise, I'd
>   imagine an easy way to get into this situation is with a bogus
>   refs/replace object that switches type.

Perhaps, I haven't tested that in any detail.

>> > Hence the non-intuitive solution of adding a
>> > lookup_{blob,commit,tag,tree}_type() function. It's to distinguish
>> > calls from parse_object_buffer() where we actually know the type, from
>> > a parse_tag_buffer() where we're just guessing about the type.
>>=20
>> I think it makes sense to allow the caller to express distinction
>> between "I know that this object is a blob, because I just read its
>> object header" and "Another object tells me that this object must be
>> a blob, because it is in a tree entry whose mode bits are 100644".
>>=20
>> I wish we found a set of names better than lookup_<type>_type() for
>> that, though.  It's just between
>>=20
>>       lookup_tag_type(r, oid, OBJ_NONE);
>>       lookup_tag_type(r, oid, OBJ_TAG);
>>=20
>> I cannot quite tell which one is which.  I also wonder if the last
>> arg should just be a boolean ("I know it is a tag" vs "I heard it
>> must be a tag").
>
> Yeah, I also found that very confusing. AFAICT lookup_tag_type() would
> only ever see OBJ_NONE or OBJ_TAG. Making it more than a boolean makes
> both the interface and implementation more complicated.

I don't feel strongly either way, but one concern here is that these are
very hot functions, and maybe it's better to give the compiler a better
chance to work with them without considering an extra argument, but I
haven't tested that...

> I also think the manual handling of OBJ_NONE in each lookup_* function
> is confusing. They all call object_as_type() because the point of that
> function is both to type-check the struct and to convert it away from
> OBJ_NONE.
>
> If we handled this error there, then I think it would be much more
> natural, because we'd have already covered the OBJ_NONE case, and
> because it's already the place we're emitting the existing error. E.g.:
>
> diff --git a/object.c b/object.c
> index 2c32691dc4..e6345541f7 100644
> --- a/object.c
> +++ b/object.c
> @@ -157,7 +157,7 @@ void *create_object(struct repository *r, const struc=
t object_id *oid, void *o)
>  	return obj;
>  }
>=20=20
> -void *object_as_type(struct object *obj, enum object_type type, int quie=
t)
> +void *object_as_type(struct object *obj, enum object_type type, unsigned=
 flags)
>  {
>  	if (obj->type =3D=3D type)
>  		return obj;
> @@ -169,10 +169,16 @@ void *object_as_type(struct object *obj, enum objec=
t_type type, int quiet)
>  		return obj;
>  	}
>  	else {
> -		if (!quiet)
> -			error(_("object %s is a %s, not a %s"),
> -			      oid_to_hex(&obj->oid),
> -			      type_name(obj->type), type_name(type));
> +		if (!(flags & OBJECT_AS_TYPE_QUIET)) {
> +			if (flags & OBJECT_AS_TYPE_EXPECT_PARSED)
> +				error(_("object %s is a %s, but was referred to as a %s"),
> +				      oid_to_hex(&obj->oid), type_name(obj->type),
> +				      type_name(type));
> +			else
> +				error(_("object %s referred to as both a %s and a %s"),
> +				      oid_to_hex(&obj->oid),
> +				      type_name(obj->type), type_name(type));
> +		}
>  		return NULL;
>  	}
>  }

Per the above I don't understand how you think there's any uncertainty
here.

If I'm right and there isn't then first of all I don't see how we could
emit 1/2 of those errors. The whole problem here is that we don't know
the type of the un-parsed object (and presumably don't want to eagerly
know, it would mean hitting the object store).

But when we do know why would we beat around the bush and say "was
referred to as X and Y" once we know what it is.=20

AFAICT there's no more reason to think that parse_object_buffer() will
be wrong about the type than "git cat-file -t" will be. They both use
the same underlying functions to get that information.
