Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0966C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE5206EF
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 23:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fPWu16ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfLUXxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:53:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58594 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLUXxA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 18:53:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 577DFAAE5B;
        Sat, 21 Dec 2019 18:52:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LrdqasiGn2tjZOU87c0R6ETLkg8=; b=fPWu16
        aiLBCJlvHq9JlEQ70ZoUu5fjlMEexz/hg/+V3qkJOETSnU5p3Z0vBpkRTttT8bIx
        03ehCX3suNMWA7hj+zvtBV7i/jQXhnlXIVZKkrEeDmeytreDsGOpBOKad4FYAZPq
        kOv5kuTIW3hMKiJlcoeKjnfBIrtvD9uRhyEBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WF6n9nlbNdw2K6uWqhjk+pV2JV9iHDFz
        7PJ+ggvQHiD4FMHpjjZtSsyrGpwzzck5vLS1LV3oNdhKTsJaXzfwfbgfdKlTKZBv
        w3zmMeW3Ru3QpMvWRfW5N2GkZOdIu+G7Gswne45fMQBUjC4gOuLe278/k6z7eeLG
        W3t2OGGvJ9s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41673AAE5A;
        Sat, 21 Dec 2019 18:52:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 533CAAAE59;
        Sat, 21 Dec 2019 18:52:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Tom Miller <jackerran@gmail.com>, git@vger.kernel.org
Subject: Re: Propose promoting 'contrib/rerere-train.sh' to command
References: <BZAQIE4YND2I.Z7BFCW7BLH3K@penguin>
        <20191221193110.GB3339249@coredump.intra.peff.net>
Date:   Sat, 21 Dec 2019 15:52:53 -0800
In-Reply-To: <20191221193110.GB3339249@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 21 Dec 2019 14:31:10 -0500")
Message-ID: <xmqqeewx6xt6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 020A27BA-244D-11EA-8E39-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The situations where I need rerere-train don't come up often, but when
> they do, it has always worked easily and without hiccups for me. So
> perhaps there are lurking gotchas that Junio might know about, but AFAIK
> the quality is high enough for it to be part of normal Git.

I actually suspect that rewriting has a high chance of initially
degrading the quality, so we should take a two step approach if we
really want it as part of the core distribution.  As to the UI, I
think "git rerere train a..b" would be a good one, but if the
scripted version is of high quality (I haven't looked at it for a
long time---even though I used it for a couple of times a year in
recent years), perhaps we can add it as "git-rerere--train"
subcommand that is spawned from "builtin/rerere.c" for the first
cut?

> I'd suggest converting it to C and making it a sub-command of rerere
> (i.e., "git rerere train a..b") rather than a separate command.
