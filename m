Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705A4C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C34760234
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhF2BFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:05:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51566 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhF2BFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:05:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E08B61559A9;
        Mon, 28 Jun 2021 21:02:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=HDhwJqSjIjTG0T1RtnbRmONXxv7iNYvggqunh0hOYIA=; b=pHrB
        UEbXqe9QXPYEPGSE81ZvfWA15BJmqyuT6tnw9dw//zd7dkcq2d/dc6YR3J30TWx9
        L0sJ1DmPUzz5LdCLN2xQNzOhK+6WK4klX/Ad5+A14ipExlJN7iEay78HDULyRIIY
        D6KvFUgewW9ypAMIhPY6LL2MIn/LGcy1m3luFIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9D401559A8;
        Mon, 28 Jun 2021 21:02:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2812F1559A7;
        Mon, 28 Jun 2021 21:02:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 3/3] bundle: remove "ref_list" in favor of
 string-list.c API
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
        <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
        <patch-3.3-9d9cb5aaf9e-20210621T151357Z-avarab@gmail.com>
        <YNS8vzPc1KyRaSR5@coredump.intra.peff.net>
Date:   Mon, 28 Jun 2021 18:02:37 -0700
Message-ID: <xmqqh7hh4h5e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B30F1F10-D875-11EB-949D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think this is a good direction, and I didn't see any errors in the
> code. It's slightly sad that we end up with more lines than we started
> with, but I think that's mostly because you're actually freeing the
> memory now.
> ...
> I.e., I think:
>
>   if (is_prereq)
>           string_list_append(&header->prerequisites, "")->util = oid;
>   else
>           string_list_append(&header->references, p + 1)->util = oid;
>
> is much more obvious.

Nicely done and nicely reviewed and improved.

Together with the "no point in freeing just before dying" on the
earlier step, polishing this topic to incorporate the suggested
changes should be fairly an easy task.  Let's not leave too many
loose ends hanging around and close this one with the last final
reroll (hopefully without "I did this too while at it" that meets
"oh, well, that is a bit controversi8al" to drag it unnecessarily
out).

Thanks.

