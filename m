Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0473220C11
	for <e@80x24.org>; Thu, 30 Nov 2017 14:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdK3OYL (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 09:24:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:18751 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbdK3OYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 09:24:09 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1D975844EE;
        Thu, 30 Nov 2017 09:24:09 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E1C18844E3;
        Thu, 30 Nov 2017 09:24:08 -0500 (EST)
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Vitaly Arbuzov <vit@uber.com>, git@vger.kernel.org
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
Date:   Thu, 30 Nov 2017 09:24:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/29/2017 10:16 PM, Vitaly Arbuzov wrote:
> Hi guys,
> 
> I'm looking for ways to improve fetch/pull/clone time for large git
> (mono)repositories with unrelated source trees (that span across
> multiple services).
> I've found sparse checkout approach appealing and helpful for most of
> client-side operations (e.g. status, reset, commit, etc.)
> The problem is that there is no feature like sparse fetch/pull in git,
> this means that ALL objects in unrelated trees are always fetched.
> It may take a lot of time for large repositories and results in some
> practical scalability limits for git.
> This forced some large companies like Facebook and Google to move to
> Mercurial as they were unable to improve client-side experience with
> git while Microsoft has developed GVFS, which seems to be a step back
> to CVCS world.
> 
> I want to get a feedback (from more experienced git users than I am)
> on what it would take to implement sparse fetching/pulling.
> (Downloading only objects related to the sparse-checkout list)
> Are there any issues with missing hashes?
> Are there any fundamental problems why it can't be done?
> Can we get away with only client-side changes or would it require
> special features on the server side?
> 
> If we had such a feature then all we would need on top is a separate
> tool that builds the right "sparse" scope for the workspace based on
> paths that developer wants to work on.
> 
> In the world where more and more companies are moving towards large
> monorepos this improvement would provide a good way of scaling git to
> meet this demand.
> 
> PS. Please don't advice to split things up, as there are some good
> reasons why many companies decide to keep their code in the monorepo,
> which you can easily find online. So let's keep that part out the
> scope.
> 
> -Vitaly
> 


This work is in-progress now.  A short summary can be found in [1]
of the current parts 1, 2, and 3.

> * jh/object-filtering (2017-11-22) 6 commits
> * jh/fsck-promisors (2017-11-22) 10 commits
> * jh/partial-clone (2017-11-22) 14 commits

[1] https://public-inbox.org/git/xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com/T/

I have a branch that contains V5 all 3 parts:
https://github.com/jeffhostetler/git/tree/core/pc5_p3

This is a WIP, so there are some rough edges....
I hope to have a V6 out before the weekend with some
bug fixes and cleanup.

Please give it a try and see if it fits your needs.
Currently, there are filter methods to filter all blobs,
all large blobs, and one to match a sparse-checkout
specification.

Let me know if you have any questions or problems.

Thanks,
Jeff
