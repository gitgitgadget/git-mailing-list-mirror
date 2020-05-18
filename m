Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01BC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99744207D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qMmP1MW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgERXn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 19:43:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54912 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 19:43:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27F886543E;
        Mon, 18 May 2020 19:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SEGyx1pl2X/igyDQ/prWwBPrpks=; b=qMmP1M
        W8LQEdV/FVGursmqK4N/ymewuSRDi0nX182Spl1Q+EQHQTvLMsUOuaLAQXsmOxxZ
        JNaXJko/oMCZ8EjkG3cbAMApMBJGg3oF9ohZhL/+iWtn0v8eZAicBveu/R4RmXHu
        /HpOlah2A5Dicyt97x6gTnRTBVx8ngtfBCVxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bzH6Dippxrv8nN2s2xDBDX+nY+6+nMgj
        UCKhwnjI61yJyQgpVu64m744t/Nl+3IPSV1m5sTwW8VLbZ/lolgsmj23DkoNSAf4
        Fa9As9EJoNSoXaPkdBCtLx3dF4DASy8GshkGHsZEaU9DrqTufRjXx21gifcCR5Cl
        ydAE2kd4TVU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F7036543D;
        Mon, 18 May 2020 19:43:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F68D6543C;
        Mon, 18 May 2020 19:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v13 03/13] refs: document how ref_iterator_advance_fn should handle symrefs
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <be083a85fb54d6399641ca634c432952aa95e1ba.1589226388.git.gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 16:43:55 -0700
In-Reply-To: <be083a85fb54d6399641ca634c432952aa95e1ba.1589226388.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 11 May 2020
        19:46:18 +0000")
Message-ID: <xmqq4ksc24hw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FEA4448-9961-11EA-A190-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/refs-internal.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index ff2436c0fb7..3490aac3a40 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -438,6 +438,11 @@ void base_ref_iterator_free(struct ref_iterator *iter);
>  
>  /* Virtual function declarations for ref_iterators: */
>  
> +/*
> + * backend-specific implementation of ref_iterator_advance.
> + * For symrefs, the function should set REF_ISSYMREF, and it should also
> + * dereference the symref to provide the OID referent.
> + */
>  typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);

Shouldn't we also talk about the need for the backend to yield
broken refs with ISBROKEN (iow, you are not allowed to skip---let
the caller make the decision to skip) etc.?

Other than that, this is a good additional piece of information to
tell the implementors of new backend.

Thanks.





>  
>  typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
