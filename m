Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC2D1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934316AbcIVUoe (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:44:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61394 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933263AbcIVUod (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:44:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16B1A3F7A0;
        Thu, 22 Sep 2016 16:44:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UzRYcsUp6Jij3lyHokpU+9lyOkU=; b=Mvjt4A
        xYBpZksy/tF4+18i7fQ1AG3wGWfxBhaLMxJxsl8R9O0gYb4zx8/Az5SyyDiNkaK+
        pyWlFNjHi5tkgbr2i6V/l6V7QobaH6gsgFS1ceT6V5AzquUdGTQUsMumfjMYxo1s
        zJzC3lVA+aKf/Hlzzcr0DyTzdwwcSoKaelDIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X0fV7ENjcl1N9YfGTkdyCczKy5mVpDlE
        xYzNFjWkFBOdzc4zK1XrCrCoGmMS7M4g53eILc4vo5NmZNlStIH2P39CxB9EguDr
        17W/N1QbhTGT5lWx/DR4KsBKcQh4qbHZGszm23B/FJxegFUDOtS3BaZ/XQEg1kgL
        RpS6y1XNoGc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DA163F79D;
        Thu, 22 Sep 2016 16:44:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76B973F79C;
        Thu, 22 Sep 2016 16:44:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: Re: [PATCH 2/6] gpg-interface: add GPG_VERIFY_QUIET flag
References: <20160922185317.349-1-santiago@nyu.edu>
        <20160922185317.349-3-santiago@nyu.edu>
Date:   Thu, 22 Sep 2016 13:44:29 -0700
In-Reply-To: <20160922185317.349-3-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Thu, 22 Sep 2016 14:53:13 -0400")
Message-ID: <xmqqzimz3brm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CF308FC-8105-11E6-B518-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Lukas P <luk.puehringer@gmail.com>

Please match this with S-o-b: below.

>
> Functions that print git object information may require that the
> gpg-interface functions be silent. Add a GPG_VERIFY_QUIET to prevent
> functions such as `print_signature_buffer` from printing any output and
> only return whether signature verification passed or not.
>
> Signed-off-by: Lukas Puehringer <lukas.puehringer@nyu.edu>
> ---
>  gpg-interface.c | 3 +++
>  gpg-interface.h | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 8672eda..b82bc50 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -88,6 +88,9 @@ int check_signature(const char *payload, size_t plen, const char *signature,
>  
>  void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
>  {
> +	if (flags & GPG_VERIFY_QUIET)
> +		return;
> +
>  	const char *output = flags & GPG_VERIFY_RAW ?
>  		sigc->gpg_status : sigc->gpg_output;

This has only two callsites, which both know what flags they are
passing.  Doesn't it make more sense to drop this patch (and
possibly addition of GPG_VERIFY_QUIET flag as well) and teach them
not to call this function in the first place?

> diff --git a/gpg-interface.h b/gpg-interface.h
> index ea68885..85dc982 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -3,6 +3,7 @@
>  
>  #define GPG_VERIFY_VERBOSE	1
>  #define GPG_VERIFY_RAW		2
> +#define GPG_VERIFY_QUIET	4
>  
>  struct signature_check {
>  	char *payload;
