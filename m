Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7B1C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D8620738
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 22:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bz/H6k76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHUWfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:35:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62662 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHUWfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 18:35:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF7158751A;
        Fri, 21 Aug 2020 18:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aBei3+m73VS+LG8BjpUJCCiLBfs=; b=bz/H6k
        76pGhq00OAxWs1oertOcI3kMWSoTvddb+QRk3tan+8mm+8ZFM3zzNBFqahj80sqx
        g1hEI7oBrOWCxgTQIjh3iGaOTwYYdRx9hyfWpm/3yGySa5rYA0186+m1qqR6f8Rx
        LVlrLRaK3wjf2AvAPLdd8xBoVnydtuWYp9JMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GfZ0KJA0pa5SwZGJr7eWzDybSt48TJFe
        8+ECTPV3VsegNzTQXkY+VpoOWf/3Rk3CWnv+5aspd0jiDsJx0WYfU1L8RZjwa3YO
        R533KAciB6W+7inMX5RY8qjbPYbrelu0osGyxIvhgxxwlUHgj7WJxm0ZkuEBhZAN
        IcnnqQP3zNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC5C887518;
        Fri, 21 Aug 2020 18:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED9B287517;
        Fri, 21 Aug 2020 18:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alvaro Aleman <aaleman@redhat.com>, Git List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] ident: say whose identity is missing when giving user.name hint
References: <CAOW=8D2J3t3cE32q2xNqSOPTa6gxR5gSuJUCCj5MSj58ccc3Cg@mail.gmail.com>
        <87ft8fvoow.fsf@igel.home> <xmqqr1rz96ry.fsf@gitster.c.googlers.com>
        <CAOW=8D3WZyoc=PpyzmPRYM2MT_=F4tnuTxJ0Z+_dHMb4Xk8imQ@mail.gmail.com>
        <xmqq5z9b91o3.fsf_-_@gitster.c.googlers.com>
        <CAPig+cR12i8KQjiWYm8DGuAc9BfJqanmNBZcZfwHGsrt2hW3Dw@mail.gmail.com>
        <xmqq1rjz8zy7.fsf@gitster.c.googlers.com>
        <CAOW=8D1nFgRRPyD7yxW2X7ZcAA3yaMzWJy7B3ykuPBJk3t8X5Q@mail.gmail.com>
        <CAPig+cSLxRVufZcnXa6JAbP-SYX486OebDS5hYjEhH7jaNgM5Q@mail.gmail.com>
Date:   Fri, 21 Aug 2020 15:35:08 -0700
In-Reply-To: <CAPig+cSLxRVufZcnXa6JAbP-SYX486OebDS5hYjEhH7jaNgM5Q@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 21 Aug 2020 17:37:58 -0400")
Message-ID: <xmqqblj37hlv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 917717DE-E3FE-11EA-A661-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 21, 2020 at 5:31 PM Alvaro Aleman <aaleman@redhat.com> wrote:
>> One nit though: There is no `--committer` flag for `git commit`,
>
> Indeed, that `--committer=` was a last-second edit (without checking
> docs).

Yeah, I forgot that we deliberately omit the command line option for
the committer info.

> How about this?
>
>     If `user.name` and `user.email` have not been configured and the
>     user invokes:
>
>         git commit --author=...
>
>     without specifying the committer, then Git errors out with a
>     message asking the user to configure `user.name` and `user.email`
>     but doesn't tell the user which attribution was missing. This can
>     be confusing for a user new to Git who isn't aware of the
>     distinction between user, author, and committer.  Give such users
>     a bit more help by extending the error message to also say which
>     attribution is expected.

OK.
