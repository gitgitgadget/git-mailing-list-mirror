Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC4C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E141239FE
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAIXWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 18:22:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61488 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAIXWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 18:22:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94E4B1146C9;
        Sat,  9 Jan 2021 18:21:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2JW7sSbvnHmWFlMnPHE0MRTkPPY=; b=D147FC
        Jft48MKa+gCLa3Gyh9Bc7KWV8zeS01xxPjQWprhhNnJEqse9xVZaMxlk1qtF0nYu
        2eXTBTlDIosYwrCmacWB2hXWoQPn3xR0JZiHea5K68GprL7daTlVWaCChVJWGZ1b
        w/HM26EFBPmP3r0YfOPpQaxZ8t0P/VqKMHT4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WDes4I0UHIdMR0CjzBQ6NMtSoN4QHCwJ
        tjXj4qkxhWGV4Z/LVlV71Hj8ouJsNFWIRgxhTqzDQJ9Wj95DuQ3/5btzT4irLOna
        WW6Gn6tJHQm+CgLJ09tFP0HESxb5l+H9xy4dbJpQGyFGQiaZNFzwQ5Bkl+kzYTVa
        yyAZDMdPtBw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DE6E1146C8;
        Sat,  9 Jan 2021 18:21:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0FC31146C7;
        Sat,  9 Jan 2021 18:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fixup! mergetool: add automerge configuration
References: <20210109214922.33972-1-davvid@gmail.com>
        <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
Date:   Sat, 09 Jan 2021 15:21:49 -0800
In-Reply-To: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Sat, 9 Jan 2021 21:59:27 +0000")
Message-ID: <xmqqzh1hd7ci.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73D6CD90-52D1-11EB-8FC4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Ah, yes, this is true.  The statement about "\r" is also true for Linux
> with POSIXLY_CORRECT, IIRC.

It's nice to have a way to reproduce without having a separate
toolchain.  Thanks for the suggestion.

> Unfortunately, printf is not specified by POSIX to take hex escapes, so
> this, too is nonportable.  We are unfortunately allowed to use only
> octal escapes (yuck).  However, we can write this:
>
>   cr=$(printf '\r')
>
> or
>
>   cr=$(printf '\015')
>
> I think the former is clearer, since that's what we were writing before.

The latter however appears more portable at least to traditionalists
;-)
