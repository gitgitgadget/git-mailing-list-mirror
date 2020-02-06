Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0DCC352A2
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD76214AF
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x6yjJSnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBFXHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:07:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54532 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBFXHE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 18:07:04 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89D324E3BF;
        Thu,  6 Feb 2020 18:07:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1G3P0jOg6pWlkipzQvJQDzWLFN8=; b=x6yjJS
        nzJKyGy2dXbRegFvi9SAt9JZ8LlcS3p/NGBqylD6pynsNqiqiZ2+sU5ezH7uhl5h
        RxwrxZ8huzG9Aa5SH7MK6W/FFi3k0vBoKDq5a5j6W6/BjgfeJ3vMy9y4t7NEauIg
        BFM8bgBqr+UfNsouMnCUGdsyhu+NZFjy7rqZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=USCpdUKQJl2/PWYYxRPpmDfH8RM/Om0E
        52ogFN4xgqF2rC1ihI4in8TWQ34XkiBtiNNeE8WPoSUtSl2vlwbwuSnTTAWTVjIA
        fUCG+oZcNW8LwYiSr92ZeQNQOz3IZVF9S3+HXxwb6Xn1wsUYN3QhEzm4mmM9QUoZ
        XqTlq5VqQ4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E5244E3BE;
        Thu,  6 Feb 2020 18:07:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB9CA4E3BD;
        Thu,  6 Feb 2020 18:07:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
        <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
        <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 15:07:00 -0800
In-Reply-To: <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 06 Feb 2020
        22:55:55 +0000")
Message-ID: <xmqqftfne2nf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 623A49F0-4935-11EA-8138-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static struct block_stats *writer_block_stats(struct writer *w, byte typ)
> +{
> +	switch (typ) {
> +	case 'r':
> +		return &w->stats.ref_stats;
> +	case 'o':
> +		return &w->stats.obj_stats;
> +	case 'i':
> +		return &w->stats.idx_stats;
> +	case 'g':
> +		return &w->stats.log_stats;
> +	}
> +	assert(false);
> +	return NULL;
> +}

As assert() turns into nothing, this is not a particularly good way
to document that "if control reaches here, that means we found a
programming error".  

We intead would use BUG("message") in our codebase, which is marked
as NORETURN (so "return NULL" after it would be a dead code).

Thanks.
