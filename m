Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DCCC433E6
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1214216FD
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgLXJQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 04:16:48 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:61782 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgLXJQr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 04:16:47 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4D1kvl03gRz5tlD;
        Thu, 24 Dec 2020 10:16:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 98BA520EE;
        Thu, 24 Dec 2020 10:16:00 +0100 (CET)
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
To:     Mike McLean <stixmclean@googlemail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
 <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
 <xmqqczz05b4x.fsf@gitster.c.googlers.com>
 <CAM0jFOfSE3_TQ7WXiR_G6eHOZnr-0ryv=CniXs4sxs1=JnucUg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ab835195-0c69-830b-c7cb-71d50b4ce4db@kdbg.org>
Date:   Thu, 24 Dec 2020 10:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAM0jFOfSE3_TQ7WXiR_G6eHOZnr-0ryv=CniXs4sxs1=JnucUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.12.20 um 01:13 schrieb Mike McLean:
> I agree that "realism and frequency of use case" is a critical metric :D
> 
> For me it's very much the 2nd case you described and there are 2
> scenarios that it comes up in most frequently:
> 
> [...]
> 2) Interactive rebases
> I make heavy use of interactive rebases, in order to make committing
> be a REALLY low effort task. If I don't have to clean up my commits
> when I make them, then I can commit really easily, which means I
> commit frequently, which is a good thing :D But then I have a messy
> git history. Especially if I'm juggling a bunch of small fixes at
> once, and I end up with bits of one fix/refactor in a commit that was
> mostly about another thing.
> 
> Not a problem: Interactive rebase to the rescue!
> 
> I use `edit` mode to split stuff apart and then squash mode to push
> the relevant bits back together again.
> But a downside of this is that frequently I end up with the commit
> with the good message being *after* the scrappy bit that's just been
> split off from another commit.
> Sometimes I can just pull that scrappy bit past the main commit and
> then `fixup` that bit, but often that would cause merge conflicts, so
> it'd be easier to have a fixdown that does exactly what I'm going to
> do with `squash`.
> 
> =-=-=-=-=-=-=-=-=-=-=
> 
> I recognise that these might be very niche or non-standard usages, and
> if you don't think there would be much demand for such functionality
> then I'm fine with that :D

I would not say that your workflow is exceptional; quite the contrary: I
do exactly like you explained. And I guess that many others do as well
(interactive rebase was invented for uses cases like yours).

I don't mind using 'squash' to consolidate commits where the meat of the
change and the commit message is not in the first one.

But consider a situation like this, which I find myself in regularly:

    $ work
    $ git commit -m "WIP begin feature"
    $ work -- ah, this can be done independently:
    $ git commit -m "refactor stuff"
    $ do the real feature (takes time, many commits)
    # finally:
    $ git commit -m "the real feature"

Here I wish that the final commit carries an author date that should be
after the "refactor" commit to be realistic. But 'squash' takes
authorship including the date from the first commit (the "WIP" commit in
this example). That is where the suggested feature could help. I admit,
though, that it's not a huge deal.

-- Hannes
