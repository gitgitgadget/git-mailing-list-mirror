Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E1C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiKDNpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiKDNpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:45:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE072614
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:45:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so5457253wmb.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HZGJGyLwYN9OCcW5zQPmheND/8IdKoj6H/jnGQiw5BU=;
        b=n6GDpYPvjndZoD8fpouIN+gOJqi4qUXzjDeaQCfqfwqBQzb3P3TgxFkfuZcoF+Nhst
         KmikWUVF94tfes30Gy5VENhNpodihG/lzpuumywRWLYKo498PslymKxY9OrsWWenrdsr
         z+SatdXF2jpe8NlCidKiR8qXJE93x2QKaYccQRJfnyp4gB3qBnL4bY8Uvx40mi9Zmujq
         uzTICtdtC7dKSJ9rQXwI3Z762AIHcAxuMOSTo/GbQP55sg9LaLfhvvnQ6l4zwR2uvcWl
         v/PW7hRXTi+H/xkwwnU9aBzcOz3Nv/jfbH6S9IAAiIf2i2VgzTHYB2PXbbJmZV+GjPLC
         LUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZGJGyLwYN9OCcW5zQPmheND/8IdKoj6H/jnGQiw5BU=;
        b=GSgePVa7lTk5aEmL2UqDU0grfJuG1M9GCmDQvKzaBP3p/LHkVBD6+PnkBDJdxeB9Vp
         SJzl8dIGP0U87DnVwpp3RhaXMAN7QGNg1gEEVZkDkGAWTEajhR4QBxP6zFeetjkNJNT1
         ETJ3IEowYXKvgpBGLZn/h7a1hkhXex+iPDp2Fyia+Mk7LrKPNJyrUcgCh08c0ocG34vb
         QdE5/Luws1WQBgHX35K2vzjK4ithOZXBw2qwswhWFpS4c51xLXo7q1U+Zl4vzlwuaTlS
         5LDgQV2/L6+oEP5YDp2ObAfLONVCh3FW4cw6cxaiZyIxaEgfXaj9e4BywhoBguyFUmVB
         i7AQ==
X-Gm-Message-State: ACrzQf12kwieJwxx5dsURGqyMgprQhVHKzEeuNhlpM7X9wjTKrb9r6jP
        5utLmp0uoTHxRR+IjgDRGXc=
X-Google-Smtp-Source: AMsMyM7AOrMWxq+cz4fuaQfDRCcTsjehwePuZgtYB65dKPNY27TURvdtGkANeHmYFbr8dftPsfpcSw==
X-Received: by 2002:a05:600c:2143:b0:3cf:63dc:d011 with SMTP id v3-20020a05600c214300b003cf63dcd011mr24135446wml.194.1667569503721;
        Fri, 04 Nov 2022 06:45:03 -0700 (PDT)
Received: from gmgdl (j99119.upc-j.chello.nl. [24.132.99.119])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b00236733f0f98sm3399255wrt.107.2022.11.04.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:45:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqx0I-000Eni-1e;
        Fri, 04 Nov 2022 14:45:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] bisect--helper: move all subcommands into their own
 functions
Date:   Fri, 04 Nov 2022 14:32:34 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
 <081f3f7f9501012404fb9e59ab6d94f632180b53.1667561761.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <081f3f7f9501012404fb9e59ab6d94f632180b53.1667561761.git.congdanhqx@gmail.com>
Message-ID: <221104.86r0yiygtd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> In a later change, we will use OPT_SUBCOMMAND to parse sub-commands to
> avoid consuming non-option opts.
>
> Since OPT_SUBCOMMAND needs a function pointer to operate,
> let's move it now.

As shown in
https://lore.kernel.org/git/patch-11.13-d261c32ddd7-20221104T132117Z-avarab=
@gmail.com/
this can be much nicer in terms of avoiding these wrappers if we jsut
teach parse-options.c to take our custom signature'd callback, but...

> +static int cmd_bisect__reset(int argc, const char **argv, const char *pr=
efix UNUSED)
> +static int cmd_bisect__terms(int argc, const char **argv, const char *pr=
efix UNUSED)
> +static int cmd_bisect__start(int argc, const char **argv, const char *pr=
efix UNUSED)
....

>  	switch (cmdmode) {
>  	case BISECT_RESET:
> -		if (argc > 1)
> -			return error(_("--bisect-reset requires either no argument or a commi=
t"));
> -		res =3D bisect_reset(argc ? argv[0] : NULL);
> +		res =3D cmd_bisect__reset(argc, argv, prefix);
>  		break;
>  	case BISECT_TERMS:
> -		if (argc > 1)
> -			return error(_("--bisect-terms requires 0 or 1 argument"));
> -		res =3D bisect_terms(&terms, argc =3D=3D 1 ? argv[0] : NULL);
> +		res =3D cmd_bisect__terms(argc, argv, prefix);
>  		break;
>  	case BISECT_START:
> -		set_terms(&terms, "bad", "good");
> -		res =3D bisect_start(&terms, argv, argc);
> +		res =3D cmd_bisect__start(argc, argv, prefix);

If we're not going to do that this isn't too bad actually. s noted in my
CL
(https://lore.kernel.org/git/cover-00.13-00000000000-20221104T132117Z-avara=
b@gmail.com/)
I started seeing if I could cut Johannes's built-in-bisect series down
to size so we could have it merged sooner than later.

It ended up refactoring every single user of "terms" to take the
file-global instead of the variable on the stack, but this shows that
that's not something we need, even without a new parse-options.c API.

B.t.w. you can cut down more on the verbosity by doing:

	struct bisect_terms terms =3D { 0 };

Which is the same as "{ .term_good =3D NULL, .term_bad =3D NULL }". I left
it in place in my version because I'm explicitly trying to avoid
touching anything we don't need to for a bisect built-in, but if we're
refactoring this anyway...

I also think this could be further reduced in size a lot if we go for
your approach, i.e. make a helper function that these call, like:

	if (have_err)
		return error(_(error_msg));
        if (set_terms)
		set_terms(&terms, "bad", "good");
	if (get_terms)
		get_terms(&terms);
	res =3D !strcmp(iam, "terms") ? bisect_terms(&terms, argc =3D=3D 1 ? argv[=
0] : NULL) :
        	!strcmp(iam, "start") ? bisect_start(&terms, argv, argc) :
                [...];
	free_terms(&terms);
	return res;

Then e.g. the body of "terms" is just:

	return that_helper(argc, argv, prefix, "terms", /* iam */
        		  argc > 1, /* have err */ N_("--bisect-terms requires 0 or 1 arg=
ument"), /* err msg */
                          0, 0, /* get terms and set terms */);

Etc., I think that might be worth it, as almost all of the contents of
these functions is just copy/pasted...
