Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80447202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 17:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935990AbdKPRdA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 12:33:00 -0500
Received: from siwi.pair.com ([209.68.5.199]:11052 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964920AbdKPR2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 12:28:52 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EDCC4844D5;
        Thu, 16 Nov 2017 12:28:51 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A7071844CB;
        Thu, 16 Nov 2017 12:28:51 -0500 (EST)
Subject: Re: [PATCH v3 4/6] list-objects: filter objects in
 traverse_commit_list
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171107193546.10017-1-git@jeffhostetler.com>
 <20171107193546.10017-5-git@jeffhostetler.com>
 <20171107152034.47686f6ece72ea3d43005b12@google.com>
 <xmqqr2t9l5xk.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e8261f46-7818-66df-a58f-d11627c17868@jeffhostetler.com>
Date:   Thu, 16 Nov 2017 12:28:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2t9l5xk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/8/2017 12:01 AM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> Having said that, though, it might be safer to still introduce one, and
>> relax it later if necessary - it is much easier to relax a constraint
>> than to increase one.
> 
> It would also be more error prone to have such a long switch ()
> statement, each of whose case arm needs to be carefully looked at.
> 
> While protection against attacks over the wire against the process
> that receives the request is necessary and doing the quoting right
> at this layer is one valuable component of it, we would need to be
> careful about what features we allow the other side to request.
> 
> For example, an innocent-looking use of get_oid_with_context() can
> trigger an expensive operation, e.g. "master^{/sekritCodeName}", may
> not just waste resources but also may reveal the presence of an
> object that we might not want to leak to a stranger.  Limiting such
> an abuse must sit at a lot higher layer than a byte-by-byte check
> over the request like the code does.
> 

Right.  I could see adding another server-side variable in the
spirit of the existing "uploadpack.allow*" variables.

My main concern at this point has been avoiding injections.

Jeff

