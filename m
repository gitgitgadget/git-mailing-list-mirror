Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1107C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80618206D4
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gYgXG7k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHEADd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:03:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58783 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgHEADd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 20:03:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D13DDEBDA;
        Tue,  4 Aug 2020 20:03:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SDgBCIV5cy2KKBxNgAh9pEt84hU=; b=gYgXG7
        k6QQ1bZ/fxPjycyLMugmv89ces1lMd/Q6wVdGk4uCsysDa9NXyQfNbiE6JisyiLl
        LUwIGQoPaPDmfAOj6CzgwykQfReBAizFcR91DOcCt00hfpNSo61oTSdXXoxwluKF
        /3QgCdLzI+tIuhgxV3YpjRwBdsxDyPRO6dN9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S4irq/WIi6Q8X/2fL60RabbQf2UVFF0U
        isLl2zYCx6fowl80ji9M36C5EqRjV7C64Q9Wl7hwp/0EDjBiOTPBSuny3lCL2VKQ
        FuxHQtHIR6lghSnG7nyaOJ3cOjszXzv0yicxB6lWvv2BB3GdBKJnh6YR6HoYlgA0
        cj0jCcJo4/8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66361DEBD9;
        Tue,  4 Aug 2020 20:03:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E207DEBD7;
        Tue,  4 Aug 2020 20:03:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] revision: fix die() message for "--unpacked="
References: <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <87imdyxedw.fsf@osv.gnss.ru>
        <20200804220833.GB2022650@coredump.intra.peff.net>
        <87sgd2vyi1.fsf_-_@osv.gnss.ru>
Date:   Tue, 04 Aug 2020 17:03:26 -0700
In-Reply-To: <87sgd2vyi1.fsf_-_@osv.gnss.ru> (Sergey Organov's message of
        "Wed, 05 Aug 2020 01:26:30 +0300")
Message-ID: <xmqqa6zaq7qp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 174B0C42-D6AF-11EA-9DC0-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Get rid of the trailing dot and mark for translation.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  revision.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 669bc856694f..d08cb5c0e9cd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2315,7 +2315,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--unpacked")) {
>  		revs->unpacked = 1;
>  	} else if (starts_with(arg, "--unpacked=")) {
> -		die("--unpacked=<packfile> no longer supported.");
> +		die(_("--unpacked=<packfile> no longer supported"));
>  	} else if (!strcmp(arg, "-r")) {
>  		revs->diff = 1;
>  		revs->diffopt.flags.recursive = 1;

Makes sense.  Will queue.  thanks.
