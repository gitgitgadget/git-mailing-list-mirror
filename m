Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB079C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6892F20724
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rkzqc79h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgKEVQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:16:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52872 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:16:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F132591315;
        Thu,  5 Nov 2020 16:16:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wTp0Bdh3uZ6+C+6IF+Q7qs4dx1Q=; b=rkzqc7
        9hyoY5vNYwus6b8pDjPR55QrUTQmHXMyc8Tn9o8jPumpH/4Zd00Y7+OpaeGi1P6Q
        /hCVge176F63/TJuov4rbKBnGs4U8FVDuDQUo1xrrzjh7+cfogyUcN9YX+5L/0g/
        IEt7Cgp/DSrVHgP4mF+VZvoL4PptEFjOWZtBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZGINZOfP7pUm8jqmrUQOvAE6+jwG+See
        u5XQKr0PHUK0gz1+yvwLYtTKI+Ezc5ULN0uBgbIQahDS4sXAp3oEZtN1dwwy3o/z
        p40ZVMHxRWvBRc+ppb3mORo4ABY9K0YQtogIX2eVVjCN91ivy7YfJfWNfLOkNisX
        /VJ+IUdJCR4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E88F991314;
        Thu,  5 Nov 2020 16:16:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6024291313;
        Thu,  5 Nov 2020 16:16:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Hu Keping <hukeping@huawei.com>, git@vger.kernel.org,
        zhengjunling@huawei.com, zhuangbiaowei@huawei.com,
        git@stormcloud9.net, rafa.almas@gmail.com, l.s.r@web.de
Subject: Re: [PATCH] Lengthening FORMAT_PATCH_NAME_MAX to 80
References: <20201105201548.2333425-1-hukeping@huawei.com>
        <20201105150149.GA107127@coredump.intra.peff.net>
Date:   Thu, 05 Nov 2020 13:16:53 -0800
In-Reply-To: <20201105150149.GA107127@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Nov 2020 10:01:49 -0500")
Message-ID: <xmqqimajijwa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AAC6406-1FAC-11EB-88F5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Considered the prefix patch number "0001-" would take 5 characters, increase
>> the FORMAT_PATCH_NAME_MAX to 80.
>
> As the code is written now, the length also includes the ".patch"
> suffix, as well as an extra byte (maybe for a NUL? Once upon a time I
> imagine we used static buffers, but these days it's all in a strbuf).
>
> A simple test with:
>
>   git init
>   for i in $(seq 8); do printf 1234567890; done |
>   git commit --allow-empty -F -
>   git format-patch -1
>
> shows us generating:
>
>   0001-1234567890123456789012345678901234567890123456789012.patch
>
> So that's only 52 characters, from our constant of 64. Bumping to 80
> gives us 66, which is reasonable though probably still involves
> occasional truncation. But maybe keeping the total length to 80 (79,
> really, because of the extra byte) may be worth doing.
>
> Which is all a long-winded way of saying that your patch seems
> reasonable to me.

A devil's advocate thinks that we should shorten it (and rename it
to format-patch-subject-prefix-length or something) instead.  That
way, "ls" output can show more than one files on a single line even
on a 80-column terminal.  The leading digits already guarantee the
uniqueness anyway.

I do not mind getting rid of the "FORMAT_PATCH_NAME_MAX" constant
and replacing it with a variable that defaults to 64 and can be
tweaked by a command line option and/or a configuration variable.
It does not feel it is worth the effort to replace one hardcoded
constant with another hardcoded constant.

> Looking at the code which uses the constant, I suspect it could also be
> made simpler:
>
>   - the PATH_MAX check in open_next_file() seems pointless. Once upon a
>     time it mattered for fitting into a PATH_MAX buffer, but these days
>     we use a dynamic buffer anyway. We are probably better off to just
>     feed the result to the filesystem and see if it complains (since
>     either way we are aborting; I'd feel differently if we adjusted our
>     truncation size)
>
>   - the logic in fmt_output_subject() could probably be simpler if the
>     constant was "here's how long the subject should be", not "here's
>     how long the whole thing must be".
>
> But those are both orthogonal to your patch and can be done separately.

Yes, these clean-ups seem worth doing.
