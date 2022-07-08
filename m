Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E94C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiGHQ3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiGHQ2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:28:51 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14062951D6
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:28:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D07B144040;
        Fri,  8 Jul 2022 12:28:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uUPUMiWNEcgpNrXRo1V382F4OjgvzGKnztA4Vn
        d0asI=; b=m3sYxcqytM+gDDJwEMuaHY9GWeZHR4MC9BqyF9+/7RvqefICFhAO3X
        Btjys7N21/bS0ic4CJ12uznQuZyqOsw5k0LzKxK+4JYqtR6NZYVFsiSMIXpgvqZA
        2Unk2OJVEfZo6rYc3RBZ0n3NZm4aAIAVt0i2K7PlPJYK8qq7tp5VU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 252AC14403F;
        Fri,  8 Jul 2022 12:28:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E755314403E;
        Fri,  8 Jul 2022 12:28:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 3/3] clone: use remote branch if it matches default HEAD
References: <YsdyLS4UFzj0j/wB@coredump.intra.peff.net>
        <YsdzZxS48u8sk9QD@coredump.intra.peff.net>
Date:   Fri, 08 Jul 2022 09:28:00 -0700
In-Reply-To: <YsdzZxS48u8sk9QD@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 7 Jul 2022 19:59:35 -0400")
Message-ID: <xmqq8rp3wovj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFB6541A-FEDA-11EC-A743-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +		/*
> +		 * We may have selected a local default branch name "foo",
> +		 * and even though the remote's HEAD does not point there,
> +		 * it may still have a "foo" branch. If so, set it up so
> +		 * that we can follow the usual checkout code later.

Very sensible.

> +		 *
> +		 * Note that for an empty repo we'll already have set
> +		 * option_no_checkout above, which would work against us here.
> +		 * But for an empty repo, find_remote_branch() can never find
> +		 * a match.
> +		 */
> +		our_head_points_at = find_remote_branch(mapped_refs, branch);
> +
> +		if (!option_bare && !our_head_points_at)
>  			install_branch_config(0, branch, remote_name, ref);

I may be completely confused, but shouldn't the condition read "if
we are not bare, and we did find the 'branch' in their refs", i.e.
without "!" in front of our_head_points_at?
