Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11919C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA6A6105A
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhJVASi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 20:18:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54135 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVASi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 20:18:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 699E415150A;
        Thu, 21 Oct 2021 20:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KonDCeuO3SiE
        6cJyM47+jJHcwlsT5WrivLv651QCYGQ=; b=qJ0fnTfutqWsl1gR+yNDh7qBH3GR
        Jr6DZFlmqHqWG6zh1pd6bwLBuaR76Yo8LF+9EplDfBY7sFyQILPz5cmXhhsw5Iqz
        LStADLVhVYztDolRWj3Ny1YTaJMWbm5QzzY+AoJxRve0cIVoUMIByg6rXHC/a2Lo
        waP9zYfdqaA5x2Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62342151509;
        Thu, 21 Oct 2021 20:16:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 968F1151508;
        Thu, 21 Oct 2021 20:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/6] reflog: free() ref given to us by dwim_log()
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
        <patch-5.6-85b7b7aef37-20211021T155529Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 17:16:17 -0700
In-Reply-To: <patch-5.6-85b7b7aef37-20211021T155529Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 17:57:36 +0200")
Message-ID: <xmqqee8dgbhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 473A3088-32CD-11EC-A017-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When dwim_log() returns the "ref" is always ether NULL or an
> xstrdup()'d string.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/reflog.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index bd4c669918d..175c83e7cc2 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -653,6 +653,7 @@ static int cmd_reflog_expire(int argc, const char *=
*argv, const char *prefix)
>  					should_expire_reflog_ent,
>  					reflog_expiry_cleanup,
>  					&cb);
> +		free(ref);

OK.  When dwim_log() returns false, it would not have touched &ref
at all, so the "continue" (not shown in the context above) is not
leaking, and this loop looks good.

Thanks.

>  	}
>  	return status;
>  }
