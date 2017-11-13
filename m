Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D521F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 11:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbdKMLMQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 06:12:16 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:43642 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbdKMLMP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 06:12:15 -0500
Received: from [192.168.2.201] ([92.22.30.94])
        by smtp.talktalk.net with SMTP
        id ECefezMRymITaECepeEzAK; Mon, 13 Nov 2017 11:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1510571534;
        bh=XkLJDzG+RGh72pUlOHoUrg3vJ8iOagfIbW962s4WZMY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VXmDbmATIMaM5G0NuYutwAPJ2YWKNAM4vGzgIA74RlxBPw6sTYhBCH5ZHIc9OVRQV
         Y945uAfcUCUAlQSLD/W1PBODuFW23s8MX0IwTJRRh8FuNj1hmeP9sHd8dirNrQd1gA
         kbvJDNoFeW19KF8MrZcBFB+FKK3uIu3BtVuGjofg=
X-Originating-IP: [92.22.30.94]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=lje0BXTe3+PqU+djfnm1WA==:117
 a=lje0BXTe3+PqU+djfnm1WA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=I7ZZ8Od9tPHz9YZaB0YA:9 a=QEXdDO2ut3YA:10
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
 <072b0edb-7a30-77f3-2ac5-893c28c0a695@talktalk.net>
 <xmqqk1yyf1q0.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <536b1a9e-92a2-b907-3489-d4059534edb8@talktalk.net>
Date:   Mon, 13 Nov 2017 11:11:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1yyf1q0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIE1vNdImMiNBaqnk++GbHQalgp9YdTaFGTXgpWA9zIw0cN6MQ5y2QD9Y+WdArLni59RBz86N18rM/TsxSxHeFtF+m4jlMGCX7BhLjSQbayfVhnkD/y6
 ee+vFSR9kR8FiYZ6SdYPbwHJKgmY/8ESOnZWg2Yvrva8hISko4Vb1ke+ep0YymNOsVJtyR+spNunPDU6JnLl9Kfzn4DyzWmuXPsa5CSPcZY5k8vP/OlJSufa
 Eslq2p4PU3PnDwWNSiTtBFQRJBMkty/KhhtE3/4IM1CfDl+e6pfbSotilHFFoKXs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/17 18:05, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> On 07/11/17 15:13, Junio C Hamano wrote:
>> ...
>>> Another possibility perhaps is that the function is safe to reuse
>>> already even without this patch, of course ;-).
>>>
>> Hmm, maybe it is. Looking at pick_commits() and do_pick_commit() if the
>> sequencer dies in print_commit_summary() (which can only happen when
>> cherry-picking or reverting) then neither the todo list or the abort
>> safety file are updated to reflect the commit that was just made.
>>
>> As I understand it print_commit_summary() dies because: (i) it cannot
>> resolve HEAD either because some other process is updating it (which is
>> bad news in the middle of a cherry-pick); (ii) because something went
>> wrong HEAD is corrupt; or (iii) log_tree_commit() cannot read some
>> objects. In all those cases dying will leave the sequencer in a sane
>> state for aborting - 'git cherry-pick --abort' will rewind HEAD to the
>> last successful commit before there was a problem with HEAD or the
>> object database. If the user somehow fixes the problem and runs 'git
>> cherry-pick --continue' then the sequencer will try and pick the same
>> commit again which may or may not be what the user wants depending on
>> what caused print_commit_summary() to die.
> 
> The above is all good analysis---thanks for your diligence.  Perhaps
> some if not all of it can go to the log message?
> 
Thanks, that's a good idea. I see the above as a reason to drop this
commit as returning an error will try and update the abort safety file
which we don't want to do if there is a problem with HEAD so I'll add it
to the previous commit to explain why it is okay to die.
