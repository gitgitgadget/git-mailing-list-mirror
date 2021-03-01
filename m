Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7BAC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E02600EF
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhCAVut (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 16:50:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65096 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbhCAVs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 16:48:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 386D4AC08B;
        Mon,  1 Mar 2021 16:47:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xHot/k1Nb3QpTeu+X569RTxGUKI=; b=UYj7WR
        f7uEsqg+5AfbPRd18qtEAZZA3s6lHSLySmai4P3bJFXLYHNFpHKEYs7YRbDrX05v
        T/ZCxH0S+QVP8Nwt67ZOeCNvFTYXW8lVcDFkh9LKXB8VAt+EwWpsKkxp9EfJsgFu
        DqonYBAR7tg39POLeproTq48LYtI/f+QG0i2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k7Ks47GpyRfEU0qNDbODvtC9QBezEARz
        YNHvgJwG89MjuF+axDTrdBKERUjTuI6503mePBYxuJcA8yNmTTgrVgizCcW6CoHg
        cIOWQVeHcLw+Yr14AttbG908BuapFpcaQuYj4gaU7Rjxp71ghQndyXTaaV0IjnyE
        68MxlSmZgJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 314C9AC089;
        Mon,  1 Mar 2021 16:47:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5A58AC086;
        Mon,  1 Mar 2021 16:47:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Moseley <Dan.Moseley@microsoft.com>
Cc:     "tboegi@web.de" <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH v2 1/1] git mv foo FOO ; git mv foo bar gave
 an assert
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
        <20210301170425.12154-1-tboegi@web.de>
        <BYAPR21MB1158CDD04067369BB367474CE09A9@BYAPR21MB1158.namprd21.prod.outlook.com>
Date:   Mon, 01 Mar 2021 13:47:45 -0800
In-Reply-To: <BYAPR21MB1158CDD04067369BB367474CE09A9@BYAPR21MB1158.namprd21.prod.outlook.com>
        (Dan Moseley's message of "Mon, 1 Mar 2021 20:23:13 +0000")
Message-ID: <xmqq5z2ao8am.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C20AE5D6-7AD7-11EB-A9F3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Moseley <Dan.Moseley@microsoft.com> writes:

> Thank you Thorsten. This makes sense to me. Do you want to add a test? 
> I believe this is what I had in my original patch, that worked pretty well:

Would this succeed unconditionally on all platforms, or only
relevant on case-insensitive filesystems?  Lack of any prerequisite
on a new test is a good thing (if it is correct), but the
description of the change talked about case insensitivity, so ...

> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 63d5f41a12..5c7fee9bd8 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -152,6 +152,14 @@ test_expect_success \
>      'move into "."' \
>      'git mv path1/path2/ .'
>
> +test_expect_success \
> +    'fail to move file already in index under different cased name' \
> +    'echo 1 > foo &&
> +     git add foo &&
> +     git commit -m add_file -- foo &&
> +     git mv foo FOO &&
> +     test_expect_code 128 git mv foo BAR'
> +
>  test_expect_success "Michael Cassar's test case" '
>         rm -fr .git papers partA &&
>         git init &&
