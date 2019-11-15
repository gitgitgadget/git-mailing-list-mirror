Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38D51F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 06:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKOGIG (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 01:08:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56129 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOGIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 01:08:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89C758FC07;
        Fri, 15 Nov 2019 01:08:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6KPj1dVQv8nAyklX7wdR8QRqXM8=; b=MrXQXG
        yg68923gAuE2gkP3ecsyYfWNSMxdQGKi54BibWDV/7+VQGWFU2q7yOO4i13pytNQ
        ZK4iJbtDkoVfIRhm5oqjn54Y1U0JPxJMiS1J7XiIBGF54dm/PHM7W4Pb2NqBTq6I
        BrQPrVw91xS6HKUtwdILWbspTH4IOyyrpwxGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K//gZsVQx/QcWpfn+NjXn95Ej55HWCQk
        CbLIxYO0gV3NqUC2sHLHsP66ku6GW9ljOqDtH5xmWSnJX8oX7Ln/Q2FuhwgTt2MO
        qmWyiQdRN6U1YnmIIbd7KEZDPJXWPdQLUthZAOvtR+hbdi4C4cizFTOo5wsNIbUG
        pDizoU2Cyxw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 819488FC06;
        Fri, 15 Nov 2019 01:08:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1AD48FC00;
        Fri, 15 Nov 2019 01:08:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 09/10] pretty: implement 'reference' format
References: <cover.1573241590.git.liu.denton@gmail.com>
        <cover.1573764280.git.liu.denton@gmail.com>
        <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
Date:   Fri, 15 Nov 2019 15:07:59 +0900
In-Reply-To: <470a2b0f4fd450af1d9c9d27ec0f0c91ea59117f.1573764280.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 14 Nov 2019 12:47:26 -0800")
Message-ID: <xmqqbltd7juo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 479C3B98-076E-11EA-869B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +* 'reference'
> +
> +	  <abbrev hash> (<title line>, <short author date>)

s/title line/title/ as you definitely do *not* want a line with a
title on it (and nothing else) in this context.

> +This format is useful for referring to other commits when writing a new
> +commit message. It uses the following canned user format:
> +`%C(auto)%h (%s, %as)`. This means it will not respect options that
> +change the output format such as `--date` `--no-abbrev-commit`, and
> +`--walk-reflogs`.

Ignoring of the '--date' may want to be eventually fixed, but for an
initial cut, using %as in the canned format is a good approach for
expediency.

I thought that %h can be told to give arbitrary long hash with
--abbrev=<n>, up to n==40 (or the number of bytes the hash of your
choice has), so I am not sure if `--no-abbrev-commit` is worth
mentioning.  I do not think I understand what you wanted to do by
using `--walk-reflogs` with the format at all, either.

Thanks.

