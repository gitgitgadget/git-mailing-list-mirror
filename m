Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F9AC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 11:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbiDKLF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbiDKLF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 07:05:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D65C47
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:03:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so30090178ejd.5
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MogJzdttuhxfPjSsMWQhxE1tN3HJYZ6ezazoRZb0RY0=;
        b=mRcXb2lCfeHKTK7nC18cyX1fUgICkMPSedphL8Jq25QSW9ktDDjf62dNr2UCnYUe5B
         mwaaqzhQDdLrHPpIsuj+FoHOFzom6DCTqyaa2i8hiU0bPdKVEBt6NWq/mh2gPNWe8/Ea
         mTC/UVoxWzXChgY8HOBMiK6m0JkxVnhIOUjFShW0o7HN5/NiRHp2utlCVsWAENxhaDkN
         vOYYP9bKfDXglNCcDVeflIVmjA0BPXJ+dprS5/UtpMu6E/P794BRl6MwWEybgIPaTcYq
         1yAyZXkcKmymz5VolqWSsCMAX/G7HRzigYXQ9MDUpEd23/ga5MqQxlnhBbdhYtUcqNCr
         X/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MogJzdttuhxfPjSsMWQhxE1tN3HJYZ6ezazoRZb0RY0=;
        b=2BnwTQSz9TKdEx5kB25zhydxyBnfehZO8TkSxkU+GgjEMvcIlqsauNSubqZjZP/9w3
         mlCUZ6bNHxFYKxgtYUtVa9fJyCawDulQ7cJz82I11vxcglG+RPrhaysPs/n7hCVjKyhU
         0/nRfO+EOJOcD42ohKfIoBQsfTp5qSzpxTa1EOOvHoywgozQN8jsHM69KQLiez7QAsG2
         rb/tI1CV7c+fnTx97pdR5mPXJkZbwAKpWFfJYXv5JucWyIDskM0bJsrsLqTixCG98ALr
         XOdwzNtMGX8GwInzsxGPZ4x3Z3qCp5S0C+8dM6w3HszNqAgfmqLq4C0c4tC42sMhCtbW
         AfWg==
X-Gm-Message-State: AOAM53061PzjHbCx3BCbLn3Ppzaj/6NvG7WXfxzECbvs25Alkwuzpw7f
        EV5VJnLmFv57ut8QfDkoVNIwlZmJhO0=
X-Google-Smtp-Source: ABdhPJyfBH+MGwfSvsj4HSkTv/wcCWrHBkxEN+UcczvUPOcPrLdRK5fHjCECmufXY/QO+Fjrvpg04Q==
X-Received: by 2002:a17:907:96a6:b0:6e3:9c1b:f403 with SMTP id hd38-20020a17090796a600b006e39c1bf403mr29431657ejc.524.1649675020896;
        Mon, 11 Apr 2022 04:03:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g14-20020a50e04e000000b0041cd8db541fsm10770119edl.74.2022.04.11.04.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:03:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ndrpb-000cJC-Mt;
        Mon, 11 Apr 2022 13:03:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Date:   Mon, 11 Apr 2022 12:19:51 +0200
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
 <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz>
 <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
Message-ID: <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 10 2022, Tao Klerks wrote:

> On Sat, Apr 9, 2022 at 1:32 PM Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>>
>> On Fri, Apr 08, 2022 at 07:32:03PM -0400, rsbecker@nexbridge.com wrote:
>> > On April 8, 2022 6:30 PM, brian m. carlson wrote:
>> > >On 2022-04-08 at 03:35:04, jurgen_gjoncari@icloud.com wrote:
>> > >> I think that often commit messages are unnecessary. I propose that =
by
>> > >> default a user should be able to commit without a message.
> [...]
>> > >We want to encourage good software engineering practices.
>> > >
> [...]
>> > >
>> > >Users who want this behaviour can use --allow-empty-message or create=
 an alias
>> > >with that option.  The functionality already exists.  I use aliases e=
xtensively in my
>> > >development and I know others do as well, so this shouldn't be an imp=
ediment if
>> > >you're working on projects where this is acceptable.
>> > >
> [...]
>>
>> There is nothing stopping you using '.' as the commit message which is
>> as informative as when it is empty. Hence this enforcement of non-empty
>> commit message does not serve the stated purpose.
>
> My apologies if this proposal has already been made in this or prior
> discussions - the list server and gmail are having another
> disagreement, so I think I'm a few hours out of date.
>
> I believe the main argument *for* allowing empty commit messages by
> default is "we shouldn't make it hard to do what you want to do, if
> you can fix it later",

Or don't fix it later, e.g. in the gist case mentioned in [1]. As shown
in [2] forcing the user to provide a message can serve to increase the
noise to signal ratio, in making it harder to distinguish those commits
where the author had nothing to say.

I have numerous local repos where I'd benefit from --allow-empty-message
by default (of course I can customize it, but habits etc). Now through
some combination of scripting and habits I've ended up with e.g.:

    git commit -mbump

These are things like my local (private) notes file, a repo that keeps
snapshots of E-Mails I send to the Git ML etc. Those things are newer
going to have meaningful commit messages.

> and the main argument *against* is "for most
> people (non-advanced users), what you do initially is what you end up
> pushing, or at least trying to push, and fixing things later is *hard*
> - it requires a much deeper understanding of git than most people
> otherwise necessarily need to develop".

Yes, maybe it won't be viable to go in that direction, but re this in my
[1]:
=09
	But I'm also pretty sure that those people are engaged in a proxy war,
	and we should just attack the "problem" directly instead. I.e. it's not
	a problem that some commit somewhere has an empty message, rather it's
	that such a commit gets "propagated". A better place to check for it is
	then at the point of point of propagation.

I think it would be useful if those advocating for this behavior would
indicate whether or not some working solution of doing it in a different
place would address their concerns, whether or not we have patches ready
for that.

E.g. something that (if you have empty commit messages) would prompt you
to interactively rebase the to-be-pushed history or whatever.

Another thing that occurred to me after sending [1] was that perhaps
"repo size" would be good heuristic, we already have a fast estimation
of that for showing abbreviated commit OIDs.

That wouldn't do the right thing on e.g. large private git-annex repos,
but would serve to distinguish a "real, mid-size or large repo" like
git.git, redis.git, linux.git etc. from dotfiles, gists etc.
=09
> In that sense, allowing people to create empty commit messages when
> they shouldn't, is often "trapping" them into a commit history that is
> less valuable (or even acceptable) than they might otherwise have
> achieved.

I agree with that if you s/allowing people to create empty/force people
to create non-empty/ :)

I think all the arguments in this thread (including mine) are ultimately
built on anecdotes, and I don't think that we can hope to get out of
that rut.

E.g. I've helped a lot of novice people with git (being the go-to "git
guy" at a past job), and one of *the most common* things I encountered
was users with some absolute mess of a working tree with large
outstanding changes, which ultimately came down to them being afraid to
commit it as it "wasn't ready".

So I really think anything we can do to break that particular pattern is
more helpful than not.

But am I absolutely confident that I'm right, and that these concerns
will outweigh other anecdotes brought up in this thread? No.

But what I am confident in saying is that tweaking the UX in this area
will have cost/benefits whatever you do, and I think that whatever
"side" one picks here the interesting arguments to be had is trying to
discuss and mitigate those costs.

> While I therefore disagree with Aevar's proposal to "allow empty, and
> advise", I do think the notion of giving advice makes perfect sense -
> let's do it the other way around, with an advice message something
> like:

Note that that's a pretty narrow reading of [1]. The main thrust of my
point was that we should consider moving this to "push" or "merge" time.

> ---
> Empty commit messages aren't normally allowed, as they reduce the
> understandability of the commit history. If you do need to create a
> commit with an empty message, you can do so by providing the
> '--allow-empty-message' argument to 'git commit'.
> ---
> Has this already been considered/discussed? Would it meet the
> objectives of those folks saying "the rejection of empty messages
> wasted my time", while also keeping the spirit of "we should make it
> easy to do the right thing and harder to do the wrong thing,
> especially for beginners"?

I think that's a lot worse than the status quo, at least now our
behavior just seems like a very basic safeguard, e.g.:
=09
	$ git commit -a
	hint: Waiting for your editor to close the file... Waiting for Emacs...
	Aborting commit due to empty commit message.

There I opened my editor, saved the empty file that came up ("empty"
when adjusted for comments), and "git commit" aborted.

Even if I think we should make some version of "allow empty" the default
I think *that* particular thing should stay.

I.e. that's really helping a user to mitigate a genuine mistake,
particularly if something goes wrong with the external editor. I.e. I
think something like this would be sufficient (as in, it should
succeed):

    $ git commit -a --no-edit
    Aborting commit due to empty commit message.

All of those would be good cases to get feedback on, i.e. let's leave
aside the question of whether the UX should "encourage" and whether
--allow-empty-message should be the default, do the proponents of the
status quo think all of these are sensible:

    git commit -a # launches editor
    git commit -a -m"" # empty message
    git commit -a --no-edit # no editor

Aside from anything else I think --allow-empty-message for that last one
is rather silly, it's basically making the user say
--yes-i-know-the-default-messages-is-the-empty-message. Maybe it's
arguably in the case of a pre-commit hook & without --no-verify?

Anyway, that was a bit of a digression, sorry.

The reason I think it's "worse than the status quo" is that it takes us
from something that seems to be an overzelous CLI option check gone
wrong to actively recommending a "novice forever" UX pattern. I.e. the
"reduce the understandability of the commit history" etc. assumes or
implies that we won't have a "git rebase -i" before pushing.

1. https://lore.kernel.org/git/220408.86r167bxra.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220411.865ynfkj7r.gmgdl@evledraar.gmail.com/
