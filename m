Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A621D1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfKFP4d (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:56:33 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:60210 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfKFP4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:56:32 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iSNfa-0004iY-Tp; Wed, 06 Nov 2019 16:56:31 +0100
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
 <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
Date:   Wed, 6 Nov 2019 16:56:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I have implemented most suggestions in PatchV2. Thanks!

> It might be worth tailoring the message to the command rather than 
> having exactly the same message for commit and reset

I decided to move the general comment to base commit where options are 
introduced and not repeat it where options are supported.

> I wonder if there is a way of calling parse_pathspec_file() from 
> parse_and_validate_options() instead. Otherwise we end up validating 
> options here instead which is a bit messy.

The code looks a bit too entangled to support that without making it 
worse. The biggest concern I have is that parse_and_validate_options() 
will populate `pathspec` and some other function will need to remember 
to clean it up. I like it better when `pathspec` is handled in one place.

I agree that things are not perfect, but this seems to be a consequence 
of other existing problems. For example, I would have expected a 
structure instead of a handful of global variables. That would have 
solved many problems. However, I didn't have the bravery to dive into 
this refactoring.
