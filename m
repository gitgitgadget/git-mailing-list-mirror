Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E9A1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 02:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755928AbdDRC12 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 22:27:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64171 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755881AbdDRC10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 22:27:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9DE2750FB;
        Mon, 17 Apr 2017 22:27:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TJ25WIphsiUN
        qtcqXGVQng9rJWY=; b=bS8T6/kYG0xYRJNgviLQDnQGX9lCXaSGdVcm48W++s+9
        q167nXPpewIQrp/aEHc5gN5hqd3fdHBQY4WrbRMCLb9L29NxcxUBhZBNttva2b3k
        jMxjb9QCPiacM8QLhKvURj6JLLd4RgCFCswrRkiqilGLAyh2glLHMV4Yd9oAQZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NrtW6P
        sQzgrdpDN+LNprhOya6D7jQkQ+zs5UnPP0nnJ0mP9yuudXlmAWqmo/B0702DMV+y
        gSdIu9nQrDtPboDetMFp2rbBLc/V/G/pGlrx82f3oulDbe5ikwIcRlPgEPd0Bcic
        OQiMsjlK1ZYDitjRMJR0w3o7x5EHQKGNlbE2E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0717750FA;
        Mon, 17 Apr 2017 22:27:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33774750F9;
        Mon, 17 Apr 2017 22:27:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        bert.wesarg@googlemail.com
Subject: Re: [PATCH v2 1/3] config: prepare to pass more info in git_config_with_options()
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
        <20170417101002.18272-1-pclouds@gmail.com>
Date:   Mon, 17 Apr 2017 19:27:16 -0700
In-Reply-To: <20170417101002.18272-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 17 Apr 2017 17:10:00 +0700")
Message-ID: <xmqqd1cah2m3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B252C60-23DE-11E7-8A5F-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> So far we can only pass one flag, respect_includes, to thie function. W=
e

s/thie/this/

> need to pass some more (non-flag even), so let's make it accept a struc=
t
> instead of an integer.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  builtin/config.c | 21 ++++++++++++---------
>  cache.h          |  7 ++++++-
>  config.c         | 16 +++++++++++-----
>  3 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 4f49a0edb9..b937d175a9 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -26,7 +26,8 @@ static int use_global_config, use_system_config, use_=
local_config;
>  static struct git_config_source given_config_source;
>  static int actions, types;
>  static int end_null;
> -static int respect_includes =3D -1;
> +static int respect_includes_opt =3D -1;
> +static struct config_options config_options;
>  static int show_origin;
> =20
>  #define ACTION_GET (1<<0)
> @@ -81,7 +82,7 @@ static struct option builtin_config_options[] =3D {
>  	OPT_GROUP(N_("Other")),
>  	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")=
),
>  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")=
),
> -	OPT_BOOL(0, "includes", &respect_includes, N_("respect include direct=
ives on lookup")),
> +	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include di=
rectives on lookup")),

It would be more in line with what the log message advertised if you
did

	static struct config_options config_options =3D {
		-1, /* .respect_includes: unspecified */
	};

	OPT_BOOL(0, "includes", &config_options.respect_includes, N_("...")),

no?
