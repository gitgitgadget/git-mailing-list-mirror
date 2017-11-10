Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D3B1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 14:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbdKJOxE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 09:53:04 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:59358 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdKJOxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 09:53:04 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id DAg1eBljRpb8rDAg1esXuq; Fri, 10 Nov 2017 14:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510325582;
        bh=ZJchYHwMPoPEdHXgH3p2YeBYUfFtL53oTqT3y8pLIZ8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cE1m+7ll5sSPlJYIpbWnZIi5orC4acaeQ1n8v1K/r2z3d/AeLS7+fdcDxnTy8Ul8X
         jx2BwwnEDtDVcN0eNdm8GpucKtRR8TeMqvyHmPZxTqM1TKaJOLhaPUxciIFgYRCPnS
         9PndHDE0kd/PlPcwhCe/7wNR3a4tT9lwYuVVzeNw=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=vj0-xzsC3HsTRW_3h3UA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 5/8] sequencer: don't die in print_commit_summary()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171106112709.2121-1-phillip.wood@talktalk.net>
 <20171106112709.2121-6-phillip.wood@talktalk.net>
 <xmqq8tfig1rr.fsf@gitster.mtv.corp.google.com>
 <xmqq7ev2dsv2.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <072b0edb-7a30-77f3-2ac5-893c28c0a695@talktalk.net>
Date:   Fri, 10 Nov 2017 14:53:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq7ev2dsv2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA6gxpivKetjVu0BkEtVUZ97q7y7tO4SASMaXztKXCoFtJeKSBmcfJZ0q1X+M20Aijy6v/Iw+tqRC+LB6N5I05zsfCiSChDPjD3F91jOkG7vCqNAMelE
 qvKleKTku85xaVaeDXNG/FkabJhKOZRNa9sWecEy6XbxEcRDIZj1v5fI3A2M3Ht2doVsVi6Sn7yvTMd6hL5t1mTfSHj2dRFTYvN1IuGT6kjAVZzvSOJlBWOs
 GhWuU+4nrMFCHhZ1ru6wE+lk6VGk/9SCr/i8ejFXMioj1b7pCQqVNYAGv+SEzS0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/17 15:13, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> And this step is going in the right direction, but I am not sure if
>> this made the function safe enough to be called repeatedly from the
>> rebase machinery and we are ready to unleash this to the end users
>> and tell them it is safe to use it.
> 
> Another possibility perhaps is that the function is safe to reuse
> already even without this patch, of course ;-).
> 
Hmm, maybe it is. Looking at pick_commits() and do_pick_commit() if the
sequencer dies in print_commit_summary() (which can only happen when
cherry-picking or reverting) then neither the todo list or the abort
safety file are updated to reflect the commit that was just made.

As I understand it print_commit_summary() dies because: (i) it cannot
resolve HEAD either because some other process is updating it (which is
bad news in the middle of a cherry-pick); (ii) because something went
wrong HEAD is corrupt; or (iii) log_tree_commit() cannot read some
objects. In all those cases dying will leave the sequencer in a sane
state for aborting - 'git cherry-pick --abort' will rewind HEAD to the
last successful commit before there was a problem with HEAD or the
object database. If the user somehow fixes the problem and runs 'git
cherry-pick --continue' then the sequencer will try and pick the same
commit again which may or may not be what the user wants depending on
what caused print_commit_summary() to die.


