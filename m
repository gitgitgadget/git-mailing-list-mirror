Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4281A1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 19:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbcGSTPm (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:15:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751536AbcGSTPk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2016 15:15:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 389992A2CC;
	Tue, 19 Jul 2016 15:15:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L+/cL1whxNKn
	GMar4dvwzU3kSfQ=; b=qV+lGGN0VRA7vbEl97HJxw8cczz8kJ1/sYxsz0inl/eM
	YSc7j6E+elRFQsuy1CernMSHCCO1zHu/WkyRbyKoEQtoaDZ+xxn5122CAMU2Ya7X
	+BS/6rdMS8EmgWdzFrIs40VLFY0WvZa4Fq4tcifBUJxWVnz4jJY2zP6bViCRc0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qDYNSO
	PtRigU4NRfHk+w8ZGnD+VPcgyGQw97lwNBjI8IchncMmBMcKXGEdISZ34Xkj6aRb
	Fu0GyDcfGGKU+Y0+yZJ/pWzppkZcVx3g5kmRdDZt4Irw2zcbfeLstTjNE1U2F4kY
	oSJWGaZQMy0dYZyqZSUkD5zOB/JEmxOCLqUm0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CB382A2CB;
	Tue, 19 Jul 2016 15:15:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 972562A2C9;
	Tue, 19 Jul 2016 15:15:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] submodule-config: use explicit empty string instead of strbuf in config_from()
References: <578E7A07.8080006@web.de>
Date:	Tue, 19 Jul 2016 12:15:36 -0700
In-Reply-To: <578E7A07.8080006@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 19
	Jul 2016 21:05:43 +0200")
Message-ID: <xmqqd1m9fnhj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D6C5028-4DE5-11E6-84ED-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Use a string constant instead of an empty strbuf to shorten the code
> and make it easier to read.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> ... unless someone can come up with a suitable non-empty string to feed
> to git_config_from_mem() as its name parameter.
>
>  submodule-config.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index db1847f..44eb162 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -397,7 +397,6 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>  		const unsigned char *commit_sha1, const char *key,
>  		enum lookup_type lookup_type)
>  {
> -	struct strbuf rev = STRBUF_INIT;
>  	unsigned long config_size;
>  	char *config;
>  	unsigned char sha1[20];
> @@ -448,7 +447,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>  	parameter.commit_sha1 = commit_sha1;
>  	parameter.gitmodules_sha1 = sha1;
>  	parameter.overwrite = 0;
> -	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
> +	git_config_from_mem(parse_config, "submodule-blob", "",
>  			config, config_size, &parameter);
>  	free(config);

Oh.

I wondered if we used to do something useful with rev and later that
useful thing was removed leaving an always-empty strbuf, but it
appears that this strbuf was introduced to always hold an empty
string and nothing else, which shows the (lack of) quality of
reviews in this area X-<.

Will apply.  Thanks.
