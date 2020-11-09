Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F593C5517A
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0130720867
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r1t+Z/6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbgKIW3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:29:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56106 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKIW3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:29:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC09B9591D;
        Mon,  9 Nov 2020 17:29:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TPy9MjiZcdF+5twT/FrIcfOAjQc=; b=r1t+Z/
        6GGQ/UBSD5RYSnSmTYQwOyDB15l6/zw/gmZXo33fAWfwB6+9OTvmDwnQjuxsUSKp
        VGAo72NvBgAIU72PKizYEeF5uJdCuwOC3EIJkm1QIWH+bBs2nEyE6WuV551A5TZY
        Z53/KRNn5dl4ehypIqvYkpdzUQEvgRPvbj++I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qdurk67gz0SYmoQPWctwRzM6X14IeM6M
        TTc9QCgIT1vY8+HJMDCDgMIyS+seh301VIbnW2vqxaLYrnGsCbshSlawYlWonJiw
        9pTH89Cw9AdwASz+x6FohC9t9KqmvazTJDIFDPcWxfqoFjAdw6zENQGUbU7A9RqS
        UXPM7oSfsN4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC5C39591C;
        Mon,  9 Nov 2020 17:29:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C39E9591B;
        Mon,  9 Nov 2020 17:29:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: bash: support recursive aliases
References: <20201109215248.461167-1-felipe.contreras@gmail.com>
        <X6m8R9erSxGlPXq2@nand.local>
Date:   Mon, 09 Nov 2020 14:29:01 -0800
In-Reply-To: <X6m8R9erSxGlPXq2@nand.local> (Taylor Blau's message of "Mon, 9
        Nov 2020 17:01:43 -0500")
Message-ID: <xmqq4klyb1w2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7ECFA2C-22DA-11EB-868D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I am not an expert or user of the Bash completion scripts in contrib, so
> I'll refrain from reviewing that portion of the patch.
>
> I would, however, recommend that you avoid the word 'recursive' here.
> Git rightly detects and rejects recursive and looping aliases. In fact,
> the example that you give below:
>
>>   l = log --oneline
>>   lg = l --graph
>
> Is not even recursive. I would instead recommend calling 'lg' a "nested"
> alias.
>
> You could argue about whether it is "l", "lg", or both that are nested,
> but I think renaming the patch to "completion: bash: support nested
> aliases" and then a s/recursive/nested throughout the patch message
> would be sufficient.
>
>> So the completion should detect such aliases as well.

Two comments.

 - on design, is it possible to make a set of aliases that form a
   cycle?  do we need to worry about such case?  what does the
   current implementation do for an "alias" in such a cycle?

 - on implementation, it is done as a recursive call to the same
   function, but a loop that naturally maps tail recursion would
   also be a trivial implementation.  is it worth rewriting the
   recursive calls into a loop?  if we need to solve the circular
   references (above) by say limiting the length of the cycle, would
   such a rewrite make sense as a way to help implementation?

