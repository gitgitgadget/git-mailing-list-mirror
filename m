Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782C6C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522D061BE6
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhKPGwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:52:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65366 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKPGwK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 01:52:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 641E415BBFD;
        Tue, 16 Nov 2021 01:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hRkqK3Gr7UO/LSsBzFTI/CcUAkG0/clOqEED+d9rh94=; b=NlXE
        ic92vOP753V5Qsnk4LVoo0w28oTvHMaFEieRe+hUIRk7lTcCIpXGXcEp+9NzX2qd
        JiIArueqRytUuNIveeCRTNpkByWbr5LIpC+57HWixhHDMPAAx8fcmtRyeEeqZiAX
        jr+x/QGFaK5cbyFezlhkRMladV97oA+vM4FF4Dg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BF0E15BBFC;
        Tue, 16 Nov 2021 01:49:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BE50315BBFA;
        Tue, 16 Nov 2021 01:49:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [GIT PULL] per signal_struct coredumps
References: <878ry512iv.fsf@disp2133>
        <CAHk-=wivLcb3ELGSf=fM0u=PxP5m1=jRrVXDOr0+QJZRZggaHg@mail.gmail.com>
        <871r3uy2vw.fsf@disp2133>
        <CAHk-=wh8v4OC=9rjFs-QH0evVrGQu+wCVL5gE8Y-uTvqh42XNA@mail.gmail.com>
        <xmqqbl2nmemx.fsf@gitster.g>
        <87pmr2k68f.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 15 Nov 2021 22:49:08 -0800
Message-ID: <xmqqk0h8bnob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D1068A2-46A9-11EC-B029-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> I have not seen addressed the workflow that actually inspired this
> odd thing I am doing.  So let me see if I can describe the problem
> that inspired the merge commit more clearly.

Where can I learn more about the "fake" merge commit (assume I do
not know anything more than what Linus wrote in the message to the
git mailing list)?  Even after re-reading your description twice,
I get that you are using an extra merge commit as a place to store
the cover letter material, I am guessing that one of the parents
(which one???) is the tip of the finished "changeset" (I take the
word to mean "one of more commits on the same theme, in a single
strand of pearls"), but I am not sure what the other parent is to
make that a "merge".  If it is "fake", I guess that any random point
in Linus's history would do, but I can understand that the maintainer
would complain about such a seemingly unnecessary (back) merge.

> Before the merge window for v5.17 I expect to be working on
> a topic I will loosely call "do_exit_coredumps_and_signals".
>
> There are going to be several changesets (something like):
> "Move coredumps rendezvous into get_signal"
> "Use the same exit code in all implementations of die"
> "Use signal short circuit delivery for coredumps"
> "Use signal short circuit delivery whenever possible"
> "Replace do_exit with a different helper for use by die"
>
> Each of those will consist of 5-10 patches and need to be individually
> reviewed and depend upon each other.  In the roughly 2 months of
> development time before v5.17 I can expect to get several of those
> changesets.  Each changeset will depend upon the work of the changeset
> before.

Up to this point, I think I get what is going on.  You've worked
together with your reviewer and came up several patches to achieve
the "Move coredumps rendezvous into get_signal" task, so now you
have one topic branch that forks from some point in Linus's history
and houses these patches.  If "Use the same exit code" topic builds
on the "Move coredumps" one, the topic branch for the former may
fork from the tip of the latter.

> As each changeset is reviewed and finalized I expect I will put it on
> the topic branch with a merge commit containing the description letter.

This part I do not understand.  What is merged into what?  The tip
of the "Move coredumps" series of commits gets merged into the
previous stable release from Linus or some appropriate point inhis
history, and the topic branch points at that merge?

> That merge commit will contain a "Link:" tag to the posting on the
> mailing list so that people can find the full description.

If a signed tag were used to store that description and Link,
wouldn't that be sufficient?  Then Linus would pull that signed tag
to see it is from you, the merge would show which tag was merged and
what the tag said.  And we do not see the fake merge---I think the
maintainer's complaint and the problem the fake merge brings into
the history is that, while one of its parents, namely, the tip of
the "Move coredumps" series of commits, does have meaning, the other
parent does not.  It can be any ancient commit.

It _might_ make it a bit more palatable to Linus if the merit of
using a merge includes that the other parent can record the fork
point of the main series of commits (i.e. the merge will have to be
created with "merge --no-ff"), but I still feel that the argument is
weak, when a signed tag would work better (and I probably am missing
the use cases in which fake merges work better than signed tags).

> When put into the topic branch after review the commits are frozen
> and ready to be sent to Linus for merging, when the next merge window
> opens.
>
> When the development window closes and the merge window opens I will run
> "git shortlog" see what is there and write up a description for the
> entire topic branch.  Ideally I will put that into a signed tag etc
> before I send it to Linus.

Here, what do you exactly mean by "the entire topic branch"?  For a
single "changeset" like "Move coredumps", or all of the changesets?

Assuming that the answer is the former, and assuming that the "topic
branch" for "Move coredumps" look like:

 a. it forks from some point in the upstream history;

 b. it build one or more commits on it, a single strand of pearls;

 c. it is capped with a (fake) merge to merge the above into some
    point in the upstream history;

what is missing from the Git toolset to turn the above two into a
signed tag that points at the tip of b. (i.e. without the fake
merge)?  Ideally, after b. is made, don't you want to go directly to
a signed tag, instead of a (fake) merge?

> In the case that triggered this conversation I happened to only have a
> single changeset with a single merge commit in the topic branch which
> looks very odd, but that is mot definitely not the case I want to
> optimize for.

It is unclear to me why the number of commits in the b. part
matters.  Be it one or 40, the (fake) merge at the tip seems
unnecessary, when the whole thing is merged into the upstream
history.

I seriously doubt that I am getting the whole requirement, as it
seems that "develop a series of commits on a branch, that may or may
not be dependent with each other, and ask the branch to be pulled by
giving the description in a signed tag that points at the tip of the
work" should work OK?
