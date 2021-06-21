Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A946C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB8B61153
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhFUUHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUUG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:06:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C8C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:04:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hq39so3742549ejc.5
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=E9VbTfT7VbxM8RPr/J2i8gaoC4291M6DJvPFNnEgS8E=;
        b=HoFV3hvVGgqO4Y17Z8E15SdddRPf6HyQUHdV9VFb7UdbpWaJdHuymxQah/s1yVpm9/
         I5PU/u2mHZ1FN0VJYdW+yIWKE6OQWYVVUDWi9DxZx02bvJ7nNjmrGJS39b8Jmbetr4Kc
         w5GjFcCGTsgCev2GLnvPOouowX8rewSxIitCy4UflDIMq176tOazqZtxA69xm2dlybjL
         F4iJ/NnVxqwfeW5XDqiBISXsLf+ZzKn+XOZcrh0G51x3laBPX9P7YG97t2W0GI9Mq1iS
         h8Xpfw+v8UGhbcQDHfKXC3dZeQes26fng644J2+i9kVwcJkMHBl36l+7xPCJgDYfT9Xt
         NLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=E9VbTfT7VbxM8RPr/J2i8gaoC4291M6DJvPFNnEgS8E=;
        b=nWI+qczRLkMExetK4lhBCYQMtjfNDdNcZg9tIfyI3RQUusqUBkiU5g1m12QbVdv8Vu
         gaTacoD2NRO4O+LO2hrtuQNbya5okZfecks+nigGWB3mdP4ZJCHyt8LdMVN5rreBk215
         e7C316jvRXO6EVoN4MV22g4PqksmGg3jJqEXNVYfzpRWR9uzVKFeJ68J10tTttemQkTv
         sax2EpPckZXUAl0G0T+YxUt3WTdLcu/+WGcSphZbj3ROVufN3tMuh0hgiem04X53cYEZ
         F8A9EmORxMDsfxWpgN+og4xZzrLVp/fyFBQoIYm/1bZmsueO+s5jiLXaG1P/dMaoMuvT
         fVLg==
X-Gm-Message-State: AOAM530CQLRL2QZWNLy3pcv7CqoNJtQ2JFzfItXdoesHooPApjaV7OOm
        tkhwFT9IxMkp2IGmWA8QUvQWOsqOP0YXeQ==
X-Google-Smtp-Source: ABdhPJwHju6z/QaRREJExjTnQr0G9f8WPwBiQwdQwTpVEAYVx6lOEoUJj2ePk7rE+eDG7wqMpU388Q==
X-Received: by 2002:a17:906:1982:: with SMTP id g2mr26761071ejd.184.1624305881981;
        Mon, 21 Jun 2021 13:04:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p17sm1383686eds.92.2021.06.21.13.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:04:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
Date:   Mon, 21 Jun 2021 21:35:06 +0200
References: <87fsxc47le.fsf@evledraar.gmail.com>
 <20210621185858.1169385-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210621185858.1169385-1-jonathantanmy@google.com>
Message-ID: <87k0mn2dd3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Jonathan Tan wrote:

>> On Wed, Jun 16 2021, Jonathan Tan wrote:
>>=20
>> > This is a continuation of the work from [1]. That work described the
>> > reasons, possible features, and possible workflows, but not the
>> > implementation in detail. This patch set has an MVP implementation, and
>> > my hope is that having a concrete implementation to look at makes it
>> > easier to discuss matters of implementation.
>>=20
>> My C on this RFC is:
>>=20
>> 1) A request that someone reply (there or here would do) to my comments
>>    on the last iteration of this at:
>>    https://lore.kernel.org/git/874kghk906.fsf@evledraar.gmail.com/
>
> OK - I'll take a look at that.
>
>> 2) I think you'd get better feedback if you CC'd the people who've been
>>   actively discussing this in previous rounds.
>
> Good point.
>
>> > Design choices:
>> >
>> >  1. Where should the suggested hooks be in the remote repo? A branch,
>> >     a non-branch ref, a config? I think that a branch is best - it is
>> >     relatively well-understood and any hooks there can be
>> >     version-controlled (and its history is independent of the other
>> >     branches).
>>=20
>> First, unlike brian I don't (I hope I'm fairly summarizing his view
>> here) disagree mostly or entirely with the existence of such a feature
>> at all. I mean, I get the viewpoint that git shouldn't bless what
>> amounts to an active RCE from the remote.
>>=20
>> I just think that we could probably do a better job of it than what
>> people are doing in practice, and I've seen people do stuff like have
>> build systems setup permanent symlinks to git-hooks/<some-name> in the
>> tracked dir. We could at least envision a git-native implementation
>> asking the user "do you want this hook update? <shows diff>".
>>=20
>> I just find this design approach completely bizarre as noted (probably
>> in less blunt words) in the linked E-Mail.
>
> That's fair. You suggest an alternative below (and maybe more in the
> linked e-mail) - let's look at your suggestion...
>
>> We have Emily's series to convert hooks to be config driven that we hope
>> to land in some form, at that point they won't be any more of a special
>> snowflake than any other config.
>>=20
>> And then, instead of doing what I'd think would be the natural result of
>> that: Simply supporting an in-repo top-level ".gitconfig" file. We're
>> still going to seemingly forever have them be an even more special
>> snowflake with this facility, and the reason seems to be mostly/entirely
>> to do with working around some aspect or restriction of Google's
>> internal infrastructure.
>
> I don't think that this is "natural". In particular, I still don't think
> that hooks should be tied to code revision. E.g. if we make commits
> based on an old revision and push them, we still want them to follow the
> latest requirements.

Even for real-world centralized workflow situations where I've seen
people think they want that, and the end of the day they almost never
actually want that.

Even something like code linting is a good example, to make it
Google-specific: say for a Go project: Are you going to pin your linting
tool/version to whatever understood your YAML format for the linter as
it was specced 10 years ago when the project started?  It's simply a
giant hassle to have a piece of code operate on every version of your
project ever in a way that doesn't break.

I think in practice the designers of this feature don't actually have
that in mind, but a "close to trunk" workflow, where you'd expect a hook
to only need to operate on revisions for the last few weeks or months,
because that'll be the oldest think people create new topics from.

But I think the burden of proof is really on the other side here,
something that works entirely differently than the rest of git needs to
have a good reason. Our in-repo .gitattributes don't work like this, nor
.gitignore, .mailmap etc.

There's also real world uses of git where the "branches" are wildly
divergent, e.g. I've worked on a system automation repo where the
"master" was just a stub template, and every team had their own almost
entirely different "repo-like" branch. Probably a bad idea for various
reasons, but Git supports it just fine.

For the centralized use-case what's the problem with just having the
hook do a 'for-each-ref --format=3D' invocation or "cat-file --batch" on
the "origin", and eval what it finds there? I'd think that gives you
what you want for the more centarlized workflow, while leaving git's
implementation working like the rest of our in-repo files.

>> I think it's just un-git-y to have a meta-branch that in some way drives
>> not only all other branches, but all other revisions of all branches,
>> ever.
>>=20
>> It breaks expectations around git in lots of different ways, you can't
>> fetch a single branch and get its hooks,
>
> Are you saying that each branch should have its own hooks? That might be
> reasonable in certain projects, but I don't see how that is a Git
> expectation.

It's a git expectation now that I can add git.git as a remote, also
chromium.git, and linux.git, fetch them all, and happily switch in the
same repo between entirely different codebases that don't share a
history.

>> you can't locally alter, commit
>> and update your hooks while e.g. renaming a "t/" directory to "test/";
>> your hooks and code can't be atomically changed).
>
> I still think that hooks should work independent of code versions, so I
> wouldn't think that atomicity here is important.

Covered above.

>> I think I get why you want to do it that way, I just don't get why, as
>> mostly noted in those earlier rounds why it wouldn't be a better
>> approach / more straightforward / more git-y to:
>>=20
>> 1. Work on getting hooks driven by config <this is happening with
>>    Emily's series / my split-out "base" topic>
>> 2. Have a facility to read an in-repo '.gitconfig'; have lots of safety
>>    valves etc. around this, I suggested starting with a whitelist of the
>>    N least dangerous config options, e.g. some diff viewing options, or
>>    a suggested sendemail.to or whatever.
>
> I've replied to this above.

Not really, even if we went for this one-HEAD-version-to-rule-them-all
plan wouldn't it make more sense to generalize it as a
refs/remotes/origin/magic-config, and we'd discover a ".gitconfig" file
under that commit/tree.

I.e. whether we generalize this to config in general is orthagonal to
whether such config lives in HEAD or in a magic ref.

With hooks as config I don't see how you'd make any of this
hook-specific, there's other config where the "every revision ever"
applies much more strongly, e.g. sendemail.to. If that changed for this
project tomorrow you wouldn't want a patch based on "maint" to send
things to a different ML.

>> 3. Work our way up to trusting that for more dangerous stuff, eventually
>>    hooks. Most of the legitimate concerns from others with this is
>>    having some UX where our users won't be trained to just blindly say
>>    "yes" to an alias/hook config that "rm -rf's /" or whatever.
>>=20
>>    If we start experimenting with that with aliases or hooks that can
>>    run arbitrary code it's like handing a toddlder a shotgun, let's at
>>    least start with a sharp fork or something (less dangerous config) :)
>>=20
>> 4. People who want this "I want my hooks to apply to all revisions ever"
>>    could probably get 99% or 100% of what they want if their hook is
>>    just a stub that does the equivalent of:
>>=20
>>        sh `curl https://git.google.com/$reponame/hooks/$hookname`
>>=20
>>    You'd then simply forbid on your servers any changes to a .gitconfig
>>    that did anything with the hook.* namespace.
>
> This would work if set in .git/config (not version controlled), but not
> .gitconfig (version controlled).

Sorry, what wouldn't work? I meant you'd forbid pushes to your in-repo
.gitconfig in your "master" branch or whatever, just like you're
presumably planning some stronger ACLs for this magic hook branch.

>> With such an implementation you don't need a magic
>> "refs/remotes/origin/suggested-hooks" refs, just some state machine (I
>> suggested e.g. GPG signing chains as an eventual end-state, but "show a
>> diff every time" would also do) that keeps track of what config (and
>> hooks are just one such case) has been OK'd, and which has not.
>
> This sounds complicated.

On the contrary I think anything that leans into git's
content-addressable security model is way less complicated. You don't
care who you fetched Junio's v2.32.0 tag from, what matters is that the
signing chain validates.

The plan of having this magic branch means a whole new trust model for
git, you trust magical authorized remotes. If you trust signed content
chains you can trust hooks if their last modification can be traced to a
signing authority you trust.

    It's really just:

        if (hook_content_changed() && hook_content_same_as_in_ok'd_revision=
_from_upsteam())
            trust_hooks();

But while we're on the subject, it seems like a very generous assumption
to think that just because you trust hooks at a given revision (or
always trust the latest), that you implicitly trust them when *combined
with* all past and future revisions from the same repository.

Even without a malicious actor that seems like it'll inevitably break in
all sorts of data-destroying ways. E.g. people commit stuff
accidentally. A hook run under a "git bisect" that na=C3=AFvely does an "rm
*" will eat your data if you land on a revision that an in-tree "-rf"
file.

But once you get to a malicious actor who can say push a topic branch
but not hook updates, will your hooks deal with files with whitespace in
them, arbitrary crafted content etc?

So I'd think that's an even better reason to prefer the in-repo
per-revision atomically committed plan, and only trust hooks for the
revision they're shipped with, at least as a default git security model.

>> I'd think it would even work better in the Googleplex, you could clone a
>> co-worker's branch and execute their hooks, since they're the same as
>> what you've pre-approved,
>
> In the presence of .gitconfig, how would you know?

If it's the same config, or you can automatically OK it. So "same" was
discussed above, or you could trust any hook that's only doing a wget of
some trusted domain and piping that to "sh".

>> you could even clone some random person's fork
>> of a "blessed" project, because the hooks would be the same `sh $(curl
>> <url I already trust>)`. That validation could even be a system-level
>> in-config hook on your laptop, thus bringing the whole thing full
>> circle...
>
> Same here.
>
> In summary, I think your point of using hook configs + remote-suggested
> configs instead of remote-suggested hooks is a reasonable one, but I
> disagree with your reasons (or, at least, your reasons as I understand
> them).

You trust e.g. chromium.git's hooks, but I clone it, patch it, and
re-push it to somegithost.com URL. If you go with trusting content it
becomes easy to install those trusted hooks for the common case, but not
if your entire trust model relies on what URL you git clone'd from.
