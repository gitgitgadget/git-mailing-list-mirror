Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0693FC433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 13:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbiEQNo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243712AbiEQNoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 09:44:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C5A4B41D
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:44:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j6so34763145ejc.13
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Mufed8BBKG9pPF3LXOC4rIA0/j3DXBjcQhMGDXAZb0c=;
        b=l04GP7vdIfS/v/tMMnA8yFzahGpRxZbKIRgLORsc1LMo/DqXiQQVjFMoRs0G6xjQes
         0UNS1PeKMAXhYD3Sn3UIR1nOc7fteQY9m5AzBY4muHXyZaii8jrBphX1g48eLJGL6/Ym
         jQQAVEIT6RWegAuIoL6JrrZSim1BslV3m8G9DZhHtE3hUIPx+gjTjvrU/Or/Oa/OxDT7
         HykjMZWx9RHdBnE2Fk3Q+1VrhndI68CAI2Gw/A30DDaTKxQKj4rsSKjF+qGov9bOdV0z
         o2vKE9MrPe3pIJcM3LC9vfCXA6xt8qTCiDVs+2lI6aL5AtY0/AQJphwN9vMSm3mhTiC2
         MYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Mufed8BBKG9pPF3LXOC4rIA0/j3DXBjcQhMGDXAZb0c=;
        b=uGM0YIzh5qJYATBpywEwjYetyxyyUMmaITq6rU0+fjnQf7kE1FgW26cMCyLHHIOjcM
         lOwA7jzt19VbkbvO37JUkzN6vlhDD2lnA+FxzVSE+EIveSBFH1GuwuR63U4ynorAPGlt
         0bgHnWKS8PuZb+AmekVMAl4T2Ca8+UWWxMa6BVAhjl0Rgx8ThDyUvyNHS4aOwiYtMvp7
         ueD/d+8VE3jGv5eY6AnGA+tvCSHdiZKzrfW6QfeXHLUTVkZgk4bcnsEZbVXJTHSqH4TU
         0f3dHKskAvD2osnCQRQAP1SNIEkUE1OxbI3djOSNHeThGEG1rd+MsrjvfQHSaSqMLeGa
         jF+A==
X-Gm-Message-State: AOAM530AlKemNO5anAw39MyCmRVBF8ffA6G5Mi1u+chK07czCW9GTYZi
        EbS6MHAquYpcnajZZxhSUek=
X-Google-Smtp-Source: ABdhPJxi+K9usg7EELDCi8g/Yvll8hs04GQzbBYF9B6Te3igP9VfCBs1A/MZjIILTHMG6W1yukLtkA==
X-Received: by 2002:a17:907:6d0a:b0:6f9:b861:82b8 with SMTP id sa10-20020a1709076d0a00b006f9b86182b8mr19761409ejc.478.1652795060968;
        Tue, 17 May 2022 06:44:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id og16-20020a1709071dd000b006f3ef214e12sm1028122ejc.120.2022.05.17.06.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:44:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nqxUp-001aZN-3g;
        Tue, 17 May 2022 15:44:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [Discussion] What is Git's Security Boundary?
Date:   Tue, 17 May 2022 14:55:24 +0200
References: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
Message-ID: <220517.86k0ak6zpo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 26 2022, Derrick Stolee wrote:

[Snip and just focusing on the "what to do with config" part of this]:

> Question: Is "protected" config _really_ more trustworthy?
> ----------------------------------------------------------
>
> This leads to an interesting question: Do we think that `~/.gitconfig`
> and `/etc/gitconfig` are "more trustworthy" than `.git/config`?
>
> I think that if an attacker has access to write to system or global confi=
g,
> then they have access to do more harm without Git. On the other hand,
> local config overrides the other config values, so local config can "unse=
t"
> any potentially-malicious values in system and global config. I don't
> think such "defensive config" is common.

I think this is a subset of areas where we rightfully piggy-back on FS
permissions, and should continue to do so.

I.e. we should trust /etc/gitconfig and the like because someone who can
modify it can modify /usr/bin/git anyway, so trying to defend against
anything in that area is pointless.

Yes we allow overriding that config, but that should be thought of as a
convenience, not as a nascent security boundary.

> Example Security Boundary Question: Unprotected Config and Executing Code
> -------------------------------------------------------------------------
>
> We have a lot of ways of executing external code from within Git. This is
> a key extensibility feature for customizing Git functionality. One way to
> do this is to create executable files in the $GIT_DIR/hooks/ directory.
> Git will discover these hooks and run them at the appropriate times.
>
> There are also many config options that specify external commands to run:
>
> * `core.fsmonitor=3D<path>` is executed before scanning the worktree for
>   created or modified files.
>
> * `core.editor` specifies an editor when writing commit messages, among
>   other user-input scenarios.
>
> * `credential.helper` specifies an external tool to assist with connecting
>   to a remote repository.
>
> * `uploadPack.packObjectsHook` chooses an alternative for `git pack-objec=
ts`
>   during `git upload-pack`.
>
> The list is actually quite long. This last one, `uploadPack.packObjectsHo=
ok`
> _does_ do a check for protected config: it does not allow its value to
> come from repository-local config.
>
> However, most of these options really do want to have customization on a
> per-repository basis, hence this proliferation of config options and
> local hook directories.
>
> I'm concerned that as long as we allow arbitrary execution to happen based
> on repository-local data, we will always have security risks in Git. For
> that reason, I'm interested in exploring ways to change how we execute
> code externally, even if it means we would (eventually) need to introduce
> a breaking change.

I agree that we should mainly be thinking of these config values that
directly execute something external, but as elaborated on below I think
any security solution that narrowly focuses only on these is on the
wrong path.

You can e.g. point git-send-email to hostile server, or disable its
SSL/TLS settings with config. Ditto HTTP settings to disable certificate
checking etc. etc.

You can also set transfer.fsckObjects=3Dfalse or one of the fsck.*
settings and open the door to fetching a payload which propagates a
known part CVE. But more below.

> The idea would be to allow repository-local customization by selecting
> from a list of "installed" executables. The list of "installed"
> executables comes from protected config (and the Git binary itself).

Most of this type of config doesn't point to a path to an executable,
but is a string we'll give to "sh -c" or equivalent. E.g. for editors we
couldn't naively add "emacs" to such a whitelist, as it supports
command-line options to evaluate arbitrary code.

How would your plan handle such cases?

> The plan I would like to put forward is to restrict all external execution
> to be from one of these sources:
>
> 1. Specified in system config (`/etc/gitconfig`).
> 2. Specified in global config (`~/.gitconfig`).
> 3. An allow-list of known tools, on $PATH (e.g. `vim`).
>
> Such a change would be a major one, and would require changing a lot of
> existing code paths. In particular, this completely removes the
> functionality of the `$GIT_DIR/hooks/` directory in favor of a config-
> based approach. This would require wide communication before pulling all
> support for the old way, and likely a 3.0 version designation. After the
> old hook mechanism is removed, the "safe.directory" protection from 2.35.2
> would no longer be needed.

Aside from any of the details of safe.directory & how we discover hook
it was my understanding per [1] that Johannes Schindelin disagreed with
this assessment of what safe.directory was for.

I.e. now the known vector is a hook, but in the previous off-list
discussions I'd proposed narrowing the new safe.directory error down to
handle that hook case only, but per the "cat being out of the bag" in
[1] there was concern about other non-hook issues being found.

Perhaps that assessment has changed, just noting it here for
completeness.

In any case, I don't think that we'd need to make the removal of
$GIT_DIR/hooks support in favor of config-based hooks a dependency of
any such proposal.

The current config-based hook proposal would allow you to exhaustively
emulate $GIT_DIR/hooks by defining all our hooks to those
paths. Therefore any security mechanism could surely consider the old
$GIT_DIR/hooks to be handled equivalently to however it would handle
that sort of config-based hooks configuration.

> At minimum, in the short term, this would affect the proposed design of
> config-based hooks.
>
> I think this is a good example to think about at a high level before going
> into the technical details. We can use it to test any proposed security
> boundary definitions to see if it lands on one side or another. Here are
> some points:
>
> 1. These config-based executables cannot be set in a full repository by
>    a "git clone" operation.
>
> 2. These config-based executables can be set in an embedded bare
>    repository, but the user needs to move deeper into the repository for
>    that to have any affect. This leads to some amount of social engineeri=
ng
>    being involved in the attack. See [4] for recent discussion on this.
>
>    [4] https://lore.kernel.org/git/Ylobp7sntKeWTLDX@nand.local/
>
> 3. If users are sharing a common Git repository, then if an attacker gains
>    control of one user's account, they can use the shared repository as an
>    attack vector to gain control of the other users' accounts. For this
>    case, do we consider the "safe.directory" config as an indicator of
>    "I trust this repo and all users that can access it _in perpetuity_" or
>    instead "I need to use this repo, even though it is owned by someone
>    else."
>
> 4. Git's dedication to backwards compatibility might prevent any attempt
>    to change how hooks are specified or config can be used to customize
>    its behavior.
>
> 5. The technical challenge of converting all possible execution paths may
>    be too daunting to ever feel the project is "complete" and be able to
>    confidently say "Git is safe from these kinds of attacks".
>
>
> Conclusion
> ----------
>
> I look forward to hearing from the community about this topic. There are
> so many things to think about in this space, and I hope that a lot of
> voices can share their perspectives here.
>
> Please collect any action items here at the end. I would love to add a
> doc to the Git tree that summarizes our conclusions here, even if it is
> only a start to our evolving security boundary.

This didn't make it on-list, but in the off-list discussion about
safe.directory I pointed out that this class of problem is something
Emacs has been dealing with for decades, and which we'd do well to try
to emulate. [2] below is the relevant part of my
<220303.861qzi3mag.gmgdl@evledraar.gmail.com> (sent on Thu, 03 Mar 2022
19:27:59 +0100), I also mentioned it in passing in [3].

The brief overview for it in Emacs's documentation is available here:
https://www.gnu.org/software/emacs/manual/html_node/emacs/Safe-File-Variabl=
es.html

I feel strongly that something like that is a much better direction to
go in than an approch that tries to narrowly classify only "dangerous"
config.

That sort of approach would basically do the reverse. We'd whitelist
"safe" config (e.g. diff.orderFile or whatever), and ask the user if
they're OK with using config that falls outside of the whitelisting.

By classifying our own config (and we'd probably need more than just
"safe" and "executes arbitrary code") the common case is that users
shouldn't need to answer those questions, as we'd know that the config
is safe.

This would be implemented by having a config mechanism "mark" which
area(s) of config are "safe". We'd only pay attention to such a config
from sources that area already "safe".

So, to begin with this addresses cases where e.g. a tool like git-annex
will execute arbitrary executables based on git configuration, which any
mechanism that marks only config git itself knows about won't be able to
do (it uses its own config space).

But it also extends this mechanism from being something *just* focused
on narrowly addressing security to something generally useful. E.g. even
if a repository on disk has "safe" config I might still want to say that
I don't want to use its alias.* config or whatever.

Whatever mechanism we end up with here, I think that now that the dust
has settled on the CVE we'd do well to consider those sorts of
problems.

A core.editor pointing to "rm -rf /" is a security issue, but any such
issues are just subsets of annoying third-party config doing something I
didn't ask for.

1. https://lore.kernel.org/git/220412.86h76yglfe.gmgdl@evledraar.gmail.com/
2.=20
	I know I've mentioned this before, including at past dev meetings, but I
	think that people interested in our whole config / repo reading ACL and
	"post-ACL" story should really look at how Emacs solves this problem.
=09
	Not just "yeah yeah, =C3=86var's blathering about Emacs again" :). It real=
ly
	is highly topical here, especially to the point that Johannes & Stolee
	are discussing about university setups. It's exactly the sort of setups
	it was aimed at. The problem space is essentially the same.
=09
	In brief summary. Emacs's implementation language and its "config
	format" are one and the same thing. It loads it from ~, and it can load
	it from a directory you're looking at, or even the file, or over the
	network.
=09
	For those familiar with "vim" it would be like its "expandtab"
	etc. "file variables" were really arbitrary C code that it would compile
	and dynamically load. Scary, I know.
=09
	I think what it does to do that safely is basically the same sort of
	security model we should be aiming for in git when it comes to reading
	the config format. In a roundabout way it's doing the same thing:
	potentially executing arbitrary code.
=09
	I wrote about this a while ago in the context of loading an in-repo (as
	in part of the repo content, a .gitconfig like we have .gitattributes)
	here: https://lore.kernel.org/git/87zi6eakkt.fsf@evledraar.gmail.com/;
=09
	I've mentioned it a few times on-list after, following that breadcrumb
	trail should lead to relevant discussions:
	https://lore.kernel.org/git/?q=3D%2F87zi6eakkt.fsf%40evledraar.gmail.com
=09
	The tl;dr is that we'd move to a whitelisting-based approach where (for
	example, the details could be tweaked):
=09
	 1. You could define in ~/.gitconfig (or other trusted "this is really
	    the user's") what files/paths you trust.
	 2. Anything not on the list we'd either ignore or prompt you the first
	    time about.
	 3. When you "trust" a "foreign" source we'd default to a narrow whitelist,
	    i.e. saying "this config defines these 5 variables at these values".
	    Is it OK to load those from this path?
=09
	    If the user says "yes" we'd write those answers to the ~/.gitconfig for
	    future reference. I.e. these config values at this path are OK.
	 4. We'd provide a way to run git commands that normally read config in a
	    way that completely ignores config, or that only trust "safe" config
	    (e.g. user.{name,email}, but nothing/little else). This could be used
	    for git-prompt.bash, git-completion.bash etc.)
=09
	 5. We could (perhaps by default) prompt you for the first time you read
	    config from a repo. Doing a "git clone" or "git init" would add a "this
	    is OK", but otherwise asking would cover e.g. wget-ing a tarred-up git
	    repo whose config is malicious.
=09
	Moving that sort of model would definitely break things, but hopefully
	in a way that wouldn't be too disruptive.
3. https://lore.kernel.org/git/220413.86fsmgeq15.gmgdl@evledraar.gmail.com/
