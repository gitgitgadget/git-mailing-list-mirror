Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6C2C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436C9205CA
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhA0G3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:29:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63256 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhA0GPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 01:15:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 841A5A013B;
        Wed, 27 Jan 2021 01:14:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IVpsgnjd189Lc+mMcVJaQjiiqkM=; b=x2tr/F
        lZV6Nz55sEtalhP+PJzcktIPHI+q8/qb9sfUMEU6RiD6ic2zYRXfHYCrksKoGXMp
        obgUKJUMlKVvi+uTGUot+JKe9lplqtkFnqxb82PXh5jnmINZ6VH7UC3EnVnc0b5k
        Eb4dMnIRpsJ+gzbPvjyGNVI6dXbgGJFLOBPLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EKWeIKRd8xkhq86iD00a8+lh6mtP8qv0
        kEURiVllHOJLMMyuH0XNsRSkmQrYhn8WKXv5aNRJHytOI8bDSgP0JkKVFvn+ZcbK
        zLwQN3t5aI/XN5i9OS/DZTc5TQbKdd5JPHoCRjE7yLWqJgOI5ZvOJzL5TIXr5SM3
        zw6sRc3BsSY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77A72A013A;
        Wed, 27 Jan 2021 01:14:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8139CA0139;
        Wed, 27 Jan 2021 01:14:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1611686656.git.jonathantanmy@google.com>
        <xmqqeei7yyi9.fsf@gitster.c.googlers.com>
        <YBDrOrUIAcbTQ8cu@coredump.intra.peff.net>
Date:   Tue, 26 Jan 2021 22:14:29 -0800
In-Reply-To: <YBDrOrUIAcbTQ8cu@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Jan 2021 23:25:30 -0500")
Message-ID: <xmqqwnvyykhm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAB3B05C-6066-11EB-8209-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's a fix which can be applied on top of jt/clone-unborn-head. It
> could equally well be applied as part of the merge (with a minor
> adjustment in the context), but I think it ought to be squashed into
> Jonathan's patch 1 anyway.

Will queue but we are not merging the topic to 'next' yet, so I'll
ask Jonathan to remember making it a part of the series if it needs
to be updated later.

Thanks.

>
> -- >8 --
> Subject: [PATCH] ls-refs: don't peel NULL oid
>
> When the "unborn" feature is enabled, upload-pack serving an ls-refs
> command will pass a NULL oid into send_ref(). In this case, there is no
> point trying to peel the ref, since we know it points to nothing.
>
> For now this is a harmless waste of cycles (we re-resolve HEAD and find
> out that indeed, it points to nothing). But after merging with another
> topic that contains 36a317929b (refs: switch peel_ref() to
> peel_iterated_oid(), 2021-01-20), we'd actually end up passing NULL to
> peel_object(), which segfaults!
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ls-refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 4077adeb6a..bc91f03653 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -66,7 +66,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  			    strip_namespace(symref_target));
>  	}
>  
> -	if (data->peel) {
> +	if (data->peel && oid) {
>  		struct object_id peeled;
>  		if (!peel_ref(refname, &peeled))
>  			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
