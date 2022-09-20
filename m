Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74181C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 11:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiITLH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiITLHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 07:07:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C62D1F3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 04:07:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hy2so1543002ejc.8
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=3kfBZ07NC4D9XRXKOtSvB52DQ+pw3xPaXffQt+qx47M=;
        b=dxoxoBrs8QZsp+fs5iKALBkEYkIeXpbVDkKC5sDCrsO8pfItCeWLV22PwqxFfEI+Gi
         3tq/qr0Xg3SqfoLPtHqEkU67CUbVmYkuTxrMH4JygStH0Xpb48mSTKlzR+kxQA7wtKGK
         wGosDEBNprkmg7IOLXQlUj6yKDYMydDPjOixpgCM1FEbjVhbll2fqPlEXuX/vintd4mS
         msQYtHGKi64FQRXnK4Gwk4roKqxE2MO2K0ZpGBoeFR45IkRmWEm/4SbX+mg9mgv3XMgg
         8arLd34EZwKGki5aquELjLtskvNhpRv5muVXUOjc9rdxlDaNWY2Z6cKZldVSGa992l+/
         Tg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=3kfBZ07NC4D9XRXKOtSvB52DQ+pw3xPaXffQt+qx47M=;
        b=JyRtWFvOjMGB88XoJHzeYhydCZYtTXmKen6KZtZ4TvO9f82VX9wjv8lW0DZ9e3L3rU
         7mY2IHvm71Y1dIN7IBZ1Lw3VEMcc/VnMPk6KhbIm9JMS+axvtpZrHweCUayZPXJcNSTl
         2uNahVOIQps5IdyOiwbIqTnCPvdIeceDlPsKfI9OV4659+BtYENrG828ZuqjgVlvdiMt
         wLMaLeLlSrqOPP0LdxOD+iVVQFkvLep4+7UEcEEypgbcTGZSDXiZKDL/S+dxui1l1u28
         1lpTQbgyvHDEFf3cUBGIxTrCbBHVJGk0oEXslxoZZaekHLKvaRKEuK6WSG1mNoBweOig
         NDgg==
X-Gm-Message-State: ACrzQf00DIeK0GDH8C50pb+R8YuoH/fT8i5aPbjTSnU+Q1fd8DsMU6UU
        109xgEZXr7bVOKx0P8F892k=
X-Google-Smtp-Source: AMsMyM5OqPItWNxBkGSXoTOKUzdXqCgAk9KaZWxpLpqW0oROgtK7QGkiBRYDrm7rjQa4ro7JqYudDQ==
X-Received: by 2002:a17:906:dac9:b0:780:ab6f:591f with SMTP id xi9-20020a170906dac900b00780ab6f591fmr14826007ejb.77.1663672072144;
        Tue, 20 Sep 2022 04:07:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kt27-20020a170906aadb00b00780a26edfcesm688915ejb.60.2022.09.20.04.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:07:51 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oab6U-001Ic0-2C;
        Tue, 20 Sep 2022 13:07:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 2/2] docs: document a format for anonymous author
 and committer IDs
Date:   Tue, 20 Sep 2022 12:51:39 +0200
References: <20220919145231.48245-1-sandals@crustytoothpaste.net>
        <20220919145231.48245-3-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220919145231.48245-3-sandals@crustytoothpaste.net>
Message-ID: <220920.86a66u5mnt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 19 2022, brian m. carlson wrote:

> The original design of Git embeds a personal name and email in every
> commit.  This has lots of downsides, including the following.
>
> First, people do not want to bake an email into an immutable Merkle tree
> that they send everywhere.  Spam, whether in general or by recruiters,
> is a problem, and even when it's not, people change companies or
> institutions and emails become invalid.
>
> Second, some people prefer to operate anonymously and don't want to
> specify personal details everywhere.
>
> Third, and most important, people change names.  This happens for many
> reasons, but it comes up most saliently for transgender people, who
> frequently change their name as part of their transition.  Referring to
> a transgender person's former name, their "deadname", is considered
> inappropriate.
>
> We have a solution that can map former personal names and emails into
> current ones, the mailmap.  However, this last case poses a problem,
> because we don't really want to correlate the person's deadname (or
> their email, which may contain their deadname) right next to their
> current name.
>
> Several solutions have been proposed for this case, including hashing or
> encoding the old information, but these are all easily invertible.
> Instead, let's propose a new form of identifier which is opaque and some
> mailmap improvements to store the mailmap information outside of the
> main history.

With you so far...

> Propose that users use the fingerprint of a cryptographic key as part of
> a special-form email which is not valid according to RFC 1123, but is
> accepted by earlier versions of Git.  Now that we have SSH signing and
> OpenSSH is available on all major platforms, creating a unique ID is as
> easy as running ssh-keygen.  This approach results in an identifier
> which is unique, deterministic, and completely anonymous.

...but...

> Propose this new option instead of using a name and email, although
> users can continue to use those as before if they prefer. Continue to
> associate personal information with this opaque identifier using the
> mailmap, but in such a way that it lives in a special ref outside of the
> history and that ref is customarily kept squashed to a single commit.
> Create a special RFC 5322 header to associate a mailmap entry with the
> user's opaque identifier when sending a patch if desired.

...while it's technically neat, I really don't see why this whole
hashing mechanism is a necessary prerequisite to get to this point.

Wouldn't we get the same thing if *by convention* we just supported
authorship like this, (which we already support):

	UUID=3D$(get-some-uuid)
        git config user.name X
        git config user.email $UUID.uuid.git.example.org

So you'd end up with e.g.:

	X <98ab8d66-38d2-11ed-a261-0242ac120002.uuid.git.example.com>

Or whatever, we could bikeshed about the format, but the point is that
it's not codifying *how* that looks.

We'd then just support this refs/mailmap mechanism you're suggesting,
where we'd have a mapping like:

      =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> X <98ab8d66=
-38d2-11ed-a261-0242ac120002.uuid.git.example.com>

Which could be force-pushed.

I can see why you'd *also* want to formalize the ID generation, but I
just don't see why we'd want to make that as one leaping change rather
than something more incremental.

I.e. even if you don't have opaque IDs in the first place this mechanism
would allow you to maintain a "mailmap" ref on the remote, which would
already be useful.

E.g. now if I use a hosting provider and have my .mailmap in various
repo I need to maintain then in each repo, but this would allow for a
magical ref which would keep it up-to-date in various repos...

> [...]If a user would like to preserve a history
> +for some reason, they can use `--use-mailmap=3Dcommit`.  For maintainers=
, they can
> +then push this ref using the normal push refspecs, or explicitly with
> +`--mailmap`, which is equivalent to `+refs/mailmap:refs/mailmap`.

I obviously see why you want the "force push" aspect of this (the
deadnaming), but I still wonder if it's really a good trade-off for git
as an SCM to make that the default.

We've been going in the other direction for e.g. tags semi-recently with
my 0bc8d71b99e (fetch: stop clobbering existing tags without --force,
2018-08-31).

By having that force-push default we make it so that a plumbing command
(that makes use of mailmap) will give you one result today, but a
different one tomorrow, with no easy way to get back.

Maybe it's something we want in the end, but it's another thing that's
"changed while at it", i.e. not only are we introducing "mailmap" remote
refs, but also:

 * Changing the many-to-many mapping of history-mailmap to a
   many-to-one, i.e. the map is per-repo, not per-ref.

 * Changing it so that you can't track is as part of your history.

If we wanted to ease into just one of those we could have a "mailmap"
tag object, which we wouldn't clobber by default....

