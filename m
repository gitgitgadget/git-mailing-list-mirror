Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4CDC47082
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB576140A
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 03:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFDDR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 23:17:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58646 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFDDR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 23:17:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BD11CEDF3;
        Thu,  3 Jun 2021 23:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KMJFqKSDiAOPWuT7qMSuqzSKzAA5wMOsJBZhBP
        jfme8=; b=OYqbG0uM2tm58K9lFPq6xP7+pnPUvER5HLYb63LQyhKmDMtYtqPfjn
        9ygYceP1mkDg0M+o8U495ReuLOBCwif5miBASOSUiUROxa0HJ6j3twVMreGi2Usr
        CTm+Y1iYWsvWsF6cYHU8soWGcwpdT+8wUSVqBdh/dfR/x9PHnac3o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52D4BCEDF2;
        Thu,  3 Jun 2021 23:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C91DACEDF1;
        Thu,  3 Jun 2021 23:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: fix api-trace2 doc for "too_many_files" event
References: <07a3f409730fb7d725042ee24b7556d17efe4676.1622774341.git.steadmon@google.com>
Date:   Fri, 04 Jun 2021 12:16:10 +0900
In-Reply-To: <07a3f409730fb7d725042ee24b7556d17efe4676.1622774341.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 3 Jun 2021 19:41:30 -0700")
Message-ID: <xmqqfsxy2ubp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 360DD808-C4E3-11EB-B724-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In 87db61a (trace2: write discard message to sentinel files,
> 2019-10-04), we added a new "too_many_files" event for when trace2
> logging would create too many files in an output directory.
> Unfortunately, the api-trace2 doc described a "discard" event instead.
> Fix the doc to use the correct event name.

When we look at that commit again, it is immediately obvious that
this fix is correct.

Even the test added to t/t0212 with the commit uses the right event
name (naturally---otherwise the test wouldn't have passed).

Will queue.  This makes me wonder if it is useful to have some sort
of "executable" documentation, though ;-)

>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/technical/api-trace2.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 3f52f981a2..037a91cbca 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -396,14 +396,14 @@ only present on the "start" and "atexit" events.
>  }
>  ------------
>  
> -`"discard"`::
> +`"too_many_files"`::
>  	This event is written to the git-trace2-discard sentinel file if there
>  	are too many files in the target trace directory (see the
>  	trace2.maxFiles config option).
>  +
>  ------------
>  {
> -	"event":"discard",
> +	"event":"too_many_files",
>  	...
>  }
>  ------------
