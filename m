Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C5C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 04:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB177208A1
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 04:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F/e468OZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKUEPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 23:15:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59204 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUEPx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 23:15:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C69552E3AD;
        Wed, 20 Nov 2019 23:15:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y3XnFcRaGFLgCqXNeoKpNuEIp0Q=; b=F/e468
        OZjyuCoQNlLpdI4O6GncIqyBR966lMGDzVE0Re7OvfrG/bwO1fOFDzkCSbrerP4f
        lqjgpr3K/cGrZUveneJMuPIHNGxhAyTsscE0xu6fpJaAQ41tyN8iOTDI9Wa1yJE2
        R8KEKEkUKtZ5mt0THgqyXrI/xO5pZbp2+QR98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RWXHT25ZiGxHMnDiYPEnlL7E8XyiulKF
        6LJu5BI5QF98fv9UWc8QO4EBNF1byjpPWI8DorOKOxwhnbUukIO1NYRFSFeeHinV
        NCiJtbtA+I5EfrmZTFzDfaVM6ltaOwbGTqd6sX+TMa0MdKPsySvXi5Mh0EGkURYT
        nQca0BaIXSc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA4B2E3AC;
        Wed, 20 Nov 2019 23:15:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 068A12E3AA;
        Wed, 20 Nov 2019 23:15:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>,
        Utsav Shah <utsav@dropbox.com>
Subject: Re: [PATCH v4 1/1] unpack-trees: skip stat on fsmonitor-valid files
References: <pull.424.v3.git.1573016055.gitgitgadget@gmail.com>
        <pull.424.v4.git.1574238737.gitgitgadget@gmail.com>
        <ea7880f2d07ef65f8b41f6786ff789f7a0ff8fd7.1574238737.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 13:15:49 +0900
In-Reply-To: <ea7880f2d07ef65f8b41f6786ff789f7a0ff8fd7.1574238737.git.gitgitgadget@gmail.com>
        (Utsav Shah via GitGitGadget's message of "Wed, 20 Nov 2019 08:32:17
        +0000")
Message-ID: <xmqqd0dlamq2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A46FE22-0C15-11EA-94E6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Utsav Shah <utsav@dropbox.com>
>
> The index might be aware that a file hasn't modified via fsmonitor, but
> unpack-trees did not pay attention to it and checked via ie_match_stat
> which can be inefficient on certain filesystems. This significantly slows
> down commands that run oneway_merge, like checkout and reset --hard.
>
> This patch makes oneway_merge check whether a file is considered
> unchanged through fsmonitor and skips ie_match_stat on it. unpack-trees
> also now correctly copies over fsmonitor validity state from the source
> index. Finally, for correctness, we force a refresh of fsmonitor state in
> tweak_fsmonitor.

Instead of saying "also now correctly copies..." as if it started
working correctly by accident, be more assertive and actively make
it so ;-)

    Check if a file is unchanged by fsmonitor in oneway_merge(), and
    avoid unnecessary calls to ie_match_stat().  Copy the fsmonitor
    validity state from the source index to the destination index in
    unpack_trees().  Force a refresh of the fsmonitor state in
    tweak_fsmonitor(), which is called after the index file is read
    from the disk, for correctness.

perhaps.

> After this change, commands like stash (that use reset --hard
> internally) go from 8s or more to ~2s on a 250k file repository on a
> mac.

Good.

>
> Changes since the last version are:
> * The sanity checks around accessing the fsmonitor_dirty bitmap have
> been moved to another patch, which is in message id [1]
> * Unintended indentation changes in fsmonitor have been removed
> * A comment explaining what untracked->use_fsmonitor means has been
> re-added (it was dropped in the previous version)
> * A few "helped-by" entries have been added to the patch
>
> [1]: (xmqqzhh0d0ma.fsf@gitster-ct.c.googlers.com)

The above is for the cover letter or after the three-dash lines, and
not for the log message.

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
> Signed-off-by: Utsav Shah <utsav@dropbox.com>
> ---
>  fsmonitor.c                 | 23 +++++++++++++++++------
>  t/t7519-status-fsmonitor.sh |  9 +++++++--
>  unpack-trees.c              |  6 +++++-
>  3 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 1f4aa1b150..0d270da80f 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -189,13 +189,26 @@ void refresh_fsmonitor(struct index_state *istate)
>  		}
>  		if (bol < query_result.len)
>  			fsmonitor_refresh_callback(istate, buf + bol);
> +
> +		/* Now mark the untracked cache for fsmonitor usage */
> +		if (istate->untracked)
> +			istate->untracked->use_fsmonitor = 1;
>  	} else {
> +
> +		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
> +		 * if we actually changed entries or not */

Multi-line comment style.

> +		int is_cache_changed = 0;
>  		/* Mark all entries invalid */
> -		for (i = 0; i < istate->cache_nr; i++)
> -			istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> +		for (i = 0; i < istate->cache_nr; i++) {

Lack of blank line between the last decl and the first stmt.
Probably the blank should go before "/* Mark all ...".

> @@ -257,9 +270,7 @@ void tweak_fsmonitor(struct index_state *istate)
>  				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
>  			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>  
> -			/* Now mark the untracked cache for fsmonitor usage */
> -			if (istate->untracked)
> -				istate->untracked->use_fsmonitor = 1;
> +			refresh_fsmonitor(istate);
>  		}
>  
>  		ewah_free(istate->fsmonitor_dirty);

Looks good.

Thanks.

