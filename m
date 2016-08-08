Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51EC2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 22:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbcHHWQT (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 18:16:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750938AbcHHWQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 18:16:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AC7234F6E;
	Mon,  8 Aug 2016 18:16:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MeWtYKot7W3/rNI4/bNlq/4Wwgw=; b=em6K0O
	oaUAULogx1dOUnTHo4ljCGmxSseswfplPwDkCqvpaWqbeNQVkQLEtklk11YK3EcB
	ilICtZ6IOEyDTaNOss8xOV0EGyCNGj05ROh70taqs9bVMDlT3bXPzExJ95vGG/uY
	8LBM/4fUzBwoZL5p6jGofTEnIXKhIf/u+IgWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z3oLUDvpncwigzBRg1tqJsCKFylXKrBg
	wTEq991Do1yNMiuoDcCJRVvv/J1QZI1mT4saoG4B37i61oTIvU/2iFcsaNIjqZLy
	oVA0dd3d1lefqSxSHFhn4hpQwwlrcyWM7mqqqGxBJBFowP+pwanx+Kdn0OlpN745
	vC4mzyg+Drk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31C3C34F6D;
	Mon,  8 Aug 2016 18:16:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E81034F68;
	Mon,  8 Aug 2016 18:16:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 00/40] libify apply and use lib in am, part 2
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
	<CAP8UFD2t9PaC8hONJJuG2EUU=0NMUC1BaDDD2Hr0u21K5rhZ3Q@mail.gmail.com>
Date:	Mon, 08 Aug 2016 15:16:14 -0700
In-Reply-To: <CAP8UFD2t9PaC8hONJJuG2EUU=0NMUC1BaDDD2Hr0u21K5rhZ3Q@mail.gmail.com>
	(Christian Couder's message of "Mon, 8 Aug 2016 23:23:24 +0200")
Message-ID: <xmqq1t1yewk1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9B0EBA4-5DB5-11E6-9348-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/apply.h b/apply.h
> index 27a3a7a..e2b89e8 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -16,7 +16,7 @@ enum apply_ws_ignore {
>  enum apply_verbosity {
>      verbosity_silent = -1,
>      verbosity_normal = 0,
> -    verbosity_verbose = 1,
> +    verbosity_verbose = 1
>  };

Thanks for not forgetting this.

> @@ -107,20 +111,6 @@ struct apply_state {
>      int applied_after_fixing_ws;
>  };
>
> -extern int apply_option_parse_exclude(const struct option *opt,
> -                      const char *arg, int unset);
> -extern int apply_option_parse_include(const struct option *opt,
> -                      const char *arg, int unset);
> -extern int apply_option_parse_p(const struct option *opt,
> -                const char *arg,
> -                int unset);
> -extern int apply_option_parse_whitespace(const struct option *opt,
> -                     const char *arg, int unset);
> -extern int apply_option_parse_directory(const struct option *opt,
> -                    const char *arg, int unset);
> -extern int apply_option_parse_space_change(const struct option *opt,
> -                       const char *arg, int unset);
> -
>  extern int apply_parse_options(int argc, const char **argv,
>                     struct apply_state *state,
>                     int *force_apply, int *options,

Also these.
