Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764E7C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B542465B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xU5448xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0WxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:53:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58665 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgA0WxL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 17:53:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B61D3C3F2;
        Mon, 27 Jan 2020 17:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WpHEf+bbdlzBLGePDfQxZqN1v5M=; b=xU5448
        xpU0hO66yVBBSISifJQCd0Do1BWe9xstUfRmZ3rwWosyq383thCw28sKYWjr6XMa
        wUaBwawObD9GWX5sytZh9a2CTIimSISg/d0VkyD9nvaiEf/q/qHNgexqLXS0IGTZ
        2iw/fRt3eRw1dVEBcJkSzsbej5eWlify+wcPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CIWMUGMur5P10QpUKdlnwSWOYJ1v7I1a
        2wG8QpUfcVh3r/5AcBp2uCWxPYh92mL0ddJXUWUFIw+FzixjiI/1Y5gBXRGe8vWt
        I/Y9aK2z5qf9NcHaBSYc2kuEjKXOkkm+YpPMHUiiYCxLL2PuRE9tUkAR9iCrNBGs
        FgwwYLQgpnA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 902703C3F1;
        Mon, 27 Jan 2020 17:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4CD83C3F0;
        Mon, 27 Jan 2020 17:53:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 3/5] Document how ref iterators and symrefs interact
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <9cf185b51f45f2df0016d7b69351ec2a7656dac2.1580134944.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 14:53:07 -0800
In-Reply-To: <9cf185b51f45f2df0016d7b69351ec2a7656dac2.1580134944.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 27 Jan 2020
        14:22:22 +0000")
Message-ID: <xmqqmua8a4vg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C99A0382-4157-11EA-A103-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
> Subject: Re: [PATCH v2 3/5] Document how ref iterators and symrefs interact

"Subject: refs: document how ...", perhaps?

Also isn't it more like iterators and symrefs do not interact in any
unexpected way, is it?  iterators while enumerating refs when they
see a symref, they do not dereference and give the underlying ref
the symref is pointing at---the underlying ref will be listed when
it comes its turn to be shown as an ordinary ref.  I am not sure
what is there to single out and document...

> Change-Id: Ie3ee63c52254c000ef712986246ca28f312b4301
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/refs-internal.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index ff2436c0fb..fc18b12340 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -269,6 +269,9 @@ int refs_rename_ref_available(struct ref_store *refs,
>   * to the next entry, ref_iterator_advance() aborts the iteration,
>   * frees the ref_iterator, and returns ITER_ERROR.
>   *
> + * Ref iterators cannot return symref targets, so symbolic refs must be
> + * dereferenced during the iteration.

What this says is not techincally incorrect.  Iterators do not give
each_ref_fn what underlying ref a symref is pointing at.  But it
also is misleading.  If your callback wants to know what object each
ref is pointing at do not need to do anything extra when it sees a
symref, as name of the object pointed at by the underlying ref is
given to it.  Only callbacks that wants to know the other ref, not
the value of the other ref, needs to dereference when called with a
symref.

But I wonder if we need to even say this.  Isn't it obvious from the
each_ref_fn API that nothing other than the refname, object id, and
what kind of ref it is, will be given to the user of the API, so it
would be natural for a caller that wants to do extra things it needs
to do for symrefs must act when it learns a ref is a symref?  After
all, that is why the flags word is one of the parameters given to an
each_ref_fn.

