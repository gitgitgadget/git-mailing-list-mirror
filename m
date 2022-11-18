Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0161DC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 19:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbiKRTHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243197AbiKRTHF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 14:07:05 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80251170
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:06:47 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f18so15325523ejz.5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 11:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+tAlz+utdjNAAjTv+/A0XNkktY+2lNZTubpdMdIRvg=;
        b=TH7EV6EPu6HOh3rJO/Q/CA9hKUryyxliSihw97FTPleRA2b+BnRtqrdjkMrC5MXAxs
         d3r61/IK/ElFzmOGKIBHA43KYBc9g8TtPmY5ZO88YcAkCSRmRlTkQp7jbDkQgbAv+hIL
         zPu39ljIbAI1Duen+XMNVAZaB+rhm0RiRDlLzUgmju5g0GRxqct9gGDuB1pkWkxAVAX/
         GizTJnZv/0A4aHYZPZ5m2XPs/FucXb3GmgVsWWmFTjj329739F34T3rCgv67WPOGmRpq
         tAm2gmZiUr5JJpHw1nGE49RhuvjRaw03m9kw94fyu6MfnC+/yEK13K8X7bqEMUiszkY4
         4vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+tAlz+utdjNAAjTv+/A0XNkktY+2lNZTubpdMdIRvg=;
        b=LN4ZfGhNmInMQQgbG8TNf63kfQiRz+vePe2dMMu1BU1d34l0HVFHSKGqlF4esxhF+K
         yShStLBd4P+B/Uh4g8qFg0503HjRuB29gHdGiZmm52u5cNzewhYEB/SC3KeXkwOyziZv
         sjKlXG7h1F9Q1zzfNgtZ2wpGxWZkU/eoctmfdTHuWie2epnB/JsBBSuDA065QAijqoQW
         CSyN6hXnL8To7Rzy63sUsz7gXNlX73G3v5SkrpaiYR/36W9GH/tdehpScgIxYnLI8alB
         v1h0zKQWGBQoe3fQWdYYFCe4vCw+PaLP5MXp/+EfH5gWDN3QgB+z6XNwJpxpHMARctNp
         VQww==
X-Gm-Message-State: ANoB5pmpVw8MXHvjBFQzkYfOIIv1YuWnWLZ3tw/aHriJIRtHB6rVKcx3
        ZSfulTG79vpFSkzDD8nf0lSNL+yDs1jB4g==
X-Google-Smtp-Source: AA0mqf4cGcVZp01M0DOnXiCVTEgw+FMav1te0R1iUxNmpeuXi5XKPH8T30cAtkPzQOyFOl5Iz/unew==
X-Received: by 2002:a17:906:2692:b0:789:d492:89f5 with SMTP id t18-20020a170906269200b00789d49289f5mr7430817ejc.103.1668798405910;
        Fri, 18 Nov 2022 11:06:45 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r11-20020a056402034b00b004587f9d3ce8sm2143414edw.56.2022.11.18.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:06:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ow6hI-005fNF-2k;
        Fri, 18 Nov 2022 20:06:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
Date:   Fri, 18 Nov 2022 19:12:10 +0100
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
        <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
        <221118.864juwhkcc.gmgdl@evledraar.gmail.com>
        <ddc1b100-98f3-7ddf-aa2b-af080cb40443@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <ddc1b100-98f3-7ddf-aa2b-af080cb40443@github.com>
Message-ID: <221118.86r0y0f5ff.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Nov 17 2022, Rub=C3=A9n Justo wrote:
>>> Whenever we copy or move (forced or not) we must make sure that there is
>>> no residual configuration that will be, probably erroneously, inherited
>>> by the new branch.  To avoid confusions, clear any branch configuration
>>> before setting the configuration from the copied or moved branch.
>>=20
>> So, whatever tea leaves we read into the history, or whether this was a
>> good or bad design in the first place, I think we should probably lean
>> towards not having this be a bug fix, but a new feature. Both modes are
>> clearly easy to support.
>>=20
>> And then document it in terms of some new switch being the equivalent to
>> --remove-section followed by a rename, the existing thing a rename etc.
>
> I've noticed a bit of a pattern on the mailing list where, if the desired
> user experience is unclear, the suggestion is "add an option! then users =
can
> choose for themselves." But then, at the same time, we'll complain about
> option bloat (as you [1] and Taylor [2] did on another recent series).

I think [1] and [2] aren't comparable in at least a couple of ways to
this case:

 a) [1] and [2] are discussions about something you can trivially do
    outside of git itself, which isn't the case with most behavior and
    options we implement, including this "branch move/copy".

    I mean you can of course script it with the refs primatives and "git
    config", but it's not "just use grep" or "just use head".

 b) [1] and [2] are a discussion about the trade-offs of adding new
    behavior, which by definition nobody relies on us for. So I think
    "a" is kind of moot to begin with.

    There's UX behavior in Git that I think sucks, but which I think
    would be irresponsible to simply change, much of it I think we'd be
    better off not having, if we had a convenient time machine.

    But that's not realistic, even if behavior is dumb or we'd like to
    change it in hindsight, we'll always need to keep the potential
    impact in mind if it's in released versions.

    Here we're talking about changing the semantics of a feature that's
    already been in released version for 5 years.

Now, I honestly don't know where I stand on "b" yet, maybe this is a
thing we can simply change.

But my spidey sense is a bit tickled by the proposed change discussing
the existing behavior as a pure bug, when it seems to me that it's
approximately what you'd get if it was implemented in terms of "config
--rename-section", v.s. the proposed new behavior of (as I understand
it) a "config --remove-section" followed by "config --rename-section".

> I don't see a compelling enough reason to introduce an option variant her=
e.
> Could I imagine a user wanting such a feature? Yes. But it also isn't cle=
ar
> what users would practically use. I think a more conservative approach wo=
uld
> be appropriate: in this case, come to an agreement on a sane default (i.e=
.,
> should we preserve the source's, or the destination's, tracking config?),
> then wait for feedback to indicate whether there's a desire for an
> alternative to that default.

I think a conservative approach would be to focus narrowly on the
tracking config, if that's the thing that's at issue. I.e. we read that
ourselves, know that it's broken if it's transmuted in certain ways etc.

But the proposed patch suggests that we extend that fix to anything we
might find in that config namespace.

It's also the nature of the fix, i.e. an existing option being changed
without a doc change to be destructive when it wasn't before.

For "git remote" we error out if "remote_is_configured()" before we call
the very same underlying function that we do for the branch
copy/move. Maybe that would make more sense? I don't know...

> [1] https://lore.kernel.org/git/221117.86k03tiudl.gmgdl@evledraar.gmail.c=
om/
> [2] https://lore.kernel.org/git/Y3ave2+kEwLTvtE6@nand.local/
>
>>=20
>>> @@ -583,12 +583,17 @@ static void copy_or_rename_branch(const char *old=
name, const char *newname, int
>>>=20=20
>>>  	strbuf_release(&logmsg);
>>>=20=20
>>> -	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>>> -	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>>> -	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf=
) < 0)
>>> -		die(_("Branch is renamed, but update of config-file failed"));
>>> -	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_c=
onfig_copy_section(oldsection.buf, newsection.buf) < 0)
>>> -		die(_("Branch is copied, but update of config-file failed"));
>>> +	if (strcmp(interpreted_oldname, interpreted_newname)) {
>>> +		strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>>> +		strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>>> +
>>> +		delete_branch_config(interpreted_newname);
>>> +
>>> +		if (!copy && git_config_rename_section(oldsection.buf, newsection.bu=
f) < 0)
>>> +			die(_("Branch is renamed, but update of config-file failed"));
>>> +		if (copy && git_config_copy_section(oldsection.buf, newsection.buf) =
< 0)
>>> +			die(_("Branch is copied, but update of config-file failed"));
>>=20
>> Aside from any question of a hypothetical "should", your implementation
>> is running head-first into a major caveat in our config API.
>>=20
>> Which is that we don't have transactions or rollbacks, and we don't even
>> carry a lock forward for all of these.
>>=20
>> So, there's crappy edge cases in the old implementation as you've found,
>> but at least it mostly failed-safe.
>>=20
>> But here we'll delete_branch_config(), then release the lock, and then
>> try to rename the new branch to that location, which might fail.
>>=20
>> So, we'll be left with no config for the thing we tried to clobber, nor
>> the new config.
>
> This is a good point, so to add to it: I think a fairly unobtrusive solut=
ion
> would be to move the config deletion after the rename is 100% complete.

Right now we do it in one go under one *.lock in
git_config_copy_section(), which has a stateful loop that mutates the
config.

So rather than "after", why not all at once? I don't see why we'd need
two calls & lock/unlock operations.

It's not like we're calling a generic function, it already has
special-cased code for "here's what I do when I'm doing the branch copy
thing", so we could implement any new behavior there.

Aside from anything else, I think one thing this proposed change
absolutely need is a documentation update. I.e. now we say:
=09
	With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
	If <oldbranch> had a corresponding reflog, it is renamed to match
	<newbranch>, and a reflog entry is created to remember the branch
	renaming. If <newbranch> exists, -M must be used to force the rename
	to happen.
=09
	The `-c` and `-C` options have the exact same semantics as `-m` and
	`-M`, except instead of the branch being renamed, it will be copied to a
	new name, along with its config and reflog.

Which to my reading really leaves this ambiguous either way. I.e. we do
say that we'll refuse to operate if the *ref* already exists, but say
nothing about existing config.

Between that and using "renamed" (which I think a user might reasonably
assume means '"git config"'s idea of rename") it seems to me to suggest
that the pre-flight checking explicitly doesn't include the config.

But it's really quite ambiguous, and isn't spelled out explicitly. So if
we're going to wipe out the existing config, we really should update the
docs.

Also, whatever this is supposed to do, shouldn't we make it consistent
with other "git branch" modes. E.g.:

	git branch -D foo
	git -P config --show-origin --get-regexp '^branch\.foo\.'
	git config branch.foo.rebase true
	git branch foo -t origin/seen
	git -P config --show-origin --get-regexp '^branch\.foo\.'

Will emit:
=09
	Deleted branch foo (was ...).
	branch 'foo' set up to track 'origin/seen'.
	file:.git/config        branch.foo.rebase true
	file:.git/config        branch.foo.remote origin
	file:.git/config        branch.foo.merge refs/heads/seen

I.e. we don't wipe away existing branch.foo.* config for new branch
creation, so why would copying or moving to the "foo" name act
differently?

If you set "git config branch.foo.merge refs/heads/next" beforehand
instead we'll wipe away *that config key*, but as noted above I think
that might be sensible.

I haven't explored other existing behavior fully, but maybe the proposed
change can look into that further ... :)

The upthread commit message doesn't discuss it, but even multiple
"merge" values are a valid state of affairs. E.g.:
=09
	$ git branch seen -t origin/seen
	branch 'seen' set up to track 'origin/seen'.
	$ git branch next -t origin/next
	branch 'next' set up to track 'origin/next'.
	$ git branch -C seen next
	$ git config --get-regexp 'branch\.next'
	branch.next.remote origin
	branch.next.merge refs/heads/seen
	branch.next.remote origin
	branch.next.merge refs/heads/next

Now, if you do:

	git checkout next

and:
	git pull --no-rebase

You'll get e.g.:

       Merge branches 'next' and 'seen' of github.com:git/git into next

Now, personally I don't use it like that, but it works now. Whatever
anyone's stance on the sensibility of existing established behavior, I'd
think (sans perhaps obvious bugs) that we'd start out with testing how
the existing behavior acts before changing it.

And again, don't take any of that as an a-priori argument against
changing it, I'm still undecided. I'd just prefer that we know what it
is we're changing.
