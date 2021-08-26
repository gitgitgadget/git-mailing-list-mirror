Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4DFC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE75160E75
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhHZULw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 16:11:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58006 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhHZULw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 16:11:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 33A021574CD;
        Thu, 26 Aug 2021 16:11:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=faFJso6OkUw8eaJKTVF6h0Yy5alHKCPG5fPcUa
        yeOvU=; b=VjxZ12Xtn6LwgxhQBY/3wlKkjiY+e3x+w2IDC9FFo8hmM+oK34/ZjZ
        uJx0RXgCP1pb+lGIfN/zUUhDVaoFramheytkBwDR8m5c9RLhjQWMca8LF55wrBc+
        YCPMkEGl7/gDoC43UTddaAZSx4EGX1YwIWsmiMBqSA0+EEMi3/Pp4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C54D1574CC;
        Thu, 26 Aug 2021 16:11:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5EC9A1574C9;
        Thu, 26 Aug 2021 16:11:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] make: delete strip target
References: <20210826113824.50078-1-bagasdotme@gmail.com>
        <20210826113824.50078-3-bagasdotme@gmail.com>
Date:   Thu, 26 Aug 2021 13:10:58 -0700
In-Reply-To: <20210826113824.50078-3-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Thu, 26 Aug 2021 18:38:24 +0700")
Message-ID: <xmqq4kbcdl0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB58FAB2-06A9-11EC-87A3-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The target isn't needed anymore since stripping is done in install-strip
> target (in previous patch).

That is not a valid justification.  

People's automation may have been using a perfectly valid

	#!/bin/sh
	make test &&
	make doc &&
	make strip &&
	make install install-doc

and this patch will break them for no good reason.

We need to remember that just because we (think we) came up with a
better way does not necessarily mean that we can immediately force
our users to adopt the new way.

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b8a3a64422..027b052a0c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2170,8 +2170,6 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
>  
>  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>  
> -strip: $(PROGRAMS) git$X
> -	$(STRIP) $(STRIP_OPTS) $^
>  
>  ### Flags affecting all rules
