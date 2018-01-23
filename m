Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE56A1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 20:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeAWUWQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 15:22:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55011 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbeAWUWP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 15:22:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5470DB9F53;
        Tue, 23 Jan 2018 15:22:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sHM5vH0FFa75dBOJWuZraIzvVow=; b=dqpcIL
        fiahoZyBXugK5rsecQfYjov6afwFsHEpVIZpiraRLmsOloeaUmlGq9QMZnRWFiFq
        4duBBJC0fYGPFvBwU3wIC3Qafx4/z9K+HCgEkez8SOcdKbR2dD/H0QZw1zQmtRYH
        WvLmgLMlJz1WbudLZdmb7XVmVemi/N6MNMozI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mBFgpIieX9d5nRNwCXn1UKCu2FZGr1or
        LrbYsusZ8jGTIx4duPWeLoSDx+WkTMiKZCOQicIovEP0TMmrn8W9mHOsJAb9kIRC
        DviN5oBU3IfhL9685NmgxGBMFi1W3XlSOrL8LcxAJARKcdwwra6sMtbjbcCxlEeH
        1l9ePe9RyJk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C6D3B9F52;
        Tue, 23 Jan 2018 15:22:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5530B9F4F;
        Tue, 23 Jan 2018 15:22:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
Date:   Tue, 23 Jan 2018 12:22:13 -0800
In-Reply-To: <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Jan 2018 16:35:48 +0100
        (STD)")
Message-ID: <xmqq607sgway.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19C69B88-007B-11E8-9A43-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 8a861c1e0d6..1d061373288 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -368,6 +368,11 @@ The commit list format can be changed by setting the configuration option
>  rebase.instructionFormat.  A customized instruction format will automatically
>  have the long commit hash prepended to the format.
>  
> +--recreate-merges::
> +	Recreate merge commits instead of flattening the history by replaying
> +	merges. Merge conflict resolutions or manual amendments to merge
> +	commits are not preserved.
> +

It is sensible to postpone tackling "evil merges" in this initial
iteration of the series, and "manual amendments ... not preserved"
is a reasonable thing to document.  But do we want to say a bit more
about conflicting merges?  "conflict resolutions ... not preserved"
sounds as if it does not stop and instead record the result with
conflict markers without even letting rerere to kick in, which
certainly is not the impression you wanted to give to the readers.

I am imagining that it will stop and give control back to the end
user just like a conflicted "pick" would, and allow "rebase
--continue" to record resolution from the working tree, and just
like conflicted "pick", it would allow rerere() to help end users
recall previous resolution.

