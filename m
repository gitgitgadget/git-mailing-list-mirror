Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB5FC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1263214
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhKPPSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:18:09 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:58930 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhKPPSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 10:18:09 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:51344)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mn0Aw-00BYWg-TH; Tue, 16 Nov 2021 08:15:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37576 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mn0Av-00DBF6-NZ; Tue, 16 Nov 2021 08:15:10 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junio C Hamano <junio@pobox.com>
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
        <87pmr2k68f.fsf@email.froward.int.ebiederm.org>
        <xmqq8rxobj1k.fsf@gitster.g>
Date:   Tue, 16 Nov 2021 09:14:32 -0600
In-Reply-To: <xmqq8rxobj1k.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        16 Nov 2021 00:29:11 -0800")
Message-ID: <87lf1ob09z.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mn0Av-00DBF6-NZ;;;mid=<87lf1ob09z.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ihlHc2DLTLJ2wnwtlhHPHI9iBIj2iM+M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] per signal_struct coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junio@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> make that a "merge".  If it is "fake", I guess that any random point
>> in Linus's history would do, but I can understand that the maintainer
>> would complain about such a seemingly unnecessary (back) merge.
>
> Having thought about it a bit more, I am not sure if these merges
> are truly "fake", or just a normal part of distributed development.
>
> As a degenerated case, first I'd imagine you have a patch series
> that focuses on a single "theme".  You perfect the patches, you fork
> a topic branch from an appropriate "public" commit of your upstream
> (e.g. the last stable release from Linus), you add a signed tag at
> the tip of that topic branch, and you ask a (subsystem) maintainer
> to pull from you.  The subsystem maintainer's tree will have series
> of merges to collect work from other people working in the subsystem
> ('x'), and the pull from you will create a merge whose first parent
> is one of these 'x' (i.e. the work by the maintainer so far), and
> the second parent of it is the tip of your work.  The merge commit M
> gives a detailed description of what happend on the side branch and
> its mergetag header carries the contents of the tag you created for
> the pull request.
>
>       \   \
>     ---x---x---M
>               / Subsystem maintainer pulls from you
>              /
>   ...---o---o (your work)
>
> Your next topic, which is a chunk of the same larger theme, may
> depend on what you did in the commits in this initial series 'o'.
>
>
>       \   \       \   \
>     ---x---x---M---x---x---N
>               /           / Subsystem maintainer pulls from you again
>              /           /
>   ...---o---o---p---p---p (your second batch)
>
>
> Eventually, this will be pulled into Linus's tree when the subsystem
> maintainer is ready to send the whole thing.
>
>                               Y--- (Linus's tree)
>                              / Linus pulls from subsystem maintainer
>       \   \       \   \     /
>     ---x---x---M---x---x---N (Subsystem maintainer's tree)
>               /           /
>              /           /
>   ...---o---o---p---p---p (Your tree)
>
> The above picture only depicts two topics, one directly building on
> top of the other, from you, but that is simplified merely for
> illustration purposes.  The real history may have more topics, some
> are dependent on others, while some are independent.
>
> Now, if you have many related but more or less independent topic
> branches that will support a larger theme, it would be quite natural
> if you acted as your own "subsystem" maintainer, in other words, in
> the above picture:
>
>  . you are in control of not just the bottom line, but in the middle
>    line of development;
>
>  . you do not have 'x' that merges from other people;
>
>  . but you do have M and N, and use these merges just like a
>    subsystem maintainer would use to describe the work done in the
>    side branches.
>
> and offer 'N' as the tip of a "larger" topic that has internal
> structure, not just a single strand of pearls, by adding a signed
> tag on 'N' and throwing a pull request at Linus (or whoever is
> immediately above your level).
>
> Is that what happened (as I said, I lack context)?  If so, I do not
> see much problem in the situation.  But this assumes that these so
> called "fake" merges are merging into right first parents.

Yes.  I write and post the patches with my developer hat on,
and I merge them with my maintainer hat on, then ultimately I send
them to Linus with the same maintainer hat on.


The full email conversation is at:
https://lore.kernel.org/all/878ry512iv.fsf@disp2133/T/#u

Here is where Linus merged the change:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a602285ac11b019e9ce7c3907328e9f95f4967f0

In this specific case it is a very degenerate case as there was only one
set of changes.


The one difference from my work flow and the one you described
is that I haven't reach the point of signing my pull requests.


In general and especially this cycle I intend to have multiple
changesets each with their own merge commit delineating them.  Short of
being informed of a better way to work.


I suspect the conversation is simply because the pull request was
sufficiently degenerate that things just looked really weird.  But I am
open to learning otherwise.

Eric




