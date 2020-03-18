Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00E4C10F29
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6699720714
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y8ZgtMD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgCRUUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:20:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53377 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgCRUUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 16:20:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40AFBBA3B5;
        Wed, 18 Mar 2020 16:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dcOXCNmy9zFST/h2tdDmWxl0+Qc=; b=Y8ZgtM
        D08FtteVBbV/VQ6FtpvtdPqtTfcpRWSDOuVkTZokLPCrYsbQi4I4goeKbp9BDliO
        vebNdLY53CZQ3Mwc1UvUwChuxGR2malRnlwOm1HHZwaZEQ0q0yccPOkeawtoy++R
        mHRAU6Kp23LXUc3/GiI8Bre4GiHJRSHXx45Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PraiOTEAwTbdC+p7J0MSbzZ+1OhW4A7r
        sjcIO2/+gE0ahAKw7g0eq3BScI3+EotcSM5hXNaergmp14cest2NForgwqZH04NF
        wnNyUbFOeYbZv7S4/gFKIZtfIRxWnbixXovfCV3RTLb4HAUGBk3LXPAH4S1IVFuT
        RioMnArqXH4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A0C1BA3B4;
        Wed, 18 Mar 2020 16:20:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 492F3BA3AE;
        Wed, 18 Mar 2020 16:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        newren@gmail.com
Subject: Re: [PATCH v2] rebase --merge: optionally skip upstreamed commits
References: <20200309205523.121319-1-jonathantanmy@google.com>
        <20200318173051.25875-1-jonathantanmy@google.com>
Date:   Wed, 18 Mar 2020 13:20:34 -0700
In-Reply-To: <20200318173051.25875-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 18 Mar 2020 10:30:51 -0700")
Message-ID: <xmqq8sjxfm99.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED558686-6955-11EA-8534-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -1840,6 +1844,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			      "interactive or merge options"));
>  	}
>  
> +	if (options.skip_cherry_pick_detection && !is_interactive(&options))
> +		die(_("--skip-cherry-pick-detection does not work with the 'apply' backend"));
> +

I presume this is, as before, built directly on v2.25.0; thanks for
keeping the original base while iterating.

Just a note to myself and those who are experimenting with the
patch.  When merged to the more recent codebase, is_interactive()
here will have to become is_merge().
