Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C0AC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1834024953
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TjdW5uJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgEHSy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 14:54:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58515 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgEHSyx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 14:54:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95D27D8C82;
        Fri,  8 May 2020 14:54:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F8WDsgmF1h6V7M6R1PXz4orCHPE=; b=TjdW5u
        JaZZLzkhQYTH9+V7Slu+z42+ZIvFTTbVkmwSKdP42W5TbVVm330XukRgOFCIsgUZ
        /DI6dqAxyO5PWxaQXewd3Yt9ySNt135aliQlTo3TigYFmmYSkXnmQ8EeATjquB3o
        oQHipGff/+RAfNYj5EX8nPmVKtNwZwmr03i34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rLR1NAcPhRpuOq/QwZyJlMjgEgNxgJxl
        RG6Adhwq4LQ1I+R0YbmDtIzrWQwozYYTjNBwGx/DDSOkCfbnHDYq46yy8I1xZEW0
        UoTU2L2WLu6113A/5LIxyMuYfEeSPHTKTsEeQ47+RW66p09414sZZsXLxQnXhmpz
        hHWMKyLbEQs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F396D8C81;
        Fri,  8 May 2020 14:54:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC7E8D8C7E;
        Fri,  8 May 2020 14:54:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v12 02/12] Iterate over the "refs/" namespace in for_each_[raw]ref
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <340c5c415e17a957b8a38932215b1179fbe68dbd.1588845586.git.gitgitgadget@gmail.com>
Date:   Fri, 08 May 2020 11:54:47 -0700
In-Reply-To: <340c5c415e17a957b8a38932215b1179fbe68dbd.1588845586.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 07 May 2020
        09:59:35 +0000")
Message-ID: <xmqqh7wqxnns.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64464A1C-915D-11EA-9181-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This happens implicitly in the files/packed ref backend; making it
> explicit simplifies adding alternate ref storage backends, such as
> reftable.

Makes sense.



>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 224ff66c7bb..4db27379661 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1525,7 +1525,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
>  
>  int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
> +	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
>  }
>  
>  int for_each_ref(each_ref_fn fn, void *cb_data)
> @@ -1585,8 +1585,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
>  
>  int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
>  {
> -	return do_for_each_ref(refs, "", fn, 0,
> -			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
> +	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
> +			       cb_data);
>  }
>  
>  int for_each_rawref(each_ref_fn fn, void *cb_data)
