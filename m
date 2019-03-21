Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7AAC202BB
	for <e@80x24.org>; Thu, 21 Mar 2019 11:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfCUL7i (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 07:59:38 -0400
Received: from mail.javad.com ([54.86.164.124]:57943 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUL7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 07:59:38 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id C688A3F3C0;
        Thu, 21 Mar 2019 11:59:36 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=qaQL3/w6;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553169577;
        bh=6JQgo4+j3q6vV36n3csRJiEUdx8vp5C08WlyNevV17k=; l=2876;
        h=Received:From:To:Subject;
        b=qaQL3/w6ozY/jluu6wCf8gM8WAgl1yxUFZ7nkqaUS+qv6lAsePPcJosq9dBZfX2mM
         vG+BzoUnP2HBhW9bxfrmiHKsfWobIliKQARddGvnQaoKGXYNPTZjk5hgigVsW8JgyY
         4Cn5PdFZE3OpUIVLDPivp9y28Xq0Croz628kKfjA=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h6wMB-0004R6-7Y; Thu, 21 Mar 2019 14:59:35 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
        <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com>
        <87pnqklr8a.fsf@javad.com>
        <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com>
        <878sx8lpqw.fsf@javad.com>
        <xmqqbm24sk68.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 14:59:35 +0300
In-Reply-To: <xmqqbm24sk68.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Mar 2019 17:31:27 +0900")
Message-ID: <87k1gsh1zs.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> The same effect can be had by just reverting "let's allow -m1 for
>>> single-parent commit", can't it?  That is a far simpler solution, I
>>> would say.
>>
>> Those one didn't introduce the issue currently at hand, as we still
>> don't allow merges by default, so why do we need to rewind it?
>
> With it reverted, "[alias] cp = cherry-pick -m1" can be used to train
> the user to blindly pick a range that has a merge without thinking,
> which is what I meant by "ship has already sailed".

Did you mean "With it *not* reverted" here? Because with it reverted,
"cherry-pick -m1" will rather loudly fail on the first non-merge commit
in the range. Such alias would be useless without that patch.

Those who don't like such alias are still free not to define or use it.

> With it reverted, a range pick of a straight single strand of pearls
> would still work just fine.  And the user is forced to think and
> chop a range with a merge into a set of subranges each of which is a
> single strand of pearls, plus picking individual merges (if picking
> these merges is really what the user wants, that is).

Unfortunately, this gets us back to the exact problem with practical
use-case the patch was provoked by. There was a large number of commits
to be picked, and the set has been carefully built by "git rev-list" (as
"git cherry-pick" built-in features were not enough: yet another issue).
Some of these commits were merges, and handling all this manually (and
repeatedly) would be a real pain. It was easier to locally patch "git
cherry-pick -m1" to achieve the goal. Then I thought that it could help
others in the future, and then took time to provide the patch. It'd be
a real pity to get back to where I started.

BTW, the above also shows that the issue with "-m 1" existed even before
"git cherry-pick" started to accept ranges, as I was not using these
ranges anyway.

Overall, I mean that I still need a way to tell "git cherry-pick" that I
do know what I'm doing, so that it stops complaining on a non-issue.
Thus if the patch is reverted, a new option should be added just for
this goal, -- back to where we are now, but an option already added.

> As ensuring the users to think is the whole point of excercise,

Yeah, provided they do have a suitable way out. Without that patch,
there was none.

> the original system before we allowed "-m1" for single parent commit
> was after all giving us the right balance, I guess, without having to
> add yet another new option.

No, unfortunately it didn't, and to me the patch in question still seems
to be in the right direction, legitimate, and useful.

Moreover, I still can't see how it's harmful. Just don't use '-m 1' if
you don't want merges.

-- Sergey
