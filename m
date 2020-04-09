Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ABCC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA97C20757
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dFWttr+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDISz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:55:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58894 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 14:55:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4ACF1BB483;
        Thu,  9 Apr 2020 14:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zXvjXd7aCIPG6DhiygRlIER+968=; b=dFWttr
        +EBMJOmXx3rRroCzazGdiH3ABCjaOmmxBnZZXyjdvorPQjfXK0bOOYq6E61I79CK
        XjBfuwXr9EDC144cTt3uCFDETjSoNsxpru23+iRepHKHM01OJB4OyhwrSHvnZNXV
        VbEcUVWfUVIlC5FxpMLk1m3Io/HurZrkXNzis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X71P80SHN575M3VfBt1Wp8xc/DZgwC2H
        UBtX54qG40pR29Qssr8Ylk0DbJX1UFmsCvllFQZUPJhDeqkpcvnznlvZxCdRkKBQ
        A7a2bxEE91bnChNdlerM84TXrlvEvyj2Shx2T0/yBYrpsh/6JvKFPaQjwmkZT6DN
        FVF2uzjO6zU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4291EBB482;
        Thu,  9 Apr 2020 14:55:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B282BB480;
        Thu,  9 Apr 2020 14:55:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
References: <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
        <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
        <20200408200526.GA2270445@coredump.intra.peff.net>
        <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
        <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
        <91fafa17-c58f-dcd0-320d-48c4512561f6@gmail.com>
        <xmqqimi9o705.fsf@gitster.c.googlers.com>
        <7d84fc45-786f-7a2e-5889-ef26916627ef@iee.email>
        <xmqqeeswodol.fsf@gitster.c.googlers.com>
        <63667043-dbca-0092-209d-865c2f60efc8@gmail.com>
        <20200409182455.GA4166316@coredump.intra.peff.net>
Date:   Thu, 09 Apr 2020 11:55:51 -0700
In-Reply-To: <20200409182455.GA4166316@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 9 Apr 2020 14:24:55 -0400")
Message-ID: <xmqq369co5e0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCE14BD0-7A93-11EA-97C8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Apr 09, 2020 at 01:20:57PM -0400, Derrick Stolee wrote:
>
>> In conclusion, I think "--show-pulls" provides the right context for these
>> extra merges to show in the history view. It also roots these merges in a
>> Git-native name (that also happens to evoke the "pull request" concept that
>> is _not_ native to Git).
>> 
>> What do you think?
>
> Yeah, after reading more of the thread, I think the simplest way to
> think about is "keep merges that pulled in something" with the
> implication of "(even if the other side didn't touch anything)".

Isn't it more like "even if our side didn't touch anything", though?

If a merge pulled in something, the other side by definition did
something (i.e. what was pulled in); if we did something since they
forked, we would have shown the merge without this patch---the only
new behaviour we are adding is to show the merge even when our side
didn't touch since they forked---so far we never showed that merge,
but now with this option we would when we are asked to.

I agree that "this is showing pulls" is an easy way to explain.

> And "something you pulled" is a sensible way to think of that. So
> --show-pulls makes sense to me. Or if we really want to tie it in to
> simplification, --no-simplify-pulls. But that's more awkward to type,
> and none of the existing simplification options use the word simplify. ;)

;-)
 
