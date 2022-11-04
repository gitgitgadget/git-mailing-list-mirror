Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17CAC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 09:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKDJvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 05:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKDJvR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 05:51:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E250140C3
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 02:51:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so11783318ejb.13
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HW1WtkUx+SfHloE9WcGDEJC9JaplIdNwFBdHsum6KbE=;
        b=GaR3UfxRAZC2raz2Ln8Wxh2DGkQpGAtevIx/eMsALAFzcIjkLOqsmViCR+XZIowAxA
         FGLXAulDrYQJoWuGm41hddtGjNnfP7BRcAFhF5AQWDbG3XsE4f4eRGLVQI89/E/bqVJB
         aU9zXUmAK9QjXiJSUcqhVZ4+7JlPsP0ZWpL9OsQbqHuRKcxCTX8ASK5hSEiL/mdGKbt9
         0LHsmFem3Rg70V3fYNIy83dgiD1d66n/N2c6tAqgqYZFeRcwsBNpjyF/XE94x3RfQ638
         f3zbXKQzd0k/46NC4zgvsDvsUXDP8uPyLgyhty7C/lJv01grlBOt7A/VZhfI55TOLu/V
         mOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW1WtkUx+SfHloE9WcGDEJC9JaplIdNwFBdHsum6KbE=;
        b=fRbSDplP6ur6sFRBVfJwumFnyLmpS/Y/l+0YiiC11W81AnSYy1df9ejLodH0ECEN1h
         XDxVwdmjPATtL871+4Haw3cDmrFEKfNp9itYXvmEAZdYvTDsa3n9mkdCvJQlm2Mb0QIg
         CyL5CmWsF+UFvRJtmt8TSYtvKeGItXu4wvf3WtchoNyPx1HHY5sh2XdNgz7TioQriVQ0
         Q6LAL2eOFwwtJpf8j7aaT+cqJXOsjb3i7YbPXgAxxwsip0Pz4IbxE2WEnqsYBzsHJKjB
         uChchFesn+i44iDbRtLBWQzjxVybf9GyJv82eJItfl2wldKizo6pcZU3WsaOT0fVFfN7
         IN3w==
X-Gm-Message-State: ACrzQf3cQdbWQVRsE9/b8P98bJ1vXY39I99lPqcoB3h2Pp6BZU5bgeKv
        7lXn0Oj5FYyQNvG6bHTfWPFPROzS8hBFSg==
X-Google-Smtp-Source: AMsMyM65sajQdsiUQcK/AlAhhwvgywZt6vAHkNydgImGxDkgTKeUr3ea4q+vd1lj0CUKwL56J3HkjQ==
X-Received: by 2002:a17:906:99c2:b0:7a8:c167:1d93 with SMTP id s2-20020a17090699c200b007a8c1671d93mr32079954ejn.490.1667555474794;
        Fri, 04 Nov 2022 02:51:14 -0700 (PDT)
Received: from gmgdl (j30044.upc-j.chello.nl. [24.132.30.44])
        by smtp.gmail.com with ESMTPSA id r5-20020a056402018500b00461bb7e7ef1sm1711048edv.30.2022.11.04.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:51:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqsw8-00DEqC-0c;
        Fri, 04 Nov 2022 10:24:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Date:   Fri, 04 Nov 2022 10:01:00 +0100
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
 <221101.86o7tq4vsn.gmgdl@evledraar.gmail.com>
 <Y2GI0R6pJmdZNgHn@nand.local>
 <221101.8635b24959.gmgdl@evledraar.gmail.com>
 <Y2IoEN6NHqj2Qisa@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2IoEN6NHqj2Qisa@coredump.intra.peff.net>
Message-ID: <221104.8635azysw7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 02 2022, Jeff King wrote:

> On Tue, Nov 01, 2022 at 10:57:46PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> >> Sure, we can do it with an environment variable, in the end that's all
>> >> git_config_push_parameter() is doing too. It's just setting things in
>> >> "GIT_CONFIG_PARAMETERS".
>> >>
>> >> And yes, we can set this in the low-level function instead of with
>> >> git_config_push_parameter() in builtin/*.c as I did. I was aiming for
>> >> something demonstrably narrow, at the cost of some verbosity.
>> >>
>> >> But I don't get how other things being equal you think sticking this =
in
>> >> "GIT_CHECKED_CREDENTIALS_IN_URL" instead of "GIT_CONFIG_PARAMETERS"
>> >> helps.
>> >
>> > I vaguely prefer calling this GIT_CHECKED_CREDENTIALS_IN_URL instead of
>> > stuffing it in the configuration.[...]
>>=20
>> To be clear, I'm asking if there's cases where we think one method or
>> the other produces different results, which I understood Jeff hinting
>> at.
>
> What I was hinting before was not that I knew of a particular bug in
> your patch, but that I think the technique of munging
> GIT_CONFIG_PARAMETERS is fragile in error-prone in the general case,
> because the sub-programs can't differentiate between the config the user
> asked for, and what was set by the suppression mechanism.
>
> For this variable, there's no need to differentiate between "the user
> asked us to be quiet" and "the calling program asked us to be quiet",
> but I could imagine cases where there are subtle distinctions. Imagine
> if there was a setting for "warn and rewrite the URL". We'd need to
> change that to "don't warn, but just rewrite the URL", which otherwise
> is a mode that doesn't need to exist.
>
> Keeping it in a separate variable keeps the concerns orthogonal. The
> code still gets to see what the user actually wants (via the config),
> but has extra information from the calling process about how noisy/quiet
> to be.

... (replied below) ...

> But you mentioned submodules in your other mail. And you're right that
> the patch I showed doesn't handle that (it would need to add the new
> variable to local_repo_env). It seems like yours should work because
> CONFIG_DATA_ENVIRONMENT as part of local_repo_env. But I don't think it
> actually does; in prepare_other_repo_env(), we retain the variables for
> config in the environment, so that:
>
>   git -c foo.bar=3Dwhatever fetch
>
> will override variables in both the superproject and in submodules.

Replying to your main point below, just an aside on this:

To be clear I'm not saying it would handle it sensibly now, but just
that if we're using env vars to communicate to sub-processes then using
CONFIG_DATA_ENVIRONMENT seems better to me.

Because even if we're getting it wrong now, then surely that's something
we're probably getting wrong in more than one place.

So e.g. if we set an env var "for ourselves", i.e. "pull->fetch" then we
could detect that condition in run_command(), and if we then spot that
we're carrying an env variable we set earlier up the chain reset it
before we spawn a submodule.

Whereas if it's all custom env variables here & there we'll need to add
all that special-casing in.

> I didn't try it, but I suspect with your patch that a superproject with
> "warn" and a submodule with "die" (both in their on-disk config files)
> would misbehave. The superproject process will warn and say "yes, I've
> checked everything" by munging the in-environment config to "allow".
> Then the submodule process will see that config, and will override the
> on-disk setting (in the usual last-one-wins config way). I.e., the
> problem is that it cannot tell the difference between "the user asked to
> override this" and the suppression mechanism.

Yes, definitely, and now I see what you're saying. I.e. imagine a chain
like this (not actual process chains, but let's go with the example);

	user config =3D warn
	run: pull
	our config =3D allow
		# OK: doesn't "warn" now
		run: fetch
			# Not warning, but ....
			run: pre-fetch hook
				# BAD: ...oh oh, now a hook is fetching some
                                # entirely unrelated repo
				run: git pull
			# OK: Doesn't warn either
			run: remote-curl (now not warning, otherwise would)
                        # BAD: our "warned already" has infected a
                        # submodule, and we downgrade "die" to "allow"
			user config =3D die
			run: git fetch <submodule>
				...

But, and maybe I'm still not getting it, but the "use a different env
var" isn't actually the important part, i.e. these would behave the
same after the initial "warn":

	-c transfer.credentialsInUrlWarnedAlready=3Dtrue

And:

	GIT_CHECKED_AND_WARNED_ALREADY=3D1

But not what I was suggesting:

	# conflated with a later "die"
	-c transfer.credentialsInUrl=3Dallow

But that only goes for e.g. a "pull" where we "warn" followed by
submodule whose config is "die".

But all suggested variants of this (mine and yours) are going to get
e.g. the case where the submodule also wants "warn". I.e. it's not
enough that we're saying "warned already".

That gets us past conflating an existing "warn" with a "die", but now we
can't tell a submodule "warn" from a superproject "warn".

For that we'd basically need to do:

	-c transfer.$(<make path to .git, or other "unique repo id>).credentialsIn=
Url=3Dallow

Or another similar mechanism, of course the most sane one to be to not
be playing this game at all, but to just ferry this state e.g. with
"--do-not-warn-about-this-repo" to our own children, which we'd not add
to the command-lines when we know we're spawning a hook, or doing the
submodule "pull/fetch".

Does that all seem right?



