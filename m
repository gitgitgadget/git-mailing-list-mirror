Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9282E1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 20:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbdLSURL (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 15:17:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53266 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753081AbdLSURG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 15:17:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2F75ADA43;
        Tue, 19 Dec 2017 15:17:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a1GguaPpVemnszIt7XKd9PmW1kI=; b=gpi44R
        qJMb8SzvuwzmVk6lf1BLISXVtTKJhQSpdq0csbnKUILPuvmOtBN4xXfpN89BYjU/
        5+JgOhI2NK6qo8T1OPE100Et65Spld0KK+jHHbHf2TX6FamamCScmitG5ke6CC3P
        bWGM9FZjvQPDb9FBoR4GwebfVfBJjx3LOlzpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZGVxOYx2/0+lhr03aos1fNfV7zt7kRkE
        W3c0gzqRQOYD3jh1ceFcuzYlL31JzMRYLJn5jzlIkaRVfdNExVlYQWf90CULz0Gq
        X5daUt7AJX/UIkJcvVRM2Qcef/781Jv6WjLsp8epE2SDOIWyQhSEzpYxbtHLFT7o
        yFenHYmZca0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7583ADA42;
        Tue, 19 Dec 2017 15:17:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE79BADA41;
        Tue, 19 Dec 2017 15:17:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Vandiver <alexmv@dropbox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 2/6] fsmonitor: Add dir.h include, for untracked_cache_invalidate_path
References: <20171219002858.22214-1-alexmv@dropbox.com>
        <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
        <c8cf261d9d620d8123e8bfa5aa952fa55685a8db.1513642743.git.alexmv@dropbox.com>
Date:   Tue, 19 Dec 2017 12:17:02 -0800
In-Reply-To: <c8cf261d9d620d8123e8bfa5aa952fa55685a8db.1513642743.git.alexmv@dropbox.com>
        (Alex Vandiver's message of "Mon, 18 Dec 2017 16:28:54 -0800")
Message-ID: <xmqqtvwmv5fl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94A525D8-E4F9-11E7-87D9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Vandiver <alexmv@dropbox.com> writes:

> Subject: Re: [PATCH 2/6] fsmonitor: Add dir.h include, for untracked_cache_invalidate_path

Perhaps

"Subject: fsmonitor.h: include dir.h"

But I am not sure if this is a right direction to go in.  If a .C
user of fsmonitor needs (does not need) things from dir.h, that file
can (does not need to) include dir.h itself.

I think this header does excessive "static inline" as premature
optimization, so a better "fix" to your perceived problem may be to
make them not "static inline".

> This missing include is currently hidden by dint of the fact that
> dir.h is already included by all things that currently include
> fsmonitor.h
>
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---


>  fsmonitor.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fsmonitor.h b/fsmonitor.h
> index cd3cc0ccf..5f68ca4d2 100644
> --- a/fsmonitor.h
> +++ b/fsmonitor.h
> @@ -1,5 +1,6 @@
>  #ifndef FSMONITOR_H
>  #define FSMONITOR_H
> +#include "dir.h"
>  
>  extern struct trace_key trace_fsmonitor;
