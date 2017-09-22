Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355D720281
	for <e@80x24.org>; Fri, 22 Sep 2017 11:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbdIVLWb (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 07:22:31 -0400
Received: from siwi.pair.com ([209.68.5.199]:12135 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752086AbdIVLWa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 07:22:30 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 96A6B8468C;
        Fri, 22 Sep 2017 07:22:29 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1FD1484635;
        Fri, 22 Sep 2017 07:22:28 -0400 (EDT)
Subject: Re: [PATCH] git: add --no-optional-locks option
To:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <7a2d895c-df8c-1305-234f-7f8e2b271ec2@kdbg.org>
 <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <dcd542e9-ba92-4dc8-6929-2d0f02bd6307@jeffhostetler.com>
Date:   Fri, 22 Sep 2017 07:22:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170922042539.fs37bauiabfqcjx5@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/22/2017 12:25 AM, Jeff King wrote:
> On Thu, Sep 21, 2017 at 08:25:50PM +0200, Johannes Sixt wrote:
> 
>>> +`GIT_OPTIONAL_LOCKS`::
>>> +	If set to `0`, Git will avoid performing any operations which
>>> +	require taking a lock and which are not required to complete the
>>> +	requested operation. For example, this will prevent `git status`
>>> +	from refreshing the index as a side effect. This is useful for
>>> +	processes running in the background which do not want to cause
>>> +	lock contention with other operations on the repository.
>>> +	Defaults to `1`. >>
>> I don't think we should pass this environment variable to remote
>> repositories. It should be listed in local_repo_env[] in environment.c.
> 
> I'm not sure I agree. This is really about the context in which the
> command is executing, not anything about the particular repository
> you're operating on.
> 
> For fetch/push operations that touch a remote, I doubt it would matter
> either way (and anyway, those often cross network boundaries that don't
> propagate environment variables anyway).
> 
> But imagine that "git status" learns to recurse into submodules and run
> "git status" inside them. Surely we would want the submodule repos to
> also avoid taking any unnecessary locks?
> 
> -Peff
> 

https://github.com/git-for-windows/git/commit/ff63b51c22389139a864eb2e565c6cdc5a30f061

https://github.com/git-for-windows/git/pull/1004/commits/45bad66192352481acbc826f11d90c8928b39a7a

We should compare this with what we did in Git for Windows last fall.
I guess those commits didn't get pushed upstream.

We added '--no-lock-index' to keep status from locking the index
during status and effectively being read-only.  This helped with
problems with Visual Studio similar to the ones being described
for KDevelop.

Jeff

