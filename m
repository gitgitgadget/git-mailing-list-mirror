Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF6FC11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32B620801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IX8IZxPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgBTW7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:59:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53946 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgBTW7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:59:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C866247F66;
        Thu, 20 Feb 2020 17:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nJP1Yp2uR/zJYJLct7NLz/u+Bcg=; b=IX8IZx
        PQTly9lK3fMqOhaXZohmNB0KJgQj9fhmK1HJcsxfQYupniqi3bUmrYdgmHmJwNly
        xlNODueV4CP8S4MNPuc/ZJrBsxmTSDWwud/tDl91jdGDsYnFhMxE5ZZX9i3S8xKZ
        EOAsJg54vYrYOmKSFQ7k73k/svZBwtd8pwP+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y7BaGKOtVaUJVz7rm419zialfTeLZrB6
        /GGfdAJeF1wMIHZTifIqA8eszZIfVn/w3YlXtN4XZyObsj4mTpqn+W03VkQ5KpdX
        RnWPJDVAAee+sXp1l89OVEwWsl83OYl/q2yY20li/NVG7pr9MxOgOMW72ILxlkIq
        dD3oBDvGdBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFC6047F64;
        Thu, 20 Feb 2020 17:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32EFB47F62;
        Thu, 20 Feb 2020 17:59:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Roland Hieber <rhi@pengutronix.de>
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
References: <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
        <20200216065101.GA2937208@coredump.intra.peff.net>
        <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
        <20200218195402.GA21586@coredump.intra.peff.net>
        <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
        <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
        <20200219015733.GA81560@coredump.intra.peff.net>
        <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
        <20200219035650.GA84414@coredump.intra.peff.net>
        <xmqqftf6hlrt.fsf@gitster-ct.c.googlers.com>
        <20200220112539.GB1252160@coredump.intra.peff.net>
        <xmqq4kvlcgcz.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW7HJb2d10U_dcbB6G-UdopQ7HKyghAji=9VhmAgn3Dw_Q@mail.gmail.com>
Date:   Thu, 20 Feb 2020 14:59:49 -0800
In-Reply-To: <CAHd-oW7HJb2d10U_dcbB6G-UdopQ7HKyghAji=9VhmAgn3Dw_Q@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 20 Feb 2020 19:19:20
        -0300")
Message-ID: <xmqqftf49862.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B35963A2-5434-11EA-AC3A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> I now this is just an illustration, but shouldn't this example be "git
> describe --contains v1.0-bob~1"?

No, none of the patches discussed in this thread would not affect
anything in --contains (as it is a completely different program).
The example was bad to use one commit _before_; I meant to use one
commit _after_ the tag.

> Another case that came to my mind is when the user runs `git describe
> --abrev=0 HEAD` and v1.0-bob points to HEAD~. In this case, v1.0 will
> be displayed without suffix,...

In this case, v1.0-1- is followed by the full object name, I think.
