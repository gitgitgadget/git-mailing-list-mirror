Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE99EC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbjIGUfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjIGUfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:35:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5AB1BCE
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:34:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92D0F31EA3;
        Thu,  7 Sep 2023 16:34:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xKyw1h681iga
        9wpQXkHGOq1l4hVy4uLneOD4enAsKkU=; b=QJuCKuNQ6c5Nb4GthBS643GWClvv
        viAiu7n3jTx6K+0DX8ttSovAtgMmjRsSAEuZbsk4odCrpl+Fa1F6vos5XEazToR3
        Q693YB3zYfICba9ZBjjqW0LDlVO5Td0SL4F2JPs19udYO1kSeY2b5nmwwENWboH6
        OmSXmukCRoUJ0Bs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BD0C31EA2;
        Thu,  7 Sep 2023 16:34:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15E8C31EA1;
        Thu,  7 Sep 2023 16:34:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: reject --no-or
In-Reply-To: <6aeb0ebe-0fea-ccd3-089a-ee0b5b5baf10@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 7 Sep 2023 22:20:59 +0200")
References: <6aeb0ebe-0fea-ccd3-089a-ee0b5b5baf10@web.de>
Date:   Thu, 07 Sep 2023 13:34:54 -0700
Message-ID: <xmqqh6o5k9ht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01014CD8-4DBE-11EE-824E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Since 3e230fa1b2 (grep: use parseopt, 2009-05-07) git grep has been
> accepting the option --no-or.  It does the same as --or: nothing.
> That's confusing and unintended.  Forbid negating --or.

OK.  It is just a no-op Boolean but that is not a good reason for us
to be loose.  Will queue.  Thanks.

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/grep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 50e712a184..2a261074f1 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -990,7 +990,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
>  		OPT_CALLBACK_F(0, "and", &opt, NULL,
>  			N_("combine patterns specified with -e"),
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback),
> -		OPT_BOOL(0, "or", &dummy, ""),
> +		OPT_BOOL_F(0, "or", &dummy, "", PARSE_OPT_NONEG),
>  		OPT_CALLBACK_F(0, "not", &opt, NULL, "",
>  			PARSE_OPT_NOARG | PARSE_OPT_NONEG, not_callback),
>  		OPT_CALLBACK_F('(', NULL, &opt, NULL, "",
> --
> 2.42.0
