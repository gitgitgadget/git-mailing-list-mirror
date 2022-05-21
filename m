Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A77C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 11:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiEULHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 07:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiEULHf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 07:07:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C95C6E58
        for <git@vger.kernel.org>; Sat, 21 May 2022 04:07:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gi33so11304025ejc.3
        for <git@vger.kernel.org>; Sat, 21 May 2022 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1QglWkkEvgCedWsSiJOBZNRlQ6QE6ikL+Vw/8kICwcI=;
        b=Do+vv5MAw0jvpHWV7OunNdgulhX1JxxkQUAYS5pzFWGR6M0XTgxRrtOj51ARu3KUPY
         Wt3Ig3cU5oxSMjv9lkFM6fo1sr/xoh9fV98xTuVd+0ToyMXS/3McJc2ILb4LWy3QATL5
         9cTVnaABDs1tJxceLfowjVARPEafACuMKGK5VTochGt2V29cOBZYT0ybCNLeviAR4PIU
         nAjipeek8r7ShSh8sq8eLeXQJ3Z5gLApsaVfHQlQoYW9pyQvq1/SGiSL44rcxsPw7j9e
         rY8CjPl5pBtPfMlLmj1iefDRHwPQ+w2/g0XPF59TfyHekepinqmmFE0pTSeMX3sCRxNr
         5Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1QglWkkEvgCedWsSiJOBZNRlQ6QE6ikL+Vw/8kICwcI=;
        b=rmgT2YcZ+SbmPnvcE/5nkt8siDtUIvSL937tmwJfWfW/EcX8HYIpEbQW55EghEF0wO
         Iq+/ZtjrZvysNLmJ+J95UpuiIT2UdjxdQozc3fyAunL3V5YE7Gg3u7vgE8oi9dEmqX0X
         3X7Cm5WwyCxPbhmTWsivlzCHm2PhAcDE81V8IuS2HpwKSi9/N18XQG/uyB41GxIIHLBz
         FhNE+cz/7yOikiueuQFzil+LyGFMu8fQ0OUinOdW16nACpto9RgYWdmSXBwnVnXafVec
         Kt6jRDK73M/X/oku5ZuIY1NbV7+IqTkFfRT5G7VpRLmt4geDyE4HBb+xS/Q1+TimmbgB
         NKCg==
X-Gm-Message-State: AOAM530s4ajAFkg2PoFCcm8oLJfrJvmDP7anJcb4hsk8MknyFRyriTcx
        qIFQ6kVqNAZ/SPHQZB/KOeY=
X-Google-Smtp-Source: ABdhPJwreY/Cg++nH5Wbno6khPaSqTMFtua+X86PWCRIOayj3ehuqkU+3xd+bYYVZSxiuz52fvfcbw==
X-Received: by 2002:a17:907:7e8b:b0:6fe:b85d:bb9 with SMTP id qb11-20020a1709077e8b00b006feb85d0bb9mr3433022ejc.640.1653131248833;
        Sat, 21 May 2022 04:07:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id mm24-20020a170906cc5800b006fe9ba21333sm2660614ejb.113.2022.05.21.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 04:07:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nsMxC-002dis-I4;
        Sat, 21 May 2022 13:07:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [Discussion] What is Git's Security Boundary?
Date:   Sat, 21 May 2022 12:22:35 +0200
References: <6af83767-576b-75c4-c778-0284344a8fe7@github.com>
 <220517.86k0ak6zpo.gmgdl@evledraar.gmail.com>
 <3c886213-d20a-b05c-3ee7-011151139fd3@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3c886213-d20a-b05c-3ee7-011151139fd3@github.com>
Message-ID: <220521.86h75j16vl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 20 2022, Derrick Stolee wrote:

> On 5/17/2022 8:55 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
> These examples you mention are definitely things that can go wrong, but
> they become much harder to use as an attack because of the extra hoops
> needed by the user.

Yes in those cases, but as noted later we've also got e.g. git-annex
configuration which is the same arbitrary command execution.

> The one thing I think is particularly interesting in your examples is the
> case of checking certs. I'm thinking specifically of a case where someone
> updates the local repo config to have a different remote URL and tricks
> the user into pushing their private repo to another location. (Although,
> why didn't they just do that themselves with their read access to the
> repo?)

.... [replied to just below]....

> A leaky bucket can have many holes, but that doesn't mean we shouldn't
> start patching the holes we see and can reach. And the process of fixing
> the ones we know about makes it easier to fix more in the future using
> similar mechanisms.

My concern is that we'd start out with implementing a security model
using the wrong approach, without learning lessons from existing working
systems. E.g. the Emacs one that's been dealing with the same problem.

I do think that doing it that way will probably be simpler to do as an
initial implementation, and if we can create a system that's
sufficiently secure and doesn't have arbitrary restrictions (e.g. only
focusing on "executable config") we won't need any of the subsequent
work of trying to combine a more extensible system with an initial
limited implementation down the road.

>>> The idea would be to allow repository-local customization by selecting
>>> from a list of "installed" executables. The list of "installed"
>>> executables comes from protected config (and the Git binary itself).
>>=20
>> Most of this type of config doesn't point to a path to an executable,
>> but is a string we'll give to "sh -c" or equivalent. E.g. for editors we
>> couldn't naively add "emacs" to such a whitelist, as it supports
>> command-line options to evaluate arbitrary code.
>>
>> How would your plan handle such cases?
>
> We could add "emacs" if we assume there are no other arguments. Extra
> arguments would need to be part of the "installed hook".

Yes, it's possible to make it work, but e.g. some want to run emacs (or
whatever editor) with "-nw", my $EDITOR is "emacsclient
--alternate-editor emacs".

So being able to e.g. have a regex to accept config for that key is more
useful than an arbitrary limitation of only allowing commands that you
could feed to "command -v" (or something), and requiring a wrapper in
$PATH for anything more complex...

>>> The plan I would like to put forward is to restrict all external execut=
ion
>>> to be from one of these sources:
>>>
>>> 1. Specified in system config (`/etc/gitconfig`).
>>> 2. Specified in global config (`~/.gitconfig`).
>>> 3. An allow-list of known tools, on $PATH (e.g. `vim`).
>>>
>>> Such a change would be a major one, and would require changing a lot of
>>> existing code paths. In particular, this completely removes the
>>> functionality of the `$GIT_DIR/hooks/` directory in favor of a config-
>>> based approach. This would require wide communication before pulling all
>>> support for the old way, and likely a 3.0 version designation. After the
>>> old hook mechanism is removed, the "safe.directory" protection from 2.3=
5.2
>>> would no longer be needed.
>>=20
>> Aside from any of the details of safe.directory & how we discover hook
>> it was my understanding per [1] that Johannes Schindelin disagreed with
>> this assessment of what safe.directory was for.
>>=20
>> I.e. now the known vector is a hook, but in the previous off-list
>> discussions I'd proposed narrowing the new safe.directory error down to
>> handle that hook case only, but per the "cat being out of the bag" in
>> [1] there was concern about other non-hook issues being found.
>>=20
>> Perhaps that assessment has changed, just noting it here for
>> completeness.
>
> You're right that since there are other ways to use shared repos to break
> user expectations and create a vulnerability, then safe.directory will
> likely still be needed.
>
> I also think that safe.directory is still insufficient because a shared
> repo can be marked as "safe" but then be attacked later when a "trusted"
> user is compromised.

Yes, exactly. I brought this up in the initial discussions about
safe.directory. I.e. it's by design creating scenarios where we're
making users more unsafe than they'd be if we narrowly focused just on
the hook config.

That's because we force them to set a repo as "safe" based on FS
permissions, but don't care about the content of the config, we just
assumed that it had that "bad hook".

Then once we mark it as safe the config can change, and could be changed
to something that would be truly harmful, i.e. now the "bad hook" which
wasn't there before could appear.

Which is just completely the wrong model to go for, and we should
instead go for something that works the way emacs's dir-locals
does.

There the default is to trust almost no config, and if you open an
untrusted file that wants to set new config the default UI is to ask you
*which parts specifically* you'd like to trust.

Those can then be whitelisted (either globally, or as path:config-pair),
so that when you open the file the next time and it's added the
proverbial "rm -rf /" you'll pick up only the parts of config you
already audited/trusted, not the new parts.

Which is the opposite of the direction safe.directory is taking us in,
where we're treating config safety as a boolean we can mark as a
one-off, and which doesn't take into account subsequent config changes
at all.

>> In any case, I don't think that we'd need to make the removal of
>> $GIT_DIR/hooks support in favor of config-based hooks a dependency of
>> any such proposal.
>>=20
>> The current config-based hook proposal would allow you to exhaustively
>> emulate $GIT_DIR/hooks by defining all our hooks to those
>> paths. Therefore any security mechanism could surely consider the old
>> $GIT_DIR/hooks to be handled equivalently to however it would handle
>> that sort of config-based hooks configuration.
>
> Here's another way I would phrase my thoughts here:
>
> If we were designing the hook mechanism _today_, then I would absolutely
> advocate that we require the hook definitions to come from protected
> config and not be repository local. It is too dangerous to let this level
> of arbitrary execution be done in shared repository context.

I agree that it's unsafe now, but I think it's wrong to head in the
direction of "protected config".

We should trust content, not origin or FS permissions. Just as I'd be
happy to accept a "git bundle" from an untrusted source if I could
validate it against a known OID I should be able to open a completely
untrusted repo (e.g. random tar.gz I downloaded) and have its config be
enacted, but only those subsets of config I've deemed safe in that
security context.

> The question we face today is two-fold:
>
> 1. Is that enough of a risk that we would want to break backwards
>    compatibility and remove $GIT_DIR/hooks as a hook mechanism?
>
> 2. Should any _new_ way of configuring hooks be more secure than the
>    $GIT_DIR/hooks mechanism?
>
> In my opinion, I think the answer to (2) is "absolutely yes" and the
> answer to (1) is "maybe". The full answer depends on how well the new
> system works, which is only something we can learn after it is built and
> used in real-world scenarios.

I think for any replacement of safe.config we'd just treat both the same
way we'd treat any other config.

>>> [...]
>>> I look forward to hearing from the community about this topic. There are
>>> so many things to think about in this space, and I hope that a lot of
>>> voices can share their perspectives here.
>>>
>>> Please collect any action items here at the end. I would love to add a
>>> doc to the Git tree that summarizes our conclusions here, even if it is
>>> only a start to our evolving security boundary.
>>=20
>> This didn't make it on-list, but in the off-list discussion about
>> safe.directory I pointed out that this class of problem is something
>> Emacs has been dealing with for decades, and which we'd do well to try
>> to emulate. [2] below is the relevant part of my
>> <220303.861qzi3mag.gmgdl@evledraar.gmail.com> (sent on Thu, 03 Mar 2022
>> 19:27:59 +0100), I also mentioned it in passing in [3].
>>=20
>> The brief overview for it in Emacs's documentation is available here:
>> https://www.gnu.org/software/emacs/manual/html_node/emacs/Safe-File-Vari=
ables.html
>>=20
>> I feel strongly that something like that is a much better direction to
>> go in than an approch that tries to narrowly classify only "dangerous"
>> config.
>>
>> That sort of approach would basically do the reverse. We'd whitelist
>> "safe" config (e.g. diff.orderFile or whatever), and ask the user if
>> they're OK with using config that falls outside of the whitelisting.
>>=20
>> By classifying our own config (and we'd probably need more than just
>> "safe" and "executes arbitrary code") the common case is that users
>> shouldn't need to answer those questions, as we'd know that the config
>> is safe.
>
> You are focusing on the part where it displays all config that is not
> known to be "safe" but ignore the parts where it refuses to take changes
> for config that is known to be "risky".
>
> Essentially I'm advocating for adding the less-invasive "never accept
> risky config from untrusted sources" and you are advocating for "always
> prompt for any untrusted config that isn't completely safe".

No, I'm not advocating for that. You wouldn't always prompt, and
depending on your configuration you could perfectly emulate your
proposal with a dir-locals-like implementation, but the reverse isn't
true.

And we could make the default configuration match what you've suggested,
I'm suggesting that a replacement can be both more generic, extensible
and safer.

>> This would be implemented by having a config mechanism "mark" which
>> area(s) of config are "safe". We'd only pay attention to such a config
>> from sources that area already "safe".
>
> Such a direction seems like it would need a significant amount of extra
> work before it would make Git usable in these shared scenarios. The
> amount of "safe" config seems to be quite large _and_ continues to grow.
> We would need to evaluate every boolean config option as it is written
> and do an extra step to add it to this allow-list. [...]

We wouldn't need to do that, I think we should do it to be friendlier to
users, just like emacs has a list of built-in config that's safe
(e.g. what tab indent level you'd like and similar).

But we could punt that until later and only say that we found config
keys X, Y and Z, we're ignoring them for now, but you can whitelist them
in general or for this key (or path/key combination) by doing ABC.

> [...]Of course, this also
> assumes that we are only guarding these repo-local config options when the
> filesystem communicates that the repo is owned by someone else. I'd like
> to remove the owner from the equation and stop trusting repo-local config
> for things like this, if at all possible.

Yes, I'm in complete agreement with you that we should completely ignore
FS ownership. Per the above content should matter, not ownership.

Having said that I think there might be some place for FS ownership in
the end, e.g. just as you might configure that ~/git/mine has config you
trust but ~/git/unpacked-tarballs has completely untrusted config you
might know enough about your system to do that based on FS permissions
instead.

But it should not be the default we we do gatekeeping. It should be
equally safe to inspect /tmp/bad-repo created by another user as a
tarball you extracted from an untrusted source as your $USER.

>> So, to begin with this addresses cases where e.g. a tool like git-annex
>> will execute arbitrary executables based on git configuration, which any
>> mechanism that marks only config git itself knows about won't be able to
>> do (it uses its own config space).
>>=20
>> But it also extends this mechanism from being something *just* focused
>> on narrowly addressing security to something generally useful. E.g. even
>> if a repository on disk has "safe" config I might still want to say that
>> I don't want to use its alias.* config or whatever.
>
> This sounds again like an opposite direction: you want to have something
> in your global config that ignores certain config keys in repo-local
> config. That creates a user-specified deny-list which I find an interesti=
ng
> direction.
>
> My goal is to make Git safer for users who would not set up such a deny-
> list.

Mine too, I'm not suggesting that anyone would set up a deny list by
default, just as emacs's dir-locals is safe by default we should ship a
sensible safe default.

But seriously, I think it would be really helpful for reaching some
understanding here if you just took some time to play with an Emacs
installation & how dir-locals works.

I'm not trying to advocate that you switch your $EDITOR (which I realize
is a borderline religious issue), nor am I mentioning emacs because it
happens to be my $EDITOR of choice.

I'm mentioning it because it's:

 1. Solving the same problem we're trying to solve here, but has an
    existing battle-tested implementation with the benefit of lessons
    learned.

 2. I'm not aware of any other software that even tries to solve the
    same problem, let alone does so successfully (but I'll happily admit
    that's probably just my own ignorance).

    E.g. last I checked vim had similar (modeline) config that relied on
    an exhaustive built-in whitelist, and other such "get config from
    file" features in editors I've tried worked the same way.

    Emacs is the only one I'm aware of where it's arbitrarily
    extensible, able to accept and safely deal with config Emacs has no
    idea about (because it's for some third party package or whatever),
    and where all of that config might range from "completely safe, at
    worst annying" (e.g. indentation configuration) to completely unsafe
    (e.g. execute this arbitrary command).

I didn't link to this upthread because I hadn't found it yet, but when
this came up on-list in the past (in a different context) I proposed
doing the git-specific config driving it like this:

    https://lore.kernel.org/git/874lkq11ug.fsf@evledraar.gmail.com/

I.e. you could accept/reject config based on sources (as in mapping to
git config's notion of --system, --global, --local etc.). In that
proposal your upthread suggestion would be implemented as something
like:

	[config "repo"]
	reject =3D core.fsmonitor
	reject =3D core.editor
	reject =3D credential.helper
	reject =3D uploadPack.packObjectsHook
	accept =3D *

In terms of implementation (which I guess I'm talking myself into at
this point) it shouldn't be that complex. We have various "early config"
reading already, e.g. for trace2 and "git init/clone".

So in this case we'd just early on read config to get these
"meta-config-rules" (i.e. the "[config ...]" settings above), and do
nothing with them except note what we found.

Then when we were using the config API "for real" (i.e. in later
git_config() callbacks and the like) we'd just exclude such config.

Then if we excluded anything we'd emit an advice() or whatever saying
that we did, that excluded config could be viewed by running X command,
or whitelisted (or the notice silenced) by doing Y or Z.

The exclusion logic would be a relatively simple rule-based filter
driven by something like wildmatch(). I.e. given a key like
"core.fsmonitor" see if we have any excludes (if not pass it along), if
we have excludes does it match etc.

Does any of that sound like it still wouldn't satisfy the goals you've
outlined? Again, I'm interested in the underlying mechanism, whether
we'd e.g. configure it by default to use some set of excludes or another
is, I think, best discussed later, except to the extent that one
proposal or another would have arbitrary limitations that would make
some use-case we'd have in mind impossible.

>> Whatever mechanism we end up with here, I think that now that the dust
>> has settled on the CVE we'd do well to consider those sorts of
>> problems.
>>=20
>> A core.editor pointing to "rm -rf /" is a security issue, but any such
>> issues are just subsets of annoying third-party config doing something I
>> didn't ask for.
>
> I feel you are making my point exactly: "rm -rf /" is just a placeholder
> for something I don't want to happen and can be harmful. The flexibility
> here allows attackers to be very creative with how they attack Git users
> and I'd like to shut down those approaches however possible.

I think this should be addressed by the above replies, but perhaps I've
misunderstood you here, so let me know if you feel there's something
outstanding.
