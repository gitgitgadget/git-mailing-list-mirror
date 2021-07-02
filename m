Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A9AC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8AA6141C
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhGBNFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhGBNFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:05:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB1C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:02:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hp26so3279765ejc.6
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BTwSVtZiuFtRTvdgLvGy5Y6YYC691hhvzY+mYdpStRQ=;
        b=DIQiew4SGcf8WPLopVr5DUTRD1FXRKHTSewO8SXPMSBb0WXQCNGmGqvjD8tsm4MbJe
         3hHzRSrCVC8CHg5AiaILSU9c9wvZeUovTN48slVXkWg3oVPCuP+WfMX+Gj/Gcjur0/I/
         IgWwQChv/eusi/gTCuXdK+9JZEmvVmS8b+kU8Q5wi9FiCYi3hIoE7qu0tQSGr0JQkHOd
         YBHF0JWvqvZPkB/CI3zzbOKifBQxvnhw66WPz+myaJ6zC07isg17fFhU0KidlLbsWu/j
         SWw+M/qVxgqBUoRUwyfBDy0xKXQySj/M20ZUraZYK9diB+YaK6Tl9xMOjX5oLLf54SMc
         z5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BTwSVtZiuFtRTvdgLvGy5Y6YYC691hhvzY+mYdpStRQ=;
        b=SjkAC1EhkzcbqQPSL0OMvVCG4yC88ysvbmRonrjqyGuYxBZ+8bh0svCfrDg72S4iTe
         bdrgzv7IylicF9wi94DXFa7hOpXpvJILXUf0kLHfZ9N5dDiWc2lDtRvLkYnl9AEJx7gc
         QnLTgQZ3gq4JUrGsQOdfJaAbvqdlKgdwijfMW+WlBqecD1sbLdpUd4luePzaM/eV9lpw
         UeBvFPKeblc2hWypHKUsF1Vlv4ga055EMM3QOAIGDh4c7pqCSEPvZ7EE5NiK9GSYeai1
         5Cqawefu3hcSLOV/0U+XbAypKWYXDmHTSP+UWkFbyixozdKjwiH2Pt3jG84Do8y+4Ew9
         2uQQ==
X-Gm-Message-State: AOAM531U72QuCdZLmOUx7VTRfVTccM3+bqzxoixLC5ypQAmN3EVlfs3X
        KDd6QGy44diqs0tjsEK23QMgBiNdo7undA==
X-Google-Smtp-Source: ABdhPJxz8iHIZNxRe4ER1Htkf3H+WRg13yVByk7xYo8Uq3RzLJYvzhgc2JE1sCZX2B372hrd4RIKZA==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr5111673ejb.542.1625230961129;
        Fri, 02 Jul 2021 06:02:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w17sm1015945ejk.112.2021.07.02.06.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:02:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] serve: add support for a "startup" git_config()
 callback
Date:   Fri, 02 Jul 2021 14:55:38 +0200
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
 <YN3wvy6fhD4V+FA3@coredump.intra.peff.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YN3wvy6fhD4V+FA3@coredump.intra.peff.net>
Message-ID: <87o8bkamxb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, Jeff King wrote:

> On Mon, Jun 28, 2021 at 09:19:24PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> So let's support this common pattern as a "startup_config" callback,
>> making use of our recently added "call_{advertise,command}()"
>> functions. This allows us to simplify e.g. the "ensure_config_read()"
>> function added in 59e1205d167 (ls-refs: report unborn targets of
>> symrefs, 2021-02-05).
>>=20
>> We could read all the config for all the protocol capabilities, but
>> let's do it one callback at a time in anticipation that some won't be
>> called at all, and that some might be more expensive than others in
>> the future.
>
> Sadly I don't think this addresses my "v2 receive-pack" concern. The
> ls_refs_startup_config() function will get called after we've received a
> request for "ls-refs", which is good. But:

I think it does in that you rightly objected to us moving all config to
such a callback, because for some of it we don't have the information
needed to look it up yet, we do that in the request handler.

But for a lot of our config it's fine to do it early, hence "startup"
config.

Yes I've moved the ls-refs handling into the "startup" because /right
now/ it's only handling fetches, it'll need to be moved out if and when
we start handling pushes.

But isn't it going to be obvious that we'll need to do that then? Since
we'll have the example of upload-pack.c doing that exact thing?

I.e. do you not want to have the "startup config" concept at all, or
would just prefer to have the ls-refs part of it pre-emotively moved out
of it in anticipation of handling pushes some day, even if we can do
that on "startup" now?

(More below)

>> +static void read_startup_config(struct protocol_capability *command)
>> +{
>> +	if (!command->startup_config)
>> +		return;
>> +	if (command->have_startup_config++)
>> +		return;
>> +	git_config(command->startup_config, NULL);
>> +}
>
> ...we don't pass any context to the config callback here. I thought
> passing "command" might work, but looking at the ls_refs() function, it
> is the one who actually reads the pkt-lines that will tell us "hey, I'm
> doing an ls-refs for a push".
>
> So none of the serve() infrastructure can help us there; we need to read
> pkt-lines and _then_ read config.
>
> I dunno. Maybe the solution is for ls_refs() to just do a separate
> config call to pick up the operation-specific bits, like:
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 88f6c3f60d..6ee70126aa 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -130,12 +130,13 @@ static void send_possibly_unborn_head(struct ls_ref=
s_data *data)
>=20=20
>  static int ls_refs_config(const char *var, const char *value, void *data)
>  {
> +	struct ls_refs_data *d =3D data;
>  	/*
>  	 * We only serve fetches over v2 for now, so respect only "uploadpack"
>  	 * config. This may need to eventually be expanded to "receive", but we
>  	 * don't yet know how that information will be passed to ls-refs.
>  	 */
> -	return parse_hide_refs_config(var, value, "uploadpack");
> +	return parse_hide_refs_config(var, value, d->for_push ? "receive" : "up=
loadpack");
>  }
>=20=20
>  int ls_refs(struct repository *r, struct strvec *keys,
> @@ -147,7 +148,6 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  	strvec_init(&data.prefixes);
>=20=20
>  	ensure_config_read();
> -	git_config(ls_refs_config, NULL);
>=20=20
>  	while (packet_reader_read(request) =3D=3D PACKET_READ_NORMAL) {
>  		const char *arg =3D request->line;
> @@ -161,8 +161,12 @@ int ls_refs(struct repository *r, struct strvec *key=
s,
>  			strvec_push(&data.prefixes, out);
>  		else if (!strcmp("unborn", arg))
>  			data.unborn =3D allow_unborn;
> +		else if (!strcmp("for-push", arg)) /* imagine this exists */
> +			data.for_push =3D 1;
>  	}
>=20=20
> +	git_config(ls_refs_config, &data);
> +
>  	if (request->status !=3D PACKET_READ_FLUSH)
>  		die(_("expected flush after ls-refs arguments"));
>=20=20
>
> And then it is a separate thing entirely from your "serve will read
> config" code. It's arguably more confusing, because now config is read
> in two places, but that is already true because of this
> ensure_config_read() thing.

This suggests to me you'd like to preemptively move it out of "startup",
correct?

Anyway, I can do that if that addresses your concern. I thought the v1
objection was mainly "the config flow won't work that way in all cases",
which you're right that I incorrectly assumed.

I just thought preemptively doing it for "ls-refs" wouldn't be needed,
since we'd notice in testing such a feature that "do it once" would
break in obvious ways for multi-requests, especially with the comment
for the "startup_config" callback explicitly calling out that case.

> The patch above obviously makes no sense until we're working on v2
> receive-pack. But I think it illustrates that your patch here is not
> getting in the way (though technically I think that would also be true
> of your v1, I do like this version better).
