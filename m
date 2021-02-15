Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C351C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076C061490
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 23:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBOXLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 18:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhBOXLv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 18:11:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163EBC061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 15:11:11 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id df22so10127495edb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B9IV9xbqErrEAUPHfio3zqS0gJAjb73HOmDVzJqNCak=;
        b=LBmMp1UIlY3iwXwquy2vCuQEiEt60twr4AGpivEt7bn8tL0ysDcYTxDMCJfaphnEmE
         1UxDx1ah8xGLc5E19E3xuGfR3P3krF0LTPCX5QfNZu5xK7/SfQF5FkuTuxrLtoyUrF5E
         YQu5CmAdyV/zMbkeh8kaScROe31Lcb5yEAqtxEJEcl5iqpYVQRlWJUFMCcrvkC6aFm5W
         loOI4tYMI+zQGRJsl1OrTiIURPLoWWzGZldh0BXfaePIKhphB7nPyOs//F8RYO3mCuje
         C5gyC7VeH4290V8N8LVYlHoo48bmpBWT3kLIoJ5RYzau93PvuH4hmoU7NvRisFZnV1hh
         B8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=B9IV9xbqErrEAUPHfio3zqS0gJAjb73HOmDVzJqNCak=;
        b=fBpkU6DdHrcSvL0I6J8+1FJ4wMkri3V0D9aO1e3q0b9SaP55ACf6lZyAXPE3k3nY+Q
         6oo5BS/DTZDpz1PDda/xQBkJkvPKog8PumtHxup8SLjFEvZJO4q093rZVmlbd328DvJC
         E680q8fbyqlGsM+bzROEHvlMdcBjjdIoocK77yCjMNj1ogZujfkLO+7c6wgSz9QeC//+
         85LScnDfkjl/IKrkVjzGXcXOnDCV8kewfLt2DB9gFOi9Fl78D/Vn9Ajbw08Sq3T34DTS
         BP4Q2FTvjSip8mGa7MDRhZNupBQrwejlUOn+uPgjj4td8gC5z30JElHK4cqRAlYmBNnY
         KSPA==
X-Gm-Message-State: AOAM532hg9SZYV7BYDmuYDW66Y/2HZEiDEjUeBkQjTMZmGGOD5hnSoHY
        26R1Jl7YUUmPDTS1daub3a0=
X-Google-Smtp-Source: ABdhPJz/TIJ95Yij99BefVzuFAM3eh7dyl+ANh+SZdIPYRiEU7AG1yTbgtRzbtnGiUY4nHVrBcH3Tw==
X-Received: by 2002:a05:6402:1e4:: with SMTP id i4mr11955743edy.227.1613430669595;
        Mon, 15 Feb 2021 15:11:09 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id r4sm11514735edv.27.2021.02.15.15.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:11:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] builtin/multi-pack-index.c: split sub-commands
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <16f33e41388ed431f70e09ef68717bd30fbee67f.1613422804.git.me@ttaylorr.com>
 <877dn9atew.fsf@evledraar.gmail.com> <YCr3DY5gawPC+G38@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YCr3DY5gawPC+G38@nand.local>
Date:   Tue, 16 Feb 2021 00:11:08 +0100
Message-ID: <874kidapv7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Taylor Blau wrote:

> On Mon, Feb 15, 2021 at 10:54:31PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Mon, Feb 15 2021, Taylor Blau wrote:
>>
>> >  	trace2_cmd_mode(argv[0]);
>>
>> Not a new issue, but curious that in the commit-graph.c code we'll first
>> validate, but here write garbage into the trace2_cmd_mode() before
>> potentially dying.
>
> Yeah, that's a good catch.
>
>> I realize this is the existing behavior, but let's just make this die()
>> be the usage_with_options() we emit above in this case?
>>
>> So maybe this on top?
>
> I split this into two patches: one to move the trace2_cmd_mode() calls
> around, and another to replace the final 'die()' with the usage text.

Thanks for picking it up.

> Like I said in my review of your patches to the commit-graph builtin
> here:
>
>     https://lore.kernel.org/git/YCrDGhIq7kU57p1s@nand.local/
>
> I don't find the 'if (argc && ...)' style more readable, so the second
> patch looks like this instead:

*Nod* FWIW (and this is getting way to nit-y) I don't disagree with you
about the "argc &&" being not very readable,

I just lean more on the side of getting rid of duplicate branches,
you'll still need the if (!argc) usage(...) case above without that
pattern, or some replacement for it.

But we can have our cake (not re-check argc all the time) and eat it too
(not copy/paste usage_with_options()). Isn't it beautiful?
=20=20=20=20
    diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
    index caf0248a98..7ff50439f8 100644
    --- a/builtin/multi-pack-index.c
    +++ b/builtin/multi-pack-index.c
    @@ -144,12 +144,8 @@ int cmd_multi_pack_index(int argc, const char **ar=
gv,
     	if (!opts.object_dir)
     		opts.object_dir =3D get_object_directory();
=20=20=20=20=20
    -	if (argc =3D=3D 0)
    -		usage_with_options(builtin_multi_pack_index_usage,
    -				   builtin_multi_pack_index_options);
    -
    -	trace2_cmd_mode(argv[0]);
    -
    +	if (!argc)
    +		goto usage;
     	if (!strcmp(argv[0], "repack"))
     		return cmd_multi_pack_index_repack(argc, argv);
     	else if (!strcmp(argv[0], "write"))
    @@ -159,5 +155,7 @@ int cmd_multi_pack_index(int argc, const char **arg=
v,
     	else if (!strcmp(argv[0], "expire"))
     		return cmd_multi_pack_index_expire(argc, argv);
     	else
    -		die(_("unrecognized subcommand: %s"), argv[0]);
    +usage:
    +		usage_with_options(builtin_multi_pack_index_usage,
    +				   builtin_multi_pack_index_options);
     }
=20=20=20=20
:)

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 5ab80bc722..ce4f1a0bcb 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -165,5 +165,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
>         else if (!strcmp(argv[0], "expire"))
>                 return cmd_multi_pack_index_expire(argc, argv);
>         else
> -               die(_("unrecognized subcommand: %s"), argv[0]);
> +               usage_with_options(builtin_multi_pack_index_usage,
> +                                  builtin_multi_pack_index_options);
>  }
>
> Is it OK if I use your Signed-off-by on both of those two new patches?

Yes please, should have included it to begin with.
