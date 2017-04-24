Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAAA4207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 22:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978561AbdDXWL7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 18:11:59 -0400
Received: from avasout08.plus.net ([212.159.14.20]:49777 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978256AbdDXWL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 18:11:58 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id CNBv1v0031keHif01NBw4V; Mon, 24 Apr 2017 23:11:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=mviJlhNYUKBwYg-DG0kA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [GSoC][RFC/PATCH v2] submodule: port subcommand foreach from
 shell to C
To:     Stefan Beller <sbeller@google.com>,
        Prathamesh Chavan <pc44800@gmail.com>
References: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
 <20170422195804.18477-1-pc44800@gmail.com>
 <CAGZ79kb1CR3qKOzByFC_wy7+Fh7cofFT1urhA06RuBK_3vGKmg@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <efe8e82d-a021-5fc4-492a-e6e0ab7d52d3@ramsayjones.plus.com>
Date:   Mon, 24 Apr 2017 23:11:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb1CR3qKOzByFC_wy7+Fh7cofFT1urhA06RuBK_3vGKmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/17 21:03, Stefan Beller wrote:
[snip]

> +
> + argv_array_pushf(&cp.env_array, "name=%s", sub->name);
> + argv_array_pushf(&cp.env_array, "path=%s", displaypath);
> + argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
> 
> You mention keeping 'sm_path' in the notes after the commit message. I would
> add that part to the commit message, to explain why we have multiple variables
> that have the same value. Maybe even a comment in the code:
> 
>     /* Keep sm_path for historic reasons, see tests in 091a6eb0fee. */
>     .. sm_path ..

Hmm, you need to be a bit careful with putting 'path' in the
environment (if you then export it to sub-processes) on windows
(cygwin, MinGW, GfW). See commit 64394e3ae9. I would have liked
to remove $path altogether from the 'submodule-foreach api' in
that commit, but users and their scripts were already using it
(so I couldn't just drop it, without some deprecation period).
So long as whatever was being 'eval'-ed in the script didn't
export $path, ...

ATB,
Ramsay Jones

