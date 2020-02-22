Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D43C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897C3206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eb3pr7FD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBVUNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:13:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56977 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgBVUNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 15:13:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 758D0BB337;
        Sat, 22 Feb 2020 15:13:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hNGXLHEa0d3kP8usNo9M2rywnbY=; b=Eb3pr7
        FDNbVyX5A9xm0/LL2UNUARWWgDxAgkkZjC6AvX3sKCOgwYK0p4fGbhyRrJkCag84
        cYpOAMrpfSVJzUCBpmPSJ3JFdPubiiBO9ah0TxLnlTTxsXBz3/Qjd5TMXFIZgQtF
        ndMB94SAXYmltjp8GObU9BUXHoFSbIa2iZZ0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pV1LiL3xL1RAs4GWBw938oOmUTGAjLS/
        ReZkvJHUlXckKEdVG8FOaW+xJYOnjZeXk73Q1Bz4B+/9wPHJFDD/N2jVEdSQgNCB
        3RFJDtzxjbYMrNuWIHWxnF6TuDQa7LhdnmcVpVqynx/YUoc0WXhCErRfeuCqGXoD
        Vr5g95PMIZc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E1C4BB336;
        Sat, 22 Feb 2020 15:13:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CAF4BB335;
        Sat, 22 Feb 2020 15:13:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] submodule--helper: use C99 named initializer
References: <20200221031027.204486-1-emilyshaffer@google.com>
        <20200221031027.204486-2-emilyshaffer@google.com>
Date:   Sat, 22 Feb 2020 12:13:33 -0800
In-Reply-To: <20200221031027.204486-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 20 Feb 2020 19:10:26 -0800")
Message-ID: <xmqqlfounzwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE45FA82-55AF-11EA-AB7F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Start using a named initializer list for SUBMODULE_UPDATE_CLONE_INIT, as

The feature has its own name.  Instead of coming up with your own
name for it, let's say "designated initializers".

> -#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
> -	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, 0, \
> -	NULL, NULL, NULL, \
> -	NULL, 0, 0, 0, NULL, 0, 0, 1}
> +#define SUBMODULE_UPDATE_CLONE_INIT { \
> +	.list = MODULE_LIST_INIT, \
> +	.update = SUBMODULE_UPDATE_STRATEGY_INIT, \
> +	.recommend_shallow = -1, \
> +	.references = STRING_LIST_INIT_DUP, \
> +	.max_jobs = 1 \
> +}

This does make it read more easily.  If you ended the last field
with trailing comma, that would have been even better as a future
proofing ;-)

