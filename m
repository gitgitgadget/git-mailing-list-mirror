Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5981F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 20:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbcIAU40 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:56:26 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:33358 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbcIAU4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:56:25 -0400
Received: from PhilipOakley ([92.22.49.238])
        by smtp.talktalk.net with SMTP
        id fYuDbxVAJxR4bfYuDbnMZX; Thu, 01 Sep 2016 21:48:14 +0100
X-Originating-IP: [92.22.49.238]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=txR83ole7ZIDfyRmTcr8FA==:117
 a=txR83ole7ZIDfyRmTcr8FA==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=YGorz3P08l4qv9jjzD4A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <1BC836ACA8C741AD9732122B3B198752@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <2FA1998250474E76A386B82AD635E56A@PhilipOakley><xmqqfuprdtwh.fsf@gitster.mtv.corp.google.com><CD6AE25418644EB688D4488F8AB40155@PhilipOakley> <xmqq8tvby19a.fsf@gitster.mtv.corp.google.com>
Subject: Re: Are --first-parent and --ancestry-path compatible rev-list options?
Date:   Thu, 1 Sep 2016 21:48:14 +0100
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
X-CMAE-Envelope: MS4wfDeC7SZLdRx0xgMYbXstCSDnEZZi/+pP4nqX4T979XlI6qtvmvZ32PzH69ugToVwnGSynM5KJohmqszS/W7wTX0Byjk4VDQa4AVP8Cb2Uh61SDTO+VV+
 R3O+brHJ4MgcXcs1Gr4liS9w8u7LrTEz1ZEW/LjnziL/q0XjP9FPYWWz9geTAl27vssdkl/zqDJvqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>
>>>> The commit graph. We are looking for F based on knowing J.
>>>>
>>>> . A - B - C - D -- E -- F -- G - H    <-first parent, --merges (C,F,H)
>>>> .  \  |  /    \        /    /
>>>> .   ----Z     |       /    /
>>>> .     |       |       |   /
>>>> .      \       \     /   /
>>>> .       I -[J]- K - L - M             <-since J, children of J
>>>> .        \         /
>>>> .         N - O - P
>>>
>>> I think these two operations are fundamentally incompatible.
>>
>> If I run them independently, they both find the desired INTERESTED
>> commit, hence the expectation that together they will still find that
>> commit as an intersection between the two sets.
>>
>>>
>>> Because the first-parent traversal is what the name says, i.e.,
>>> forbids the positive side of revision traversal to stray into side
>>> branches, the positive side of a traversal that begins at H will not
>>> see M, L and K.
>>
>> But it does see F the ultimately desired commit.
>
> You are doing --merges --first-parent, right?  Traversing only the
> first-parent chain on the positive side, while excluding J's
> ancestor by traversing the negative side without being limited to
> the first-parent chain, would paint B and its ancestors as
> uninteresting on the first-parent chain, so among H, G, F, E, D and
> C, which are the survivors on the first-parent chain that are still
> not UNINTERESTIN, the last one you would find that is a merge is F.
>
> So I do not see any room for "But" to come in here...
>

The confusion is between the "As required" and "as coded" viewpoints (this 
is regular dayjob problem of allegedly having 'requirement specifications').

You have rightly described the algorithm as currently implemented, while I 
was was trying to state a requirement (based on a user question).

The user question was, given a commit 'J', and a future commit 'H' 
(typically a branch tip such as 'master'), find those commits that are :
A) merges
B) on the first parent DAG chain of the future commit 'H'
C) children of the given commit 'J'

i.e. the points on master where the feature J (and it's children) could have 
brought in some effect to master.

Each of the three conditions match one of the revision list options, but the 
implemented logic does not produce the AND effect that could be expected. 
Essentially it (the user's desire vs the coding implementation) is a case 
where (depending on the viewpoint) we get the 'denying the antecedent' 
fallacy.

Just because a commit is not --first-parent does not mean that revison 
walking (in this case) should stop. The user is interested in the ancestry 
path, so from that perspective the the walk should carry on through the 
other parents till its reaches the TRULY_DISINTERESTED line, or reaches J.


With the current implementation one appears to need to script a search 
through all the first parent merges and then prune out those that aren't 
merge-base is-ancestor commits, which is what the OP ended up having to do.


I haven't had any time to look into the rev-walk code itself, but is this 
something that could be coded (new option) or is the double-duty problem 
with UNINTERESTING too hard baked into the code?
--
Philip

