Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3896BC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067DA20774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yaie4gUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgHNUVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:21:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64330 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNUVd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:21:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 526268058D;
        Fri, 14 Aug 2020 16:21:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UaLzxrChcWYkq9hW+fyRtxIYIGA=; b=yaie4g
        UI457DCU6VeBHAUsMKUDelHcBOSM6sERknvBwrDz23MrnAf3/ZUlLpqXXjRpURYc
        ZbiImrnkJS19iTNH+EiCThRMYeLo1uZI+lfBKHfQLr2nZPPc6t1iRjV2GapM2BtT
        r0Q/99J9tpHrcXxtac+lDZmCFlOHX6YWb+6bU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UcffpXsbRMUU0GZG3XvOckBuplCMW6FQ
        OdEoNOTX6Gu9gBWdSi0EuNwf7VPykq0scwhfW+soD15ItwtHDNFenxd1xetq0yEs
        mwmabstttdavaD3J0fhE/2LaewrDPWsF2ISdOQEUoMoyPZ/BWwQwaBkTo2lmdBhS
        RKhZ4vFxlsM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49D738058C;
        Fri, 14 Aug 2020 16:21:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C40938058B;
        Fri, 14 Aug 2020 16:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] config: drop git_config_get_string_const()
References: <20200814161328.GA153929@coredump.intra.peff.net>
        <20200814161921.GD595698@coredump.intra.peff.net>
Date:   Fri, 14 Aug 2020 13:21:32 -0700
In-Reply-To: <20200814161921.GD595698@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 14 Aug 2020 12:19:21 -0400")
Message-ID: <xmqq364pvv03.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE908324-DE6B-11EA-8DBD-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As evidenced by the leak fixes in the previous commit, the "const" in
> git_config_get_string_const() clearly misleads people into thinking that
> it does not allocate a copy of the string. We can fix this by renaming
> it, but it's easier still to just drop it.

This turns out to be a bit more painful than I imagined.

Do we want to do the same with repo_config_get_string_const(), by
the way?  Which would open the wound even wider, but may be worth
doing for consistency.

