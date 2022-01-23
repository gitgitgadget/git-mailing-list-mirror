Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B4EC433F5
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 20:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiAWU2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 15:28:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52061 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbiAWU2U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 15:28:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D93A112CE0;
        Sun, 23 Jan 2022 15:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TWy51oxNg6Dxnh+bZsllgfh2QSgCJPGYt29OLm
        cmHfo=; b=BNz9pIqi9xgxvVdMwGKI2QOXFfg1yH4yl88+afaAm29x143k9Z3p4g
        hk/zZZ5b/m2wY2p3zLhozSAWwDtFAMNDspq8sFt+iP8c3qvCkTHwjSp6jkziD64h
        biyL7SvV3MxeWSVrsWaxWcCB88x4zZZBDmkK2vOcB1yKR/lsn3uxQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43CFC112CDF;
        Sun, 23 Jan 2022 15:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B02B0112CDE;
        Sun, 23 Jan 2022 15:28:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] mem-pool: Don't assume uintmax_t is aligned enough
 for all types
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
        <20220123152458.72540-1-jrtc27@jrtc27.com>
        <xmqqsfte8awj.fsf@gitster.g>
        <FD089F0E-C826-4A8E-BC16-F763E256B410@jrtc27.com>
Date:   Sun, 23 Jan 2022 12:28:17 -0800
In-Reply-To: <FD089F0E-C826-4A8E-BC16-F763E256B410@jrtc27.com> (Jessica
        Clarke's message of "Sun, 23 Jan 2022 20:23:53 +0000")
Message-ID: <xmqqo8428ae6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 003421A0-7C8B-11EC-9CB7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

> So, sizeof(X) does not always equal _Alignof(X), even for primitive
> types, _Alignof need only be a factor of sizeof. The two are the same
> on most architectures, and is a sensible ABI, but the exception is the
> m68k case I was referring to above. On m68k, sizeof(long long) == 8,
> but _Alignof(long long) == 2 (yes this is a real pain point of its ABI;

Ah, thanks.  Having a variant of the above explanation in a comment
next to the "union within a struct" would help future readers from
asking the same question as I asked.

