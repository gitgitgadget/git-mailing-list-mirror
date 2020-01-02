Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9FC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 18:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385821582
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 18:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TLkXnf8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgABSR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:17:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52485 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABSR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 13:17:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B90CAC7EF;
        Thu,  2 Jan 2020 13:17:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=87wHeCo0nE1Ox4B0V7AO2vCQLTs=; b=TLkXnf
        8bd5q4haTEXXn1zjZBkoVEzcBsoYhBSCo+8PHa6hpGnBJo0JsD/asuUDQd7pkJPH
        lMUfkXQgi1xtfeycVS6TyvWrSz9+TVyaytIUFmQEuixVwdCjD04/T0+bTo94oDuA
        gQJ1+H6FbJn3ICI9mRPaHNM7IqMOmCmp1Z86U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KrabecTyMqg6uH6T9YvGk+fUWWwPvi+z
        /Y4pJ/3NN/m7t/OjS843cuz6IRrqjP8ik4vC9DnZmUNjES50XebEafgwf1dDCB9v
        9hy3c7OqfIduSLvsXFljDVyW9gJyvPra8XZLZHn9ST6676sENLV/HvgCegrCYYEn
        aCNroia+iaA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22E9FAC7EE;
        Thu,  2 Jan 2020 13:17:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45B2CAC7ED;
        Thu,  2 Jan 2020 13:17:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sparse-checkout: use extern for global variables
References: <pull.506.git.1577798268.gitgitgadget@gmail.com>
        <c704cb554e1897278913520f266d95a4b04f9639.1577798268.git.gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 10:17:22 -0800
In-Reply-To: <c704cb554e1897278913520f266d95a4b04f9639.1577798268.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 31 Dec 2019
        13:17:48 +0000")
Message-ID: <xmqq36cxg1u5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FF48CC8-2D8C-11EA-897A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When the core.sparseCheckoutCone config setting was added in
> 879321eb0b ("sparse-checkout: add 'cone' mode" 2019-11-21), the
> variables storing the config values for core.sparseCheckout and
> core.sparseCheckoutCone were rearranged in cache.h, but in doing
> so the "extern" keyword was dropped.
>
> While we are tending to drop the "extern" keyword for function
> declarations, it is still necessary for global variables used
> across multiple *.c files. The impact of not having the extern
> keyword may be unpredictable.

"May be unpredictable" might be a bit too strong, but I agree that
it is better not to rely on the "common extension" these days, and
instead make sure variable decls have "extern" in front.

Will queue.  Thanks.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 1554488d66..cbfaead23a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -958,8 +958,8 @@ extern int protect_hfs;
>  extern int protect_ntfs;
>  extern const char *core_fsmonitor;
>  
> -int core_apply_sparse_checkout;
> -int core_sparse_checkout_cone;
> +extern int core_apply_sparse_checkout;
> +extern int core_sparse_checkout_cone;
>  
>  /*
>   * Include broken refs in all ref iterations, which will
