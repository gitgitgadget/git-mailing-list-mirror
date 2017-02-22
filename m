Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC66201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 20:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934486AbdBVUpK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 15:45:10 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:17885 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934465AbdBVUpE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 15:45:04 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id gdmXc9tE446SJgdmYc6Wf2; Wed, 22 Feb 2017 20:45:03 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=1XWaLZrsAAAA:8
 a=uPZiAMpXAAAA:8 a=oAYF_C9AAAAA:8 a=U-nTR59oH9PhCsFOOnoA:9 a=wPNLvfGTeEIA:10
 a=nJcEw6yWrPvoIXZ49MH8:22 a=svzibyHiZmA4t4YY0eFS:22 a=qaKyCUGJxuDmXQJvZgRi:22
Message-ID: <F50FAF9C5F724A87B5424494262E1BAD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>, <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>, <gitster@pobox.com>, <sop@google.com>,
        "Stefan Beller" <sbeller@google.com>
References: <20170221231815.4123-1-sbeller@google.com>
Subject: Re: [PATCH] submodule init: warn about falling back to a local path
Date:   Wed, 22 Feb 2017 15:01:50 -0000
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
X-CMAE-Envelope: MS4wfG6Ycpy5jFe1oykqHLVsWSJloDsfhBGWT/UDjAMzzz1Tb+M/4mDRZHrVc52ZjPLsffTcCy/BK/e6KwYD8H0KTkLaRaGtFPcOYG2MazErL8cfOpJj9x0S
 tBDruid1GY0gJrlO1Z66NfIPVXKUiMgwyO/eHpe+9xCD6mypvBXeCWDfCohALDtVUhjpZK8p3rUyrbEpt0usb0/TSQ9o06mryWU9bvxlfb7p+37PoGOgKRVj
 7nOHmvw7VefO3QoscHXKfvEF0JUaUDp8xyL+pz8P0Lxf/6oPmQICO+knyr5Igxk7i43oC4VYEL0GDYAB/62eKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> When a submodule is initialized, the config variable 
> 'submodule.<name>.url'
> is set depending on the value of the same variable in the .gitmodules
> file. When the URL indicates to be relative, then the url is computed
> relative to its default remote. The default remote cannot be determined
> accurately in all cases, such that it falls back to 'origin'.
>
> The 'origin' remote may not exist, though. In that case we give up looking
> for a suitable remote and we'll just assume it to be a local relative 
> path.
>
> This can be confusing to users as there is a lot of guessing involved,
> which is not obvious to the user.

Would a note in the user docs about the fallback you list above also be 
useful?

>
> So in the corner case of assuming a local autoritative truth, warn the
> user to lessen the confusion.
>
> This behavior was introduced in 4d6893200 (submodule add: allow relative
> repository path even when no url is set, 2011-06-06), which shared the
> code with submodule-init and then ported to C in 3604242f080a (submodule:
> port init from shell to C, 2016-04-15).
>
> In case of submodule-add, this behavior makes sense in some use cases[1],
> however for submodule-init there does not seem to be an immediate obvious
> use case to fall back to a local submodule. However there might be, so
> warn instead of die here.
>
> [1] e.g. 
> http://stackoverflow.com/questions/8721984/git-ignore-files-for-public-repository-but-not-for-private
> "store a secret locally in a submodule, with no intention to publish it"
>
> Reported-by: Shawn Pearce <spearce@spearce.org>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> builtin/submodule--helper.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
--
Philip 

