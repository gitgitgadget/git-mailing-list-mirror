Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE0D1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbcIBWYT (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 18:24:19 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:28765 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbcIBWYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 18:24:18 -0400
Received: from PhilipOakley ([92.22.49.238])
        by smtp.talktalk.net with SMTP
        id fwshb0jUjxR4bfwshbo3DS; Fri, 02 Sep 2016 23:24:16 +0100
X-Originating-IP: [92.22.49.238]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=txR83ole7ZIDfyRmTcr8FA==:117
 a=txR83ole7ZIDfyRmTcr8FA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=by_K5aTjz1vVX1IXSdcA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <55512A8927384A0790DDC7F526B09053@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert Dailey" <rcdailey.lists@gmail.com>,
        "Git" <git@vger.kernel.org>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>
Subject: Re: Fixup of a fixup not working right
Date:   Fri, 2 Sep 2016 23:24:16 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfLQYGUHD3HLDCmeFKAOd8OHZwEWM8QCELFqheVBgLsxuLNQI3lYoIOzul/Po9/dk7PUgxCohmjXpd9ptzJPd859TM9Bj2rBLy0Jca3Zire0/JwXDmLIV
 aP/gXzvmfQ/OdyQxcrZnyYw1el011OE1yoalYFYTQu0JEgegVwfJE6muVRRQ3Ns69rVO2pyOubXEes92J2XNFxMOAzAr/jxpvjQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert Dailey" <rcdailey.lists@gmail.com>
> Suppose I have a branch with 4 commits, in the following order (as you
> might see during interactive rebase):
>
> pick 123 Original Change
> pick 789 fixup! Original Change
> pick 456 Some Other Thing
> pick abc fixup! fixup! Original Change
>
> However, let's say the first commit is already pushed upstream on a
> topic branch. Since there are multiple developers on this topic
> branch, I do not want to rebase right now. Instead, I want to document
> future fixups via fixup commits and then when we're ready to merge, do
> a final rebase prior to the merge to master to clean things up after
> we're all done collaborating.
>
> For this specific situation, since the first commit is already pushed,
> I want to perform a fixup on the 1st fixup commit. When I perform an
> interactive rebase against upstream topic, I get the following:
>
> pick 789 fixup! Original Change
> pick 456 Some Other Thing
> pick abc fixup! fixup! Original Change
>
> The tip commit (abc in this case) is not marked as a fixup. What I
> expect to see is:
>
> pick 789 fixup! Original Change
> fixup abc fixup! fixup! Original Change
> pick 456 Some Other Thing
>
> Is this by design, or a defect? I assumed that Git would only look at
> the first occurrence of "fixup!" and treat everything else after as
> the commit description to match. But it seems in this case that it
> stops at the last occurrence of "fixup!", which would explain why it
> isn't matching in the interactive rebase. I haven't looked at the
> code, though.

As I understand this it's implied by design. The issue is that the rebase is 
looking for that named commit within its current rebase range, and can't 
find it, so ignores it.

There is a separate issue that all the fixup! fixup! messages are 
essentially treated as being concatenations of the original fixup!, no 
matter how many time the fiup is present.

In the mean time you should reword those commit messages as being 
'bug-fixes' as they are (you say) already upstream and hence published. You 
can make the first as a bug-fix and the following ones a fixup!s.

>
> Thoughts? Also I'm perfectly willing to accept feedback involving me
> just using the feature wrong or as not intended. Thanks in advance.
> 

