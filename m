Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B8C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0BE61352
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELD0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:26:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54060 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhELD0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 23:26:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0231C878A;
        Tue, 11 May 2021 23:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Me25thdfXpA0ZCEMLbRaus1fYkVF+3AksGTRW8
        x8Vig=; b=Sr7t0zB82RxZ/sXoUt6zr4r/UpZAE0FkoUUA0PdqnGToFUq17/yQi8
        CR19XOBkHroxE4bxACLfaweZRYHJfEdsn7R4nfFfL1Gs+lxlBnpAn7U2Stku7qS8
        cSNPDM/bQbfud+Izh7qAWJ64HTke4/XOQgTjobCltRb+zi7E/d7+U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97938C8788;
        Tue, 11 May 2021 23:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 179ECC8787;
        Tue, 11 May 2021 23:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org
Subject: Re: Syntax for specifying a command in git config
References: <YJrH8uqzapnpNEsb@gpanders.com>
        <YJrKJAa45mNIL+rf@coredump.intra.peff.net>
        <xmqqo8dgj2vk.fsf@gitster.g>
        <YJsiKDNbKclFU00b@coredump.intra.peff.net>
Date:   Wed, 12 May 2021 12:25:16 +0900
In-Reply-To: <YJsiKDNbKclFU00b@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 20:32:40 -0400")
Message-ID: <xmqqtun8hbvn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC2814DC-B2D1-11EB-8B5C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> 	git send-email --smtp-server="/usr/bin/env msmtp"
>> 	git send-email --smtp-server="!my-msa --emulate-sendmail"
>
> Yes, the patch under discussion does apply to both the command-line
> option and the config option (and I agree it should).
>
> I didn't think about arguments, but you're right that may be a useful
> feature. And if done via the shell, as brian suggested elsewhere, would
> be more consistent with other parts of Git using "!" syntax.

Heh, it was my tongue-in-cheek way to say we do not need this '!'
new feature, as long as everybody has 'env' in /usr/bin ;-)

> It does make things a little weird in that:
>
>   git send-email --smtp-server='/path/to/my-sendmail foo'
>
> and
>
>   git send-email --smtp-server '!my-sendmail foo'
>
> behave differently (the first does not work; it looks for an executable
> with a space in the name).

True.  Hopefully we do not have to worry about $IFS whitespaces in
an absolute path to the mail submission program?  ... Nah, that's a
wishful thinking.

But then nobody stops you from saying

	git send-email --smtp-server '!/path/to/my-sendmail foo'

so it probably is OK.  We can gradually deprecate the "absolute path"
form and standardise on the "!prefix" form.

