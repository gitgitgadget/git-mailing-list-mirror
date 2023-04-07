Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215DC761A6
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 02:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbjDGCl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 22:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDGCl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 22:41:28 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165E83C0
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 19:41:26 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w133so30385200oib.1
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 19:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680835286;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOXLmhzLnFws+xbxMjEVBPxe19URqUEZRCdiflR3T5c=;
        b=UzUxbj/mgh9UwLffcCL1CxTY7wcAEznSlB7pem6JZVAFyB4z9kD+56gVpnmR5ig8Uj
         nogbTKs+f4c7W3TSCGxGKb42EW31xTxzXpWPVADWItb7CxK+JF7w7rRsKGd6RFDhJzR1
         op94XviHZCifNfCjZtRNVXeBOWa7WpQOLtwJ5ScRov/Dk4qBQ2uh/l5H4g/IvCT3ogim
         zFT+lrQhS4De/M6Sf33IIBDzCdB4LbUIiF8E3SLBmXRCiCKpL79o6ZBfgVMffDm3aja1
         X1mpUSQWfuCg0DAc6Xp5HupCBBcEIZpVRDe0YQPNMLsDG5MRuOzw6/yxt/tFS51OuDQA
         2CsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835286;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vOXLmhzLnFws+xbxMjEVBPxe19URqUEZRCdiflR3T5c=;
        b=TsMAk93Oun6+xgGGVXvEbi4QImfJTXPWJQNY5gSAxDyyMTzyur0Kls63qz+8HgTe7o
         Ru4jn57Orwo02IJFyzolqcIzFBmXXcQnT/c7tRTU64kB+9QczIf9I9SK/baryeiDF8/5
         z5H4qRkut1xRTIYwgEVStDpidLQZ/L/iZzwogIa1yCQbHtH9gort4sltDCKEx9MHQj6G
         OWq0WOZYuL36GLNRT0RGXcg8TdOEc+59efRID3qy/x3oFIw+IkNt+o++ugsKi1vY5FaP
         IRXSFInSunScnaUUsgBXW/uPKscmLG5JMqUY5kGoS+3Fz2oqbyieitm2MjkuVGfY3/a6
         sTmA==
X-Gm-Message-State: AAQBX9dxPn5eeclLiK7RCEfqFh9Vxx34laG0nZf1fbntacg6Je7OkLZW
        lTvmcAiRiU7kmV9cJ7haC6M=
X-Google-Smtp-Source: AKy350a8cn8Yu3MIgXLraISOwZK41w96fUN7RyDf+6l8iZxzTW/Sk8RLWIOVKZ0YmrluIsKs13wB2w==
X-Received: by 2002:a05:6808:1a25:b0:384:28d6:b99c with SMTP id bk37-20020a0568081a2500b0038428d6b99cmr510706oib.7.1680835285618;
        Thu, 06 Apr 2023 19:41:25 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e3-20020a05680809a300b00389509965e3sm1292434oig.58.2023.04.06.19.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:41:25 -0700 (PDT)
Date:   Thu, 06 Apr 2023 20:41:24 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?RGFuaWVsIE1hcnTDrQ==?= <mvdan@mvdan.cc>
Message-ID: <642f82d4153e5_9afe29469@chronos.notmuch>
In-Reply-To: <230406.867cupv3n1.gmgdl@evledraar.gmail.com>
References: <20230405012742.2452208-1-felipe.contreras@gmail.com>
 <20230405012742.2452208-2-felipe.contreras@gmail.com>
 <230405.86fs9evfte.gmgdl@evledraar.gmail.com>
 <CAMP44s0oBKfp6bXbg_+vp4CuRj_nh8uDBTCeT65z7UCUzj4K0Q@mail.gmail.com>
 <230406.867cupv3n1.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 1/2] Add fetch.updateHead option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Apr 05 2023, Felipe Contreras wrote:
> > On Wed, Apr 5, 2023 at 4:28=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason <avarab@gmail.com> wrote:
> >> On Tue, Apr 04 2023, Felipe Contreras wrote:

> >> > +
> >> > +     if (!ref || !target) {
> >> > +             warning(_("could not update remote head"));
> >> > +             return;
> >> > +     }
> >> > +
> >> > +     r =3D resolve_ref_unsafe(ref, 0, NULL, &flags);
> >> > +
> >> > +     if (r) {
> >> > +             if (config =3D=3D FETCH_UPDATE_HEAD_MISSING) {
> >> > +                     if (flags & REF_ISSYMREF)
> >> > +                             /* already present */
> >> > +                             return;
> >> > +             } else if (config =3D=3D FETCH_UPDATE_HEAD_ALWAYS) {=

> >> > +                     if (!strcmp(r, target))
> >> > +                             /* already up-to-date */
> >> > +                             return;
> >>
> >> I think you should name the "enum" you're adding below, the one that=

> >> contains the new "FETCH_UPDATE_HEAD_DEFAULT".
> >>
> >> Then this could be a "switch", and the compiler could check the
> >> arguments, i.e. you could pass an enum type instead of an "int".
> >
> > Sure, it can be an `enum fetch_update_mode` instead of `int`, but I
> > don't see what value it provides, other than more verbosity. The enum=

> > right above is also unnamed, and 'remote->origin' is an int. And it's=

> > not the only enum of that kind in the source code.
> >
> > Using a switch is better, but that doesn't require an enum type. The
> > multiple ifs are just a remnant of a previous version of the code.
> =

> More on this below, but it's for self-documentation (makes the code
> easier to follow),

I guess it *can* make the code easier to follow for some people, but only=
 very
marginally, and certainly not for me.

> and the compiler can notice missing "case" arms,
> which isn't the case with an "int".

Yes, but that has never been useful in my experience.

> > But I seem to recall previous discussions (perhaps in LKML) where
> > people accepted that lines 120-characters long are OK. We don't live
> > in the 80's anymore, terminals have more than 80 columns.
> =

> I don't know what the kernel does, but we try to conform to our
> CodingGuidelines, which sets a limit of 80.

There's a difference between claiming we try to conform to X, and actuall=
y
trying to conform to X. I think the evidence above shows it's not the lat=
ter.

That is: the guideline says something which isn't actually true. Or at le=
ast:
if we are trying, we are not trying very hard.

> But whatever else we do, we don't generally say that a newly added
> function to a given file should be exempted from the preferred coding
> style because the file isn't consistently using it.

A guideline is not a law.

If the guideline says "try to do X", and a patch doesn't do X, that's not=
 a
valid reason to reject it. It is not a prescriptive command, it has no "s=
hall"
or "must". It's merely a suggestion.

And as I showed above, a suggestion that is clearly not followed to the t=
ee in
all the code base.

> >> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> >> > index dc44da9c79..dbeb2928ae 100755
> >> > --- a/t/t5510-fetch.sh
> >> > +++ b/t/t5510-fetch.sh
> >> > @@ -814,6 +814,37 @@ test_expect_success 'fetch from multiple conf=
igured URLs in single remote' '
> >> >       git fetch multipleurls
> >> >  '
> >> >
> >> > +test_cmp_symbolic_ref () {
> >> > +     git symbolic-ref "$1" >actual &&
> >> > +     echo "$2" >expected &&
> >> > +     test_cmp expected actual
> >> > +}
> >>
> >> Sort of an aside, but this seems to be the Nth use of this pattern i=
n
> >> the test suite, e.g. t1401-symbolic-ref.sh repeatedly hardcodes the
> >> same.
> >>
> >> I wonder if a prep commit to stick this in test-lib-functions.sh wou=
ld
> >> be in order, or maybe a "--symbolic" argument to "test_cmp_rev"?
> >
> > Sure. If I had incline that such a patch would be merged (or this one=
)
> > I would do it, but I have a plethora of cleanup patches just gatherin=
g
> > dust, so I'd rather not.
> =

> Fair enough, thanks.
> =

> Re the "more below" above, I tried hacking some of what I suggested
> upthread on top of your patches, here's the result of
> that. Changes/commentary:
> =

>  * Switched the "int" to "enum"

For the record: I still don't see any value in doing that.

But I also don't see any harm, so I'm OK with that change.

>  * You've prepared the parse_update_head() to accept a NULL "r", but as=

>    this & your other code shows, we never pass it NULL. I don't get why=

>    we'd have it handle that case, as surely all plausible users are
>    "populate this config variable for me", no?

Yeah, I don't see any value in checking that, it probably was already the=
re
from the original function I copied the code.

>  * I think better than a BUG() call in the new update_head() we should
>    just drop "need_update_head" entirely. It ends up just being a
>    variable that states "is missing or always", so for update_head() we=

>    can just pass a boolean "missing?".

Actually, `need_update_head` doesn't equal "is missing or always": it mos=
tly
tracks the fact that we sent "HEAD" as part of the refspecs sent to the r=
emote.

For example if you do `git fetch`, that sets `need_update_head`, but if y=
ou do
`git fetch master` it does not (AFAIK).

So your change is not equivalent, and it would call update_head() unneces=
sarily
in many instances where there is no "HEAD" coming back from the remote, s=
o
`struct ref *head` is NULL. That's not a big issue, since the function wi=
ll
simply return in those cases.

But...

According to Jeff King, there are some instances where "HEAD" is coming b=
ack
from the server, even if we didn't request it, in those cases we would wa=
nt the
local "remote/foo/HEAD" to be updated as well (if configured).

So your change is not functionally equivalent: it's actually better. The =
reason
I didn't implement the logic Jeff King suggested is that I didn't see a w=
ay to
do it without complicating the code, but your suggestion is the way.

>  * I renamed "update_head" to "fetch_update_head" just to have the
>    compiler catch cases where we were using the old "int", but if you
>    find some of this useful we could keep the old name.

I do find a lot of this useful (bar the switch to an enum), but I think t=
he old
name is better, since it's a configuration that affects commands other th=
an
`git fetch`, for example `git remote update`.

> Hope some of that helps.
> =

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 6bf147b0123..6492e88d779 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -59,7 +59,7 @@ static int fetch_prune_tags_config =3D -1; /* unspeci=
fied */
>  static int prune_tags =3D -1; /* unspecified */
>  #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
>  =

> -static int fetch_update_head =3D FETCH_UPDATE_HEAD_DEFAULT;
> +static enum fetch_update_head fetch_update_head =3D FETCH_UPDATE_HEAD_=
DEFAULT;
>  =

>  static int all, append, dry_run, force, keep, multiple, update_head_ok=
;
>  static int write_fetch_head =3D 1;
> @@ -1584,7 +1584,8 @@ static int backfill_tags(struct transport *transp=
ort,
>  	return retcode;
>  }
>  =

> -static void update_head(int config, const struct ref *head, const stru=
ct remote *remote)
> +static void update_head(int fetch_missing, const struct ref *head,
> +			struct remote *remote)

This is good, it simplifies the logic below.

>  {
>  	char *ref, *target;
>  	const char *r;
> @@ -1594,7 +1595,7 @@ static void update_head(int config, const struct =
ref *head, const struct remote
>  		return;
>  =

>  	if (!remote->mirror) {
> -		ref =3D apply_refspecs((struct refspec *)&remote->fetch, "refs/heads=
/HEAD");
> +		ref =3D apply_refspecs(&remote->fetch, "refs/heads/HEAD");
>  		target =3D apply_refspecs((struct refspec *)&remote->fetch, head->sy=
mref);

Small nit: you didn't drop this casting.

>  =

>  		if (!ref || !target) {
> @@ -1609,17 +1610,14 @@ static void update_head(int config, const struc=
t ref *head, const struct remote
>  	r =3D resolve_ref_unsafe(ref, 0, NULL, &flags);
>  =

>  	if (r) {
> -		if (config =3D=3D FETCH_UPDATE_HEAD_MISSING) {
> +		if (fetch_missing) {
>  			if (flags & REF_ISSYMREF)
>  				/* already present */
>  				return;
> -		} else if (config =3D=3D FETCH_UPDATE_HEAD_ALWAYS) {
> -			if (!strcmp(r, target))
> -				/* already up-to-date */
> -				return;
> -		} else
> -			/* should never happen */
> +		} else if (!strcmp(r, target)) {
> +			/* already up-to-date */
>  			return;
> +		}

I prefer to have the main logic (always) on top, but otherwise good.

>  	}
>  =

>  	if (!create_symref(ref, target, "remote update head")) {
> @@ -1643,7 +1641,7 @@ static int do_fetch(struct transport *transport,
>  	int must_list_refs =3D 1;
>  	struct fetch_head fetch_head =3D { 0 };
>  	struct strbuf err =3D STRBUF_INIT;
> -	int need_update_head =3D 0, update_head_config =3D 0;
> +	enum fetch_update_head update_head_config =3D FETCH_UPDATE_HEAD_DEFAU=
LT;
>  =

>  	if (tags =3D=3D TAGS_DEFAULT) {
>  		if (transport->remote->fetch_tags =3D=3D 2)
> @@ -1680,15 +1678,19 @@ static int do_fetch(struct transport *transport=
,
>  =

>  		if (transport->remote->fetch.nr) {
>  =

> -			if (transport->remote->update_head)
> -				update_head_config =3D transport->remote->update_head;
> +			if (transport->remote->fetch_update_head !=3D FETCH_UPDATE_HEAD_DEF=
AULT)

In Git codestyle implicit tends to be preferred over explicit (as is in t=
he Linux codesyle)

 * `if (p)` over `if (p !=3D NULL)`
 * `if (i)` over `if (i !=3D 0)`
 * `if (!strcmp(...)` over `if (strcmp(...) =3D=3D 0`

And so on, so I think this strongly suggests this is preferred:

  if (transport->remote->update_head)

Over

  if (transport->remote->fetch_update_head !=3D FETCH_UPDATE_HEAD_DEFAULT=
)

> +				update_head_config =3D transport->remote->fetch_update_head;
>  			else
>  				update_head_config =3D fetch_update_head;
>  =

> -			need_update_head =3D update_head_config && update_head_config !=3D =
FETCH_UPDATE_HEAD_NEVER;
> -
> -			if (need_update_head)
> +			switch (update_head_config) {
> +			case FETCH_UPDATE_HEAD_MISSING:
> +			case FETCH_UPDATE_HEAD_ALWAYS:
>  				strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
> +			case FETCH_UPDATE_HEAD_DEFAULT:
> +			case FETCH_UPDATE_HEAD_NEVER:

I would rather have "default:" here to catch all the rest.

I suppose this could be clearer to some people (although IMO overly verbo=
se),
but this has nothing to do with the enum change, as it can be done with `=
int
update_head_config`.

> +				break;
> +			}
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
>  		}
> @@ -1801,8 +1803,16 @@ static int do_fetch(struct transport *transport,=

>  =

>  	commit_fetch_head(&fetch_head);
>  =

> -	if (need_update_head)
> -		update_head(update_head_config, find_ref_by_name(remote_refs, "HEAD"=
), transport->remote);
> +	switch (update_head_config) {
> +	case FETCH_UPDATE_HEAD_MISSING:
> +	case FETCH_UPDATE_HEAD_ALWAYS:
> +		update_head(update_head_config =3D=3D FETCH_UPDATE_HEAD_MISSING,
> +			    find_ref_by_name(remote_refs, "HEAD"),
> +			    transport->remote);
> +	case FETCH_UPDATE_HEAD_DEFAULT:
> +	case FETCH_UPDATE_HEAD_NEVER:
> +		break;
> +	}

Ditto. Although this isn't functionally equivalent, it's actually better.=


---

I've integrated the important parts of these changes into v2 and sent tha=
t.

I still don't see an incline of this patch ever being merged, so it's pro=
bably
just an exercise, but for the record there it is.

Cheers.

-- =

Felipe Contreras=
