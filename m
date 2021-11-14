Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD988C433FE
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF8660F36
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 09:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhKNJxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 04:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKNJxO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 04:53:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E7C061746;
        Sun, 14 Nov 2021 01:50:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z10so31064990edc.11;
        Sun, 14 Nov 2021 01:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZcER0Y3soiBByBb1oP0mC67a0nYeoNNrkpjoobg25YA=;
        b=JcHkXkQNuJ5kTKKpfJF9VJSWpdJ+CBrHIGby851n60bLf6nD0mFIlT/WvS768L99aa
         JyXmTaS5mQL2coZkHZpVhllSj8iA2Y6A0m76Ecg1NfxtpmPucR8o6cq36qGZuRmXsIm1
         yEmDBC9HLeRaMFcm8Mpny87kTKxtWOaPi0CuTdWC5hwWw3iaPNDcBbCXyKvzgqIayhVd
         5eS32Qrw7nzwbsPPahpNGeNdJjEIZx8Dz4eVhA+++KfwV/hZixzR3pX+mu0uRSKWVcOo
         R3H0ebIZi1ncYamN+Ge45MCvEWSQ335qXj9lcGoimuTeY0oG4oQ4YwU6FSEgRtmUloa4
         Xr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZcER0Y3soiBByBb1oP0mC67a0nYeoNNrkpjoobg25YA=;
        b=HT8Sf6NoQhn/5UMQ5FYPSavzF7FDfULN/0eTFU/IiONXC0y9TVK1Gn20zElYL5ZwgB
         EkjFBHg7MdrYy7cJdp5F+FA3Bi00+NCBwAKt+5oPFAKaAKzCkAXNCKpmPxJSh9aRZmdS
         sF6Nhb1xLDNH/CzGIMf5FZY0teOyk6KLJh+Gw0qdw6Pmh8nTrHL3qlWVi7xPO1+e5LDH
         0p+NhWqp0pI+EOIdnyqJIEcJRK5xjDdC4aazzG64mxik91f1i8VvhGYZG6VIJ5QmvZJN
         w9MREjNTPlBdT0n5z5gbn5OqkehMT00X14GtNLuxWdpUQ1BqvJWRmB2tfE0aMGdUEXsf
         T/mA==
X-Gm-Message-State: AOAM530Ea1JJAcYdW/XcQ5gf0u++pntA5hrzlY+qxgUQDy0oPyXH97E2
        SHb4ag1WJ0KolyDlLzq10uk=
X-Google-Smtp-Source: ABdhPJxi/eNzbiZ3GaaMvCzhBmZG51tbdy+pIDK//xvTqV8FT646cF8P4uNewLvW9g1p+pbY8ykYbA==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr41510837edd.140.1636883417703;
        Sun, 14 Nov 2021 01:50:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd22sm4881588ejc.98.2021.11.14.01.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 01:50:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmC9Q-000h4Z-9R;
        Sun, 14 Nov 2021 10:50:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Git List Mailing <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [GIT PULL] per signal_struct coredumps
Date:   Sun, 14 Nov 2021 10:36:46 +0100
References: <878ry512iv.fsf@disp2133>
 <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
 <871r3uy2vw.fsf@disp2133>
 <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
 <xmqqbl2nmemx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqbl2nmemx.fsf@gitster.g>
Message-ID: <211114.86h7cft6av.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 13 2021, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> The basic issue is how to sanely keep track of a cover letter when you
>> have a branch that you haven't sent out yet, but will ask somebody to
>> pull. It may still be seeing more testing and development before that
>> pull happens, though.
>>
>> This very much smells of what the "branch description" is all about, but
>>
>>  (a) I suspect "git branch --edit-description" is not very well known
>
> True.
>
>
>>  (b) it works well with "git request-pull", but not so much some other
>> things (like copying it into a signed tag)
>
> I think that is just a matter of programming ;-)
>
>>  (c) it makes an unholy mess of your config file if you actually use
>> it for extensive explanations (branch descriptions _work_ for
>> multi-line messages, but it really was designed as a one-liner thing).
>
> Not, really.
>
> The "-m" option similar to "commit/tag" is deliberately omitted and
> use of editor is forced, to encourage better than one-liner
> information.  cf. b7200e83 (branch: teach --edit-description option,
> 2011-09-20).
>
> The unholy mess is true if you are in the habit of editing .git/config
> in your editor, but that is to be expected if you are storing multi
> paragraph description as a value of a configuration variable.
>
>>  (d) it doesn't work across repositories (ie multiple developers or
>> even just a single developer on multiple machines).
>
> This is the biggest issue.
>
>> IOW, the "branch description" is _kind_ of the right thing, but not really.
>
> Having said all that, quite honestly, as the inventor of the
> "--edit-description", I did it as sort of a joke, and not a serious
> "feature".
>
>> An empty commit would do it as well, but an empty commit very easily
>> gets lost (git rebase etc). The fake merge does have similar issues.
>
> These days, I think rebase distinguishes between "an empty commit
> that is deliberately empty from the beginning" and "a commit that
> was not empty, but because we are applying on a new base, it has
> become unnecessary and empty", and we can tell the command to drop
> the latter while keeping the former.  So if I were to design a
> recommended workflow (and add any missing workflow elements), it
> would be:
>
>  - You develop your N-patch series on a branch;
>
>  - You conclude with an empty commit that records your cover letter
>    material.
>
>  - "git commit" may want to learn a new option that automatically
>    prepares summary of the last N patches in the commit log
>    editor, and the option should imply the "--allow-empty" option.
>    That would help when editing such an empty commit that will
>    become the cover letter.
>
>  - You repeatedly "rebase -i", "cherry-pick", etc. to whip your
>    branch into shape.
>
>  - You can push and fetch such a branch among your machines and your
>    group.
>
>  - "git format-patch" may want to recognize that the topmost commit
>    is an empty commit, and use that as the seed material for the
>    cover letter.
>
>  - If your project's pull request requires a signed tag with cover
>    letter material, "git tag -s" may want to learn a new option to
>    be fed such a branch with N-patch plus the topmost empty commit,
>    and tag the last real commit in the topic (i.e. the parent of the
>    topmost empty commit) with material taken from the topmost empty
>    commit.
>
>> Both a fake merge, and an empty commit have the advantage that they
>> are easy to see and work with (ie "git log" and all the other git
>> workflows work very naturally).
>>
>> Comments from git people?
>>
>>                 Linus
>
> I can see how the above outline would work.  I do not know if it
> would work well for your project, or there are other workflows for
> which the above outline would be insufficient.

There's a more general question to be considered here which is how the
object model is supposed to keep track of this sort of thing, if at all.

One solution is (dare I say?) "git notes". I.e. if you're keeping a
notes/CL about a set of commits you could publish a notes branch where
the CL is by convention on the tip of that commit. Now when someone else
"takes over" your branch they'll "git fetch" your notes, have set up
approprite core.{notes,display}Ref, copy your notes into their own note,
then edit/amend/publish/push.

Setting that up should be small matter of scripting around existing
commands, and should be an improvement on having to manually share or
extract what's now stored in branch descriptions.

On the other hand that information is rather unwieldy to deal with, and
"notes" support isn't very widespread on e.g. git hosting sites
(althougt that's also a chicken & egg problem).

Another solution that fits nicely into the data model is to consider
this the same "problem" as PGP signed commits. I.e. an an
"x-metadata-cover-letter" header could be added to the tip commit object
itself, either an --allow-empty --allow-empty-message commit, or "git
merge --no-ff" in case the range that CL covers is ambiguous (which in
that case would start with the merge base of the two parents).

If git's going to have some native-ish solution to this problem it
should also be considered that what E-Mail based workflows want to do
with CL's is analogous to what popular hosting sites are doing with the
text field for a PR/MR. I.e. ideally such a cover letter could be
stored/structured in such a way that if you pushed a branch to open such
a PR/MR the "cover letter" could be extracted.

Which also gets into questions of if that data should be stored
permanently. I.e. it's a merge commit as described above would the
person merging it expect to merge down the parent (i.e. sans
coverletter), or if it's stored in the commit object rewrite the commit?

And for some text-only cover letters might suffice, but git users in
general observably upload attachments to explain their commits (say a
screenshot of performance numbers). So a design that combined the above
with the ability to point at a tree might be preferred.
