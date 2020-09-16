Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E28C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98A52080C
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 22:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VgEa01lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgIPWRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:17:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59083 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIPWRr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 18:17:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CDB87F496;
        Wed, 16 Sep 2020 17:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GRea4R9pws/zUR37iq4Fw1/mvw0=; b=VgEa01
        ltGXuffpGtPPt2RP6TH/EPr70ypVGPxuIdiBJYr8W9UEw3AJEcWOUI+zcDhPCTts
        +sI5+T356t4SV37fPOZFgp1wkn269YoN+4YgDSIv0bMqqUBenEMCvsgZIXxa9MT6
        BR1KhOWTETe2TQiZ5AjccxOS1qufPIWAD28Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IBPnvdtnvHRqspQH4T0vdkgszAfTO8vD
        l4iGrbQ7JRpAjtbKlq1FT9Yj0k3Zru/rYuqiRZoRJzxiv4YkxEPBdd+umBDnL2kr
        l9hyK1uRbvt3QH6Vkpqy8FEWs1Bujx1cGIIKeI0EjF9ScscpnOqjDVgwnyCe/V6n
        HcC3OSVG2Ig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 930B67F495;
        Wed, 16 Sep 2020 17:20:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1863A7F494;
        Wed, 16 Sep 2020 17:20:36 -0400 (EDT)
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
        <xmqq4kny2461.fsf@gitster.c.googlers.com>
        <20200915212338.GA2868700@coredump.intra.peff.net>
        <xmqqa6xqzpx9.fsf@gitster.c.googlers.com>
        <20200916163427.GB17726@coredump.intra.peff.net>
Date:   Wed, 16 Sep 2020 14:20:34 -0700
In-Reply-To: <20200916163427.GB17726@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 16 Sep 2020 12:34:27 -0400")
Message-ID: <xmqqsgbhv2ot.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 762A03EC-F862-11EA-AA2C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That said, it sounds from the other part of the thread like we'll need
> better parse-options support anyway, so this "noop flag bit" idea
> probably isn't a good direction anyway.

OK.  Thanks.
