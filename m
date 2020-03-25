Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D36C1975A
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CC4206F8
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 06:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HSh9H0IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgCYGbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 02:31:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58815 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 02:31:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3D12609E7;
        Wed, 25 Mar 2020 02:31:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mrOQ76R4XhIaWybGd22dOLuGAaY=; b=HSh9H0
        IRvKiIVLfHjaI21ZMOJNT9DlZVWRsA2H7D7Qy566PobM30x/RvzifB1GNg4YFJ29
        fWbTiu0UfRsfdXXNl6gZELygfGUnTvXd5RRR1+8jpTC9Rcx4kw2czwd4W9pVcn3A
        bnimxHDFGHE+4gDZjsPxnxPUTZKsu1+s3Z5cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MUdcqKQWRz6GFJysxpumDvYRdA8j3k59
        jjZhxJommlb/Zlm5cvvf+ZJEVTqUKnosqIZO+oLfZELDvA5LWkY7T6BtVRtUKMYW
        M4xkATeHTN+bn/vJZvcUVBwCry8vBO5IX3Lbwzfxntxo3rQS9iCtcaJB9Wo7RyaO
        YfV3K2b4uVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C5C9609E6;
        Wed, 25 Mar 2020 02:31:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70BE1609E4;
        Wed, 25 Mar 2020 02:31:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t5801: teach compare_refs() to accept !
References: <cover.1585115341.git.liu.denton@gmail.com>
        <b51f97f6ae37e4b69b9651cbd60a480e5db3e72d.1585115341.git.liu.denton@gmail.com>
Date:   Tue, 24 Mar 2020 23:31:12 -0700
In-Reply-To: <b51f97f6ae37e4b69b9651cbd60a480e5db3e72d.1585115341.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 25 Mar 2020 01:54:55 -0400")
Message-ID: <xmqqv9mtx7wv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39437E66-6E62-11EA-BA00-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>  compare_refs() {
> +	fail= &&
> +	if test "x$1" = 'x!'
> +	then
> +		fail='!' &&
> +		shift
> +	fi &&
>  	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
>  	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
> -	test_cmp expect actual
> +	eval $fail test_cmp expect actual
>  }
>  
>  test_expect_success 'setup repository' '
> @@ -189,7 +195,7 @@ test_expect_success GPG 'push signed tag' '
>  	git push origin signed-tag
>  	) &&
>  	compare_refs local signed-tag^{} server signed-tag^{} &&
> -	test_must_fail compare_refs local signed-tag server signed-tag
> +	compare_refs ! local signed-tag server signed-tag

While this is not wrong per-se, I do not know why we cannot just use

	! compare_refs local signed-tag server signed-tag

i.e. "we expect these two repositories have different tags"?

It is totally plausible that I am missing something obvious, as it
is getting late and I no longer am a night person.

Thanks.

>  '
>  
>  test_expect_success GPG 'push signed tag with signed-tags capability' '
