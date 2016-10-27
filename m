Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9968420193
	for <e@80x24.org>; Thu, 27 Oct 2016 17:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934200AbcJ0RhS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 13:37:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62203 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754392AbcJ0RhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 13:37:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEB6B4988B;
        Thu, 27 Oct 2016 13:37:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2MUI4UpF7BPcZHEA/zkR+qr/sYw=; b=WA+x0X
        JyyOjwFNIO9ngiftwXX+XriFXRUgOGA2ZRVzVxOkJnFvxbJQsrAIv8eoGOLg+aKR
        G15ya+hAEZXQ7vvnU2GgdB/V4fvLCbeqhMmTmlITaBxu+aWWTZtjwuQxSKyCywOs
        LsXoQ3E3EAmSFvrzIoEn5ZTnIf0QrFSI/PaBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A73S8gNIJIv4qM/G1UGQdQU49wBctxxR
        4r+fjObrRFz/SFSvc/GwpDsR9aiOZpIn05f1neRccxYAsF7njfDDd6+tCfmsc+4e
        CkZEfrqCMY8rJ3QrsTy9tDyglOAdLduR8rEVaxrqLV+A8qYu3WJt9f1f9iN8myDy
        76OYJSE0CG0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A528C4988A;
        Thu, 27 Oct 2016 13:37:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1828049889;
        Thu, 27 Oct 2016 13:37:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util: move content inside ifdef/endif guards
References: <20161027173029.bu233oiekpfoh6lw@sigill.intra.peff.net>
Date:   Thu, 27 Oct 2016 10:37:13 -0700
In-Reply-To: <20161027173029.bu233oiekpfoh6lw@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 27 Oct 2016 13:30:30 -0400")
Message-ID: <xmqq8tt97kxi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 008EFF4E-9C6C-11E6-A129-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit 3f2e2297b9 (add an extra level of indirection to
> main(), 2016-07-01) added a declaration to git-compat-util.h,
> but it was accidentally placed after the final #endif that
> guards against multiple inclusions.
>
> This doesn't have any actual impact on the code, since it's
> not incorrect to repeat a function declaration in C. But
> it's a bad habit, and makes it more likely for somebody else
> to make the same mistake. It also defeats gcc's optimization
> to avoid opening header files whose contents are completely
> guarded.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I just happened to notice this today while doing something unrelated in
> the file.

Thanks.

>
>  git-compat-util.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 91e366d1dd..771ea29f31 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1042,6 +1042,6 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
>  #define getc_unlocked(fh) getc(fh)
>  #endif
>  
> -#endif
> -
>  extern int cmd_main(int, const char **);
> +
> +#endif
