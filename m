Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A426C1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 17:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbcGLRUP (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 13:20:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751014AbcGLRUN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 13:20:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 77D432A9D0;
	Tue, 12 Jul 2016 13:20:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AmZmAO6Z5U+H
	1yCXPFm0uYyt/2g=; b=A3xpAhlYPet/OhazBzDegZLNXscCz/2pNard+lU1aHSB
	fwAyziu08vE5whgDVKbZWALsuoIib2VHGCbQRSQ6hvL0XqNRf0ZxiarM5EVkJiIo
	pvHsf6jZ1LdDdgYsknK6YfMpRNKlc+T//DsxnmbOx3xJZuiJDtjKkcMEznO6lMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ao2aD2
	rzVCXfZkQN7YehpX1RGWXMlGGKu+jaAz05jNBEJR7XKqe0qvW7WGYNtluDYGFMKB
	IWqWnBP2QkjDULvy9GJJLhEq1NV7dAA0QHQjgVB+KPT8PDZ8DNlWp8GBsm8RhYZy
	L05JXms5dygwCcpyyitoYhAtcOp4K+YrD46Bg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FC972A9CD;
	Tue, 12 Jul 2016 13:20:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00DD62A9CC;
	Tue, 12 Jul 2016 13:20:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 2/5] sha1_file.c: use type off_t* for object_info->disk_sizep
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
	<20160705170558.10906-3-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 10:20:02 -0700
In-Reply-To: <20160705170558.10906-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 5 Jul 2016 19:05:55 +0200")
Message-ID: <xmqqk2gq6af1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E05EEFB0-4854-11E6-974D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This field, filled by sha1_object_info() contains the on-disk size of
> an object, which could go over 4GB limit of unsigned long on 32-bit
> systems. Use off_t for it instead and update all callers.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/cat-file.c | 4 ++--
>  cache.h            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 618103f..5b34bd0 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -131,7 +131,7 @@ struct expand_data {
>  	unsigned char sha1[20];
>  	enum object_type type;
>  	unsigned long size;
> -	unsigned long disk_size;
> +	off_t disk_size;
>  	const char *rest;
>  	unsigned char delta_base_sha1[20];
>  
> @@ -191,7 +191,7 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
>  		if (data->mark_query)
>  			data->info.disk_sizep = &data->disk_size;
>  		else
> -			strbuf_addf(sb, "%lu", data->disk_size);
> +			strbuf_addf(sb, "%"PRIuMAX, data->disk_size);

Doesn't this now need a cast?

>  	} else if (is_atom("rest", atom, len)) {
>  		if (data->mark_query)
>  			data->split_on_whitespace = 1;
> diff --git a/cache.h b/cache.h
> index c73becb..a4465cb 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1508,7 +1508,7 @@ struct object_info {
>  	/* Request */
>  	enum object_type *typep;
>  	unsigned long *sizep;
> -	unsigned long *disk_sizep;
> +	off_t *disk_sizep;
>  	unsigned char *delta_base_sha1;
>  	struct strbuf *typename;
