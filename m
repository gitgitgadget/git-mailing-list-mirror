Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5830C2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdJCUZD (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:25:03 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:63865 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbdJCUZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:25:01 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3y69WH3mVRz5tl9;
        Tue,  3 Oct 2017 22:24:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 86E962127;
        Tue,  3 Oct 2017 22:24:57 +0200 (CEST)
Subject: Re: [PATCH 3/3] sub-process: allocate argv on the heap
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-4-t.gummerer@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <85456f81-9e9f-d0e4-86f7-9f546691dee3@kdbg.org>
Date:   Tue, 3 Oct 2017 22:24:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171003195713.13395-4-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.10.2017 um 21:57 schrieb Thomas Gummerer:
> diff --git a/sub-process.c b/sub-process.c
> index 6dde5062be..4680af8193 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -77,7 +77,9 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
>   {
>   	int err;
>   	struct child_process *process;
> -	const char *argv[] = { cmd, NULL };
> +	const char **argv = xmalloc(2 * sizeof(char *));
> +	argv[0] = cmd;
> +	argv[1] = NULL;
>   
>   	entry->cmd = cmd;
>   	process = &entry->process;
> 

Perhaps this should become

	argv_array_push(&process->args, cmd);

so that there is no new memory leak?

-- Hannes
