Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB3241F461
	for <e@80x24.org>; Thu, 20 Jun 2019 22:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFTWLp (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 18:11:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58051 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTWLp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 18:11:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B4346344A;
        Thu, 20 Jun 2019 18:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Rt9IqeZ3xkOk
        yVTi6mqz431IDEI=; b=p4+iGzqJtHJCp4oG2y4aLSJBdYAlSJBBfV92XwVhmmC7
        /cRSycNSSIgQA8hx0IbfJCLRigRfpwexJaLJEgYT6Kf9h/YCiJz5FQJj7dh3RrlF
        29naj93O2LQmk9Qy7WPAGyTR8fJ0GV27eb7S9iyJuK2XBfpK9Z8R/i8pZhy/i9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=o+wXds
        4N5zdquSXrXFlVgd91eSJKq8rIpoZQAxP5lA19lFqC6h1RBdxf6io4EMZu6djC6y
        TK0Skfp4aF3G3p6dvE8g2jq8B+AU31BuGLtmeDzEFCotRixEj+3Tu69cy96xpNFc
        vffAFEgRiC4unrdTp9zL514KAWmzPJxVPZLJw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 93FDE63449;
        Thu, 20 Jun 2019 18:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6ED263447;
        Thu, 20 Jun 2019 18:11:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/8] env--helper: new undocumented builtin wrapping git_env_*()
References: <20190619233046.27503-1-avarab@gmail.com>
        <20190620210915.11297-3-avarab@gmail.com>
Date:   Thu, 20 Jun 2019 15:11:38 -0700
In-Reply-To: <20190620210915.11297-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jun 2019 23:09:09 +0200")
Message-ID: <xmqqpnn7lxet.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 615596EA-93A8-11E9-A664-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	switch (cmdmode) {
> +	case ENV_HELPER_BOOL:
> +		tmp_int =3D strtol(env_default, (char **)&env_default, 10);
> +		if (*env_default) {
> +			error(_("option `--default' expects a numerical value with `--mode-=
bool`"));
> +			usage_with_options(env__helper_usage, opts);
> +		}
> +		ret_int =3D git_env_bool(env_variable, tmp_int);
> +		if (!quiet)
> +			printf("%d\n", ret_int);
> +		ret =3D ret_int;
> +		break;
> +	case ENV_HELPER_ULONG:
> +		tmp_ulong =3D strtoll(env_default, (char **)&env_default, 10);
> +		if (*env_default) {
> +			error(_("option `--default' expects a numerical value with `--mode-=
ulong`"));
> +			usage_with_options(env__helper_usage, opts);
> +		}
> +		ret_ulong =3D git_env_ulong(env_variable, tmp_ulong);
> +		if (!quiet)
> +			printf("%lu\n", ret_ulong);
> +		ret =3D ret_ulong;
> +		break;

Perhaps have something like 'default: BUG("wrong cmdmode");'

> +	}
> +
> +	if (exit_code)
> +		return !ret;

as I am getting

    error: 'ret' may be used uninitialized in this function [-Werror=3Dma=
ybe-uninitialized]

from here.

Giving an otherwise useless initial value to ret would be a
workaround.
