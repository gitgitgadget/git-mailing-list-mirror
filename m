Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2166AC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E009264E65
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBPTRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 14:17:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62362 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBPTRC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 14:17:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 573CB9D0ED;
        Tue, 16 Feb 2021 14:16:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gU4zt2fSmkQGLRE8QE2GVCF8jeI=; b=NCLEqk
        ds3nc/kbL2lGsOE12842bpjczgb0NX5fAUagjdg7wIWMcwvEQ4n3ssD4UGARnSKr
        fLF/3PK8RUb1is2qsnpI/r6PVQOkXd7G2BrvV2Zz03m3CuGOWYm9Rw7ezYKSsonk
        UNbT+QHOdPiWsH0fCoHTXXl7zq6AM4XDCG8gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BGbjx+HXCR/TZBof2+9t4FOxuOefkTLQ
        sq1KM5JR8grK69BaiViPoOgsvKyd+4+biUN1H0cgYmUQ3apuT1hjhLx/jWh8nlZx
        rMwc43ifa3IrfXaGcMg31Y6HW3Q9DfqDdyLkrAwC/BtgNJtdxQZhb06apEKWnhlr
        KXBMasIwVUo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F0A59D0EC;
        Tue, 16 Feb 2021 14:16:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C22979D0EB;
        Tue, 16 Feb 2021 14:16:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jan =?utf-8?B?4oCcS2hhcmRpeOKAnSBTdGFuxJtr?= <khardix@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-send-email: smtpserver in $HOME
References: <CAG+K25Pk0+sOAYuWS2OF7CXLXJLjGMKyBB_SOLpoO5RFiktN5g@mail.gmail.com>
        <xmqqo8gksqr4.fsf@gitster.c.googlers.com>
        <YCvotU6KVruFuf9/@coredump.intra.peff.net>
        <xmqq35xvrgbg.fsf@gitster.c.googlers.com>
        <YCwXf1CA0Xyw/B88@coredump.intra.peff.net>
Date:   Tue, 16 Feb 2021 11:16:18 -0800
In-Reply-To: <YCwXf1CA0Xyw/B88@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 16 Feb 2021 14:05:35 -0500")
Message-ID: <xmqqy2fnq0vx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7277632E-708B-11EB-9789-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Sure, but you cannot say "does it refer to a local file" for a
> non-absolute path.

Hmph, why not?  I would expect that this would work as a valid way

	$ git send-email --smtp-server=./my-phoney-smtp

to test a server substitute (perhaps for testing).  The only reason
why it does not is because file_name_is_absolute() check would not
like it.

> And that is the source of the problem, IMHO: there is
> no way to signal "this is a command I expect to be executed" except by
> using an absolute path.

Yes.

> Or do you mean that we should see if $smtp_server exists in the PATH,
> and if so prefer it over a network hostname?

We can certainly go in that direction, too.  A new --smtp-program option
would be a cleaner way to solve it, though, as you said elsewhere.
