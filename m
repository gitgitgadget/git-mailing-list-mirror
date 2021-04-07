Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA40DC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C286121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDGWrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhDGWrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:47:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1DC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:47:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a25so7264364ejk.0
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ehhOqGuqYMdvtSrOqvSXfyo8VRzHTrKb+J/PHQU2S80=;
        b=F7KrluGNN37XY0HZdoY1NfiVpUQD4mWet21KwlzQQ/FdrINFVnHFoE8rUN0CgPRtpc
         h/2cmNtuDTDnnc9PgnCZ0cjZkLCcNFyXZEtwMZUuToSL9mUiKd5wwHMxrw5aciGhqSjO
         O8pKVrsXRAg8al1rupFTHOfX4ByaE8wHMBVZX5mRY2l6/MSD3SEHvvalw9i3JW4iAl7r
         dyD2J0yOkbi53IxF6821MzsS7zgN3qvH7/tjhCAcy0xCENw1VLnesDGRRZVkdjpqmfhw
         RQIPNiXA9S3nijPNBNg5YG6EbYXJ0iGR7UXsC0y5mjfMpt8qrD/o2RBYxEHcqdCgEY1D
         tXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ehhOqGuqYMdvtSrOqvSXfyo8VRzHTrKb+J/PHQU2S80=;
        b=KJZ5O2FDCYEJWaBRZeNwynjMu0VEg3e2B/vZ2jsDoVRVcvlffvs66Dlh7UrNnLKJkU
         UGf9DCklY8Xnz6aupOH70QSK52jO9e6lx5FdAjWL2dcgHAUsbyZWmOqiFgmsjd1yx0aZ
         40nhEhYBE1Nc/JBIQaj0NABD6/yuYzLU18zdbFZNMT9bFlEYUISLoo1oGUFbFLONA718
         chy2WNfjkQvjwd3OauQ2mCUAmsH23vS2OLBxENvRIElnBL2BaYzU7gSZ/3i5L8YsUhcw
         oxUrik2QLy/omlUyudrqeMDpDSVr44qdA7GiHKzRY/Ag5zI3dmSjE4oCKOoVDYVgP1/7
         U7Sw==
X-Gm-Message-State: AOAM53156TtrrRapRgoG/BmeoQr1OYZi2963zXMKRfEMNY2YZCeuAXx1
        CSegmrjZzFDSaRmMMAL3ADQ=
X-Google-Smtp-Source: ABdhPJz89lLRfFLvpn05ni9qy67HcsdBapj7UXKKIs0k5LM0TbsrBn0j/eD4rPqRv+NkXXSGyYfvlQ==
X-Received: by 2002:a17:906:d796:: with SMTP id pj22mr6548392ejb.32.1617835626299;
        Wed, 07 Apr 2021 15:47:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x4sm15864698edd.58.2021.04.07.15.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:47:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Albert Cui <albertqcui@gmail.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <87im5nzbe6.fsf@evledraar.gmail.com>
 <CAMbkP-SX2PvjWaNGfO4YUVaWHhAr_KHb170sb_pp8_CiSydQFg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAMbkP-SX2PvjWaNGfO4YUVaWHhAr_KHb170sb_pp8_CiSydQFg@mail.gmail.com>
Date:   Thu, 08 Apr 2021 00:47:05 +0200
Message-ID: <874kghk906.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 06 2021, Albert Cui wrote:

> On Fri, Mar 19, 2021 at 3:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> On Thu, Mar 18 2021, Albert Cui via GitGitGadget wrote:

Not replying to everything here for lack of time, might need to loop
back to this, please headsup me if there's outstanding things you'd like

>> As noted in the proposal I linked I think anyone thinking about this
>> would do well to examine the trade-off Emacs's implementation of this
>> uses, since it manages to safely open arbitrary files that'll
>> potentially run arbitrary code on-open, but only if the user opts-in.
>>
>
> In [0], I proposed only allowing pre-clone opt-in to suggested hooks
> if allowlisted in the config for the given remote, which seems similar
> to your previous proposal. Extending this idea to any config settings
> seems very reasonable. I'd love other people's thoughts about this.
>
> In your proposal, you wrote:
>
>> It would work really well with includeIf, e.g. I could clone all my work=
 repos to a "safe" area in ~/work which is allowed to set more options, e.g=
. aliases.
>
> It seems much safer to do this for a given remote, opposed to a local
> file path, no?

Yes, probably. I don't think I thought much about it at the time.

>> > +Later, we might want to do this before the initial clone is performed=
; that
>> > +workflow looks like:
>> > +
>> > +* During clone, perform ls-refs as normal
>> > +
>> > +* If the server has a "magic" config branch, fetch only that config b=
ranch.
>>
>> ...the reason for the magic branch is this before-clone use-case?
>>
>> Unless there's a really strong use-case for that I'd think the
>> per-branch .gitconfig would be a better trade-off, but even then there
>> would be ways to make that work obviously in the many-many case, and
>> still e.g. have a branch advertise a config blob for its "main" branch
>> as a special case or something.
>>
>> I also suspect an unstated constraint of having this in a magic branch
>> is the limitation of some git hosting provider's ACL
>> implementations. More on that later...
>>
>
> Mentioned in [0], the primary motivation for a magic config branch
> that lived outside of the worktree was "since the configuration is
> separate from the code base, it allows you to go back in history or to
> older branches while preserving "improvements" to the hooks
> configuration e.g. maybe the project has shifted to using a newer
> version of a linter."

It also means that your hooks will forever need to be aware of the union
of all revisions in the project to work properly, or more likely they'll
simply break on older revisions as e.g. a hook that needs to handle a
test directory handles just "t", but it used to be called "tests".

It's also just un-git-y in *requiring* a remote. A .mailmap,
.gitattributes etc. all work with a repo you find on-disk, why does
config & hooks need to be different?

How would a user of such a repo suggest changes to a hook? Now it's
fairly easy for e.g. .gitattributes, you change it, push a branch, ask
for it to be merged etc.

If you want the same hook for all revisions ever having some light logic
in the hook itself to check/cache that (it's executing arbitrary code
after all) seems like a saner thing for those who have this "magic
branch" use-case than to make it the default.


> [...]
>> > +Future Work
>> > +~~~~~~~~~~~
>> > +
>> > +* Extending this to allow repository owners to specify specific confi=
gurations
>> > +in general e.g. this repository should use partial-clone with these p=
arameters.
>>
>> I don't see why such a proposal should narrowly confine itself to hooks.
>>
>> Once we have config-based hooks then hooks are just configuration.
>>
>> If we're going to pick up arbitrary configuration from remotes/repos on
>> request then we'd be starting with the most dangerous configuration.
>>
>
> Summarizing from [0]: Based on this feedback, I'm hearing "we should
> have a design for suggested configuration in general," but I don't
> think that necessitates that we should pursue generic configuration
> before hooks configuration.

It's the principle that if we think you might stab your eye
accidentally, maybe we should start with a plastic fork instead of going
directly to a lightsaber :)

I.e. hooks are a *lot* more dangerous to get wrong. I think this sort of
proposal would be better received if it started with a small whitelist
of our least dangerous (but still useful to set in-repo .gitconfig)
config variables. Then the worst thing that'll happen is you'll confuse
git-diff a bit, not an RCE.

>> I think a better way to start such an effort incrementally would be:
>>
>> 1. Audit git's config parser for the safety of parsing arbitrary config,
>>    we parse .gitmodules now, do we feel it's safe enough to parse
>>    arbitrary config (probably, but worth checking).
>>
>> 2. Add reflection to git's own config variables. Right now we have this
>>    in the binary generated via a grep from the documentation. Similar to
>>    Emacs's implementation we should/could categorize all our known
>>    config variables by safety.
>>
>
> To clarify, are you saying, today, git's config variables are pulled
> from the documentation? I.e. the documentation is the source of truth
> for what config variables are supported? o.0

Yes, see generate-configlist.sh.

But we don't hard round-trip it, and we couldn't have an exhaustive list
anyway due to things like userdiff, sendemail.identity etc.

But I'm mentioning it because the next logical step from there is to for
some/most pre-declare them, and at that point it could be some struct
that lists the danger level of each one, and from there whitelisting
them for in-repo .gitconfig would be a logical next step...

>>    Hooks are the least safe, something like a diff.context=3DN setting t=
he
>>    repo wants to suggest a -U<n> setting much safer (just tweaking our
>>    existing diff algorithm) etc. But even in those cases we'd want to
>>    proceed slowly, e.g. is that config parsing for that -U<n> defensive
>>    enough to be safe for arbitrary data?
>>
>
> To clarify, this proposal is just to set the hooks config that
> config-based hooks enabled e.g. running `git config --add
> hook.pre-commit.command pylint` on behalf of the user, so I'm not sure
> what "arbitrary data" you're referring to. At least, any problems I'd
> think we'd already address with config-based hooks.

As noted by brian m. carlson etc. in the side-thread in
<YGzrfaSC4xd75j2U@camp.crustytoothpaste.net> the danger is that by
making this a supported feature git becomes the social-engineering
vector to fool users into trusting a command like that which they
otherwise might not have.

>> 3. Users should be able to e.g. configure "yes, for any repo I clone
>>    they can tweak 'safe'" variables. This would reduce user dialog
>>    fatigue, and thus increase safety. I.e. a repo who wants to set a
>>    thing like hooks would stand out, but something that e.g. wants to
>>    change the diff order would pass on existing global configuration.
>>
>> 4. Smarter ACL that magic remote+magic branch: It seems like an obvious
>>    thing to me to want that if I clone e.g. a random clone of git.git
>>    that I'd want to setup config for it IFF the .gitconfig in it is
>>    reachable from a tag GPG signed by <approved key>.
>>
>>    Git's a distributed system, so while I don't think it's bad to have
>>    some feature like "I always trust config from this remote" (e.g. a
>>    corporate environment where you know its .gitconfig is
>>    guarded/audited) we should think about more distributed-friendly
>>    solutions first and if possible guide users towards those.
>
> This seems like an OK alternative to allow-listing based on remote,
> but are you expecting users to add a GPG key to their .gitconfig?

That instead of saying you trust https://github.com/git/git your primary
means of interaction with this feature would be saying you, as an
example, trust Junio's GPG key.

And if you clone a git.git from *anywhere* and have already opted-in to
whatever scary config we'd expose for tihs we'll trust and setup the
hooks, if and only if they're identical to hooks we can find that were
last signed by the trusted GPG key.

> Remote URLs seem much more user friendly (think IP address vs URL).

Git is content-addressable, something that caters directly to that is
more consistent and user friendly than something that makes URLs magical
as a model for trust.

If I want a trusted kernel I don't really care what URL I clone
linux.git from, I care that I can resolve the content to something Linus
signed.

So if I trust Junio's key and would like this to Just Work it would be
better if I clone a mirror of git.git that it works, and I don't have to
maintain a list of all mirrors myself. Trusting based on content and GPG
keys gives you that, magic URLs don't.

It seems to me that in the BigCorp use-case this would also be
useful. Presumably you just want blessed reviewed hooks to execute
arbitrary code on your laptop, but if your co-worker forks a repo and
has control of your magic branch you don't want to setup the potential
harmful RCE. They might have malicious hooks.

But that's also annoying because in your BigCorp repo you'll presumably
want the hooks to check/validate/whatever. Just because you cloned a
fork you'd still like that.

If you trust (signed) content instead of URLs you can have your cake and
eat it too. As long as your co-worker didn't modify the hook config in
his fork it'll Just Work.
