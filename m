Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7DAC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F48619BB
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbhKPTAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:00:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53970 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbhKPTA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:00:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ADA7160C77;
        Tue, 16 Nov 2021 13:57:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BmA2AR2xU9ZOiPIbU/9W6eJvT1qxQolXs+Ip7T
        cM1nY=; b=QA1osiIremJpPvuZZqajFV52oNS7avVTqTilp/WgwA18XR72k8LT5f
        3btt4P7l/vhOmU54/uU+2uvu1UrZS2lEo7IcR7SPLOzs116j9Ya4uySPYQTICC1l
        elYR60KpGisZ3ibOZt7K53lWwW9hu99NCFXbHbx6uUQS5XLezSC5Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72F45160C76;
        Tue, 16 Nov 2021 13:57:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BE4ED160C74;
        Tue, 16 Nov 2021 13:57:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] wrapper: use a CSPRNG to generate random file names
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
        <20211116033542.3247094-3-sandals@crustytoothpaste.net>
        <YZPQE+SKVXjexXMT@coredump.intra.peff.net>
        <YZP4XDtF7O7Sxh17@nand.local>
Date:   Tue, 16 Nov 2021 10:57:28 -0800
In-Reply-To: <YZP4XDtF7O7Sxh17@nand.local> (Taylor Blau's message of "Tue, 16
        Nov 2021 13:28:44 -0500")
Message-ID: <xmqqtugc9bdz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C4A7E0A-470F-11EC-9631-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> I actually wonder if we should simply die() in such a case. That's not
>> very friendly from a libification stand-point, but we really can't
>> progress on much without being able to generate random bytes.
>
> Alternatively, we could fall back to the existing code paths. This is
> somewhat connected to my suggestion to Randall earlier in the thread.
> But I would rather see that fallback done at compile-time for platforms
> that don't give us an easy-to-use CSPRNG, and avoid masking legitimate
> errors caused from trying to use a CSPRNG that should exist.

Yeah, I do not think we are doing this because the current code is
completely broken and everybody needs to move to CSPRNG that makes
it absoletely safe---rather this is still just making it safer than
the current code, when system support is available.  So a fallback
to the current code would be a good (and easy) thing to have, I
would think.

Thanks.
