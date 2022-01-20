Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F10FC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 18:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241941AbiATSZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 13:25:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64800 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbiATSZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 13:25:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8DED114D0F;
        Thu, 20 Jan 2022 13:25:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DQBzcMT6DK1/
        sBN37JphANNhBDtgfDTD8xXuhJGXFJ8=; b=uHd9Ndkw5yZjGn4iMl49BI4iYGYo
        shXVmHhLxZQE2hPKtZprJxBGQ2XxWnbnqBX4sBpbs76BYqEj40jfkqKWxsaVqQUh
        nmy68b82ArsEaPYcYmbpAzbcwX+l26XGvITZgo2nJoRT+PXMJJw8gRKX66LZcdgW
        QPmcShkUFCmo9dU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0199114D0E;
        Thu, 20 Jan 2022 13:25:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F23A7114D0D;
        Thu, 20 Jan 2022 13:25:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH] parse-options: document automatic
 PARSE_OPT_LITERAL_ARGHELP
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
        <xmqqh7a0r87q.fsf@gitster.g>
        <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
        <xmqqlezboakd.fsf@gitster.g>
        <c6ab4408-1091-4d14-849e-afe5f3053e8b@web.de>
Date:   Thu, 20 Jan 2022 10:25:26 -0800
In-Reply-To: <c6ab4408-1091-4d14-849e-afe5f3053e8b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 20 Jan 2022 11:30:15 +0100")
Message-ID: <xmqqiluejmcp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57ABB098-7A1E-11EC-A053-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Now that I read the whole comment, I think the right place to introduce
> the automatic brackets is the description of argh some lines up.
>
> --- >8 ---
> Subject: [PATCH 5/5] parse-options: document bracketing of argh
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  parse-options.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/parse-options.h b/parse-options.h
> index e22846d3b7..88d589d159 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -85,6 +85,11 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct=
 parse_opt_ctx_t *ctx,
>   *   token to explain the kind of argument this option wants. Does not
>   *   begin in capital letter, and does not end with a full stop.
>   *   Should be wrapped by N_() for translation.
> + *   Is automatically enclosed in brackets when printed, unless it
> + *   contains any of the following characters: ()<>[]|
> + *   E.g. "name" is shown as "<name>" to indicate that a name value
> + *   needs to be supplied, not the literal string "name", but
> + *   "<start>,<end>" and "(this|that)" are printed verbatim.
>   *
>   * `help`::
>   *   the short help associated to what the option does.

Very nice.

This version gives the necessary information in (almost) one place.

I said (almost) because "it contains any of ..." is not the only way
to decline the <automatic angle brackets>, and am wondering if it is
more helpful to say something like

	... when printed, unless PARSE_OPT_LITERAL_ARGHELP is set in
	the flags, or it contains any of the following characters: ...

and then shrink the description of the flag bit to

    PARSE_OPT_LITERAL_ARGHELP: controls if `argh` is enclosed in in
    brackets when shown (see the description on `argh` above).

