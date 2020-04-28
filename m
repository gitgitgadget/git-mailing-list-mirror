Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D0C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4B5208FE
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 18:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JEkNXUY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgD1ST6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:19:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63734 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgD1ST6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 14:19:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89E1F4C126;
        Tue, 28 Apr 2020 14:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bvK7c8I9rhTSTjB4ah82YrqKozU=; b=JEkNXU
        Y4r5GTioaUD+sIfL0h7bWyJ98zEL4bUBJNh81JbS4iXHNgnkNucIn1LC9yv6Dg5c
        3Lfv45BFx1T+tEw5czp4r5EecTtKBzfhBs+rcFgJLUS7ASrjsDjj6cO9YtVlQXts
        Z8v1xBjpA0caYziD65zLCnVjmuRO/MODKeRaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lMYigBp5+P3ZtiptmVL6yE6xJhR4SYVk
        +dxG8+jBzRiVf8Fgjh4xXv8MaiIn1j+X9oHU2X6X+MIEYMsNJDhhRWsBPQfseL08
        gw5MoyCnKZ685KnsK5PhMtX0U7qRVoCTkAl0c433772vmAQinl+FcUOxwtORkUMq
        ejcfaEXAdWE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8172C4C124;
        Tue, 28 Apr 2020 14:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C2B94C122;
        Tue, 28 Apr 2020 14:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: proto v2 fixes for maint (was Re: Preparing for a Git 2.26.3 release)
References: <20200428055514.GB201501@google.com>
        <xmqq7dxz4j62.fsf@gitster.c.googlers.com>
Date:   Tue, 28 Apr 2020 11:19:55 -0700
In-Reply-To: <xmqq7dxz4j62.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 28 Apr 2020 10:25:09 -0700")
Message-ID: <xmqqd07r322c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCBEE7EE-897C-11EA-945F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In short, my preference is to ship 2.26.3 with the "demote v2 from
> default", and hopefully try 2.27 with "v2 with negotiation fix" and
> hope people won't find any other remaining glitches in 2.27.  After
> that, we may want to merge the negotiation fix down to 2.26.x track
> but I am not comfortable merging it in a release on the maintenance
> track with the timeframe we seem to be talking about (i.e. a few
> weeks, presumably).

The last part needs clarification.  What I am hesitant is to merge
only the "negotiation fix" in 2.26.3 while keeping v2 the default.
As long as v2 is not the default with the "demote" patch, I am OK
to have the "negotiation fix" in there, too.
