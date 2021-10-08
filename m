Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF2BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E86061027
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbhJHWSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:18:41 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56871 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbhJHWSj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:18:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 614D714D1EF;
        Fri,  8 Oct 2021 18:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z1pncngFMSQRiOnGC0x8A/5daxbkQLsr23XnVY
        e4Gic=; b=kiOfhDMVbvi2HaOnhvSHV0jSSMa1TadROWdK+Ye+eZ08q9qMK5/1lZ
        dvJHHViTRdL/NM/9TgAn0Km6liv0I0tinDEdRHpbey4KX5RuX96gVPoAJgjl44Jv
        mub30zHDba388WlTT7ufiPWUmpxja8RsnT3Lk3mWk8+h3poypFKss=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A10314D1EE;
        Fri,  8 Oct 2021 18:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A6B6214D1ED;
        Fri,  8 Oct 2021 18:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Estelle <robertestelle@gmail.com>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
        <xmqqbl3zjl5y.fsf@gitster.g>
        <CAMmwyQpP0m6dTdC-L9abZqk9nJkcYy=j4_s0+EdGDr__pykeXQ@mail.gmail.com>
Date:   Fri, 08 Oct 2021 15:16:38 -0700
In-Reply-To: <CAMmwyQpP0m6dTdC-L9abZqk9nJkcYy=j4_s0+EdGDr__pykeXQ@mail.gmail.com>
        (Robert Estelle's message of "Fri, 8 Oct 2021 15:05:15 -0700")
Message-ID: <xmqqh7dri2m1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68E12AB8-2885-11EC-B76C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Estelle <robertestelle@gmail.com> writes:

> On Fri, Oct 8, 2021 at 1:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Would it be equally a valid fix to use "=" instead of "==", or would
>> that change the meaning? This is a bash-only piece of code, so use
>> of [[ ... ]] is not technically incorrect, but if the basic [] works
>> well enough with "=", we should prefer that.
>
> Yes, `[` is preferable for portability and they'd behave the same in
> this case. I consciously chose to use `[[` because that's what all the
> other comparisons in that script use. (I think I noted that in the
> commit message, maybe). I think there's value in consistency, and not
> enough value of `[` over `[[` to justify changing all the other lines.

I do not know if we mind eventual consistency using [] not [[]], but
this topic is certainly not about aiming for consistency.

If the difference affects correctness, as brian mentioned, that is a
different matter.  We should use [ x = y ] in this patch while
leaving the existing uses of [[ x == y ]].

Later in a separate patch series, we may need to examine other uses
of [[ x == y ]] and correct the ones that do not need/want the
pattern matching semantics to use [ x = y ].

