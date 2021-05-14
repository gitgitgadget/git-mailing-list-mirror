Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA01C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 03:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D230C6100C
	for <git@archiver.kernel.org>; Fri, 14 May 2021 03:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhEND70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 23:59:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61358 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhEND7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 23:59:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E6412B8FBB;
        Thu, 13 May 2021 23:58:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H1nCf3k8gOApMIb3jfgQg6AJFwLF07UE5ENPAi
        kcKHw=; b=KriVrTRuEmkQxNpOSZIiD8EHhzL/coTmfuYSkHhT33Nv6zPZVK1m2K
        0cTegoYGKL1VAgJSiCjM/8WwA5OGxZnWH4Pl9SlgP580Y1ers7pon+8oVOkyCuoV
        QM03QxfUfHhEKXRnWW1DgIjSniHNd2DIozP/Wok+zNbnYD204x9CI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE66FB8FBA;
        Thu, 13 May 2021 23:58:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70CCAB8FB8;
        Thu, 13 May 2021 23:58:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
References: <609b2828309fc_678ff2082@natae.notmuch>
        <20210514003104.94644-1-sandals@crustytoothpaste.net>
        <20210514003104.94644-2-sandals@crustytoothpaste.net>
Date:   Fri, 14 May 2021 12:58:12 +0900
In-Reply-To: <20210514003104.94644-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 14 May 2021 00:31:03 +0000")
Message-ID: <xmqqbl9e7yqz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AFD0EEA-B468-11EB-8551-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2aae4c9cbb..891181c0f3 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -192,10 +192,16 @@ ASCIIDOC_HTML = xhtml5
>  ASCIIDOC_DOCBOOK = docbook5
>  ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
>  ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
> -ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> +TXT_TO_HTML += -alitdd='&\#x2d;&\#x2d;'
> +TXT_TO_XML  += -alitdd='&\#x2d;&\#x2d;'
>  DBLATEX_COMMON =
>  XMLTO_EXTRA += --skip-validation
>  XMLTO_EXTRA += -x manpage.xsl
> +ifdef USE_ASCIIDOCTOR_MANPAGE
> +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
> +TXT_TO_MAN += -aplus='+'
> +TXT_TO_MAN += -alitdd='\--'
> +endif
>  endif

This hunk is wholly inside USE_ASCIIDOCTOR and deals with {litdd}
and {plus}, which are defined in asciidoc.conf that is not read by
Asciidoctor, so we'd need to be careful to keep these three places
(i.e. TXT_TO_HTML, TXT_TO_XML and TXT_TO_MAN) in sync with the
asciidoct.conf file.

It is curious that {plus} for Asciidoctor is deffined only for
manpages and HTML/XML side lacks the definition.  Intended?

It seems that the latter has several more "attributes" defined that
we do not replicate in the Makefile---I wonder if that is a sign
that we can get rid of entries for asterisk, caret, startsb,
etc. from asciidoc.conf?

Thanks.
