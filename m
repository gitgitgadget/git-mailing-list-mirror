Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2A320A40
	for <e@80x24.org>; Sat,  2 Dec 2017 20:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbdLBU4r (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 15:56:47 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22176 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbdLBU4q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 15:56:46 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LEq5ewYcCNSVVLEq5eYdLP; Sat, 02 Dec 2017 20:56:45 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=VwQbUJbxAAAA:8 a=h_5V94UaQotAFXL730YA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>, <gitster@pobox.com>
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de> (Ulrich Windl's message of "Tue, 28 Nov 2017 15:21:49 +0100") <xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com> <5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de>
Subject: Re: Re: bug deleting "unmerged" branch (2.12.3)
Date:   Sat, 2 Dec 2017 20:56:44 -0000
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
X-Antivirus: AVG (VPS 171202-2, 02/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfComjzv8xtfIOvuqtzSZl24hPSUAAmKwxpd6U3b48gzP9t1MA1ynQc/s/oBL+9tTSkcXE4nH66NyIm+ErZcjroX6v5fbVp3BjntlKniFLMjv6y5NV2tJ
 pENW2uc41MWCHyPu8uEDbqEJD0VHG4M56A2JSXo3PYnRiRWbWKGkaQ+Q5a5B63FUVOanENcPXxcLCwZBCg5RHsLkYNNgTSng7z9dIXb9ae0qJtwRO+ggglee
 02dLD/11/eaiE2t5RnA9jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To: <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Sent: Wednesday, November 29, 2017 8:32 AM
Subject: Antw: Re: bug deleting "unmerged" branch (2.12.3)


>
>> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
>>
>>> I think if more than one branches are pointing to the same commit,
>>> one should be allowed to delete all but the last one without
>>> warning. Do you agree?
>>
>> That comes from a viewpoint that the only purpose "branch -d" exists
>> in addition to "branch -D" is to protect objects from "gc".  Those
>> who added the safety feature may have shared that view originally,
>> but it turns out that it protects another important thing you are
>> forgetting.
>>
>> Imagine that two topics, 'topicA' and 'topicB', were independently
>> forked from 'master', and then later we wanted to add a feature that
>> depends on these two topics.  Since the 'feature' forked, there may
>> have been other developments, and we ended up in this topology:
>>
>>     ---o---o---o---o---o---M
>>         \   \
>>          \   o---A---o---F
>>           \         /
>>            o---o---o---o---B
>>
>> where A, B and F are the tips of 'topicA', 'topicB' and 'feature'
>> branches right now [*1*].
>>
>> Now imagine we are on 'master' and just made 'topicB' graduate.  We
>> would have this topology.
>>
>>     ---o---o---o---o---o---o---M
>>         \   \                 /
>>          \   o---A---o---F   /
>>           \         /       /
>>            o---o---o---o---B
>>
>> While we do have 'topicA' and 'feature' branches still in flight,
>> we are done with 'topicB'.  Even though the tip of 'topicA' is
>> reachable from the tip of 'feature', the fact that the branch points
>> at 'A' is still relevant.  If we lose that information right now,
>> we'd have to go find it when we (1) want to further enhance the
>> topic by checking out and building on 'topicA', and (2) want to
>> finally get 'topicA' graduate to 'master'.
>>
>> Because removal of a topic (in this case 'topicB') is often done
>> after a merge of that topic is made into an integration branch,
>> "branch -d" that protects branches that are yet to be merged to the
>> current branch catches you if you said "branch -d topic{A,B}" (or
>> other equivalent forms, most likely you'd have a script that spits
>> out list of branches and feed it to "xargs branch -d").
>>
>> So, no, I do not agree.
>
> Hi!
>
> I can follow your argumentation, but I fail to see that your branches A 
> and B point to the same commit (which is what I was talking about). So my 
> situation would be:
>
> o---oA,B
>
> I still think I could safely remove either A or B, even when the branch 
> (identified by the commit, not by the name) is unmerged. What did I miss?

I think it was that currently you are on M, and neither A nor B are 
ancestors (i.e. merged) of M.

As Junio said:- "branch -d" protects branches that are yet to be merged to 
the **current branch**.

[I said the same in another part of the thread. The question now would be 
what needs changing? the error/warning message, the docs, something else?]

>
> Regards,
> Ulrich
>
>>
>>
>> [Footnotes]
>>
>> *1* Since the 'feature' started developing, there were a few commits
>>     added to 'topicB' but because the feature does not depend on
>>     these enhancements to that topic, B is ahead of the commit that
>>     was originally merged with the tip of 'topicA' to form the
>>     'feature' branch.
> 

