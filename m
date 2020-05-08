Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C65C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA352083B
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebRfBRkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEHSyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 14:54:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59587 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHSyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 14:54:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DE48B9359;
        Fri,  8 May 2020 14:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L/zvfHbwDxmHOqXRrJ9HkxgDzJU=; b=ebRfBR
        kR3hg1QCWHo5LXQe1tzdlt0aA1ae4kdMY/pys4DXeqeUJmK3d9LvCmIuRVmfHtCb
        SrCmHm73NTccCWjvv3fY4BknEN93yKiBc2SBH5jIbTI0lHQ62w75xELtQNszt4y/
        xnB7X9lOXNfyG9OxN8ygO+4VPtVEg+KWoPwSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LAp76ZKWv95kzCgu+moLjQdKGTuM8Q4r
        gMBrnpB9SY8DtjKWX/gElkvRAnF2l6fa4YMFz9yMj4hFaXkQvy5O3/076uvrmJe6
        8kEP0XPLeVtkcI1DnevyipMtjSFoxO7VIrhSoEyBmGngrHvWNRSR/nWNXNe/C/Kh
        JI8q6wbE8ls=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8546DB9358;
        Fri,  8 May 2020 14:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35AE0B9357;
        Fri,  8 May 2020 14:54:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v12 01/12] refs.h: clarify reflog iteration order
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <dfa5fd74f859b2186d0222f98417128c52903fe7.1588845586.git.gitgitgadget@gmail.com>
Date:   Fri, 08 May 2020 11:54:26 -0700
In-Reply-To: <dfa5fd74f859b2186d0222f98417128c52903fe7.1588845586.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 07 May 2020
        09:59:34 +0000")
Message-ID: <xmqqlfm2xnod.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57FC4B26-915D-11EA-9EEB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/refs.h b/refs.h
> index a92d2c74c83..9421c5b8465 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -432,18 +432,21 @@ int delete_refs(const char *msg, struct string_list *refnames,
>  int refs_delete_reflog(struct ref_store *refs, const char *refname);
>  int delete_reflog(const char *refname);
>  
> -/* iterate over reflog entries */
> +/* Iterate over reflog entries. */

It is not wrong per-se, but it is more problematic that this
description is very similar to the functions that take callback
functions of this type than it begins with lowercase.

/* Callback to process a reflog entry found by the iterators (see below) */

perhaps?

>  typedef int each_reflog_ent_fn(
>  		struct object_id *old_oid, struct object_id *new_oid,
>  		const char *committer, timestamp_t timestamp,
>  		int tz, const char *msg, void *cb_data);
>  
> +/* Iterate in over reflog entries, oldest entry first. */

/* Iterate over reflog entries of refname in refs */

/* oldest entry first */
>  int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
>  			     each_reflog_ent_fn fn, void *cb_data);

/* youngest entry first */
>  int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
>  				     const char *refname,
>  				     each_reflog_ent_fn fn,
>  				     void *cb_data);
> +
> +/* Call a function for each reflog entry, oldest entry first. */

Likewise.

>  int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
>  int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
