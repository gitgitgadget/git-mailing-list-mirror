Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A1C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 06:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF2460FD8
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 06:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhH3Gk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 02:40:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58787 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhH3GkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 02:40:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99E7CE1932;
        Mon, 30 Aug 2021 02:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MtuKy1qV/AyYdNcykMzHq6tU3OAbvpaCij3+Vg
        CyI0g=; b=kZNvEtR/PnsDUIj6AQ74KCyPzL6SZbaSEO5XeBMFm/IvVehKbttQVt
        gpiF4TAhF35cs0tc9iXN7EwZrqOt3iNxKkfwdhjrfxVFBIoQU5Njm9SntF1C8tWk
        BUkpaVOXNgi6XUOoJVuewMXR0f1oxIC7+v+4wruJpdxBwXMQVHI6o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92A0CE1931;
        Mon, 30 Aug 2021 02:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A3DCE1930;
        Mon, 30 Aug 2021 02:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 0/3] pack-objects: simplify add_objects_in_unpacked_packs()
References: <cover.1630291682.git.me@ttaylorr.com>
Date:   Sun, 29 Aug 2021 23:39:30 -0700
In-Reply-To: <cover.1630291682.git.me@ttaylorr.com> (Taylor Blau's message of
        "Sun, 29 Aug 2021 22:48:43 -0400")
Message-ID: <xmqqy28j5tct.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07ED8FC2-095D-11EC-90E6-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This short series is extracted from mine and Peff's work on cruft packs. These
> three patches focus on cleaning up add_objects_in_unpacked_packs(), which is
> used to implement `git repack -k`.
>
> The pay-off for this clean-up is significant, though: we net -50 lines of code,
> and the result is much more readable, at least in my opinion.
>
> The changes are described in detail in the patch messages, but essentially we
> are replacing a loop over get_all_packs() with for_each_packed_object() after
> adding a couple of new flags necessary to make the switch. And once we are done
> with that, the third patch removes a bit from the object flag allocation table.

A quite pleasant read.  

Each step looked nicely done and well explained.

Will queue.

Thanks.

>
> Thanks in advance for your review.
>
> Taylor Blau (3):
>   object-store.h: teach for_each_packed_object to ignore kept packs
>   builtin/pack-objects.c: simplify add_objects_in_unpacked_packs()
>   builtin/pack-objects.c: remove duplicate hash lookup
>
>  builtin/pack-objects.c | 85 ++++++------------------------------------
>  object-store.h         |  6 +++
>  object.h               |  1 -
>  packfile.c             |  6 +++
>  4 files changed, 24 insertions(+), 74 deletions(-)
