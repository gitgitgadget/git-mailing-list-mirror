Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97D9201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 23:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbdKIXPM (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 18:15:12 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:47194 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753850AbdKIXPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 18:15:11 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id Cw2Oery7mbjdZCw2Oe2H94; Thu, 09 Nov 2017 23:15:09 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=qX0ueMBeGtnBRC8gHW8A:9 a=bANY1TUM1s0iwQze:21
 a=sk7XHJPs6GDoXEyE:21 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <EA775C6AB4684B7A86A88C733C132827@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Ann T Ropea" <bedhanger@gmx.de>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>
References: <20171105162730.31405-1-bedhanger@gmx.de>        <20171107025321.31028-1-bedhanger@gmx.de>        <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
Date:   Thu, 9 Nov 2017 23:15:06 -0000
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
X-Antivirus: AVG (VPS 171109-2, 09/11/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfP/7CypjH+qE/a3qpnWtiObjhxw35X0lP54Dnl6+j3JlTScKMsZlNtSivOSwicosPh07DWQJUdZNfYB1i9SgkHgeyMdDZ5j0XzAiwx34zo2dDfONcvjS
 anEJ5h7uxdL8ULaehuZAei11cahdc2G78xA1miCkAZwYWBHfbV3N6MXjSt4tiV+Z18JhrPiShK3pKtM1vcuIGG9nrWUGJS/YET5aXqLPRRhJ1LTHaaUmLLne
 QUC0tp5DvDhPFo8PPpah3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Wednesday, November 08, 2017 1:59 AM


> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> But...
>>> ...
>>> This change causes quite a few tests to fall over; however, they
>>> all have truncated-something-longer-ellipses in their
>>> raw-diff-output expected sections, and removing the ellipses
>>> from there makes the tests pass again, :-)
>>
>> The number of failures you report in the test suit suggests that
>> someone somewhere will be expecting that notation, and that we may
>> need a deprecation period, perhaps with an 'ellipsis' config variable
>> whose default value can later be flipped, though that leaves a config
>> value needing support forever!
>
> Hmmm, never thought about that.
>
> I have been assuming that tools reading "--raw" output that is
> abbreviated would be crazy, because they have to strip the dots and
> the number of dots may not always be three [*1*].
>
> But you are right.  It would be very unlikely that there is no such
> crazy tools, so it deserves consideration if we would be breaking
> such tools.
>
> On the other hand, if such a crazy tool was still written correctly
> (it is debatable what the definition of "correct" is, though), it
> would be stripping any number dots at the end, not just insisting on
> seeing exactly three dots, and splitting these fields at SP.
> Otherwise they would already be broken as they cannot handle
> occasional object names that have less than three dots because they
> happen to be longer than the more common abbreviation length used by
> other objects.  So in practice it might not be _too_ bad.
>
Thinking on this, I'd suggest that the patch series does remove the ellipsis 
dots immediately, but retains a config option that can be set to get back 
the old 'dots' display for those who have badly written scripts that maybe 
haven't failed yet. i.e. no deprecation period, just a fall back option; and 
if nobody shouts then remove the config option after a respectable period.

It would also mean the existing tests can be re-used...

>
> [Footnote]
>
> *1* When we ask for --abbrev=7, we allocate 10 places and fill the
> rest with necessary number of dots after the result of
> find_unique_abbrev(), so if an object name turns out to require 8
> hexdigits to make it unique, we'll append only two dots to it to
> make it 10 so that it aligns nicely with others) and they would
> always be reading the full, non abbreviated output.  The story does
> not change that much when we do not explicitly ask for a specific
> abbreviation length in that we add variable number of dots for
> aligning in that case, too.

The --abbrev=7 does cater for many smaller repo's, so there is a possiblity 
that the bad script issue hasn't been hit yet by those repos.
--

Philip 

