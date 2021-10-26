Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9D3C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0078660C4A
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhJZVoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:44:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58361 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbhJZVo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:44:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96907E1AC4;
        Tue, 26 Oct 2021 17:42:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uRyuWG/uQET2d2R0WxYRlmlHJSeo7IVKdfeA88
        PVIPY=; b=ewGY5vtnnP4lXI2DhzXtoPQaMgVHgn+zuoh9QFTJ6JssJM8a3sLwyB
        wyBg4GsOy/yS8aGLn8pjGW+uWmjDav8D/oHMB2v4rDupBJ+r+9vpGjZRvBD0WL8k
        rCUmtLbaIaYQFx7ANwoKplob96vdwqPuogJ9cThjeyykblq7N7g/U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59505E1AC3;
        Tue, 26 Oct 2021 17:42:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8397FE1AC2;
        Tue, 26 Oct 2021 17:42:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Subject: Re: [PATCH] color: allow colors to be prefixed with "reset"
References: <pull.1117.git.git.1635210227532.gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 14:42:02 -0700
In-Reply-To: <pull.1117.git.git.1635210227532.gitgitgadget@gmail.com> (Robert
        Estelle via GitGitGadget's message of "Tue, 26 Oct 2021 01:03:47
        +0000")
Message-ID: <xmqqee87xy39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ED9A276-36A5-11EC-8931-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Robert Estelle <robertestelle@gmail.com>
>
> "reset" was previously treated as a standalone special color name
> representing `\e[m`. Now, it can apply to other color properties,
> allowing exact specifications without implicit attribute inheritance.
>
> For example, "reset green" now renders `\e[;32m`, which is interpreted
> as "reset everything; then set foreground to green". This means the
> background and other attributes are also reset to their defaults.
>
> Previously, this was impossible to represent in a single color:
> "reset" could be specified alone, or a color with attributes, but some
> thing like clearing a background color were impossible.
>
> There is a separate change that introduces the "default" color name to
> assist with that, but even then, the above could only to be represented
> by explicitly disabling each of the attributes:
>   green default no-bold no-dim no-italic no-ul no-blink no-reverse no-strike
>
> Signed-off-by: Robert Estelle <robertestelle@gmail.com>
> ---

Unlike the "default" patch, I quite do not see the point of the
example(s).  Instead of saying "reset green", can't we already say
"set bg to default, and set fg to green", thanks to the other one?
Or does "default" do too little to deserve a name that implies "go
back to default", e.g. by not defeating the 'blink' attribute that
was set earlier?
