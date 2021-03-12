Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A952DC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7982364F86
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 23:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhCLXnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 18:43:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51741 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbhCLXm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 18:42:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25A10BF1DC;
        Fri, 12 Mar 2021 18:42:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y1ihM4/liHffE0vevbWTUluJwco=; b=JE0cqH
        E/naxgQGzMCtUOWI6XQslorKeAUi3Z1RIWAKesUo+S8rwS9CLvIB9zu6Xf4/lSsT
        A7S+L2BsaSjMECRsq1gz9mb5zK0TGUMTiSRKzgXcHk89iwDhifGoWRJxSH85fShZ
        fXQ3PYcdThNXKREb5XTgaJAupUx3s9+nmRqeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gj0PO5pLIOSlDMIotDjDX6uftAoKwysd
        1y68X/DiJ8Sg2QXwoPrJCstHFdld84sFj66GdMI/12Zzt0uC/l/L0ZRLQfw0RoOC
        ij4rKtfO8r1JwW6od3d1x0S0502gN/GGL8cm1eafuTZFUpEN2+CkH9LVZ1N7Lz8g
        SsvRvD3o5ks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E661BF1DB;
        Fri, 12 Mar 2021 18:42:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2449BF1DA;
        Fri, 12 Mar 2021 18:42:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 0/7] Fix all leaks in t0001
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
        <YEZzGjNMSj+MkDUH@coredump.intra.peff.net>
Date:   Fri, 12 Mar 2021 15:42:56 -0800
In-Reply-To: <YEZzGjNMSj+MkDUH@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 8 Mar 2021 13:55:22 -0500")
Message-ID: <xmqqa6r85473.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABDA5342-838C-11EB-85A1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it's worth doing. The reason t0000 passes is because it was my
> reference script when adding UNLEAK() back in:
>
>   https://lore.kernel.org/git/20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net/
>
> (which might be of historical interest if you haven't read it). I knew
> that the next step would be tediously going through the test suite
> looking at the tool results, and I somehow stalled on that part. ;)
> ...
> I haven't looked at the individual patches yet. I'll respond to them
> individually.

Thanks for working on this, and reviewing the result.

I agree with Peff's review comments and will look forward to seeing
a new iteration that updates the issues pointed out, which range from
coding styles to constness---IIUC, none of them were rocket science
to correct.

