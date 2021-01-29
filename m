Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58301C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AD864DDB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhA2XVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 18:21:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54080 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhA2XVA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 18:21:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14F3C108E8F;
        Fri, 29 Jan 2021 18:19:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RulkyiOs3nMdC4kEUf8nOW2z3eY=; b=vkaNd6
        9Yg71uXwtlAxQYwbnqlPy3Hi+4VjsAGawodKDRIR6PRaPxR3b+fxxYLy3/zuiZiX
        LNVuvpNMdGbAfWi824LxR4zFb6vq2kb+BbvlBV3d02g8rhU6/jHwGJQVkHWhNnJa
        F4J88+9pX0VAw+gh4vf1CsAz7XYAdOp6SA/Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jvOLXTpd8uQ7iqFYYaCqzq0qn9DgrVwt
        CW7GJypdnEfCIEATNaku6rX3sJye5mdZs0MawIY9I79wS73m9YvTwDLBBiZOLZ/7
        LiOeKV4H9Lkeh3sajdqntyEZkC9noQhzB73eti+CPzcGXw2UDWEfHfd66puR7uB5
        H85EJX8YHT0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D43D108E8D;
        Fri, 29 Jan 2021 18:19:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5463F108E8C;
        Fri, 29 Jan 2021 18:19:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, random_n0body@icloud.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH v2 1/1] MacOS: precompose_argv_prefix()
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
        <20210129171512.28167-1-tboegi@web.de>
Date:   Fri, 29 Jan 2021 15:19:41 -0800
In-Reply-To: <20210129171512.28167-1-tboegi@web.de> (tboegi@web.de's message
        of "Fri, 29 Jan 2021 18:15:12 +0100")
Message-ID: <xmqq4kizs54i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78052A8A-6288-11EB-B58D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> Solution:
> precompose_argv() now handles the prefix (if needed), and is renamed into
> precompose_argv_prefix().
>
> Inside this function the config variable core.precomposeunicode is read
> into the global variable precomposed_unicode, as before.
> This reading is skipped if precomposed_unicode had been read before.
>
> The original patch for preocomposed unicode, 76759c7dff53, placed
> precompose_argv() into parse-options.c
> Now move it into git.c .
> As a cleanup, remove it from parse-options.c and diff*.c

So an effect of this change is that now everybody's argv[], not just
those who are using parse-options API, is munged at the same single
place.  That sounds like a good move toward a happy future.

Will queue.  Thanks.
