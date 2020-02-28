Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA99C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269A82468D
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JzhcX/vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1Qmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:42:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63398 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1Qmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 11:42:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33C29BCAF9;
        Fri, 28 Feb 2020 11:42:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Enj1wovFbg46SV1vMPqwtyNNfAM=; b=JzhcX/
        vUhkmxKL5WDzPnaWvqSa8kqGRgqQiXVPP6N2/FhIicDzZumbcjUaNBTV74IJ6ZVH
        ZGeVFQlYtNL9N1oJLZFPGP2lQufjinGKNunZ5TfYtlbkWEgwx97XpGzMDfclug0L
        Zd7sx+Q4dfeddD0scTokJEbFsA8UMHszxHbMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jGOeQTZgsSu1/kTnnQPwpkr7oJtHwyDc
        +FZ71GQvhc8HYMP5m+uqDKAe7sW2oXn5Eyh4a2yKpS1/VCdlPFpC07J20EwtoQ8c
        PUXL5Y82w+i0psFngAxYonMjkRsx0OnQLCHv9N4XX8GNuyAYHk55aSamfVzznyHD
        RBPdMIYN3LE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C26BBCAF7;
        Fri, 28 Feb 2020 11:42:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49A29BCAF6;
        Fri, 28 Feb 2020 11:42:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] config.mak.dev: re-enable -Wformat-zero-length
References: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
        <20200227235445.GA1371170@coredump.intra.peff.net>
Date:   Fri, 28 Feb 2020 08:42:47 -0800
In-Reply-To: <20200227235445.GA1371170@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Feb 2020 18:54:45 -0500")
Message-ID: <xmqqtv3aek8o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AF25E56-5A49-11EA-A50C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The short of it is that we probably can't just disable the warning for
> everybody because of portability issues. And ignoring it for developers
> puts us in the situation we're in now, where non-dev builds are annoyed.

"git blame" unfortunately is very bad at poing at a commit that
removed something, so I do not offhand know how much it would help
readers who later wonder "oh, I am sure we had thing to disable
format-zero-length warning, and I want to learn the reason why we
dropped it", but thanks for writing this down.

> Since the workaround is both rarely needed and fairly straight-forward,
> let's just commit to doing it as necessary, and re-enable the warning.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I had totally forgotten about that thread until researching the history
> just now. There's another option there involving #pragma, but it was too
> gross for me to even suggest now as an alternative in the commit
> message. ;) I think this is the most practical improvement.
>
>  config.mak.dev | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/config.mak.dev b/config.mak.dev
> index bf1f3fcdee..89b218d11a 100644
> --- a/config.mak.dev
> +++ b/config.mak.dev
> @@ -9,7 +9,6 @@ endif
>  DEVELOPER_CFLAGS += -Wall
>  DEVELOPER_CFLAGS += -Wdeclaration-after-statement
>  DEVELOPER_CFLAGS += -Wformat-security
> -DEVELOPER_CFLAGS += -Wno-format-zero-length
>  DEVELOPER_CFLAGS += -Wold-style-definition
>  DEVELOPER_CFLAGS += -Woverflow
>  DEVELOPER_CFLAGS += -Wpointer-arith
