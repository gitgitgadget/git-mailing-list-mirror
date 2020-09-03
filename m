Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6749CC433E7
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 02:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D5320758
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 02:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wMiWPHbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgICCHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:07:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54597 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgICCHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 22:07:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 618ADDD23F;
        Wed,  2 Sep 2020 22:07:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0jMz45HObTm6yRPXb+bERqYnswU=; b=wMiWPH
        bWixrOQ6Vk/0NGEBIC07eFfv5fFbg2aGKR2LSRfQrkRZSlbljmwgNlDcezLfCDsR
        EwvuoWp8ZMHspy/nXDuuEEnuXEAbLf7NcplU19JhFvvQXElx0QPl7L2nxtVifoaO
        B8ElgNOnR7oKOGiX1pGKtAdCx6jd46T8+vHqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SPQ1oX4rOeHp1y5wNlEzYn6DaHR2wMUb
        lMagRMnD7AxVayKyVpQruGGOaXeBn1diFw2UNQUug5zA9mMlRagJbIFjWJXP9s2g
        mMDqoT3BWYQ8dbaD2oulHwsqtsDzhoCSKdopbv+9bE5I2ClS4ydaXokpe3TCG+ky
        tjk95GzZOzc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59D7FDD23E;
        Wed,  2 Sep 2020 22:07:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A310BDD23D;
        Wed,  2 Sep 2020 22:07:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] vcbuild: fix library name for expat with make MSVC=1
References: <pull.722.git.1599077798953.gitgitgadget@gmail.com>
        <20200903000640.GD4035286@google.com>
Date:   Wed, 02 Sep 2020 19:07:36 -0700
In-Reply-To: <20200903000640.GD4035286@google.com> (Jonathan Nieder's message
        of "Wed, 2 Sep 2020 17:06:40 -0700")
Message-ID: <xmqqk0xba9zr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D3BAA3C-ED8A-11EA-A090-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> (cc-ing a couple of Windows experts)
> Orgad Shaneh wrote:
>
>> Subject: vcbuild: fix library name for expat with make MSVC=1
>
> Do you have more details?  For example, what error message does the
> build produce without this change?

Presumably you'd get an error at link time, saying either 'no such
library: expat.lib', or 'symbol X not found' for symbols that were
supposed to come from libexpat.lib.

I do not think we want to see exact error message.  If an empty body
of the log message bothers us, I probably would say that it is
sufficient to write something like

    The name of the expat library is libexpat.lib, not expat.lib;
    otherwise we'd get linkage errors.

> I'm ignorant enough about the platform-specific details involved that
> I'd like an Ack from one of the Windows folks.

I saw Dscho looked at both pull requests and commented on them, but
haven't seen him (or anybody else) acking or nacking the version
that was submitted.  It would be nice to see an Ack from Windows'
side.

Thanks.
