Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BECFC433E6
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A04964F38
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 10:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCSK1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 06:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCSK1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 06:27:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DBC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 03:27:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b7so8840422ejv.1
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=iNDq/XCJASOStJQxxsd7Dj9CeXUllB/bZOIsvAIKyWs=;
        b=Qq8DLaGfM2dMfmjII1xhQ+Fi+Ild6yZ+4IfCZvK1RJyRkc3SlTFZGcV3mCweVdvhLU
         8VKooNswV/iiG3ilxxinHbbYygNxfNyVeTdhWK5mwsARXMxyRRyq55ecTHwSPHQrv/wd
         o+/P4z3U7801EoTbn/wc4cLfZgUvzjDyZ2bK4FZ0NmppmtxBtCXq1Q2Jba4F7MagbzAU
         9OLZC9zV8w5QX/BD6v45X4OUaPcspnIjhab2s096Vi2MfnAPbPlJTeMMLyPEa3TQqEaB
         9C+3VykJZFBxYFoJu3d0c8NfSENZNh33g8K4+/8PnI4wWntLLhmC9AOsFQ8apOksW6nI
         GkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=iNDq/XCJASOStJQxxsd7Dj9CeXUllB/bZOIsvAIKyWs=;
        b=sIZiifscMPLrl/j92lOPqO9ofR0lzsYwUVs+tNw2yOlH+pCXHdblzwIAOocqCcem1d
         MRghUFWEOpJKMA72/U60W322GsI3Lx5t5BLHt0rL4V6AtUTNCV+vsnYFv0+kkX3GDnCi
         d9SJvO0hoU4yh5m8s8CjVFv5d64j3mxNLunmnV4PA//xFu48I95fYHlsq6Y8SwGAspVF
         wf4nAbTAj670iEZuV8shppdOzyKUCYwvW+XFwjTyUMoJ2/9mmwqFDRBdoMhhI6lYFgoz
         L6tO84k6/S59FS402pP1IndDZJH3PL/AKlxBk2ZOh9GcvQGbiYvLWS3yUfP7udBeQ4CT
         bdmw==
X-Gm-Message-State: AOAM532sFJ8UgWgb9PMGGIHVcqjiMJje1Yqd7lkAFMW2EHbhU6+cBan3
        ti/jOgJgionUZzgXqKIxX1OhYb3IwEw=
X-Google-Smtp-Source: ABdhPJwkz13/nCIPNMQUr/zVCUVIvFG04vfETy6B1VtlPH8GkO4MRxSr+mV1pOGcACJbSB3ZQrgshw==
X-Received: by 2002:a17:907:9709:: with SMTP id jg9mr3411047ejc.276.1616149650222;
        Fri, 19 Mar 2021 03:27:30 -0700 (PDT)
Received: from evledraar (77-60-191-25.biz.kpn.net. [77.60.191.25])
        by smtp.gmail.com with ESMTPSA id w24sm3830672edt.44.2021.03.19.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 03:27:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Albert Cui <albertqcui@gmail.com>
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
Date:   Fri, 19 Mar 2021 11:27:29 +0100
Message-ID: <87im5nzbe6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 18 2021, Albert Cui via GitGitGadget wrote:

> We propose adding native Git functionality to allow project maintainers to
> specify hooks that a user ought to install and utilize in their development
> workflows. This patch documents the requirements we propose for this feature
> as well as a design sketch for implementation.

I like this goal. It's something I proposed (off-list) before and did a
small write-up of here:
https://lore.kernel.org/git/87zi6eakkt.fsf@evledraar.gmail.com/

As far as I recall the response in the room at the time was the expected
combination of "sure that would be neat" and "let's see the
patches". I.e. I don't think there's hard objections to the existence of
such a facility, but of course the devel is in the details, and
obviously I never followed-up with actually trying to implement it.

With config-based hooks this'll be much easier for the hook case, and
I've tried to help that along[A]. I'd be interested in reviewing any
effort in this area as well. The ".githooks/*" case in that proposal
goes away with config-based hooks (since they wouldn't be special
anymore, just config).

> +Example workflow
> +^^^^^^^^^^^^^^^^
> +
> +* Perform fetch as normal
> +
> +* After fetch is complete, Git checks for a "magic" config branch (e.g.
> ++origin/refs/recommended-config+) which contains information about config lines
> +an end-user may want (including hooks).

Why collapse the many-to-many branch/config relationship to many-one
this way instead of having a .gitconfig at the top-level? Then you can
seamlessly have per-branch config, and it'll work if you later locally
clone the repo or just transport that branch (e.g. via bundle).

But reading ahead...

> +* As part of the fetch subcommand, Git prompts users to install the configs
> +contained there.
> +
> +    ** User responses to that prompt could be "sticky" - e.g. a user could reply
> +    "no (this time)", "no (never)", "yes (this time)", or "yes (always)".
> +    Always/never indicate that the user trusts the remote this config is coming
> +    from, and should not apply to configs fetched from other remotes.

As noted in the proposal I linked I think anyone thinking about this
would do well to examine the trade-off Emacs's implementation of this
uses, since it manages to safely open arbitrary files that'll
potentially run arbitrary code on-open, but only if the user opts-in.

> +Later, we might want to do this before the initial clone is performed; that
> +workflow looks like:
> +
> +* During clone, perform ls-refs as normal
> +
> +* If the server has a "magic" config branch, fetch only that config branch.

...the reason for the magic branch is this before-clone use-case?

Unless there's a really strong use-case for that I'd think the
per-branch .gitconfig would be a better trade-off, but even then there
would be ways to make that work obviously in the many-many case, and
still e.g. have a branch advertise a config blob for its "main" branch
as a special case or something.

I also suspect an unstated constraint of having this in a magic branch
is the limitation of some git hosting provider's ACL
implementations. More on that later...

> +* Prompt users as described above.
> +
> +* Perform the rest of the clone.
> [...]
> +* Repository owners have a method for providing recommended config for
> +contributors.
> +
> +* Installation flow happens without additional user intervention.
> +
> +* Keeping config branch and history separate from code branch and history means
> +it is versioned, but not tied to user's checkout.
> +
> +* Letting users specify "always" or "never" reduces amount of pain introduced by
> +interactive "configuration wizard" flow.
> +
> +Cons
> +^^^^
> +
> +* Requires addition of step to fetch (and later clone).
> +
> +* Turning a "set and forget" command like clone into an interactive session with
> +the user is not ideal; care must be taken to avoid breaking bots.
> +
> +* Inflating configs and executables from a remote tracking branch which is never
> +checked out could be slow.
> +
> +Future Work
> +~~~~~~~~~~~
> +
> +* Extending this to allow repository owners to specify specific configurations
> +in general e.g. this repository should use partial-clone with these parameters.

I don't see why such a proposal should narrowly confine itself to hooks.

Once we have config-based hooks then hooks are just configuration.

If we're going to pick up arbitrary configuration from remotes/repos on
request then we'd be starting with the most dangerous configuration.

I think a better way to start such an effort incrementally would be:

1. Audit git's config parser for the safety of parsing arbitrary config,
   we parse .gitmodules now, do we feel it's safe enough to parse
   arbitrary config (probably, but worth checking).

2. Add reflection to git's own config variables. Right now we have this
   in the binary generated via a grep from the documentation. Similar to
   Emacs's implementation we should/could categorize all our known
   config variables by safety.

   Hooks are the least safe, something like a diff.context=N setting the
   repo wants to suggest a -U<n> setting much safer (just tweaking our
   existing diff algorithm) etc. But even in those cases we'd want to
   proceed slowly, e.g. is that config parsing for that -U<n> defensive
   enough to be safe for arbitrary data?

3. Users should be able to e.g. configure "yes, for any repo I clone
   they can tweak 'safe'" variables. This would reduce user dialog
   fatigue, and thus increase safety. I.e. a repo who wants to set a
   thing like hooks would stand out, but something that e.g. wants to
   change the diff order would pass on existing global configuration.

4. Smarter ACL that magic remote+magic branch: It seems like an obvious
   thing to me to want that if I clone e.g. a random clone of git.git
   that I'd want to setup config for it IFF the .gitconfig in it is
   reachable from a tag GPG signed by <approved key>.

   Git's a distributed system, so while I don't think it's bad to have
   some feature like "I always trust config from this remote" (e.g. a
   corporate environment where you know its .gitconfig is
   guarded/audited) we should think about more distributed-friendly
   solutions first and if possible guide users towards those.

A. https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
