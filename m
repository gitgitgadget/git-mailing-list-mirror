Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A936C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2812208E4
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 20:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZeD2ov6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIOUJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 16:09:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56868 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgIOUJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 16:09:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7EF0BDBF75;
        Tue, 15 Sep 2020 16:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BUdZK7QbF2zAY4eke6R2C31X4sg=; b=ZeD2ov
        6E5mtPuv4ughrpofp+khpodB6vioaGYmnPhZ4P9SlQRsU8h4UKjIipLfD2s4U+bm
        BVCGoUtwJv+oUL7e4VtFNsv4N/GD/ppODNlwNWVW+W5xwMuniymBK2coXP5PR8ss
        712Z78UKz5L+wcSARnNvD3DO25lMAO//7gP2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gqHCSmstz1JYyZguhJfLukeIIrHthRkx
        WU8yQN4eYO4hu64h7kbNSSIlx4I4hlNTNVtcYCadopFfmlaKXsFdO1jIAbPEdbPN
        uDuXgsfqXgYcxiy1MfuNNy3KECc3LEalql8NW2/NcGDRhJYeAZNnt5oEc0kTT4tQ
        /znNsLgNtN8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77765DBF71;
        Tue, 15 Sep 2020 16:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9B92DBF6F;
        Tue, 15 Sep 2020 16:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: sub-fetches discard --ipv4|6 option
References: <20200914121906.GD4705@pflmari>
        <20200914194951.GA2819729@coredump.intra.peff.net>
        <20200915115025.GA18984@pflmari>
        <20200915130506.GA2839276@coredump.intra.peff.net>
        <20200915140613.GB18984@pflmari>
        <20200915152730.GA2853972@coredump.intra.peff.net>
Date:   Tue, 15 Sep 2020 13:09:10 -0700
In-Reply-To: <20200915152730.GA2853972@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 15 Sep 2020 11:27:30 -0400")
Message-ID: <xmqq4kny2461.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52AE89FC-F78F-11EA-B64E-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 15, 2020 at 04:06:13PM +0200, Alex Riesen wrote:
>
>> > Yeah, that would solve the duplication problem. We could probably add a
>> > "recursive" bit to the parse-options flag variable. Even if
>> > parse-options itself doesn't use it, it could be a convenience for
>> > callers like this one. It is a little inconvenient to set flags there,
>> > just because it usually means ditching our wrapper macros in favor of a
>> > raw struct declaration.
>> 
>> Or extend the list of wrappers with _REC(URSIVE) macros
>
> If you go that route, we have some "_F" macros that take flags. Probably
> would make sense to add it more consistently, which lets you convert:
>
>   OPT_BOOL('f', "foo", &foo, "the foo option");
>
> into:
>
>   OPT_BOOL_F('f', "foo", &foo, "the foo option", PARSE_OPT_RECURSIVE);
>
> but could also be used for other flags.

What is this "recursive" about?  Does it have much in common with
"passthru", or are they orthogonal?
