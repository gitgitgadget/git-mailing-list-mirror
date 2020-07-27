Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF4C433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829D120729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 23:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kFMPg6Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG0XGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:06:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50559 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0XGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 19:06:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 711A3CE4D4;
        Mon, 27 Jul 2020 19:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lz+ned8VI8ZsOBqub1PypDQuhLU=; b=kFMPg6
        Vfs19gXlucCHSJ5E3dqotg4IoGRw5JYYX5xocKwTMBYuBo9Il/6XN7T8Y65RSfzw
        2Xw+ptj3KEjyL9VdCXKsUZKJ2ZplJbeLOSA7VxQ1SI32d67PuvpqIfa+iLNA+rH7
        d8U6rLmvUs32SR6B5PCy0C0ZAXIeTt4v/tnGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GjFzdgzqxfZtID6Xc5CMzoPnNoME8eNd
        FW78Ss8UDD6vrnGcueP4MGZQAEWPKqkMHfvK2yC6nrqp79+kubyGLTvPgiD4hI7A
        6E9FB/RxMCwMPeYKOaTt85XwU4zR48qmnJZ3guCc3cbXHwcqv/3nopvxp0lwOxrk
        iLRM8o5A5Ig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68E56CE4D3;
        Mon, 27 Jul 2020 19:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB0A5CE4D1;
        Mon, 27 Jul 2020 19:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com>
        <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com>
        <xmqqk0yog1lg.fsf@gitster.c.googlers.com> <878sf4r4au.fsf@0x63.nu>
Date:   Mon, 27 Jul 2020 16:05:58 -0700
In-Reply-To: <878sf4r4au.fsf@0x63.nu> (Anders Waldenborg's message of "Tue, 28
        Jul 2020 00:17:39 +0200")
Message-ID: <xmqq5za8ftih.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC418648-D05D-11EA-A2BB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> From what I can understand it tries to match *both* on the second level
> AND the value of .key (trailers.c:token_matches_item)

Yuck, I do not know what were we thinking to design the behaviour
like *that*.  Or it may be simply buggy.

> $ printf '\na: 1\nb: 2\nc: 3\n' | \
>   git -c 'trailer.A.key=B' interpret-trailers
> B: 1
> B: 2
> c: 3

I can understand the first one (i.e. "trailer.$name.$var" try to
match $name as case insensitively) but not the second one.  There is
not an single rule for "b" trailer, and we should be getting the
same behaviour as the third line, i.e. the key not involved in
rewriting is passed as-is.

