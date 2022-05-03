Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2570C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 06:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiECGxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 02:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiECGxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 02:53:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A837BC5
        for <git@vger.kernel.org>; Mon,  2 May 2022 23:49:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D536810BDC8;
        Tue,  3 May 2022 02:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3PjMZr6lR/aiGUf5z4JqLs8ULIb7Bf6rhfGKpZ
        MEcgY=; b=rQegQe9C4hF5QTLhLgywF0CrzgL2bU5mGfjsNEyUYzi/eqPMy9uoDD
        AZSiddIjDcaraTb0CFxnB2HkGmJEq0q6uJpkSZ+40vUiY8t0IOG8ENtHJyP/tAKv
        UQ/gf18ykDnRzcQ5gu+CLSaCKQoJNb/u6EsCu+TRvVXBFWD/mHMj8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBA7C10BDC7;
        Tue,  3 May 2022 02:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B4F310BDC1;
        Tue,  3 May 2022 02:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect branch information after fetching (local branch !=
 remote branch)
References: <9b3a9023-cd73-2e9d-64f1-7cc7e53d9b54@gmail.com>
        <xmqq7d73rwnq.fsf@gitster.g>
        <bcb069c7-f104-a494-1862-30709dc6f8a0@gmail.com>
Date:   Mon, 02 May 2022 23:49:25 -0700
In-Reply-To: <bcb069c7-f104-a494-1862-30709dc6f8a0@gmail.com> (Bagas Sanjaya's
        message of "Tue, 3 May 2022 13:42:06 +0700")
Message-ID: <xmqq35hrrtze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C3CBDB4-CAAD-11EC-97EF-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 5/3/22 12:51, Junio C Hamano wrote:
>> The verbose report left by "git fetch" tells us what branch they
>> have is used to update what branch we have, so I think this is
>> pretty much expected.
>> 
>> I am puzzled by your mention of 'net-next' (local).
>> 
>> You may have
>> 
>>     [branch "net-next"]
>>         remote = net-next
>> 	merge = master
>> 
>> and that is where your expectation on the local may be coming from,
>> but it wouldn't be all that relevant to "git fetch". The update of
>> the local branch will happen long after "git fetch" is done.
>> 
>
> Ah I see.
>
> So the left-hand side of verbose report (local branch) is actually
> the value of branch."net-next".merge, right?

Not really.  It comes from

	[remote "net-next"]
	    remote = https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
	    fetch = refs/heads/*:refs/remotes/net-next/*

and the fact that the remote happens to have only one branch under
its refs/heads/ hierarchy.  Fetch does not care all that much about
"branch.*.merge" (which is what I said---the configuration is not
all that relevant to "git fetch").

