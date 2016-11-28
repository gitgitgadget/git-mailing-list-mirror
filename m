Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155091FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 21:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755333AbcK1VZ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 16:25:58 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:55114 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752668AbcK1VZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 16:25:57 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tSKVC3K9pz5tlF;
        Mon, 28 Nov 2016 22:25:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7822C140;
        Mon, 28 Nov 2016 22:25:54 +0100 (CET)
Subject: Re: [PATCH v2 00/11] git worktree (re)move
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
 <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com>
 <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <73836804-a581-85a4-b0c0-2aa46a7f9b8d@kdbg.org>
Date:   Mon, 28 Nov 2016 22:25:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2016 um 21:20 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Does this round address the issue raised in
>>
>>   http://public-inbox.org/git/alpine.DEB.2.20.1611161041040.3746@virtualbox
>>
>> by Dscho?
>>
>> Even if you are not tracking a fifo, for example, your working tree
>> may have one created in t/trash* directory during testing, and
>> letting platform "cp -r" taking care of it (if that is possible---I
>> didn't look at the code that calls busybox copy to see if you are
>> doing something exotic or just blindly copying everything in the
>> directory) may turn out to be a more portable way to do this, and I
>> suspect that the cost of copying one whole-tree would dominate the
>> run_command() overhead.
>
> Please do not take the above as me saying "you must spawn the
> platform cp -r".

copy_dir_recursively is used in 'worktree move' when the move is across 
file systems. My stance on it is to punt in this case. *I* would not 
trust Git, or any other program that is not *specifically* made to copy 
a whole directory structure, to get all cases right when a simple 
rename() is not sufficent. And, uh, oh, it does a 
remove_dir_recursively() after it has finshed copying. No, Git is not a 
tool to move directories, thank you very much!

-- Hannes

