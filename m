Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D4C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1063C64EC5
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhBIROQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:14:16 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56683 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhBIROM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:14:12 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DZqGB4G2Wz1qs0n;
        Tue,  9 Feb 2021 18:12:50 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DZqGB1MDBz1t6pC;
        Tue,  9 Feb 2021 18:12:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id zeSmzVsWnTMv; Tue,  9 Feb 2021 18:12:49 +0100 (CET)
X-Auth-Info: JUlnB12eB4/JmKX9MqzDXxBcjoE/FOZsvDL0ZRay/KArwxwI66RLNNeFtuGYNYbP
Received: from igel.home (ppp-46-244-185-213.dynamic.mnet-online.de [46.244.185.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 Feb 2021 18:12:49 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 547022C361B; Tue,  9 Feb 2021 18:12:48 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: how to most effectively cherry pick by selective patch hunk?
References: <566b38df-307c-f342-b583-3a50a81b5057@crashcourse.ca>
        <YCK6w/VbfUtM68Ad@coredump.intra.peff.net>
X-Yow:  Now I'm having INSIPID THOUGHTS about the beautiful, round
 wives of HOLLYWOOD MOVIE MOGULS encased in PLEXIGLASS CARS
 and being approached by SMALL BOYS selling FRUIT..
Date:   Tue, 09 Feb 2021 18:12:48 +0100
In-Reply-To: <YCK6w/VbfUtM68Ad@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 9 Feb 2021 11:39:31 -0500")
Message-ID: <87im712mi7.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Feb 09 2021, Jeff King wrote:

> Of course that involves a change to Git, and you were looking for
> something you could do with existing versions. :) You can emulate it by
> making the commit's parent equivalent to your current state. I.e.:
>
>   git checkout --detach ;# detached HEAD for temporary commit
>   git cherry-pick $commit ;# maybe deal with conflicts
>   commit=$(git rev-parse --verify HEAD) ;# remember the temp commit
>   git checkout - ;# back to your branch
>   git checkout -p $commit

Alternatively, you could cherry-pick normally, then use
 git checkout -p HEAD^
to remove what you don't want.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
