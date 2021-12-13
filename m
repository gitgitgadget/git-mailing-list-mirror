Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222FDC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 15:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhLMPce (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 10:32:34 -0500
Received: from siwi.pair.com ([209.68.5.199]:64511 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234801AbhLMPce (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 10:32:34 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 74D9A3F4820;
        Mon, 13 Dec 2021 10:32:33 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 51C7D3F481C;
        Mon, 13 Dec 2021 10:32:33 -0500 (EST)
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
References: <xmqqilvvluoa.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <23f0375c-41ab-348f-f11a-161e6514bb9d@jeffhostetler.com>
Date:   Mon, 13 Dec 2021 10:32:32 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/10/21 9:52 PM, Junio C Hamano wrote:
> 
> 
> * js/trace2-avoid-recursive-errors (2021-11-18) 1 commit
>    (merged to 'next' on 2021-12-02 at c5b1e5ddec)
>   + trace2: disable tr2_dst before warning on write errors
> 
>   trace2 error code path fix.
>   source: <5a9e49e7f1540d762374382e1769edf112cf093f.1637272706.git.steadmon@google.com>

Sorry, I've been away from the list for a while.

I just noticed this is using "sigchain_push()" which might
be called from threaded code and could cause problems.

I think pthread_sigmask() would be a safer choice here.

I documented the reasons in compat/simple-ipc/ipc-unix-socket.c
in the header before "thread_block_sigpipe()".

Jeff
