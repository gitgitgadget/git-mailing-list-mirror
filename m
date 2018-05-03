Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F32A200B9
	for <e@80x24.org>; Thu,  3 May 2018 13:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeECN3u (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 09:29:50 -0400
Received: from avasout04.plus.net ([212.159.14.19]:47900 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECN3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 09:29:49 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id EEItfD8H7sD7bEEIufYdex; Thu, 03 May 2018 14:29:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=ljNTjMXPF_evwjSVPPgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/5] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        christian.couder@gmail.com, pc44800@gmail.com
References: <20180503005358.89082-1-sbeller@google.com>
 <20180503005358.89082-2-sbeller@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f8c0fb71-4bb1-3793-76ef-1052e739849b@ramsayjones.plus.com>
Date:   Thu, 3 May 2018 14:29:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503005358.89082-2-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJvVxsBZWEwEMXWdbUIjnXsTIvETJcQWbT64YIpd/XUUHi+gecplmh5uEH5SWZy0s4VGcC1+8dy65FJ98XLS3XNgQMbNGqjaBpmwHufHRTv6ShEZ8dzP
 KAlPqskJwJWsvYPc3Y8A8EUgvyi1ryYZCiIY+xVehyllFr0PEThWrUU7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/05/18 01:53, Stefan Beller wrote:
> From: Prathamesh Chavan <pc44800@gmail.com>
> 
> When running 'git submodule foreach --recursive' from a subdirectory of
> your repository, nested submodules get a bogus value for $path:
> For a submodule 'sub' that contains a nested submodule 'nested',
> running 'git -C dir submodule foreach echo $path' from the root of the
> superproject would report path='../nested' for the nested submodule.
> The first part '../' is derived from the logic computing the relative
> path from $pwd to the root of the superproject. The second part is the
> submodule path inside the submodule. This value is of little use and is
> hard to document.
> 
> There are three different possible solutions that have more value:
> (a) The path value is documented as the path from the toplevel of the
>     superproject to the mount point of the submodule. If 'the' refers to
>     the superproject holding this submodule ('sub' holding 'nested'),
>     the path would be expected to be path='nested'.
> (b) In case 'the' superproject is referring to the toplevel, which
>     is the superproject in which the original command was invoked,
>     then path is expected to be path='sub/nested'.
> (c) The documentation explains $path as [...] "relative to the
>     superproject", following 091a6eb0fe (submodule: drop the
>     top-level requirement, 2013-06-16), such that the nested submodule
>     would be expected as path='../sub/nested', when "the" superproject
>     is the superproject, where the command was run from
> (d) or the value of path='nested' is expected if we take the
>     intermediate superproject into account. [This is the same as
>     (a); it highlights that the documentation is not clear, but
>     technically correct if we were to revert 091a6eb0fe.]
> 
> The behavior for (c) was introduced in 091a6eb0fe (submodule: drop the
> top-level requirement, 2013-06-16) the intent for $path seemed to be
> relative to $cwd to the submodule worktree, but that did not work for
> nested submodules, as the intermittent submodules were not included in
----------------------------^^^^^^^^^^^^
intermediate

ATB,
Ramsay Jones
