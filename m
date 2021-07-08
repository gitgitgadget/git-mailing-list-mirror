Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E5C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E3961434
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 22:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGHWYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 18:24:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58383 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGHWYk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 18:24:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5289C140477;
        Thu,  8 Jul 2021 18:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=f8T/8Acc4k0HohOh5lPq6oUpu
        RgbKZkfknvv1Qc+mQ4=; b=hM1rB/LDpv+cLqqYzKi5FqIETN9nDDt6buZe7/oX8
        KVn8Fmi7f/+FxaEWhe5GRydCGJJ7q29fPspKNS4nlnyLdXtoQ1IA9yUNUk4CTEPO
        KSCcyc6WmOEAc4lpu0Gabt5EReSldBnMnj3+jiOQxMayQqdyfCL5K9PRMhLNBz7D
        LI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B1D0140475;
        Thu,  8 Jul 2021 18:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F2BA140471;
        Thu,  8 Jul 2021 18:21:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/4] pack-objects.c: do stdin parsing via
 revision.c's API
References: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
        <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
        <patch-3.4-943b1b4c12a-20210621T150651Z-avarab@gmail.com>
Date:   Thu, 08 Jul 2021 15:21:53 -0700
Message-ID: <xmqqfswoa1ku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E72B2F9C-E03A-11EB-9331-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Extend the rev_info stdin parsing API to support hooking into its
> read_revisions_from_stdin() function, and change the custom stdin
> parsing in pack-objects.c to use it.

This step, while it might not be introducing new bugs, does not look
anything more than just adding yet another new API for the sake of
adding one (especially, the number of lines added vs removed does
not look so impressive).

Perhaps we'll see why it makes sense in the next step?

>  builtin/pack-objects.c | 63 ++++++++++++++++++++----------------------
>  revision.c             | 22 +++++++++++++++
>  revision.h             | 30 ++++++++++++++++++++
>  3 files changed, 82 insertions(+), 33 deletions(-)
