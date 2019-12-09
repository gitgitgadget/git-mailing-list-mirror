Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40408C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002AE205ED
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b/BX5zZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfLITYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:24:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58901 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfLITYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:24:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8D1C3EC4D;
        Mon,  9 Dec 2019 14:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=e3ZlLREJCTgG
        MJrg4sfqtID1aK4=; b=b/BX5zZVywXGFzuYUnjaJD8gn6O1Z2CtNPDsAkCGa/tk
        Wo+iAS/f7QKMMxDZ28pFLwHUOxj2mQ8kjBHuLMwu2YBgGfVCiOmNJyRjipUv44Tn
        OEhxDSb9kaRIYYxbxZyBnWzXzlBAiGA+qiVi17rUjdTiJYbqwLpSXoDOwz4C+2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BtV8va
        QcnKM0DWFHoNL8XL87vFBy0WMM+/UYxPkxmZJbzoNP00A5ZGVHxPnkz91xQpF068
        C4VjHTYCRiJnsE0BQnUMJc+vkntuaA0Vd90sYZmk6UQIb/kCHcsH6vHNJHcMZTPG
        rD25HiOXXGD3roXR3pZT0Vr6/Y3bLNSNSoo+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0EED3EC4C;
        Mon,  9 Dec 2019 14:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 022E33EC4A;
        Mon,  9 Dec 2019 14:24:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] commit: use strbuf_add() to add a length-limited string
References: <f4c7d65f-d7bb-c574-fe48-8d2df0c2907a@web.de>
Date:   Mon, 09 Dec 2019 11:24:33 -0800
In-Reply-To: <f4c7d65f-d7bb-c574-fe48-8d2df0c2907a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 7 Dec 2019 12:16:04 +0100")
Message-ID: <xmqqh829uwsu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 888AACC6-1AB9-11EA-968B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> This is shorter and simpler.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---

Ack (this was from me abck in 2012).

>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 294dc574cd..35a1fb9ad6 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -537,7 +537,7 @@ static void export_one(const char *var, const char =
*s, const char *e, int hack)
>  	struct strbuf buf =3D STRBUF_INIT;
>  	if (hack)
>  		strbuf_addch(&buf, hack);
> -	strbuf_addf(&buf, "%.*s", (int)(e - s), s);
> +	strbuf_add(&buf, s, e - s);
>  	setenv(var, buf.buf, 1);
>  	strbuf_release(&buf);
>  }
> --
> 2.24.0
