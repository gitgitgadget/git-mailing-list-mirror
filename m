Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5494FC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1064A64DD8
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhA1F6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 00:58:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62754 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhA1F6o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 00:58:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 04A9B124A09;
        Thu, 28 Jan 2021 00:58:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H/e93WTKVZTNsSMBBQipSGNz3u0=; b=cnx5x8
        ldIkBgi1FzahvEHa8L3i4R8LM1a2gzRQalqATNctiZMa0ycoHPw/SFXEv3Txcagq
        Q3cgQHuO92nfkHh28iyJtVqfFlRuMU3l8YzU9/xES9v3//ZXK/Km9zT6kzGOJqIf
        Lee22f9tj0wywnKqPdGKjPnjK/7DkqoIzXHsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vaWgLP6Jo67qouNIlpuTpZRqSBVBrPH/
        kmbMo+6uI8YaWWN02OD6x1O5DDiqdxtNhNuq6H0EYIUyqML/qoxzDELpm2xePxYt
        9LmvgjluO13IrWYP0ZKIspG0QLEf/QwgbeuFxR1xQVQAwtz7fpkvQAYnrdqygQVy
        GJBepwpatoo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4C5F124A08;
        Thu, 28 Jan 2021 00:58:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31135124A06;
        Thu, 28 Jan 2021 00:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] range-diff/format-patch: handle commit ranges
 other than A..B
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
        <2c2744333ecf5662d4198bdddeee80ff4adf6acd.1611339373.git.gitgitgadget@gmail.com>
        <xmqqv9bo7lwd.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101270342140.57@tvgsbejvaqbjf.bet>
Date:   Wed, 27 Jan 2021 21:57:59 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101270342140.57@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 27 Jan 2021 03:57:15 +0100 (CET)")
Message-ID: <xmqqa6sty55k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C76CDB24-612D-11EB-AACC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Maybe I am too stuck with the idea of avoiding regular expressions after
> that StackOverflow incident... Maybe
>
> 	static regex_t *regex;
>
> 	if (strstr(range, ".."))
> 		return 1;
>
> 	if (!regex) {
> 		regex = xmalloc(sizeof(*regex));
> 		if (regcomp(regex, "\\^(!|-[0-9]*)$", REG_EXTENDED))
> 			BUG("could not compile regex");
> 	}
>
> 	return !regexec(regex, range, 0, NULL, 0);
>
> is more readable, and acceptable in this context?

Readable, yes, acceptable, I don't know, and I am not even sure if I
want to be the one to judge to be honest ;-)

Have you tried the approach to feed the thing to setup_revisions()
and inspect what objects are in revs.pending?  

When you got a valid range, you should find one or more positive and
one or more negative commits , and the approach won't be fooled by
strings like "HEAD^{/other than A..B/}".

Or does the revision parsing machinery too eager to "die" when we
find a syntax error?  If so, scratch that idea, but in the longer
haul, fixing these die's would also be something we'd want to do to
make more parts of libgit.a callable as a proper library.

Thanks.
