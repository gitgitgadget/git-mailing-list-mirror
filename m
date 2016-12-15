Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B571FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 18:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbcLOSwI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 13:52:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53707 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752706AbcLOSwF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 13:52:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90FC7585D2;
        Thu, 15 Dec 2016 13:50:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uqItPU+ODQf+xv4d0gMmuH7b9WY=; b=rR5A1S
        An087E2o93f0wvmfuhmGV/JHaqg16WGhY2u4rtLMSg7dRgtnrhpNZIbtFkmFAKuS
        0XF9ODODrpOg19gO62F/CqC3LID3v8uXJFPEoufjsx2plVWJwWLSmVh/mDxgTCC5
        mA+XLaGZ/fltwoPhby3FQ0gksKgOpU1Nj3hQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DHuLJx8SGpPzBhcPrae2iN8TQKSq8chY
        XYORucKE92GO7A2eIedS39jOOuhYQsdPbC+J0gPHLjD7BJm01ig6+g90nwdrpJmA
        UBgbVAQGGeUOaWLnqXJ46nuwhCA6AZ6fEiuHOSvNo5L+E6IHYj0upQrb+MfOrFme
        7tpX6I7hVMY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88611585D1;
        Thu, 15 Dec 2016 13:50:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 090E5585CF;
        Thu, 15 Dec 2016 13:50:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 09/34] sequencer (rebase -i): write an author-script file
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <09c2718e119f809093794410ae1a738c1cd122d1.1481642927.git.johannes.schindelin@gmx.de>
Date:   Thu, 15 Dec 2016 10:50:31 -0800
In-Reply-To: <09c2718e119f809093794410ae1a738c1cd122d1.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:30:09 +0100
        (CET)")
Message-ID: <xmqqd1gtuivc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B94E9A6-C2F7-11E6-94CE-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +	strbuf_addstr(&buf, "GIT_AUTHOR_NAME='");
> +	while (*message && *message != '\n' && *message != '\r')
> +		if (skip_prefix(message, " <", &message))
> +			break;
> +		else if (*message != '\'')
> +			strbuf_addch(&buf, *(message++));
> +		else
> +			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
> +	while (*message && *message != '\n' && *message != '\r')
> +		if (skip_prefix(message, "> ", &message))
> +			break;
> +		else if (*message != '\'')
> +			strbuf_addch(&buf, *(message++));
> +		else
> +			strbuf_addf(&buf, "'\\\\%c'", *(message++));

Aren't these reading from an in-core commit object?  

If so, it should use split_ident_line() for consistency with other
parts of the system to do this parsing.  We should also already have
a helper for simple shell-quoting in quote.c and you would want to
use that instead of open coding like this.
