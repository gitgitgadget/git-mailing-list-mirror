Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E849202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 14:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbdKGOY5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 09:24:57 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:44248 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbdKGOY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 09:24:56 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id C4o9e5eunpb8rC4o9epwo9; Tue, 07 Nov 2017 14:24:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510064694;
        bh=OwDZBslLpBxjAI1i2VkthWLa+cuvsvBUZcpEI4dcnXI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cIz7BSny8uDvTM985Y/HG5d7VrvP2Rt792CosjG+5TycZG4TF9UMfTzyLMFo7LPJi
         RBNDIgb6n3vigzQXntSUIY+F2kn1BMHgPRHx7KS31kqUpDFzftm2jJm/4Mh48mSta6
         JLmmguOGFaYaTRjKAITCV5kliRZSH7fXV/BDj4V0=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=z--0miu0g-leITsC8MwA:9 a=hHTIS6bp7xTyj1Qc:21 a=ne-cJOXglnOt1-G7:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 1/8] commit: move empty message checks to libgit
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
 <20171106112709.2121-2-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1711070141110.6482@virtualbox>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4f35fa04-c0a0-2e1f-5a59-7e18154242e9@talktalk.net>
Date:   Tue, 7 Nov 2017 14:24:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711070141110.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBh0RgcRf70n3bYL7zY60IjLxGN0Lcqmi0Qbwt6pE5y/hVrreHTd6fLtqNHspEy8XqdXudIjySFohIVTMaPow/heF6YafiHNvVgknqe5aoNqc1XX5/mP
 BtxIul8Chcqhi6jNj01B2t9j0JJQfMaC626QD8vA1cbRZz9AFhbEe3kHy9sMpcrEgwq3zf3M5Fs15q/0FYSH03mVUvGbdWra7YbjRUvucY/KLW8eRJ+Jq+It
 /wrq9PtRHpuOQxYgodFllX/F74fhmuZH80ko1QkgoG9KHZppGvsRrAihlB6TpYvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/17 00:43, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 6 Nov 2017, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Move the functions that check for empty messages from bulitin/commit.c
>> to sequencer.c so they can be shared with other commands. The
>> functions are refactored to take an explicit cleanup mode and template
>> filename passed by the caller.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Good rationale. Just one thing:
> 
>> diff --git a/sequencer.h b/sequencer.h
>> index 6f3d3df82c0ade64b7b125acd49bf3f5e15c53af..65a4b0c25185d7ad5115035abb766d1b95df9a62 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -58,4 +58,14 @@ extern const char sign_off_header[];
>>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
>>  void append_conflicts_hint(struct strbuf *msgbuf);
>>  
>> +enum cleanup_mode {
>> +	CLEANUP_SPACE,
>> +	CLEANUP_NONE,
>> +	CLEANUP_SCISSORS,
>> +	CLEANUP_ALL
>> +};
> 
> When it was file-local, `cleanup_mode` was okay (although far from great).
> Now that we want to make it more widely available, I fear we have to make
> the name much longer, e.g. `commit_msg_cleanup_mode`.

That's certainly less ambiguous! I'll bite the bullet and extend the name.

