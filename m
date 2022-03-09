Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E9C433FE
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiCIWDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiCIWDn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:03:43 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51951694A0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:02:41 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 674451249CB;
        Wed,  9 Mar 2022 17:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vMXvIRvzTMR5hNei6G3q9iHS4m5qOEPGoi3ebg
        gF2fI=; b=R5BlmYRwZ0Infrhx/oP92sdibzbfS8NVUTb7nFYn4OsUFtPTZqIHO1
        QRWU4AkQW2yy0LiM91IaYwfxH6pXsP3GGZTiVp0Gq8jG/RlxGtVPIOYwi6KuKanu
        fHtdhAIZq8Qg86xMeDuuEOdVGJqaeEseR6ypthRlbXrHJGVQFgjpo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F0A31249CA;
        Wed,  9 Mar 2022 17:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C558B1249C9;
        Wed,  9 Mar 2022 17:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] test-lib: declare local variables as local
References: <81f43fbefde84ab7af9ee2ac760845b728a48ab5.1646861976.git.git@grubix.eu>
Date:   Wed, 09 Mar 2022 14:02:38 -0800
In-Reply-To: <81f43fbefde84ab7af9ee2ac760845b728a48ab5.1646861976.git.git@grubix.eu>
        (Michael J. Gruber's message of "Wed, 9 Mar 2022 22:41:43 +0100")
Message-ID: <xmqqv8wmlr7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A310B26C-9FF4-11EC-8210-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> 131b94a10a ("test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_ on
> glibc >= 2.34", 2022-03-04) introduced "local" variables without
> declaring them as such. This conflicts with their use in some tests (at
> least when running them with dash), leading to test failures in:

Thanks.

>
> t0006-date.sh
> t2002-checkout-cache-u.sh
> t3430-rebase-merges.sh
> t4138-apply-ws-expansion.sh
> t4124-apply-ws-rule.sh
>
> Declare those variables as local to let the tests pass again.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  t/test-lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a3b711988c..e3c9822bf3 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -548,6 +548,8 @@ then
>  	}
>  else
>  	setup_malloc_check () {
> +		local g
> +		local t
>  		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
>  		export MALLOC_CHECK_ MALLOC_PERTURB_
>  		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
