Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CA7C433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6652D619AB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhC3PYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3PYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:24:33 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D790C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:24:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso15921365oti.11
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hAP8AMK3/CnfkaeEgGmqtNq7bKyi/ZmXqtvOip4+aCo=;
        b=QETIPu+Z+nZcqrUkMOLKQjzOgN9hcv1oq/anY6KX2nEaglpK1TH8lT+kADTGGEvB3m
         bVyiyTvhWHXTjT5V67HTDBA+3yZVXDj7uIN15Zu6XFig58ZUh6sLDBmM8wBoq0RPMOWx
         wKMPBMzdI3GYz3J/ISowTCyn8HCQk+W7EzDxrtl4TLyeWRzy9Jn0hhhIqZbghYF+SsTF
         BzVSdwuUZmvriiHrPNK/hBkHCmuNTPBqS6IZoz1IQAkCQiNhYDZUCUEVD9o16R+nyydh
         DuGuThkRkcExXW8Bsc8wilpveQsOF+2LvnZsDIoo5NCW5AGxJhPAbPLDjcK0/cS7/Ak3
         RwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAP8AMK3/CnfkaeEgGmqtNq7bKyi/ZmXqtvOip4+aCo=;
        b=BwQItVSnNM49GQmHvputh4lUPZKHEZY22IOQ++gWWFJGtv9SPe5KZCD5DL6o5Du7Sh
         FsJVzCvVwKvG0hnpBpw3bME2gOfbzj9gM+NerZwCJGt+iA1v8bCg1QCEzhFF2u9GNmr1
         Jy349Y8FG06+9gi2yMHwwxStwY0JhOkIYXhAehUxHiIDeTJLRcfkGhB6VqVh4rz6d2od
         DMWKheLBjX8fXn9vxuTOHErFk/0TyItd1iwCHLhO+ObzGMOp0FBtTvG+z3GICccMMI9c
         OO468bPPa9m7x2GFQSRoALr3zxBzL1ROEsRH70xKyLAjAnMEoSd3sIQY/K2koPXtLIp6
         eSPA==
X-Gm-Message-State: AOAM532hJfsx/YWkKo+0vcEVy21Dyu2cOukidfgn6whesTT/surLIndN
        0W+Os8ugS9fio1X0S03Jlps=
X-Google-Smtp-Source: ABdhPJytul4PBwjjC6PP5l7hNqIDlbbsYeJk5ujkar6WuiY1HVNR/ifBEaozamfas7A9Ke0CDQICjQ==
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr27278263otq.260.1617117872381;
        Tue, 30 Mar 2021 08:24:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id 9sm4127272oid.17.2021.03.30.08.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 08:24:31 -0700 (PDT)
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Albert Cui <albertqcui@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
Date:   Tue, 30 Mar 2021 11:24:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2021 9:43 PM, Albert Cui via GitGitGadget wrote:
> From: Albert Cui <albertqcui@gmail.com>
> 
> Hooks today are configured at the repository level, making it difficult to
> share hooks across repositories. Configuration-based hook management, by
> moving hooks configuration to the config, makes this much easier. However,
> there is still no good way for project maintainers to encourage or enforce
> adoption of specific hook commands on specific hook events in a repository.
> As such, there are many tools that provide this functionality on top of Git.
> 
> This patch documents the requirements we propose for this feature as well as
> a design sketch for implementation.

Sorry for being so late in reviewing this.

My first reaction is that this feature is suggesting multiple security
vulnerabilities as core functionality. It also seems to be tied to
niche projects (in number of projects, not necessarily the size of those
projects).

I was recommended in conversation to think of this as a way to take
existing ad-hoc behavior and standardize it with a "Git-blessed"
solution. I'm not sure this proposal makes a strong enough case for
why having a "configure-hooks.sh" script in the base of the repo is
not enough. It simultaneously does not use existing precedents like
.gitattributes or .gitignore as direction in using the worktree at
HEAD as a mechanism for communicating details. I find using a separate
ref for hooks to be a non-starter and the design should be rebuilt from
scratch.

I also expect that a significant portion of users will see a message
like "this repository needs hooks" and will just say "yes" to get rid
of the prompt. There needs to be sufficient opportunity for users to
inspect the hook configuration and avoid frustrated or distracted users
from doing the wrong thing.

Server-side checks should always exist, so users who don't follow the
project's guidelines using the recommended hooks will be blocked. The
important thing is that there is an easy way for willing participants
to install the correct hooks. This doesn't mean we should make it
almost automatic.

Also, please proactively pursue a security review of the feature,
including non-technical risks such as social engineering, forks, or
other possible attacks. This idea seems so risky that I would be
against accepting it unless a security expert has done a thorough
review.

> +We propose adding native Git functionality to allow project maintainers to
> +specify hooks that a user ought to install and utilize in their development
> +workflows.

I think providing a way for repository owners to _recommend_ how cloners
should interact with the repository is a good idea. I think starting with
hooks is perhaps a significant jump to the most complicated version of
that idea.

As you think of this design, it might be good to think about how some
recommended Git config (within an allow-list) might fit into this system
as well. I would have started there, with things like "Use partial clone"
or "use sparse-checkout". Those are really things that need to happen at
clone time, they can't really happen after-the-fact, which helps justifying
a modification to 'git clone'. The hook configuration doesn't _need_ to
happen during 'git clone'. More on this timing later.

The .gitattributes file is the closest analogue I could find in current
functionality, but it operates on a path-based scope, not repository scope.

> +Server-side vs Local Checks
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
...
> +In the ideal world, developers and project maintainers use both local and server
> +side checks in their workflow. However, for many smaller projects, this may not
> +be possible: CI may be too expensive to run or configure. The number of local
> +solutions to this use case speaks to this need (see <<prior-art, Prior Art>>).
> +Bringing this natively to Git can give all these developers a well-supported,
> +secure implementation opposed to the fragmentation we see today.

I'm not sure this is a good selling point for small projects. If they
are small, then the CI to verify commits is cheap(er).

Local hooks should never be used as a replacement for server-side checks.
A user could always use a repository without the local hooks and push
commits that have not been vetted locally. The extreme example is to have
a commit hook that compiles the code and runs all the tests. Would you
then remove all CI builds?

Making it easier to adopt local hooks can avoid some pain points when
users are blocked by the server-side checks.

> +Server-side vs Local Checks
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
...
> +User Goals / Critical User Journeys
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
...

I appreciate the motivation in this document. However, the motivation
doesn't really justify why this should be baked into Git itself, since
a "configure-repo" script in the base of the repo would suffice to
achieve that functionality.

The reason to put this in Git is to standardize this process so it
is not different in each repository. It might be good to spend time
justifying that angle.

> +Security Considerations and Design Principles
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +We must balance the desire to make hooks setup easy for developers --- allowing
> +them to get hooks set up with low friction, and hence increasing the probability
> +of them adopting these hooks --- with protecting users from the security risks
> +of arbitrary code execution on their hosts.
> +
> +To inform the design, we propose these design principles:
> +
> +* User consent: Users must explicitly agree to hooks usage; no hooks should
> +execute without consent, and users should re-consent if hooks update. Users can
> +opt-out of hooks.
> +
> +* Trust comes from the central repository:
> +  ** Most users don't have the time or expertise to properly audit every hook
> +  and what it does. There must be trust between the user and the remote that the
> +  code came from, and the Git project should ensure trust to the degree it can
> +  e.g. enforce HTTPS for its integrity guarantees.
> +
> +  ** Since developers will likely build their local clone in their development
> +  process, at some point, arbitrary code from the repository will be executed.
> +  In this sense, hooks _with user consent_ do not introduce a new attack surface.

It is critical that users are presented with this consent at the correct
times. For instance, I believe configuring local hooks should only be
done _after_ "git clone" completes. That allows a user to inspect the
worktree to their content instead of in the middle of an interactive shell
session or something. (The "git clone" command could output a message to
stderr saying "This repository recommends configuring local hooks. Run
'git <tbd>' to inspect the hooks and configure them.")

We've had enough code-execution bugs with "git clone" that I want to
completely avoid that possibility here.

> +* Give users visibility: Git must allow users to make informed decisions. This
> +means surfacing essential information to the user in a visible manner e.g. what
> +remotes the hooks are coming from, whether the hooks have changed in the latest
> +checkout.

As a user moves HEAD, we should similarly avoid updating the hooks
automatically, but instead present a message to the user to update their
hooks using an intentional command.

> +    ** This could be a path to a script/binary within the repository

Binaries will be tricky if you want users of multiple platforms to
interact with your repository. And scripts can be slower than binaries.

How could someone build hooks from source using your workflow? Perhaps
users are expected to locally compile the code before configuring the
hooks?

> +    ** This could be a path to a script/binary contained within submodules of
> +    the repository

This gives me significant chills. Proceed with caution here.

I understand the reason to want this feature: you could have a suite
of repositories using a common hook set that lives in each as a
submodule. I just want to point out that this adds yet another
dimension for attack.

> +    ** This could be a user installed command or script/binary that exists
> +    outside of the repository and is present in `$PATH`

Like `rm -rf ~/*`? I'm trying to think of dangerous things to do without
elevation. It could help here to clarify the intended user pattern here:
"This repository requires that you install tool X." This seems unlikely
to be necessarily true at clone time, so the users will have a broken
state if they don't run some extra steps. How will that be communicated?

Requirements like these make me think that these repositories would be
better off with a script that configures the hooks after checking if
these things actually exist on the PATH (and installs them if not). I
would lower the priority of this one for now.

> +* This configuration should only apply if it was received over HTTPS

Avoiding http:// and git:// makes sense. Why not SSH?

> +* A setup command for users to set up hooks
> +
> +    ** Hook setup could happen at clone time assuming the user has consented
> +    e.g. if `--setup-hooks` is passed to `git clone`

This is not enough consent.

> +* Users must explicitly approve hooks at least once
> +
> +    ** Running the setup command should count as approval, including if the user
> +    consented during the clone
> +
> +    ** When a hook command changes, a user should re-approve execution (note:
> +    implementation should not interfere with requirement listed in “Fast
> +    Follows")

Users should explicitly approve hooks any time they would change.
They should also be able to explore the source of the change using
whatever editors and tools they want, so the worktree should change
to its new state without new hooks, _then_ the user could consider
updating hooks based on that new state.

> +Fast Follows
> +^^^^^^^^^^^^
> +
> +* When prompted to execute a hook, users can specify always or never, even if
> +the hook updates

I don't understand what this means. "when prompted to execute a hook" are you
saying that the user will get a message saying "Git will now run the pre-commit
hook, are you ok with that?"

"even if the hook updates": I've made my stance clear that the user should be
in complete control of when the hooks update.

> +Out of Scope
> +^^^^^^^^^^^^
> +
> +* Ensuring the user has installed software that isn't distributed with the repo

If you are going to allow hooks to run something on the PATH, then Git
should probably check that such an executable exists before setting the
config and causing problems.

> +Implementation Exploration: Check "magic" branch for configs at fetch time
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Example User Experience
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +===== Case 1: Consent through clone
> +
> +....
> +$ git clone --setup-hooks
> +...
> +
> +The following hooks were installed from remote `origin` ($ORIGIN_URL):
> +
> +pre-commit: git-secrets --pre_commit_hook
> +pre-push:  $GIT_ROOT/pre_push.sh
> +....

Nope. I think this workflow is a non-starter.

> +===== Case 2: Prompting after clone
> +....
> +$ git clone
> +...
> +
> +Remote `origin` ($ORIGIN_URL) suggest installing the following hooks:
> +
> +pre-commit: git-secrets --pre_commit_hook
> +pre-push:  $GIT_ROOT/pre_push.sh

Yes, this works for me.

> +# instead of prompting, we could give users commands to run instead
> +# see case 3
> +
> +Do you wish to install them?
> +1. Yes (this time)
> +2. Yes (always from origin)
> +3. No (not this time)
> +4. No (never)

I'd rather see the installation as a separate step. That gives more
weight to the users' consent. Even if you do have a prompt here that
says Yes/No, *do not* include "always from origin".

> +===== Case 3: Re-prompting when hooks change
> +....
> +$ git pull
> +
> +The following hooks were updated from remote `origin` ($ORIGIN_URL):
> +
> +pre-push:  $GIT_ROOT/pre_push.sh
> +
> +If you wish to install them, run `git hook setup origin`.

Good. Stop here. Perhaps also describe this as something that happens
with "git checkout" because it matters when HEAD updates, even if the
commit was fetched earlier.

> +===== Case 4: Nudging when hooks weren't installed
> +....
> +$ git commit
> +advice: The repository owner has recommended a 'pre-commit' hook that was not run.
> +To view it, run `git show origin/refs/recommended-config:some-pre-commit`. To install it, run `git hook setup origin pre-commit`
> +
> +Turn off this advice by setting config variable advice.missingHook to false."
> +....

These nudges seem like a good pattern, especially with the advice config.

> +Implementation Sketch
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +* Perform fetch as normal
> +
> +* After fetch is complete, Git checks for a "magic" config branch (e.g.
> ++origin/refs/recommended-config+) which contains information about config lines
> +an end-user may want (including hooks).

I think this is the wrong direction to go. You are recommending a few things:

1. Some branch names are more special than others.
2. Hooks live in a separate history than the rest of the repository.
3. Users cannot inspect the hooks in their worktree before installation.

Instead, think about things like .gitignore and .gitattributes, as they can
change as the repository changes. Make a special _filename_ or directory:
for example ".githooks/".

> +* As part of the fetch subcommand, Git prompts users to install the configs
> +contained there.

Prompt users that they are available and can be configured using another
command.

I summarized my thoughts at the top.

Thanks,
-Stolee
