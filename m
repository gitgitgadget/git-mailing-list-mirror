Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3B21F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756225AbeASSzR (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:55:17 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:12270 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756195AbeASSzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:55:06 -0500
Received: from [192.168.2.201] ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id cbodeiKtdpb8rcbodecnso; Fri, 19 Jan 2018 18:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516388104;
        bh=ekX6wckfe/jy30564+GTzOSc71F5SGXyn9EwsHT0PD4=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=XCd94WRMYA1BFZBSKfhD6+0zp0VKLKEYamk8l6HQ+WiG4L6EEI6A3OXBsFqOa2/GE
         uQuZlti0pETwnLJXpO79GZ0r0E80e652uSlpQAFhKxINLHNbkZ8lZF8TIPBr7+O1yo
         +mNRzORgRkeguNmFD97PuP1GIMx2G0wMZtqZQjxc=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=IkcTkHD0fZMA:10 a=qCpffpwGBEQzZuBsVGoA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to resettherevision
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
 <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org>
Message-ID: <229b332d-56b8-0183-f57b-b0db0c62f781@talktalk.net>
Date:   Fri, 19 Jan 2018 18:55:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNKOejI8v7FEcyEYCM/YgCuQe0Q4dtkTV69WZA7oTcUhidv1jeWPHp8NFKGMgVE/13zsZya1IAnXH1pJTFcJMTvOfE/CxDEX8HkI20+KRAHSDddqIpWX
 S1oMtxdgYXMMWuX2P8lCPzml81jtSYkzLRId7G1H5w1KS0NPo+xBsCHf8oIbRMU7Qo3OlZSv9Iw+dYWPaOYbPgLFU2TaND+OXjfYqD1zPnr4nvOO7wOOe0Z/
 u+nrU1iI+EKKzPcULVRZTrAD9PT2nDokoub1CXOycNhflUmAjhQaiOe4VM47VuRF9Mbaie6q7LK2s2482EYe1gnk3vujZ6eWVhO1gJRBlqWrE0JrXyIMmaQV
 lHkT7ROs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/01/18 12:24, Phillip Wood wrote:
> 
> On 18/01/18 15:35, Johannes Schindelin wrote:
>>
>> Internally, the `label <name>` command creates the ref
>> `refs/rewritten/<name>`. This makes it possible to work with the labeled
>> revisions interactively, or in a scripted fashion (e.g. via the todo
>> list command `exec`).
> 
> If a user has two work trees and runs a rebase in each with the same
> label name, they'll clobber each other. I'd suggest storing them under
> refs/rewritten/<branch-name or detached HEAD SHA> instead. If the user
> tries to rebase a second worktree with the same detached HEAD as an
> existing rebase then refuse to start.
> 

Ah this isn't a concern after all as patch 5 makes refs/rewritten local
to the worktree. Perhaps you could move that part of patch 5 here or add
a note to the commit message that it will become worktree local later in
the series

Best Wishes

Phillip
