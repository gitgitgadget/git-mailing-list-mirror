Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6FC61F516
	for <e@80x24.org>; Fri, 22 Jun 2018 17:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbeFVRgJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 13:36:09 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:14491 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751375AbeFVRgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 13:36:08 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41C5MW07X5z5tlL;
        Fri, 22 Jun 2018 19:36:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 193411CA9;
        Fri, 22 Jun 2018 19:36:06 +0200 (CEST)
Subject: Re: Unexpected ignorecase=false behavior on Windows
To:     Marc Strapetz <marc.strapetz@syntevo.com>
References: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <1c7e338e-157b-fd2f-5eb1-01373f627acd@kdbg.org>
Date:   Fri, 22 Jun 2018 19:36:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.06.2018 um 14:04 schrieb Marc Strapetz:
> On Windows, when creating following repository:
> 
> $ git init
> $ echo "1" > file.txt
> $ git add .
> $ git commit -m "initial import"
> $ ren file.txt File.txt
> $ git config core.ignorecase false

This is a user error. core.ignorecase is *not* an instruction as in 
"hey, Git, do not ignore the case of file names". It is better regarded 
as an internal value, with which Git remembers how it should treat the 
names of files that it receives when it traverses the directories on the 
disk.

Git could probe the file system capabilities each time it runs. But that 
would be wasteful. Hence, this probe happens only once when the 
repository is initialized, and the result is recorded in this 
configuration value. You should not change it.

> Status results are:
> 
> $ git status --porcelain
> ?? File.txt
> 
> As on Unix, I would expect to see:
> 
> $ git status --porcelain
>   D file.txt
> ?? File.txt
> 
> Is the Windows behavior intended? I'm asking, because e.g. JGit will 
> report missing files, too, and I'm wondering what would be the correct 
> way to resolve this discrepancy? (JGit does not have 
> "ignorecase=true"-support at all, btw).

Then I don't think there is a way to remove the discrepancy.

-- Hannes
