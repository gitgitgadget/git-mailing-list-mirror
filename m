Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC3BC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE49920739
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MK1b8XXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgJ2XkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:40:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55509 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2XkS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 19:40:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 129BB8034B;
        Thu, 29 Oct 2020 19:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nfCjOG9nNVSMI5pr9qKjGd2t1ck=; b=MK1b8X
        XQftSieVDWJiGKDlmti6PPs03bPaS5U/bDb8sj9D5tDIsxff46g62MVrMyJ4j2o1
        Ro5o+vBYQQf1w9w1747A1MWISTSPsvSa2wIXgeJv0mN7d1f1mbCySWfdxNyOPogh
        oXobIcUar0sPimK5Ir9BiHxE6pVz352fbZjQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BVyKctpPyWwnZzrAUfS0D8T2VcbNM66k
        cC7oDZbJEID4UUQbv4m0ffuPAE4yixFT4MA4xnaeZg81KHeuw/N6N6ftsavEejko
        e1drDznx+b+z7ZaGzvfPKU6zNewvVdH0Hj8CDZnK4vYszilnes3guyYX2xdIXrVY
        ZUktTKMbSLw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E888880349;
        Thu, 29 Oct 2020 19:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5377D80347;
        Thu, 29 Oct 2020 19:40:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 01/19] convert: make convert_attrs() and convert
 structs public
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <dfc3e0fd62bcf0223dc51485521116e1aca2ee07.1603937110.git.matheus.bernardino@usp.br>
Date:   Thu, 29 Oct 2020 16:40:14 -0700
In-Reply-To: <dfc3e0fd62bcf0223dc51485521116e1aca2ee07.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:38 -0300")
Message-ID: <xmqq361w4n4x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1858EDF0-1A40-11EB-909F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> diff --git a/convert.h b/convert.h
> index e29d1026a6..aeb4a1be9a 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -37,6 +37,27 @@ enum eol {
>  #endif
>  };
>  
> +enum crlf_action {
> +	CRLF_UNDEFINED,
> +	CRLF_BINARY,
> +	CRLF_TEXT,
> +	CRLF_TEXT_INPUT,
> +	CRLF_TEXT_CRLF,
> +	CRLF_AUTO,
> +	CRLF_AUTO_INPUT,
> +	CRLF_AUTO_CRLF
> +};
> +
> +struct convert_driver;
> +
> +struct conv_attrs {
> +	struct convert_driver *drv;
> +	enum crlf_action attr_action; /* What attr says */
> +	enum crlf_action crlf_action; /* When no attr is set, use core.autocrlf */
> +	int ident;
> +	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
> +};
> +
>  enum ce_delay_state {
>  	CE_NO_DELAY = 0,
>  	CE_CAN_DELAY = 1,
> @@ -102,6 +123,9 @@ void convert_to_git_filter_fd(const struct index_state *istate,
>  int would_convert_to_git_filter_fd(const struct index_state *istate,
>  				   const char *path);
>  
> +void convert_attrs(const struct index_state *istate,
> +		   struct conv_attrs *ca, const char *path);
> +
>  /*
>   * Initialize the checkout metadata with the given values.  Any argument may be
>   * NULL if it is not applicable.  The treeish should be a commit if that is

The new global symbols are reasonable, I would think, with a
possible exception of "crlf_action", which may want to also have
"conv" or "convert" somewhere in its name.

