Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71EA1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 14:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758595AbcIXO2N (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 10:28:13 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:6270 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754578AbcIXO2M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 10:28:12 -0400
Received: from PhilipOakley ([92.22.56.237])
        by smtp.talktalk.net with SMTP
        id nnw1bokMgxR4bnnw1b1j34; Sat, 24 Sep 2016 15:28:10 +0100
X-Originating-IP: [92.22.56.237]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=STbUQm/7X+VKdJQF1oCBnA==:117
 a=STbUQm/7X+VKdJQF1oCBnA==:17 a=8nJEP1OIZ-IA:10 a=yMhMjlubAAAA:8
 a=ybZZDoGAAAAA:8 a=5rxgeBVgAAAA:8 a=PKzvZo6CAAAA:8 a=4PqRy3kfYJMmc3sGEKQA:9
 a=wPNLvfGTeEIA:10 a=BKKCjISod1eDJeS0ORpz:22 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=PwKx63F5tFurRwaNxrlG:22 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <99A866BEF8944598A50C6E061A703297@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Ben Peart" <Ben.Peart@microsoft.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     <pclouds@gmail.com>, <git@vger.kernel.org>
References: <20160913142628.15440-1-benpeart@microsoft.com>        <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>        <BL2PR03MB3232D3128A72D4EC9ADC2C6F4F10@BL2PR03MB323.namprd03.prod.outlook.com>        <BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>        <007401d21278$445eba80$cd1c2f80$@gmail.com>        <xmqqzin3g8di.fsf@gitster.mtv.corp.google.com> <xmqqr38fg6tk.fsf@gitster.mtv.corp.google.com> <BL2PR03MB323ADC371E49EFD1CBBC566F4F60@BL2PR03MB323.namprd03.prod.outlook.com>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
Date:   Sat, 24 Sep 2016 15:28:11 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfL/wijFW0njHuDCTnauQ5eDLcIf7mO8wO62eJBXXOMNVhIp4rNGfm/HQnbfemc1pimnaJMcXznuWNdqvDYDPv1ESS1t3zNe5ebiIrjC9qLCtGom03/7C
 fz/V65lEHZBMchQ/N0lH8QObWoiqeOxb0ZGu+RV9LfX05r12CFa2/CPJZLdD0fF8hIbhHX0bregFcqHqsFUNfDYw1dbSEhJvgCiGScp30OpURZiNnw9gGTYX
 32+ORH7BrVgXgEVDYe2Z+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben,
Using a 'bottom / in-line' posting flow is much preferred, which may require 
some manual editing[1], hopefully I have it about right...
Philip
--
[1] this is massaged and mangled Outlook Express, sometimes one has to work 
with the tools at hand...

From: "Ben Peart" <Ben.Peart@microsoft.com>
> From: Junio C Hamano [mailto:gitster@pobox.com]
> > Junio C Hamano <gitster@pobox.comwrites:
> >
> > >"git checkout -b foo" (without -f -m or <start_point>) is defined in
> > >the manual as being a shortcut for/equivalent to:
> > >
> > >        (1a) "git branch foo"
> > >        (1b) "git checkout foo"
> > >
> > >However, it has been our experience in our observed use cases and all
> > >the existing git tests, that it can be treated as equivalent to:
> > >
> > >        (2a) "git branch foo"
> > >        (2b) "git symbolic-ref HEAD refs/heads/foo"
> > >...
> > >
> > I am still not sure if I like the change of what "checkout -b" is this
> > late in the game, though.
> >
> > Having said all that.
> >
> > I do see the merit of having a shorthand way to invoke your 2 above.
> > It is just that I am not convinced that it is the best way to achieve 
> > that goal to redefine what "git checkout -b <new-name>" (no other 
> > parameters) does.
> >
> ---
>
> I understand the reluctance to change the existing behavior of the "git 
> checkout -b <new-name>" command.
>
> I see this as a tradeoff between taking advantage of the muscle memory for 
> the existing command and coming up with a new shortcut command and 
> training people to use it instead.
>
> The fact that all the use cases we've observed and all the git test cases 
> actually produce the same results but significantly faster with that 
> change in behavior made me hope we could redefine the command to take 
> advantage of the muscle memory.
>
> That said, you're much more on the frontline of receiving negative 
> feedback about doing that than I am. :)  How would you like to proceed?

The discussion can often feel harsh [2], especially if there is accidental 
'talking past each other', which is usually because of differing 
perspectives on the issues.

I didn't see an initial confirmation as to what the issue really was. You 
indicated the symptom ('a long checkout time'), but then we missed out on 
hard facts and example repos, so that the issue was replicable.

Is there an example public repo that you can show the issue on? (or 
anonymise a private one - there is a script for that [3])

Can you give local timings (and indication of the hardware and software 
versions used for the test, and if appropriate, network setup)?

I know at my work that sometime our home drives are multiply mapped to H:, a 
C:/homedrive directory and a $netshare/me network directory via the 
Microsofy roaming profiles, and if there is hard synchronization (or 
whatever term is appropriate) there can be sudden slowdowns as local C: 
writes drop from 'instant' to 'forever'...

Is there anything special about the repos that have the delays? Is it a 
local process issue that causes the repos to develop those symptoms (see 
above about not being sure why you have these issues), in which case it 
could be local self inflicted issues, or it could be that you have a 
regulatory issue for that domain that requires such symptoms, which would 
shift the problem from a 'don't do that' response to a 'hmm, how to cover 
this'.


At the moment there is the simple workaround of an alias that executes that 
two step command dance to achieve what you needed, and Junio has outlined 
the issues he needed to be covered from his maintainer perspective (e.g. the 
detection of sparse checkouts). Confirming the root causes would help in 
setting a baseline.

I hope that is of help - I'd seen that the discussion had gone quiet.

--
Philip


[2] Been there, feel your pain. It's not in any way malicious, just a 
reflection that email can be a poor medium for such discussions.
[3] https://public-inbox.org/git/20140827170127.GA6138@peff.net/ suggest 
that the `git fast-export --anonymize --all` maybe the approach. 

