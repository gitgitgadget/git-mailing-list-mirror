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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A62720248
	for <e@80x24.org>; Fri, 22 Mar 2019 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfCVPWN (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 11:22:13 -0400
Received: from mail.javad.com ([54.86.164.124]:43626 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfCVPWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 11:22:12 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 86C273E93B;
        Fri, 22 Mar 2019 15:22:11 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=F8tAb5sD;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553268131;
        bh=gp8Rnt7FMsa1f1iJMHA0GqX2G3i9WL8B/Pa6YwG24PM=; l=3073;
        h=Received:From:To:Subject;
        b=F8tAb5sDJbYoSs7NvYmJwVdJLyZogOgKiNAdB0M+EV337Go2vPnhj3aHgAxLKaAYL
         LIe/NBm6ZwM+ueaKmF6MRob0Z376wblxVhjTT6NgEsBlcxhn2vC6jgcSYmjO8Fbyiu
         ZPcagD5v845L53YrpU+eg3XEnEJuWqO/LUqGb4Lo=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h7Lzm-0006Lx-3E; Fri, 22 Mar 2019 18:22:10 +0300
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
        <87k1gsh1zs.fsf@javad.com>
        <xmqqy357r6im.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 22 Mar 2019 18:22:10 +0300
In-Reply-To: <xmqqy357r6im.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 22 Mar 2019 11:24:01 +0900")
Message-ID: <8736nfc4t9.fsf@javad.com>
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
>>> With it reverted, "[alias] cp = cherry-pick -m1" can be used to train
>>> the user to blindly pick a range that has a merge without thinking,
>>> which is what I meant by "ship has already sailed".
>>
>> Did you mean "With it *not* reverted" here?
>
> Thanks for a correction.  Yes, if we do not revert it, then that
> would allow people to follow a bad workflow we do not want to
> recommend (and I think that is what Elijah does not want to do), and
> that is why I said the ship has already sailed.

I still don't think it makes sense to revert the patch (that fixed a
real-life issue) on the sole ground that, as a side-effect, it has
provided an opportunity that could potentially be abused, specifically
by defining a random alias, and then shooting oneself in the foot with
it. And even then no irreversible damage actually happens.

Moreover, if somebody actually wants to "follow a bad workflow", he
still needs to ask for it explicitly, either by providing '-m 1', or by
defining and using an alias, so let him do it please, maybe he even does
know what he is doing, after all.

>
>> Those who don't like such alias are still free not to define or use it.
>
> That's not the point.  Those who do want to be careful can learn to
> use a new option --forbid-stupid-things, but why should they?

Sure thing, who said they should? Fortunately, that's exactly the
current state, no need to invent and specify any --forbid-stupid-things
option, and even if we pretend the option is already there and is
active by default, still no need to revert anything.

> They should be forbidden from doing stupid things by default, which is
> the point of this exchange.

I already agreed before to assume this, and it seems that we now all
agree this safety should be preserved, as there are those who actually
care. However, as merges are already forbidden right now with all the
current defaults, I fail to see how it could justify reverting of
already applied patch.

To me, the actual question here is: what's the option that overrides
that default? The current answer is: "-m 1", that admittedly is not very
nice, but has not been introduced by any of the recent patches, so is
not solvable by reverting any of them.

To summarize, as it looks to me, it's mostly the current way of allowing
merges, that cryptically reads as "-m 1", that makes the OP unhappy.
This was already the case before the "allow '-m 1' for non-merge
commits" patch, so reverting it won't solve the problem in any suitable
way.

Due to all the above, may we please finally let alone the already
applied patch and focus on finding (or denying) actual solution to the
original issue of this thread?

If so, I'm still on the ground of providing new, say,
"--no-forbid-merges" option, if anything. I'm with Duy Nguyen that the
way suggested by RFC, making value optional for yet another short
option, is to be avoided at all costs.

-- Sergey
