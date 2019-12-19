Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E368CC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A0C20716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLSSDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:03:25 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:25127 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSSDY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:03:24 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ii08x-0002HI-OH; Thu, 19 Dec 2019 19:03:23 +0100
Subject: Re: [PATCH 2/5] parse_branchname_arg(): introduce expect_commit_only
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
 <a84633a44474aa25bd1101a9ca2a5d9687900bf2.1574969538.git.gitgitgadget@gmail.com>
 <xmqqfthhe92v.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <713f8aea-cdd6-3fcd-8e9f-c9b909454ef5@syntevo.com>
Date:   Thu, 19 Dec 2019 19:03:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqfthhe92v.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.12.2019 20:18, Junio C Hamano wrote:

>> `has_dash_dash` unexpectedly takes `opts->accept_pathspec` into account.
> 
> You also touched the code that depends on opts->accept_pathspec in
> the earlier step 1/5; these two steps seem harder to reason about
> than necessary---I wonder if it is easier to explain and understand
> if these two steps are merged into one and explained together?

Yes, that sounds like a good idea! In V3 in other topic [1] I have 
shuffled the changes between commits for easier understanding.

>> +	if (has_dash_dash)
>> +	    expect_commit_only = 1;
> 
> Non-standard indentation here.

Sorry!

>> +	opts->count_checkout_paths = !opts->quiet && !expect_commit_only;
> 
> OK.  count_checkout_paths is relevant only when checking out paths
> out of a tree-ish, so "expect-commit-only" would be false in such a
> situation.  On the other hand, if we were checking out a branch (or
> detaching), we must have a commit and a tree-ish is insufficient,
> so expect_commit_only would be true in such a case.
> 
> Makes sense.  I am wondering if we still need has_dash_dash, and
> also if expect_commit_only is the best name for the variable.

It seems that indeed, the variable could use an even better name. It's 
<commit> as opposed to <pathspec>, and not as opposed to <tree-ish>. I 
have renamed the variable again in V3 in other topic [1].

----
[1] 
https://lore.kernel.org/git/pull.490.v3.git.1576778515.gitgitgadget@gmail.com/
