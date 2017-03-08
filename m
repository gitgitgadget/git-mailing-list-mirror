Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61D9202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbdCHULn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:11:43 -0500
Received: from siwi.pair.com ([209.68.5.199]:27766 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdCHULm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:11:42 -0500
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1CF1484658;
        Wed,  8 Mar 2017 15:11:02 -0500 (EST)
Subject: Re: [PATCH 06/10] rev-list: add --allow-partial option to relax
 connectivity checks
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
 <1488994685-37403-7-git-send-email-jeffhost@microsoft.com>
 <xmqqd1dr38f0.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2cc503b4-f6cf-336a-bc3f-f44b1d187eaf@jeffhostetler.com>
Date:   Wed, 8 Mar 2017 15:10:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqd1dr38f0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/8/2017 1:55 PM, Junio C Hamano wrote:
> Jeff Hostetler <jeffhost@microsoft.com> writes:
>
>> From: Jeff Hostetler <git@jeffhostetler.com>
>>
>> Teach rev-list to optionally not complain when there are missing
>> blobs.  This is for use following a partial clone or fetch when
>> the server omitted certain blobs.
>
> This makes it impossible to tell from objects missing by design
> (because we did an --partial-by-size clone earlier, expecting we can
> later fetch from elsewhere when necessary) and objects inaccessible
> by accident (because you have a repository corruption), no?

Right.  It will effectively neuter several commands like
index-pack, gc, and fsck WRT missing blobs.

> Even though I do very much like the basic "high level" premise to
> omit often useless large blobs that are buried deep in the history
> we would not necessarily need from the initial cloning and
> subsequent fetches, I find it somewhat disturbing that the code
> "Assume"s that any missing blob is due to an previous partial clone.
> Adding this option smells like telling the users that they are not
> supposed to run "git fsck" because a partially cloned repository is
> inherently a corrupt repository.
>
> Can't we do a bit better?  If we want to make the world safer again,
> what additional complexity is required to allow us to tell the
> "missing by design" and "corrupt repository" apart?

I'm open to suggestions here.  It would be nice to extend the
fetch-pack/upload-pack protocol to return a list of the SHAa
(and maybe the sizes) of the omitted blobs, so that a partial
clone or fetch would still be able to be integrity checked.

Jeff

