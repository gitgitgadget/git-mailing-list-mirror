Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52904C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0806361996
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhC2S1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:27:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61022 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhC2S07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 14:26:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4505D12FB0B;
        Mon, 29 Mar 2021 14:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Qdez2D5nL+NDHKPqr+y637Gum0=; b=yjx5VM
        5/U4clmrb4VLpr5woLgYe9UsiUWpoqGpxLw8eR9hpVe3Nf7yb+Y92egLguIvdRbq
        0SNtRAIAS1pMN4icApqUd9cD5txmxdCuMKof+ikcwyhdoxWGLWUxnrnWJMFC5eQ2
        anhsld+AAnChIX0BiZBuvqtEuxSdWFrtTZFUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gxJZ2gJXvzNhviJCWCG3ub1IaZUG+IyL
        ISymM4oH5+3ja3ZO+pSP5G7ynFbO9a0ywa/6JWqY6QnV+vZX9CHlOuMDpgIQSYYK
        MC4HASFxZc7B2b9H+q/aI6XUdjo9G1tbX4xqY5+sRCZYGVRzoagv5L2x6lu3yjDH
        Yv3lvjxqXJA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E7F912FB0A;
        Mon, 29 Mar 2021 14:26:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8762B12FB07;
        Mon, 29 Mar 2021 14:26:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] Makefile: rename objects in-place, don't clobber
References: <20210307132001.7485-1-avarab@gmail.com>
        <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
        <patch-1.6-3330cdbccc0-20210329T161723Z-avarab@gmail.com>
        <xmqqy2e5kegv.fsf@gitster.g>
Date:   Mon, 29 Mar 2021 11:26:54 -0700
In-Reply-To: <xmqqy2e5kegv.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        29 Mar 2021 11:21:52 -0700")
Message-ID: <xmqqr1jxke8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57C45A04-90BC-11EB-8BFC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>     	thing:
>>     		rm -f thing thing+
>>     		prepare contents for thing >thing+
>
> Did I say that?  I recall I specifically avoided the "redirection"
> because this is *NOT* shell-script only principle.

Ah, I did say that in the response to the previous iteration.  But
the same principle applied to your other patch for [ce]tags which
took "-o output", and I was recalling my response to that thread.

In any case, whether "cmd >thing" or "cmd -o thing", if cmd leaves a
broken output in thing when it fails, it needs the "into thing+ and
rename to thing" dance.  Redirecion always need it, but a well behaved
command like $(CC) should not need it.

Thanks.
