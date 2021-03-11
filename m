Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6255C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD8764F8D
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCKR3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:29:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53116 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhCKR3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:29:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9F3312A91A;
        Thu, 11 Mar 2021 12:29:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NkUWZrrzUVttej8gSMqfDyQ/woQ=; b=xx+WLc
        d9RImj54laE/EYkd6ANMdN+CGMO0KndUEXhz3rAe9PjI/drFordf+u1Jxm+oCcKW
        DOcIDxqu9WmWbl28DsKA480+aquOtGd+kd5wNnDT1YzvLG0mOwpLytQQMYkDs3mf
        SrKj/jZ31nGXXv50FgWwUtONaSsGzo31G8o9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cvs8f1+mFn/3fDjPETvIoSstTNhAdvFR
        470keQh5fj8f9wctBEx7Q81f8I74AaNV6SWZ1Jk5aAbnkWmnRojPiow2edLIfZ01
        u6zPxESgYKqvhxzMYXsHEOsmDKwXO+9nIxlG9/pvJ4IWEkCzUN/9hBk6L+p1Aut3
        i2/kzafwqtE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2B9C12A919;
        Thu, 11 Mar 2021 12:29:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1683712A916;
        Thu, 11 Mar 2021 12:29:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] commit: provides multiple common signatures
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
Date:   Thu, 11 Mar 2021 09:28:59 -0800
In-Reply-To: <pull.901.git.1615446968597.gitgitgadget@gmail.com> (ZheNing Hu
        via GitGitGadget's message of "Thu, 11 Mar 2021 07:16:08 +0000")
Message-ID: <xmqq1rclfvl0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44CB9CB8-828F-11EB-8077-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Similar to "Helped-by", "Reported-by", "Reviewed-by", "Mentored-by"
> these signatures are often seen in git commit messages. After
> referring to the simple implementation of `commit --signoff`
> and `send-email -cc=" commiter <email>"`, I am considering
> whether to provide multiple signature parameters from the
> command line.
> + ...
> +	>file6 &&
> +	git add file6 &&
> +	git commit -H "foo <bar@frotz>" \
> +	-R "foo2 <bar2@frotz>" \
> +	-M "foo3 <bar3@frotz>" \
> +	-r "foo4 <bar4@frotz>" -s -m "thank you" &&

Firm NAK.

Especially, not in this form that squats on short-and-sweet single
letter option names only to support the convention of this single
project (namely, Git).

cf. https://lore.kernel.org/git/20200824061156.1929850-1-espeer@gmail.com/

Thanks.
