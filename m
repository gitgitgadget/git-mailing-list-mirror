Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36473C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F96760F51
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 00:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhH3AfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 20:35:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbhH3AfP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 20:35:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C38B161F4F;
        Sun, 29 Aug 2021 20:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r72egF2zVr1F1HerpvamfTgCSs7QF4k84GF+R9
        A1+rw=; b=oXtyyCBKYg0wrhvFD84Re1Gk64Ua7ttXgcI0mrlvX2pw01as4J4UN/
        mNRZWGWW/8o7v3pnPx2BZBUVzZmTdvXCMszBupqqLGP2XWLsFQA5QGs6JMqNITnZ
        8cmga3+YbWmdxj+j57CsZ+t69lJv2sSgLbLJSXmgML21V7hMpSEIo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64679161F4E;
        Sun, 29 Aug 2021 20:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AD8D7161F4D;
        Sun, 29 Aug 2021 20:34:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <xmqqa6l6oafd.fsf@gitster.g> <YSVX18UXh9vX+Zhp@nand.local>
        <xmqqr1eimtrp.fsf@gitster.g> <YSVjnSDaBXgXvT9W@nand.local>
        <xmqq35qymrcn.fsf@gitster.g> <xmqqy28qlcow.fsf@gitster.g>
        <YSVuUYFh7lmhNlEy@nand.local> <xmqqo89jbf49.fsf@gitster.g>
        <YSko4OwwPb7MwEMa@nand.local> <xmqq4kb797xc.fsf@gitster.g>
        <YSwhNxqAS8JajA7p@nand.local>
Date:   Sun, 29 Aug 2021 17:34:18 -0700
In-Reply-To: <YSwhNxqAS8JajA7p@nand.local> (Taylor Blau's message of "Sun, 29
        Aug 2021 20:07:19 -0400")
Message-ID: <xmqqfsur7otx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03B70E2A-092A-11EC-80F5-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> now or later would affect this series. Even if we just disallow
> --object-dir pointing at a non-alternate repository, we would still have
> the issue of having alternate chains which don't all have the same
> object format.

Exactly.  That is why I feel that it probably needs to be dealt with
before doing anything else.  The alternate mechanism pulling in an
object store that uses incompatible hash algo would break not just
the multi-pack-index but probably the basic object access layer as
well, which would be more grave problem, no?

> My inclination would be to
> send a new version that simply requires the MIDX builtin to be run from
> within a repository (as well as the cleanups from Johannes).

Sounds like a good first step.
