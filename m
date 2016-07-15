Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86233203BD
	for <e@80x24.org>; Fri, 15 Jul 2016 05:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbcGOF4Z (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 01:56:25 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:21491 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbcGOF4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 01:56:24 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rrMJP2Cwhz5tlB;
	Fri, 15 Jul 2016 07:56:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 4F1CB52DC;
	Fri, 15 Jul 2016 07:56:20 +0200 (CEST)
Subject: Re: [PATCH] git-clean: remove fifo, devices, socket files
To:	Andrey Vagin <avagin@openvz.org>
References: <1468550579-9298-1-git-send-email-avagin@openvz.org>
Cc:	gitster@pobox.com, git@vger.kernel.org
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <ab717fc4-fd07-53d1-1a88-ceba6155889c@kdbg.org>
Date:	Fri, 15 Jul 2016 07:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <1468550579-9298-1-git-send-email-avagin@openvz.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 15.07.2016 um 04:42 schrieb Andrey Vagin:
> Currently git-clean removes only links and files, but
> there can be special files like fifo, sockets, devices.
>
> I think git-clean has to remove them too.

I think that is not necessary. If you do

   mkfifo fifo && sudo mknod zero c 1 5

then 'git status' will not report them and 'git add' will not add them 
to a repository.

Similarly, if you happen to have a special file under a name in your 
working tree where the repository has regular files, then 'git status' 
will report the names as modified, and 'git reset --hard' will replace 
the special files by the files recorded in the repository.

IOW: These special files are invisible for Git unless it already knows 
the names. The latter case is outside 'git clean's domain, and the 
former case really means that special files in the working tree are left 
at the user's discretion.

-- Hannes

