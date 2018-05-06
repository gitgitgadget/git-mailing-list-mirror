Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0145E2023D
	for <e@80x24.org>; Sun,  6 May 2018 23:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeEFXDc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 6 May 2018 19:03:32 -0400
Received: from antelope.ash.relay.mailchannels.net ([23.83.222.4]:9799 "EHLO
        antelope.ash.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751849AbeEFXDc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 May 2018 19:03:32 -0400
X-Greylist: delayed 13861 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 May 2018 19:03:30 EDT
X-Sender-Id: p38ruhd5tl|x-authuser|ms@kilabit.info
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E23E8500C54;
        Sun,  6 May 2018 23:03:26 +0000 (UTC)
Received: from sg09.dewaweb.com (unknown [100.96.13.46])
        (Authenticated sender: p38ruhd5tl)
        by relay.mailchannels.net (Postfix) with ESMTPA id 09A19500C45;
        Sun,  6 May 2018 23:03:25 +0000 (UTC)
X-Sender-Id: p38ruhd5tl|x-authuser|ms@kilabit.info
Received: from sg09.dewaweb.com (sg09.dewaweb.com [172.19.61.140])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.14.1);
        Sun, 06 May 2018 23:03:26 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: p38ruhd5tl|x-authuser|ms@kilabit.info
X-MailChannels-Auth-Id: p38ruhd5tl
X-Industry-Keen: 0a42a1522e608ae8_1525647806689_2452623049
X-MC-Loop-Signature: 1525647806689:292245130
X-MC-Ingress-Time: 1525647806689
Received: from [139.228.118.230] (port=34910 helo=localhost.localdomain)
        by sg09.dewaweb.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <ms@kilabit.info>)
        id 1fFSgd-006Kuc-Hu; Mon, 07 May 2018 07:03:23 +0800
Date:   Mon, 7 May 2018 06:03:22 +0700
From:   Shulhan <ms@kilabit.info>
To:     Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [bug] Multiline value should error if the next line is section
Message-ID: <20180507060322.66b121bd@kilabit.info>
In-Reply-To: <CAN0heSooYuGkxP9u0Uuwu_TCEOd_pj20L05=bwwHynPOapej6g@mail.gmail.com>
References: <20180507020348.31b473b4@kilabit.info>
        <CAN0heSooYuGkxP9u0Uuwu_TCEOd_pj20L05=bwwHynPOapej6g@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-AuthUser: ms@kilabit.info
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 6 May 2018 22:03:10 +0200
Martin Ågren <martin.agren@gmail.com> wrote:

> Hi Shulhan
> 
> Thank you for your report. I'm abbreviating a bit:
> 
> On 6 May 2018 at 21:03, Shulhan <ms@kilabit.info> wrote:
> > [alias]
> >         tree = --no-pager log --graph \
> >                 -n 20 \
> > [user]
> >         name = Shulhan
> >
> > (2) Run `git config -f git.config -l`
> >
> > The command print the following output,
> >
> > alias.tree=--no-pager log --graph -n 20 [user]
> > alias.name=Shulhan  
> 
> Small mistake, big consequences. :-)
> 
> This behavior looks correct to me, though. It seems very hard to me to
> second-guess what the user meant. For example, what if that third line
> contained a "="? Like:
> 
> [alias]
>         huh = !dd \
>               bs=1024 ...
> 
> Should Git guess that the backslash on the second line was a mistake?
> Or maybe not, because alias.bs = "1024 ..." would be a useless alias?

The context of multiline next value that I reported before was
about section, not variable.

> 
> I think such guessing would be theoretically possible, but especially
> if Git guesses wrong, that could be very frustrating to fight against.
> 

I'm not familiar with git config parser, obviously :), but checking
the start of next multiline value that start with '[' maybe not
impossible. Git should not guessed, but report error at the
offending line: either user forgot to enclosed the variable with
double quote or they missplace the backslash.
