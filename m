Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC6C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 01:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHJBAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHJBAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 21:00:52 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989D91982
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 18:00:51 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA2C018B916;
        Wed,  9 Aug 2023 21:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4UwoXXPzd5zknkzO4ZsQ4+y13UpJbXvy4/8JOi
        PZAmQ=; b=ERH/qHMmtq3FImW2JFRaj6+aioeXYWOOYVk6HJ1PJMc6kw7ZHpPh/6
        HEjNYfICRA4OLb8YpDSIeSb6JbN8+EvipqBzBHOLPHODNEdlM8Q8liBFhtAZSLhG
        BSFOCXct9Po+Y8WCARwOTNGDNtUWd3x4bAoeY9mfQsHypsiRXXUUs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1F0818B914;
        Wed,  9 Aug 2023 21:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F33D18B913;
        Wed,  9 Aug 2023 21:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
        <xmqqo7k9fa5x.fsf@gitster.g>
        <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
        <20230808212720.GA760752@coredump.intra.peff.net>
        <xmqqzg3156sy.fsf@gitster.g>
        <20230809140902.GA775795@coredump.intra.peff.net>
        <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
        <xmqqzg30m3vo.fsf@gitster.g>
        <20230810002638.GC795985@coredump.intra.peff.net>
Date:   Wed, 09 Aug 2023 18:00:49 -0700
In-Reply-To: <20230810002638.GC795985@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 9 Aug 2023 20:26:38 -0400")
Message-ID: <xmqqo7jfk8xq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58F7C13A-3719-11EE-BDE4-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   int my_foo;
>   ...
>   OPT_CALLBACK('f', "foo", int, &my_foo, ...etc);
>
> Not great, but it might not be _too_ bad given that most helpers like
> OPT_BOOL() can just say "int" behind the scenes.
>
> That said, I don't recall these void pointers being a large source of
> errors in the past. So while it's a fun type-system puzzle, the
> effort/reward ratio might not be favorable.

I tend to agree on both counts, it is a fun puzzle, and it probably
is not going to give us sufficient reward.  The fact that "int" and
typeof(my_foo) need to be manually kept straight defeats the "type
safety" justification for this mental exercise.

Thanks.
