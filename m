Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27629C433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F013660FE7
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 17:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbhKNRU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 12:20:27 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:33582 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNRUS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 12:20:18 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:45458)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmJ85-007fOg-O3; Sun, 14 Nov 2021 10:17:21 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:44736 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmJ84-008yaG-Ei; Sun, 14 Nov 2021 10:17:21 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
References: <878ry512iv.fsf@disp2133>
        <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
        <871r3uy2vw.fsf@disp2133>
        <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
        <xmqqbl2nmemx.fsf@gitster.g>
Date:   Sun, 14 Nov 2021 11:16:32 -0600
In-Reply-To: <xmqqbl2nmemx.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        13 Nov 2021 22:32:06 -0800")
Message-ID: <87pmr2k68f.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mmJ84-008yaG-Ei;;;mid=<87pmr2k68f.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+gE1TiU4PxLTZNvixOtm/bc/InDopdMBY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] per signal_struct coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

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

I think an empty commit at the top of a development branch sounds
like a nice place to store the cover letter for a set of changes.
That is a related problem but that is not the problem that inspired
the no-op merge commits.



I have not seen addressed the workflow that actually inspired this
odd thing I am doing.  So let me see if I can describe the problem
that inspired the merge commit more clearly.

Before the merge window for v5.17 I expect to be working on
a topic I will loosely call "do_exit_coredumps_and_signals".

There are going to be several changesets (something like):
"Move coredumps rendezvous into get_signal"
"Use the same exit code in all implementations of die"
"Use signal short circuit delivery for coredumps"
"Use signal short circuit delivery whenever possible"
"Replace do_exit with a different helper for use by die"

Each of those will consist of 5-10 patches and need to be individually
reviewed and depend upon each other.  In the roughly 2 months of
development time before v5.17 I can expect to get several of those
changesets.  Each changeset will depend upon the work of the changeset
before.

As each changeset is reviewed and finalized I expect I will put it on
the topic branch with a merge commit containing the description letter.
That merge commit will contain a "Link:" tag to the posting on the
mailing list so that people can find the full description.

When put into the topic branch after review the commits are frozen
and ready to be sent to Linus for merging, when the next merge window
opens.




When the development window closes and the merge window opens I will run
"git shortlog" see what is there and write up a description for the
entire topic branch.  Ideally I will put that into a signed tag etc
before I send it to Linus.

In the case that triggered this conversation I happened to only have a
single changeset with a single merge commit in the topic branch which
looks very odd, but that is mot definitely not the case I want to
optimize for.


The changes I am making are digging through some old grotty areas of the
kernel.  It isn't uncommon for me to be fixing issues that predate git.
So it takes some sleuthing and description so that other people can see
what is going on in each of those changes.  So I want to preserve the
description of what and what is going on with those changesets as
much as possible.

A big rollup into a single description for Linus of the entire topic
branch is necessary, but will generally not contain all of the detail of
the cover letters for the patch sets.

I need something like a merge commit rather than an empty commit so
that both the start and the end of the series of changes is shown.

Notes probably don't work because I want the description of what is
going to persist and be available to "git log".  So that the next poor
sucker who touches the code can have a change of figuring out what
I was thinking.

If I have just one fake-merge I would not mind if request-pull or
something incorporated it, but with several I am most definitely going
to need to edit the message so it is at the 10,000 foot view of the
entire topic branch, and not at the nitty gritty view of a single patch
set.


There was only a single changeset in the branch that caused this because
I am making what is remotely possibly a breaking change and I need to
get it into a released code base to verify that I am not breaking
anyone.  If I don't need to revert that change then there are very
substantial cleanups I can make in the kernel.   So all of the
additional changesets have to wait until v5.16 is released before I can
ask Linus to pull them.

Which meant during this one development cycle I was not able to build
one changeset on top of another changeset because one of the changes is
something of a risk.  That is a degenerate case of my normal expected
work-flow.


Eric
