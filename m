Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF9C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3ED613F8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFCVh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 17:37:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58815 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCVh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 17:37:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4D7514446E;
        Thu,  3 Jun 2021 17:36:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HbYTV5QiyhNToZNfeBiG9gzX7WAp2jVf63jf5p
        HEbss=; b=wXidhN8iewsdpUkInh5Z+ajbZdYkC4j9hzs+/Wbw8u0AgDYs2l+adQ
        esD28oNjzAWpX5Yz8SyZ9Qk+jp5MT018AJHsXjv9EMkk5RlJHdiNdhj4GLe9a9tv
        3toyeNNusbOS8bicB/PF6KXvW3gr5fVth003IfuAw5g1DpW2g2Mjc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CE7714446D;
        Thu,  3 Jun 2021 17:36:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D90814446C;
        Thu,  3 Jun 2021 17:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] [GSOC] ref-filter: add %(raw) atom
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
        <5a94705cdbc101169488919e35613d723e6ec581.1622558243.git.gitgitgadget@gmail.com>
        <xmqqsg1z65b8.fsf@gitster.g>
        <CAOLTT8TiyAtJfcrPoBF6SECfaKOTKt24NSOtTmf84JwHrU8g1A@mail.gmail.com>
        <CAOLTT8QjnFqXHRzAPnJStf4Ra189dZFe9k-Y9COoSCwW47CXiA@mail.gmail.com>
Date:   Fri, 04 Jun 2021 06:36:07 +0900
In-Reply-To: <CAOLTT8QjnFqXHRzAPnJStf4Ra189dZFe9k-Y9COoSCwW47CXiA@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 3 Jun 2021 22:06:35 +0800")
Message-ID: <xmqqy2bq4omw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5F6F2D2-C4B3-11EB-8BB3-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Now I am building %(raw:textconv) and %(raw:filter), the code will be
> very difficult to write:
>
>         if (format->quote_style && !strncmp(sp, "raw", 3)
>                                 && ((!arg) || (!strncmp(arg,
> ":textconv", 9)) || (!strncmp(arg, ":filter", 7))))
>                 return strbuf_addf_ret(err, -1, _("--format=%.*s
> cannot be used with"
>                                 "--python, --shell, --tcl, --perl"),
> (int)(ep-atom), atom);
>
> Is there any good way?

The problem you are having sounds like a natural consequence of
doing the check at the wrong place in the code, at least to me.
