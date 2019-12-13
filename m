Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77954C7D615
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11882474A
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S23Q0j9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfLMRwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:52:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57534 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMRwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:52:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE6D71842E;
        Fri, 13 Dec 2019 12:52:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KzYMlzmabGGvOkCCKulunKkLr4U=; b=S23Q0j
        9nvhlcVTYbe+Yupl+lVpCi0c1+fm+iB+zn04udTDc3+wc6rIfr/TBH4elq5tMseC
        GB/8CYvgKTBJOwiLOTUbUi/Jcift93SFSBOFUBD8K5oAFG8IoXKclcQLX4PyZvYI
        6p0WCoXEMuFSqxfP3cb3Etcw2jlHeyotQHNDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NxNfKHsn276P8X4cz+9zZaVnElw2DJhQ
        wUirQ4fDU3R3V6eT2ISWgl2VfsEv1kE4neyJOxQiC4U/RT+oimjficyfVwGi7ekJ
        BFs4YxYWbGBlIOFf545mYAboOxQCDWsfdgutEPufNwQe74Slbk4tAKSEHXaYoc/9
        lnmPWi7f4E8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5F531842B;
        Fri, 13 Dec 2019 12:52:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C62418429;
        Fri, 13 Dec 2019 12:52:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Gmail munges dates?
References: <20191213015753.GA14249@generichostname>
        <20191213054227.GA76445@coredump.intra.peff.net>
Date:   Fri, 13 Dec 2019 09:52:20 -0800
In-Reply-To: <20191213054227.GA76445@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 13 Dec 2019 00:42:27 -0500")
Message-ID: <xmqqtv64kt9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 504AEFFE-1DD1-11EA-9854-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> 2. Do we want to introduce a --in-body-date option or something to
>> format-patch which would include an in-body Date:, similar to the
>> in-body From:? (Also, while we're at it, maybe we could include an
>> --in-body-from to force that to happen since that's been a feature that
>> was requested in the past[2])
>
> I doubt I'd use it myself, but I wouldn't be opposed to an in-body-date
> option. You'd perhaps want to define some heuristics to avoid
> uninteresting noise. If your patch is from 10 minutes ago, and you are
> just now sending it in, adding the extra date header is mostly just
> clutter. So perhaps you'd want it to kick in when the date is more than
> N time units or something.

I do not have a fundamental objection to the --in-body-date option,
either, although I do not want to see it used when sending patches
to this list.

As long as it is a command-line per-invocation option, I do not
think you'd need any "uninteresting noise filtering" logic.  A
configuration variable to always do so would cause a huge headache
to keep the behaviour sensible when sending one's own patches,
and would require such filtering, I would think.

Thanks.
