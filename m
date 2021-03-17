Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FA6C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A1964F59
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhCQTB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:01:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65136 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhCQTBE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 15:01:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F0B21A3E87;
        Wed, 17 Mar 2021 15:01:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V/kXUUxDClHy
        drSxntO7aAIKPt8=; b=rvuy27a7morR6UQl3rTTn2yQnVEHo8We2UUdw78100yX
        8aN28mfLRLBOT9oo2q5egVEJd9EyJN0MIgNuqCdd40brqqk6TFBOrmEjkVAtt3cY
        a9ly1mGabH5NIRFy/jGFIXDfsz9kO1B98GIzzPRwHnE3vP9SNNwX7deMGrPTxsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=F8716e
        MtXs6j/SriS59oDxof73apJxDJqXIgkKn0Suh/TtCg7XyVJLggSUY452bpBWpP0N
        U5g9ESFE57iPk+fbK/XpgdpbDyH5jZiv8LsKlcdbwaRsLebVqJ6zPGDvPb61zXh9
        TwJ5kzb6B58fEQ9/Sciz2Xz/k0DbIozkbZb0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95BC1A3E86;
        Wed, 17 Mar 2021 15:01:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC627A3E85;
        Wed, 17 Mar 2021 15:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 17/22] fsck.c: pass along the fsck_msg_id in the
 fsck_error callback
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-18-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 12:01:01 -0700
In-Reply-To: <20210316161738.30254-18-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 17:17:33 +0100")
Message-ID: <xmqqblbhvc42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1E74E86C-8753-11EB-B024-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the fsck_error callback to also pass along the
> fsck_msg_id. Before this change the only way to get the message id was
> to parse it back out of the "message".

Nice.

> Let's pass it down explicitly for the benefit of callers that might
> want to use it, as discussed in [1].
>
> Passing the msg_type is now redundant, as you can always get it back
> from the msg_id, but I'm not changing that convention. It's really
> common to need the msg_type, and the report() function itself (which
> calls "fsck_error") needs to call fsck_msg_type() to discover
> it. Let's not needlessly re-do that work in the user callback.
