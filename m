Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8EF1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 23:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbdBIX5P (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 18:57:15 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:48911 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdBIX5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 18:57:14 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id byaOcecwWcpskbyaOcIqsv; Thu, 09 Feb 2017 23:57:13 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8
 a=HT6eWQxRrusZO9_mngwA:9 a=10FpKyCUU8CcekRc:21 a=EXAqMlvutUhXG3DU:21
 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22
Message-ID: <1637154470724DABAC99AF6199707A4B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Jeff King" <peff@peff.net>, "David Turner" <dturner@twosigma.com>
Cc:     <git@vger.kernel.org>, <pclouds@gmail.com>
References: <20170209020222.23642-1-dturner@twosigma.com> <20170209032325.bspll66ux6n2pj4n@sigill.intra.peff.net>
Subject: Re: [PATCH] gc: ignore old gc.log files
Date:   Thu, 9 Feb 2017 23:57:12 -0000
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
X-CMAE-Envelope: MS4wfC/b0kSr/mALr7RxK5t14TRLuwMzXghWNA7Exo9kQj5nnfp5fyeRwK2PfJa3IMX3MxIlx3mPxdxGq8LzpQXlmx5XxHG6cfAHsM4ycl9z9fMcCvl4tc2p
 QNstrlVpZ0GipmLBqhvuGJXa5NPw8Q02w03OzOXtR2Yfov8PPYVNDNtKEr6WQDhVuCYytZKANCKFQhFxmg02GdaYHipgK5eautEnquT7Ah/3+TGy4tu6IbfF
 HA7nh9lmsVa2dLnhxXV30w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jeff King" <peff@peff.net>
> On Wed, Feb 08, 2017 at 09:02:22PM -0500, David Turner wrote:
>
>> The intent of automatic gc is to have a git repository be relatively
>> low-maintenance from a server-operator perspective.  Of course, large
>> operators like GitHub will need a more complicated management strategy,
>> but for ordinary usage, git should just work.
>>
>> In this commit, git learns to ignore gc.log files which are older than
>> (by default) one day old.  It also learns about a config, gc.maxLogAge
>> to manage this.
>>
>> So git should never get itself into a state where it refuses to do any
>> maintenance, just because at some point some piece of the maintenance
>> didn't make progress.  That might still happen (e.g. because the repo
>> is corrupt), but at the very least it won't be because Git is too dumb
>> to try again.
>
> Sounds like a good goal and approach.
>
>> +gc.maxLogAge::
>> + If the file gc.log exists, then `git gc --auto` won't run
>> + unless that file is more than maxLogAge seconds old.  Default
>> + is 86400, one day.

Is there a reason why one day is chosen? If maintenance staff are available 
24/7 then a shorter time would be appropriate, but if it's a 5 day work week 
then they may want longer. Is there a particular case it targets?

>
> For other time-based config, we use approxidate with a relative time,
> like "1 day ago". I think it would make sense for this to match, as it
> makes the config a little more readable.
>
> You can follow the prune_expire example which is right below your new
> config variable in all of the hunks of your patch. Though I think
> ultimately that isn't parsed inside gc, so you'd eventually look at how
> "prune --expire" is handled (which I think is via parse_expiry_date()).
>
[...]

Philip 

