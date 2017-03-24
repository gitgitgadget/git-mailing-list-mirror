Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A051FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 19:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967009AbdCXTbF (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 15:31:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56544 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S967061AbdCXTaE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 15:30:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7AD076A17;
        Fri, 24 Mar 2017 15:29:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YgjiRX/CBzwiYyagKAzc+OFYTZ4=; b=xK53IX
        pTH2nhsyZLCX8fpv0ucUMJ4tRwXeo1mDy3Z1LpKNd0KGJyu/3tsEM2wck+gc1W8J
        KKHdXFTB9lGwbcyARMLJe9I79elXMOrJ+zMhNJ5GlvaArZDsGyCzKTgubl1ybgKc
        u7SLZCRFuD6TfHFwlG1mrvWmmDsgRkyFBOmzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q/buqJWBOGlgfvZseXEKl/quo1074tLK
        ym0ylZjCO4j+xDJdxB38BV4uQjjrTJ/+XjQ62qe2u5mIBpSz3yD4z+bNUGBXBgMa
        Ruj95ULRPWVjNIS59k9sUNREmIGgswTw87ssxxjMtP4twAwxOvqYYHgoArl6rXHc
        oEyNQhdBBAE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEE0176A16;
        Fri, 24 Mar 2017 15:29:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1171F76A15;
        Fri, 24 Mar 2017 15:29:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Romuald Brunet <romuald@chivil.com>, git@vger.kernel.org,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] push: allow atomic flag via configuration
References: <1490375874.745.227.camel@locke.gandi.net>
        <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net>
Date:   Fri, 24 Mar 2017 12:29:50 -0700
In-Reply-To: <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 24 Mar 2017 14:45:51 -0400")
Message-ID: <xmqqmvca79sh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40910756-10C8-11E7-A754-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My one question would be whether people would want this to actually be
> specific to a particular remote, and not just on for a given repository
> (your "site-specific" in the description made me think of that). In that
> case it would be better as part of the remote.* config.

Yeah, I had the same reaction.  

Conceptually, this sits next to remote.*.push that defines which set
of refs are sent by default, and remote.<name>.pushAtomic does make
sense.  If (and only if) it turns out to be cumbersome for somebody
to set the configuration for each and every remote, it is OK to also
add push.atomic to serve as a fallback for remote.*.pushAtomic, I
would think, but adding only push.atomic feels somewhat backwards.



