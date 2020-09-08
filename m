Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23755C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18A820759
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A7yP9gqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgIHWuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:50:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50974 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIHWux (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 18:50:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8E6828C2AB;
        Tue,  8 Sep 2020 18:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j7jqQ9NsDMsBM1j2n1/RnBJO31s=; b=A7yP9g
        qCjUFtlHl9wTfDSkYZgH4PwZ9XFXQCUtqNFHSzVWdewUuP/YhPrWk+ZbP8qydSnb
        cRstC8zNVR7ujGeMyEkZNwngp2Dqwt045Wpo8aiIa7lIeh/o6cyp/X+kUNLZR5GK
        uMU0oiZHBEDLlKS/se1KghxPZO++TbMrsj35s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IUYRXWcmfqHJvuu3s7o2LlWQ5feVhMTz
        Cdw+d4HmXZ2Qzo5barIrMEvVnP3RncuW77GZe6GAvLGPnU5pbO0BMHlDf5qHX6AF
        PIf7urDtgz41f06ErzbpB7GcAxi1RaXtk/0TFvgIhgmCNC/5nevTzem2V/WO/3N9
        ew2wxp3DaMY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 82E2A8C2AA;
        Tue,  8 Sep 2020 18:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 108488C2A9;
        Tue,  8 Sep 2020 18:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: move REF_LOG_ONLY to refs-internal.h
References: <pull.712.git.1598628333959.gitgitgadget@gmail.com>
Date:   Tue, 08 Sep 2020 15:50:50 -0700
In-Reply-To: <pull.712.git.1598628333959.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Fri, 28 Aug 2020 15:25:33
        +0000")
Message-ID: <xmqqo8mfx4qd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE6E0DD0-F225-11EA-90FE-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> REF_LOG_ONLY is used in the transaction preparation: if a symref is involved in
> a transaction, the referent of the symref should be updated, and the symref
> itself should only be updated in the reflog.
>
> Other ref backends will need to duplicate this logic too, so move it to a
> central place.

Hmph, I am not necessarily sure about "need to duplicate" [*1*], but
I do agree with the patch text---the bit should not belong to a
single "files-backend" backend.

[Footnote]

*1* obviously, a better alternative, if possible, would be to let
    the more generic layer do so without forcing the backends to
    duplicate.  But even if such a change were possible and we
    decide to avoid duplication, it does not make sense to have this
    bit specifically defined for the files-backend and nobody else.


> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>     refs: move REF_LOG_ONLY to refs-internal.h
>     
>     REF_LOG_ONLY is used in the transaction preparation: if a symref is
>     involved in a transaction, the referent of the symref should be updated,
>     and the symref itself should only be updated in the reflog. 
>     
>     Other ref backends will need to duplicate this logic too, so move it to
>     a central place.
>     
>     Signed-off-by: Han-Wen Nienhuys hanwen@google.com [hanwen@google.com]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-712%2Fhanwen%2Flog-only-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-712/hanwen/log-only-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/712
>
>  refs/files-backend.c | 7 -------
>  refs/refs-internal.h | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 985631f33e..b1946dc583 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -38,13 +38,6 @@
>   */
>  #define REF_NEEDS_COMMIT (1 << 6)
>  
> -/*
> - * Used as a flag in ref_update::flags when we want to log a ref
> - * update but not actually perform it.  This is used when a symbolic
> - * ref update is split up.
> - */
> -#define REF_LOG_ONLY (1 << 7)
> -
>  /*
>   * Used as a flag in ref_update::flags when the ref_update was via an
>   * update to HEAD.
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 357359a0be..1f92861aeb 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -31,6 +31,13 @@ struct ref_transaction;
>   */
>  #define REF_HAVE_OLD (1 << 3)
>  
> +/*
> + * Used as a flag in ref_update::flags when we want to log a ref
> + * update but not actually perform it.  This is used when a symbolic
> + * ref update is split up.
> + */
> +#define REF_LOG_ONLY (1 << 7)
> +
>  /*
>   * Return the length of time to retry acquiring a loose reference lock
>   * before giving up, in milliseconds:
>
> base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
