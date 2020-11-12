Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B98C2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA25F22240
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL42LQQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgKLOTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbgKLOTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:19:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134F7C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:19:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a15so6407764edy.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9ZJN7LZmRVJ/dz9FN1w6/+yp7t/Obnvj3/QXh7fK2t4=;
        b=tL42LQQuwoy1L969H7GjaEhVZD9jdzyH9ZTpRo1BdwvE9CW5kHTwGrqyIAkt1oH/M0
         jbKKaDIlx8wYb5P2NqUtyh+X7blnAUfkOpAqg2ckk7+qFBh0x5L9BUD3HX1IVmUWLHDl
         eI9K4c3fjW7Ef+bs5EefRcp2ByBH5d2+fygi0gIOnIzzB2V6LqVZWGibjoAuvdwv1U6S
         namm0k5LR40R75R4I3+iJ+jqNbER1F4PI3JxeNGXPpKDNh6DZkKZiFOXHXMrqGFUK4cw
         rtcdCutzAqTm5qHlPE1Q6olrJoM9So/YoIwyHljrohP046emZUdmoVbD4H5vOOAObliG
         NJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9ZJN7LZmRVJ/dz9FN1w6/+yp7t/Obnvj3/QXh7fK2t4=;
        b=GZiBVW6+x+hXwlM5BJszMBAY7GVHaC9o1pLXwAINpA4d5P4LLy3EeXGce6wNL3vEXo
         RtpmNoC3EtGfCodOB8XRy28YisVmOeDgF3i3KdUXuHzP2rRY5I7b22qlGiTVwYncVcVI
         yb8mCynpKq+MoqfR0SarjdIPn/4036XrNe1FJhDysmMbCY50Gkh253INPkU60Jwf/iId
         GG6vkfifqjS9uIh2ULhePsWvlTMIE99+GoNXVjWBNJbL9+ek3zYr+cejHfzN9Z6o5Dwx
         T5yErrnIOY4nzBC64KzNkZ9DAZX29/WxgY+Yb4HKLWk1MtZlOL/IhfnQjneeLzXbBRFb
         j+1w==
X-Gm-Message-State: AOAM533HBuUhzh20Hh5y2xQx2feWMxC5q9tSwyJm0k+9oTcWZYEBBF7C
        Dy9Pg3yDYXhNiG8KVdyrQVF7eyI9cncPQQ==
X-Google-Smtp-Source: ABdhPJzVbC/VOqVGPe0BwmbZu6HM4DkuS1xysXv3jCIv6/s9fogY3U28QLOi+FYIFgjxl8cHBD/EIA==
X-Received: by 2002:a50:dac7:: with SMTP id s7mr5263415edj.106.1605190761342;
        Thu, 12 Nov 2020 06:19:21 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id rp28sm2211284ejb.77.2020.11.12.06.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:19:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: How do I "git fetch" with a custom <refspec> but a default remote?
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com> <20201111151754.31527-1-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20201111151754.31527-1-avarab@gmail.com>
Date:   Thu, 12 Nov 2020 15:19:19 +0100
Message-ID: <877dqqhd3s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 11 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> In any case, this is one thing that came out of that
> investigation. The code we're keeping by moving it to git-submodule.sh
> can also be replaced by some C code we have, but I wanted to leave
> that to another submission (if I'll get to it), and make this simply a
> code removal.

I may have missed a way to do $subject, but I don't think it's
possible. The reason I want it is because git-submodule.sh does this:

    git fetch $(get_default_remote) "$@" ;;

Where that shellscript function gets the name of the remote configured
for the current branch. If you do just a:

    git fetch

Then it will do the right thing, per its documentation:

     When no remote is specified, by default the origin remote will be
     used, unless there=E2=80=99s an upstream branch configured for the cur=
rent
     branch.

But git-submodule.sh wants to do:

    git fetch <default-remote> <some-sha1>

So the caller is forced to find out what that is.

I came up with this patch:
=20=20=20=20
    diff --git a/builtin/fetch.c b/builtin/fetch.c
    index f9c3c49f14..f110ac8d08 100644
    --- a/builtin/fetch.c
    +++ b/builtin/fetch.c
    @@ -56,6 +56,7 @@ static int prune_tags =3D -1; /* unspecified */
     #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
=20=20=20=20=20
     static int all, append, dry_run, force, keep, multiple, update_head_ok;
    +static int default_remote;
     static int write_fetch_head =3D 1;
     static int verbosity, deepen_relative, set_upstream;
     static int progress =3D -1;
    @@ -140,6 +141,8 @@ static struct option builtin_fetch_options[] =3D {
            OPT__VERBOSITY(&verbosity),
            OPT_BOOL(0, "all", &all,
                     N_("fetch from all remotes")),
    +       OPT_BOOL(0, "default-remote", &default_remote,
    +                N_("fetch from default remote")),
            OPT_BOOL(0, "set-upstream", &set_upstream,
                     N_("set upstream for git pull/fetch")),
            OPT_BOOL('a', "append", &append,
    @@ -1852,7 +1855,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
                    else if (argc > 1)
                            die(_("fetch --all does not make sense with ref=
specs"));
                    (void) for_each_remote(get_one_remote_for_fetch, &list);
    -       } else if (argc =3D=3D 0) {
    +       } else if (argc =3D=3D 0 || default_remote) {
                    /* No arguments -- use default remote */
                    remote =3D remote_get(NULL);
            } else if (multiple) {

Which allows me to do:

    -               git fetch $(get_default_remote) "$@" ;;
    +               git fetch --default-remote "$@" ;;


So it works, but what do we think about this calling convention? Do we
have any prior art for commands that take positional arguments like
<remote> and <refspec> where you'd like to use a default for an earlier
argument to provide a subsequent one?

To make it more general and consistent we'de probably like a --remote=3D*
and --refspec arguments, so the invocation would be:

    git fetch ([--remote=3D]<name> | --default-remote) [([--refspec=3D]<ref=
spec> | --default-refspec)]

But maybe I'm overthinking it...

