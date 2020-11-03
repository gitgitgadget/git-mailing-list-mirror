Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D67C388F7
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94087206E3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lVGZUa0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbgKCVWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:22:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64360 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387810AbgKCVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:22:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 737F7EE2F7;
        Tue,  3 Nov 2020 16:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tZSFubVHwLUamWyCfLP8KRIQZBI=; b=lVGZUa
        0gH7cDCuQ+Bok82ntbTMPU4doXZnFl59ENPPuVeANYSFemgX3h3C5D/ZKV9hMoUO
        Z2ll/0+54JAwunb8Wky8+nqyXl1Es5Wy6ZdIHZ8kXDvrbzpfkEtI/5uy/7SNij3v
        0+T2A97Jj7dkHqRb82cPdoykVUEXPtK2GgQIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OCppkJoXmCWPIwM6zg7UnuWT5EjcvuUe
        68kSV5wREZe0NL1LjGZc6YqIHwr0RDUnGY61T7QDk5FO6zKRVASAwgapgcISBrQm
        0qNntq7jxz8rSfpqsjzrGCDh6Ek/Q6jY7aYxaBnhCqTz1drEwE4lX9i21gyLrhTx
        hCRidtLV1xs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BC4BEE2F6;
        Tue,  3 Nov 2020 16:22:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B6EF9EE2F5;
        Tue,  3 Nov 2020 16:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/10] Advertise trace2 SID in protocol capabilities
References: <cover.1604006121.git.steadmon@google.com>
        <4f1a1bab-7ac7-b8dd-acb2-6aeb04be3171@jeffhostetler.com>
        <20201102222020.GA1904687@google.com>
Date:   Tue, 03 Nov 2020 13:22:27 -0800
In-Reply-To: <20201102222020.GA1904687@google.com> (Josh Steadmon's message of
        "Mon, 2 Nov 2020 14:20:20 -0800")
Message-ID: <xmqqa6vyqgoc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD22CF5E-1E1A-11EB-B9FC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> So the value being passed between client and server over the
>> protocol may look like `<sid1>/<sid2>/<sid3>` rather than just a
>> single `<sid_x>` term.  For your purposes, do you want or care if
>> you get the single term or the full SID ?
>
> I'm not sure we care too much one way or the other. A single component
> of the SID should be enough to join client & server logs, but it's
> easier to just send the whole thing.

It may be worth documenting this design decision in the protocol
doc; even though protocol doc may say this should be treated as an
opaque token, people may assume certain structure.
