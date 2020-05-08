Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB533C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942F221974
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZK5447tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEHS6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 14:58:31 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58538 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgEHS63 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 14:58:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BBA3B9394;
        Fri,  8 May 2020 14:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4OGONtZDRoLMZ3t2oQk2xczXJNU=; b=ZK5447
        tzWz1D13MbkIgZMmzII7EXzaXPpjkqMJwT8fceleiqz29tO8rvA99OmJ6NvagxEl
        ARZPqOWHj+a9viiQuNAPHlLisZveep6PGTVNQSPSI4Jd+i7+61q8AGk7Qz9OjnrL
        jZVl4d0KQ+p/VRQVhdJGQCyN3S/VCluFH6PIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BRz0bomYCOuIOua4HSAdCTNWdV4hgdvo
        rOhsG6bwAiCgjGCWBbCqeJhUK4MKf4VSbfkd+xpXtG96pZm9+T3vja01XD9CVQB2
        ruPkEfv3EV2NKRHPvYv+cYLRhXXsuVk+vRuHoyPyB7Vnrm3Y1IciM4JUMFlTSI9O
        5sTtE/ID2jk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83921B9393;
        Fri,  8 May 2020 14:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C267BB938E;
        Fri,  8 May 2020 14:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v12 03/12] refs: document how ref_iterator_advance_fn should handle symrefs
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <6553285043b2f004cca646aefd59c509324d4da3.1588845586.git.gitgitgadget@gmail.com>
Date:   Fri, 08 May 2020 11:58:23 -0700
In-Reply-To: <6553285043b2f004cca646aefd59c509324d4da3.1588845586.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 07 May 2020
        09:59:36 +0000")
Message-ID: <xmqqd07exnhs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4FF087E-915D-11EA-84AB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

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
>  
>  typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,

Makes sense.

I wonder if I should take 1-3/12 as a separate "clean-up" series and
merge it before everything else down to 'master'?  That would reduce
the churn somewhat.

I also wonder if there are similar "clean-up" buried later in the
series. For example, would it make sense to also move 11/12 and have
it graduate early together with 1-3/12?

Thanks.

