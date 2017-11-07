Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4225F202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 14:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933867AbdKGOcn (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 09:32:43 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:17404 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbdKGOcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 09:32:42 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id C4vge5ffNpb8rC4vgepx2r; Tue, 07 Nov 2017 14:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510065160;
        bh=MffgBvXPRmgeKaWtdT3sMUdZg7oIYBPEwZ8JV7kfZ1k=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I8uamx1H9mzOs5tEbwkXFh7llo6OK5vGAe6OB9zapCvX2MkbqVR2lsJpNRYIpx+A7
         7Tm/rw8DkypBkbWc935GwT1M2R4JavQV0kQXjA87dOUuon8bgcjP38se1fnFil6ZAM
         WKr3qSiW98clbPiv8F9WQsiWH6v90C4jAKNWOo1A=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=0hRNfuDKx-M2hwCfPbMA:9 a=QEXdDO2ut3YA:10 a=SHUmGpGg8TAA:10
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 4/8] commit: move print_commit_summary() to libgit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
 <20171106112709.2121-5-phillip.wood@talktalk.net>
 <xmqqlgjig3lv.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7849f0e9-24eb-89db-3524-dffdb00d82ad@talktalk.net>
Date:   Tue, 7 Nov 2017 14:32:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgjig3lv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHEYpSef1B6w4LyCSSUZg/yza14OHiixNFd1dT1yPId2XsE9oGhfrgDgcxcS+oRarGIl/TL8h6HUrQn1ZttLSsqERFEjibRjqLiI5svzEcoD8vbh/ZsJ
 ub2EWCPk9tUFX7GZ1DpTnReQlo4TBKLMB0uI0FdjF1U0cA1qGFYLjOxp6T7YyDqz9Gla+D3kpYXI4HDETtsSwKZp5xorovN3huOwEygmmkgszkLKySdHgYms
 teKcVMXzK2oZTRsuQaest/0j9Zj3kmdy5Y9nLpSJ4IcTPYDD9c6CKpzVSzQ229Ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/17 03:38, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Move print_commit_summary() from builtin/commit.c to sequencer.c so it
>> can be shared with other commands. The function is modified by
>> changing the last argument to a flag so callers can specify whether
>> they want to show the author date in addition to specifying if this is
>> an initial commit.
> 
> A movement of a long function like this one really is easier if you
> did not make any other unnecessary change in the same patch and then
> made the change as a follow-up.

I'm not sure what you mean by unnecessary, the original code called a
file-local function author_date_is_interesting(). That had to be changed
in order to move the code, I guess it would have been clearer to make
that change first and then move the modified code to sequencer.c in a
separate commit.

> The end result seemed sane.  
> 
> Do not use signed int as a collection of bits "flags", as it makes
> readers wonder if you are going to do some clever thing by treating
> the topmost bit somewhat special (e.g. "if (flags < 0)").  Unless
> you are indeed doing something clever like that, use "unsigned int"
> instead.
> 

Thanks, I'll change it to an unsigned int.

Best Wishes

Phillip
