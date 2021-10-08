Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06294C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30B960F55
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 23:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbhJHXLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 19:11:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59851 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJHXLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 19:11:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 577C314D7B4;
        Fri,  8 Oct 2021 19:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WYuojHRMKLB9x6frsSD7jwbL3wSIueZggzdtNe
        xLv34=; b=e84zhOuWrsymK/2nqHzEZk2HeuoprDwheC6mup4Qkxpw/51FUFuzwH
        WjFOdUrcaYLbPoT9KTmDGV9tBay9NxR4qBino/nKlXlYSrIkZW5p3ktVJ4etlpA6
        jZJ/UK8o8k0FHUVebQfiw4htSkdBv0gkFQvxvdyJsZr0IvNLz2ojA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C75914D7B3;
        Fri,  8 Oct 2021 19:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4FDB14D7AF;
        Fri,  8 Oct 2021 19:09:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Estelle <robertestelle@gmail.com>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
        <xmqqbl3zjl5y.fsf@gitster.g>
        <CAMmwyQpP0m6dTdC-L9abZqk9nJkcYy=j4_s0+EdGDr__pykeXQ@mail.gmail.com>
        <xmqqh7dri2m1.fsf@gitster.g>
        <CAMmwyQp7ChC7RZAZX4Y3UyAghOAmvHA7e3BBJonGYJNoSc+nFA@mail.gmail.com>
Date:   Fri, 08 Oct 2021 16:09:01 -0700
In-Reply-To: <CAMmwyQp7ChC7RZAZX4Y3UyAghOAmvHA7e3BBJonGYJNoSc+nFA@mail.gmail.com>
        (Robert Estelle's message of "Fri, 8 Oct 2021 15:26:30 -0700")
Message-ID: <xmqqzgrjglma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA49ABB2-288C-11EC-A654-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Estelle <robertestelle@gmail.com> writes:

> The choice between the two does not affect correctness, it's purely
> stylistic here. It only would affect correctness for unquoted
> arguments or extended comparison operators. Those *are* in use
> elsewhere in this script and force the use of `[[` in those places.
>
> Keep in mind also that this is an autocomplete script. Although it's
> sourced by both bash and zsh, it does not make sense to attempt to
> make it work for bare POSIX sh.

Nobody is trying to.  It is more for reducing the risk of people
shooting their foot by cutting and pasting without thinking.

When you do not mean pattern matching and want exact matching, even
if it is guaranteed that the data you pass through the codepath does
not have pattern to cause the former, hence the distinction between
[[ x == y ]] and [ x = y ] does not make a difference, that is a
mere happenstance, and use of [ x = y ] is the correct thing to do
in such a case.
