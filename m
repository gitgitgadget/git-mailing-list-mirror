Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD73C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A77206D4
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 19:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1z8Zksz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460329AbgJ0TE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:04:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51903 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899531AbgJ0TE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 15:04:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68544EF150;
        Tue, 27 Oct 2020 15:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iYBw0M+dN9APBpotHsU7Lz31gmA=; b=h1z8Zk
        szMbDrH1q74mz1eaYdccfOxbFug5oaEJgLN54y+P/AzpxrRJjwUuoOtT7t+hf6lm
        rWZjnVrfr8M+zIu3fcHhmNJJUjTsLQ/ykDVvIw1pgZj5qaWJlDSFk3I/TWnBSGnj
        6tWGcVl4zm54PrCTB6ZFqeKKFFbZ/SbGEVjyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bHc6MPNza11iYs0MKXnDJ2EdYQqZzo07
        A+udHxnTnr1plxg+Y9qM468IasCMclXUZZmNuPDYBDKsHUfcijTOu5QZQ06dlQ3I
        2vPMyR5pDO1c9hHedq0JeY1U0LPQ35aexY5lJWwwxlfRxKP5lsFtTgpU9oLJrRht
        7UQgTOVZfOE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61EDFEF14F;
        Tue, 27 Oct 2020 15:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8EE13EF14E;
        Tue, 27 Oct 2020 15:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sideband: diagnose more incoming packet anomalies
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
        <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
        <20201027065250.GB3005508@coredump.intra.peff.net>
        <20201027071309.GD3005508@coredump.intra.peff.net>
Date:   Tue, 27 Oct 2020 12:04:51 -0700
In-Reply-To: <20201027071309.GD3005508@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 27 Oct 2020 03:13:09 -0400")
Message-ID: <xmqq7drbcwx8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BC87378-1887-11EB-BEF2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And one other small cleanup, worth doing with or without my patch.
>
> -- >8 --
> Subject: [PATCH] test-pkt-line: drop colon from sideband identity
>
> We pass "sideband: " as our identity for errors to recv_sideband(). But
> it already adds the trailing colon and space. This doesn't invalidate
> any tests, but it looks funny when you examine the test output.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense and it is a no-brainer to understand why it is the right
thing to do.  I'll queue it directly on top of two patches from
Dscho.

Thanks.

>  t/helper/test-pkt-line.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
> index 0bf20642be..5e638f0b97 100644
> --- a/t/helper/test-pkt-line.c
> +++ b/t/helper/test-pkt-line.c
> @@ -100,7 +100,7 @@ static int send_split_sideband(void)
>  
>  static int receive_sideband(void)
>  {
> -	return recv_sideband("sideband: ", 0, 1);
> +	return recv_sideband("sideband", 0, 1);
>  }
>  
>  int cmd__pkt_line(int argc, const char **argv)
