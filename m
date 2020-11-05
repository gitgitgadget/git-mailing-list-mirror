Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8AC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4C920724
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="blewUlMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKEVYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:24:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62990 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKEVYW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:24:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A957F9E12;
        Thu,  5 Nov 2020 16:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jZrwXzSh+XpuqlCe9aq2gDNJF8o=; b=blewUl
        MgcNHjUCoZi5p8rqTWY0scA+3xYODXAXL1kv75YILrv985ZYUBFn2twR1EaRtBX9
        7CKM09UGsHLfRqdFnL58K8JFwKVXWz8bcogT1n0uGDaqwyO2hwJjOZlRCaoO5Hs7
        PABaFG2ymEUCiU2QxIfBYlbP0DVxjjOMp7Mcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C7dycR3cj8X9frw/fT8Y1xk8HqKEOta/
        d5WqMglNqaCBsGrn+XD46EPNTXfRaG9kM7dqOHen8V28RRaQV5jXDP8BO7oOBtU0
        gch81Z8t5NgiFy/HUz46M3zn8mcDo/KxqRHimRpGGVAPgMmeg02CyfKjQT2H6eZW
        82sbKbupnUk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22939F9E10;
        Thu,  5 Nov 2020 16:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CBC7F9E0F;
        Thu,  5 Nov 2020 16:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 02/11] docs: new trace2.advertiseSID option
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <5d5097b67109554e0763724633810ea616b5e2b2.1604355792.git.steadmon@google.com>
        <xmqq1rhaqfqg.fsf@gitster.c.googlers.com>
        <20201105192847.GD36751@google.com>
Date:   Thu, 05 Nov 2020 13:24:15 -0800
In-Reply-To: <20201105192847.GD36751@google.com> (Josh Steadmon's message of
        "Thu, 5 Nov 2020 11:28:47 -0800")
Message-ID: <xmqqeel7ijk0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42BF995A-1FAD-11EB-8AE0-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Yes this makes sense. Do you think it's worthwhile to move all the
> session ID implementation out of trace2? Right now there are some
> user-facing bits (environment variables for parent/child SID hierarchy)
> that specifically mention trace2, and I believe that the repo tool is
> using it to tie together logs produced by a single repo invocation.

If somebody other than trace2 starts using session ID, or if we
introduce a mechanism that allows a session ID assigned without
enabling the rest of the trace2 machinery, such a separation may
make sense at the implementation level, but until then, I do not
think it is worth doing.

