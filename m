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
	by dcvr.yhbt.net (Postfix) with ESMTP id B9258202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCTP7h (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 11:59:37 -0400
Received: from mail.javad.com ([54.86.164.124]:46887 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCTP7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 11:59:37 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id BEBD03E89D;
        Wed, 20 Mar 2019 15:59:35 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=gWeFyFIm;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553097576;
        bh=vYhSvXYPWSvRxV5zDfY8TjeZUBHHOkai6dq/HqdWxpI=; l=3474;
        h=Received:From:To:Subject;
        b=gWeFyFImNW2d4rmW0ETwiMuKBIBCBc/wr0Sq/3R3u8JtMwS7pmlTg62etnMQvRKJr
         8uXkqbc4iG0/DnbSHbsBqPsFoN0KwVegCHSwzNpCDuyFO1+6j+yivk0DYL8FhM6cfv
         vUEj8IK5OqLipQ0nP+K/ui+fn7sjNcTN/68nAUpw=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h6dcs-0002nV-BI; Wed, 20 Mar 2019 18:59:34 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>
        <871s31vjo7.fsf@javad.com>
        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
Date:   Wed, 20 Mar 2019 18:59:34 +0300
In-Reply-To: <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 20 Mar 2019 08:39:16 -0600")
Message-ID: <87lg19mt95.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Mar 20, 2019 at 8:09 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> [...]
>>
>> > But I do have a very strong opinion against adding yet another
>> > option that takes an optional argument.  If we want to allow
>> > cherry-picking a merge commit just as easy as cherrry-picking a
>> > single-parent commit, "git cherry-pick -m merge" (assuming 'merge'
>> > is the tip of a branch that is a merge commit) that still requires
>> > the user to say "-m" is not a good improvement.  We should just
>> > accept "git cherry-pick merge" without any "-m" if we want to move
>> > in this direction, I would think.
>>
>> Let's just make '-m 1' the default option indeed. No need for further
>> complexities.
>>
>> Exactly according to what Junio has already said before. Here:
>>
>> https://public-inbox.org/git/xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com
>>
>> Junio wrote:
>>
>> > Now, it appears, at least to me, that the world pretty much accepted
>> > that the first-parent worldview is often very convenient and worth
>> > supporting by the tool, so the next logical step might be to set
>> > opts->mainline to 1 by default (and allow an explicit "-m $n" from
>> > the command line to override it).  But that should happen after this
>> > patch lands---it is logically a separate step, I would think.
>>
>> ... and as that patch already landed...
>
> This worries me that it'll lead to bad surprises.  Perhaps some folks
> cherry-pick merges around intentionally, but I would want that to be a
> rare occurrence at most.  There are lots of folks at $DAYJOB that
> cherry-pick things, not all of them are expert git-users, and I am
> certain several have erroneously attempted to cherry-pick merges
> before.

Wow, random Joes cherry-picking here and there... Sounds like a bigger
problem is lurking here.

> I would much rather they continued to get an error message
> and then asked other folks for help so that someone can explain to
> them what they should instead be doing rather than silently changing
> the current error into an unwanted operation.  Granted, the users will
> at least get a confusing "Merge branch <foo>" commit message for
> something that isn't a merge, but I don't think the users will notice
> that either.  It just means we've got both confusing and ugly history
> without the necessary individual commits or with too much having been
> cherry-picked.

To me it seems that cherry-picking wrong commit is cherry-picking wrong
commit, no matter if it's a merge or not. I don't think that trying to
save a user from such a mistake worth the trouble, given that
cherry-pick is reversible operation, but I still see your point.

> If -m 1 is too much to ask people to specify, could we provide some
> other shorthand? Or at least make a default-off config option people
> would have to set if they want a cherry-pick of a merge to succeed
> without specifying -m?

If we decide we still need this safety precaution, I'd opt to continue
to require '-m 1' to cherry-pick a merge, rather than adding some
special support. Not such a big deal.

BTW, doesn't git have generic configuration support to add default
option to a command, I wonder (I'm aware of aliases, but they don't
seem to fit)? The C.J. then would simply add '-m 1' to 'cherry-pick' in
configuration. No luck?

-- Sergey

