Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAA4C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 18:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352299AbiCUSsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiCUSss (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 14:48:48 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48818CD10
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 11:47:22 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 52C823F413F;
        Mon, 21 Mar 2022 14:47:21 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 259B93F413E;
        Mon, 21 Mar 2022 14:47:21 -0400 (EDT)
Subject: Re: [PATCH 02/16] update-index: convert advise() messages back to
 warning()
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
 <b120972a441d3081519af0e31bb0c639df148287.1647033303.git.gitgitgadget@gmail.com>
 <xmqq5yoht6an.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3ba50173-8739-3741-7226-0299ea941e00@jeffhostetler.com>
Date:   Mon, 21 Mar 2022 14:47:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5yoht6an.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/14/22 2:08 AM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> fixup! update-index: convert fsmonitor warnings to advise
> 
> Same comment as 01/16 applies here.  "convert ... back to ..." in
> the title refers to the fact that builtin-fsmonitor-part2 topic
> turned warning() into advise() without a good justification, I
> think.  Flipping and flopping between warning and advise, without
> giving any justification going either direction, is not a good move.

Sorry for not including the backstory.

Ben wrote the original warning message back in 2017.

In my original version of part 2 I added a more detailed warning message
because of the new `core.useBuiltinFSMonitor` config settings and
how it interacted with `core.fsmonitor`.  And we talked about making
that longer message advise rather than a warning.  So I changed them
to advise().

But then we decided to remove `core.useBuiltinFSMonitor` and overload
`core.fsmonitor` to take a boolean, so the original text of the message
was sufficient and correct.  So to minimize the diff, I reverted the
text change and kept the change from warning() to advise().

But then there were comments from AEvar on either changing all of
the nearby warning() calls to advise() *and* to change them to use
the `advise_type` enum.  That seemed like a large/disruptive change
at this point.

Also, I wasn't really sure of the need for Ben's original warning
message, so I'd rather leave it as is than expand the scope.

So I basically reverted the change for this series.  If (in a later
series) we want to revisit all of the warnings in update-index.c,
then we can think about this.

Jeff
