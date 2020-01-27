Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC317C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7367222527
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SRMcTCkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgA0TRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:17:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62817 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgA0TRd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 14:17:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E606C3A9BD;
        Mon, 27 Jan 2020 14:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QB955cI1JRHt24S1Xa0QXGj0WM0=; b=SRMcTC
        kBcf7MInnR6dJcrOqf6W+mB0w3IigDO1jY1dAocIo8w1D262SK+OtbS2C+zMmzFw
        Js/o1rXhfMWrGGzH1Qs7uuwlmA7vtR6qWtMgVzv2cDk6BvJDLME0vcmzpA0B5RGn
        xryneD2rxZ2NuSGhFLyTda7g2Zf8SM8IZ13Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OZwIR7U9yaVjSRofYpOvmamX9BUPh7hL
        LCvDtwEPE8kaaK/a1F0Y26TZMZzI1YYyLJnJlhBee85N6tOC3rIUJ2pD356QKS3w
        qmVzotKNK6c/nj++4LgXHqJ3QStzbdPefb3xWWx1BYMMuRWlSHtPVcByeJtNQfuM
        rzgcMuonMYY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE7FA3A9BB;
        Mon, 27 Jan 2020 14:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D8DB3A9B9;
        Mon, 27 Jan 2020 14:17:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/4] merge-recursive: silence -Wxor-used-as-pow warning
References: <20200125053542.GA744596@coredump.intra.peff.net>
        <20200125053723.GA744673@coredump.intra.peff.net>
        <xmqq4kwjcupj.fsf@gitster-ct.c.googlers.com>
        <20200125195515.GB5519@coredump.intra.peff.net>
Date:   Mon, 27 Jan 2020 11:17:31 -0800
In-Reply-To: <20200125195515.GB5519@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 25 Jan 2020 14:55:15 -0500")
Message-ID: <xmqqblqobtf8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AACD1FA2-4139-11EA-A041-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't overly care on the implementation either way, since it's now
> hidden in the helper. I mostly chose the bit-flip to match the existing
> code, but I'd be happy to change it.

I don't, either, and as a step in this series, it makes perfect
sense to keep the implementation detail the same in the new helper.

Making it more readable would be a separate issue.

Thanks.
