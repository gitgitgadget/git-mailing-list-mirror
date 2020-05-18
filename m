Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0EDC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDAA2207D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZXjXhXR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgERXbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 19:31:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62492 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgERXbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 19:31:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A383B4CD59;
        Mon, 18 May 2020 19:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qmjcyhf6tfHLvlo2+xCDz2GdsBQ=; b=ZXjXhX
        R5kDO/FLIV09X6O7P2wxeyLdUpId+tD1sfjCN+/6k1PGmbO8UhO/MoVcNphDb16i
        o7SIQn5PI8Tc3dXUUZcZ5LJ9rOQAIKt4YbVqTyPyM6sjop5MP76uYCbPsmfc6M1r
        Vrd9CCn+KHiiDOSxIDaxjyGymJV8FK24X58ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MaXUGl1XYlL1oD05fCkiwv7n2kwBbPi1
        LhoT/HOlGCepS16KAUyTsaSnJUoNWmScrfTXy0L9vVExR/ONz+0V8aam6T0HPSPr
        7LGOVm8KAcEmGJlIXCmnUzIkNhTdSoGCxuWzb0lovSR26mzXsN7fHly9b79vQiB3
        5werGOWFMJE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96A574CD56;
        Mon, 18 May 2020 19:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCB384CD55;
        Mon, 18 May 2020 19:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v13 01/13] refs.h: clarify reflog iteration order
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <8394c156eb4aef348f36622c3ec07e3a825b1c41.1589226388.git.gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 16:31:36 -0700
In-Reply-To: <8394c156eb4aef348f36622c3ec07e3a825b1c41.1589226388.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 11 May 2020
        19:46:16 +0000")
Message-ID: <xmqqd070252f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7962FFC-995F-11EA-9B27-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

I think the split of the topics was a good first move; now we need
to make sure that we need no more work on the early part.

> diff --git a/refs.h b/refs.h
> index a92d2c74c83..99ba9e331e5 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -432,19 +432,31 @@ int delete_refs(const char *msg, struct string_list *refnames,
>  int refs_delete_reflog(struct ref_store *refs, const char *refname);
>  int delete_reflog(const char *refname);
>  
> -/* iterate over reflog entries */
> +/* Callback to process a reflog entry found by the iteration functions (see
> + * below) */

/*
 * A multi-line comment in our codebase
 * look like this, with the opening slash-asterisk
 * and closing asterisk-slash occupying their own
 * lines.
 */
>  typedef int each_reflog_ent_fn(
>  		struct object_id *old_oid, struct object_id *new_oid,
>  		const char *committer, timestamp_t timestamp,
>  		int tz, const char *msg, void *cb_data);
>  
> +/* Iterate in over reflog entries in the log for `refname`. */

"in over"???  Should this just be "iterate over reflog entries in ..."?

> +
> +/* oldest entry first */
>  int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
>  			     each_reflog_ent_fn fn, void *cb_data);
> +
> +/* youngest entry first */
>  int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
>  				     const char *refname,
>  				     each_reflog_ent_fn fn,
>  				     void *cb_data);
> +
> +/* Call a function for each reflog entry in the log for `refname`. */
> +
> +/* oldest entry first */
>  int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
> +
> +/* youngest entry first */
>  int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);

The only difference betwen refs_for_each_reflog_ent() and
for_each_reflog_ent() is that the former takes an arbitrary
ref-store while the latter works on the default ref-store, no?  They
should otherwise be identical, so describing one as "Iterate over
reflog entries" while describing the other as "Call a function for
each" feel misleading.


