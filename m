Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE61C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7399720702
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VaeFfZz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgKWSoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:44:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61811 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgKWSoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 13:44:05 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F385B92499;
        Mon, 23 Nov 2020 13:44:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hqlW3YfddKK7REejwHz/4mCQ2pg=; b=VaeFfZ
        z43W6fhl2VYITAetZ8QwOQKAqlofctLOrCUWPq5F2Fbt4h0vscxF3R5xQ3u3lCL3
        uWIfxZu3BDHhNaS4g7uskua3GAw4LQ/pc34kNigArrHShC03z8xAI/d5zn7SvKhz
        zbVSMc5sHkYvDuvnv3vdH51o/gfhlRZuYCxQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LelOxSjVOlOGdklfHoYrS2839V6Zou+n
        dbrBTN75AheptHhNOEvesYYKHILGRKZw2OLaJ1pp69Ru/qvBfGNbIjNuhjzhFp9P
        QwIRd4ayNLfU2rHiXFT8bd0scP2q/KOq765T8V4g8TFAUQdSXN2DZ0smy54w1SE4
        IfXEaEPVzJU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC17C92497;
        Mon, 23 Nov 2020 13:44:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77A0E92495;
        Mon, 23 Nov 2020 13:44:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     nate@roosteregg.cc
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3301: test proper exit response to no-value
 notes.displayRef.
References: <20201123032342.24566-1-nate@roosteregg.cc>
        <20201123032342.24566-3-nate@roosteregg.cc>
Date:   Mon, 23 Nov 2020 10:44:01 -0800
In-Reply-To: <20201123032342.24566-3-nate@roosteregg.cc> (nate@roosteregg.cc's
        message of "Sun, 22 Nov 2020 22:23:42 -0500")
Message-ID: <xmqqr1ojoqvi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB3A154A-2DBB-11EB-AC4E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nate@roosteregg.cc writes:

> From: Nate Avers <nate@roosteregg.cc>
>
> Signed-off-by: Nate Avers <nate@roosteregg.cc>
> ---
>  t/t3301-notes.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 8f43303007..ca60faf480 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -672,6 +672,11 @@ test_expect_success 'notes.displayRef respects order' '
>  	test_cmp expect-both-reversed actual
>  '
>  
> +test_expect_success 'notes.displayRef with no value handled gracefully' '
> +	test_must_fail git -c notes.displayRef log -0 --notes &&
> +	test_must_fail git -c notes.displayRef diff-tree --notes HEAD
> +'

Looks good.  I didn't know we can feed the "no assignment means
true" configuration from the command line with "git -c" ;-)

>  test_expect_success 'GIT_NOTES_DISPLAY_REF works' '
>  	GIT_NOTES_DISPLAY_REF=refs/notes/commits:refs/notes/other \
>  		git log -2 >actual &&
