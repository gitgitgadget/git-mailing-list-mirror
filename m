Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90546202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 14:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755122AbdKGO2x (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 09:28:53 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:24006 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755046AbdKGO2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 09:28:52 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id C4rze5fIhpb8rC4rzepwvz; Tue, 07 Nov 2017 14:28:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510064931;
        bh=S4/Xt4IwTRop21jLB8VEdLOr+fAqxcfoVchVXhKM5kE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GsUqhdyyhdneVTu+TTQU1Oj0gqJnq/u+3bHFLQwjRPzNtoCiggAfgRlHDG4EYciE0
         ijXYebZ5SISyNCM2wIuid4NTGet+Xs4BKYMJTgtRDWEDEY7m6rVY9Hw9dm4qhTrsOW
         6cU5otH7+uL6012l/S3fp1gqlislj47l9bi75RrY=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=ALxn1UI8Cdqh-BuCW3MA:9 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 3/8] commit: move post-rewrite code to libgit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
 <20171106112709.2121-4-phillip.wood@talktalk.net>
 <xmqqpo8ug587.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a3d29ea7-1939-1595-0978-08a418b2b324@talktalk.net>
Date:   Tue, 7 Nov 2017 14:28:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo8ug587.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNtYLQUjGNuRVGJNWwQzVOa4oHOVMn8JdbIKNE8pRf2ehG3EJJJQYin/jhrxiC8juqE/tyEalNbb2agJo488Nxda4LGomlruV7hMdYQPJ5tf4xWDZFt9
 BZOA0f758zPZcyzMK39tyCPtoz35STZgZBSroSIOo1TU/ktFhNxKQz8J9itOkSuCafVW4WRXqnN1aL0rPcobsdHNuu41JMKRgyVKZqML1bfVuiqCfr1L99+c
 Z28gechyLrs9F439ZHepop39DPrT2zRldbFOxoTcGMCX53XeE/rBi+qBu/HCU5FU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/17 03:03, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Move run_rewrite_hook() from bulitin/commit.c to sequencer.c so it can
>> be shared with other commands and add a new function
>> commit_post_rewrite() based on the code in builtin/commit.c that
>> encapsulates rewriting notes and running the post-rewrite hook.
> 
> This, especially the part that rips out the notes rewriting from
> builtin/commit.c and moves it to elsewhere, is a bit curious
> separation of labor.  I guess we'll see why in later steps in the
> series.

It's so the sequencer can have a built in version of 'git commit
--amend' when processing fixup/squash commands. I'll expand the commit
message to explain why this is needed later.


> The change itself looks like a regression-free no-op, which is good.
> 

