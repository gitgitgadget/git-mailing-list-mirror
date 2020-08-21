Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729BFC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A2F20732
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f/4WoKMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgHUQwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:52:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50957 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgHUQTz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:19:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 393DB7A235;
        Fri, 21 Aug 2020 12:19:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BezUXU+ia+IqTjTkPIvYbxqlrT8=; b=f/4WoK
        My5moUHR4liTXhbHxpG9le4sZYbKKahwJODTn0ApPAMX1Gc0p2M1WBIj3xn47IZF
        zADioDna/EQYexHSc8Qj9E950rv4FlAB2SfTqMbS8zGJwkUsK0wP+nwwpzKJICoP
        rbiB1NEPsUGfV9BCaEaTIch3xw2yp/zT5WWKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W2fXUvgNLsHaLeIcch+lkwUs/9SkqXYJ
        ssnytGMgsIJGzxZn5uFR8i1bNCRPp4nKDYUAvXfogMibg1dwBvpraXlswaZaDUaT
        t8/y2+wsBqIcqNWyU2Er1iZa+BjanYLiYrlV6DZwEgWVHjeOQIHPY1VmCDJZlwxt
        ZLLfPoImK4U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21F4F7A233;
        Fri, 21 Aug 2020 12:19:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 919A97A232;
        Fri, 21 Aug 2020 12:19:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
        <20200815002509.2467645-3-jacob.e.keller@intel.com>
        <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
        <CA+P7+xpcm51cLPDDW+F1J-XZ2VvwNDWjnZqm54f3DKXxDfBF5Q@mail.gmail.com>
        <20200818174116.GA2473110@coredump.intra.peff.net>
        <CA+P7+xqfAqnoKBeOiO6f7tdyi_7M=wKpmnFoWBt6UHbOqbYCzQ@mail.gmail.com>
        <20200821023335.GA3124022@coredump.intra.peff.net>
Date:   Fri, 21 Aug 2020 09:19:50 -0700
In-Reply-To: <20200821023335.GA3124022@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 20 Aug 2020 22:33:35 -0400")
Message-ID: <xmqqr1s09djt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23773950-E3CA-11EA-A279-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, I'd agree we should be applying the negative refspecs first, and
> then de-duping / looking for collisions. Which I think is what the patch
> is doing currently.

Good to see that we thought this through.  The reasoning deserves to
be recorded somewhere (perhaps a comment just before making the call
to apply the negative refspec).

Thanks.
