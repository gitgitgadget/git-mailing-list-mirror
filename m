Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3AC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAAC20746
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="on0/s6QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEHSLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 14:11:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50869 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEHSLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 14:11:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA1AA5C3D7;
        Fri,  8 May 2020 14:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=crpbH7SdA2pxaFwQIN+TEbscHiI=; b=on0/s6
        QMCAEVB0a2S4E2089fiVzgQCzDNx9gMrDGTYW585BfhbjSO8RkEUcXOmxo54CG2v
        m7tavJa5oEie0OIErq0EMD+sVZulWyjYTj21KlJaohGiPuruV7aIlJAFM4A0SSmP
        V5wGobep+D/M3IUlCvVdHTtkGnVNH01xjn6WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xRKlTz/FMJlzeLkMop90Nbg4qKZnZT53
        qalYyaIXBRjpQxFNYK6f+LegzVOoOZfghxaigs742iwYWo34SL4NZ8rbUK2DfD+H
        bUydrcw6t6xzJ3JpGRoOJ6w+LgVPD4h+P86yjGQtUHg/Q5g+99uzxqTJx/98Jr0d
        ypXUZv+l+vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BADA5C3D6;
        Fri,  8 May 2020 14:11:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7C2A5C3D4;
        Fri,  8 May 2020 14:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] upload-pack: fix filter options scope
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
        <20200508080115.15616-1-chriscool@tuxfamily.org>
        <20200508130616.GA631018@coredump.intra.peff.net>
        <xmqqtv0qzax9.fsf@gitster.c.googlers.com>
        <20200508171635.GB637136@coredump.intra.peff.net>
Date:   Fri, 08 May 2020 11:11:00 -0700
In-Reply-To: <20200508171635.GB637136@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 8 May 2020 13:16:35 -0400")
Message-ID: <xmqqr1vuxpor.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45EF42C2-9157-11EA-8C27-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Maybe even:
>
>   upload-pack: clear filter_options for each v2 fetch command
>
> which is more direct (we already allow follow-up fetches; they just
> don't work sometimes) and makes it clear that this is about fixing the
> filter feature with v2.

Christian may want to send in an updated one, but will queue with
that title in the meantime.

Thanks.
