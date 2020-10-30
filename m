Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F6C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 21:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611F222227
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 21:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tXQT8NgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgJ3Vgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 17:36:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55873 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgJ3Vgp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 17:36:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FC7BEDB2E;
        Fri, 30 Oct 2020 17:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sILrMwLnhv9UeNt3HK1Zq+09g2A=; b=tXQT8N
        gKATpnykjTWYqUzQxZco+6KeyB+cfofbRx6uhd+8rRyF3ICMyVSzSaiZZ6I7cqJs
        w8/AHgMHldAb8K8hMTsZNnlx1lsREdRvm8UqIcHu7HVVaLdV1A+yZXVOZ57qAbWe
        QayWAAtrdOO8aqxmFN3pBFbrkxoGdnFjM/qCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uk5lfI+zQ9IJkD64KakkvvjGAxs7OcoX
        DLY9doLKnSo+dDrPE/t0eYaVA/rpA/MPYlnppuKEXnwdCxbmtqo+4xm91r5SEH3q
        u4W4CKNM8mKMQDSa9KJwlimvKZ7DTBu0CMKi2DGZukktZcb03nEET6LERPoQMK+N
        CEXDbpyyo4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37819EDB2D;
        Fri, 30 Oct 2020 17:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 82FD0EDB2C;
        Fri, 30 Oct 2020 17:36:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 05/19] entry: extract a header file for entry.c
 functions
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <2caa2c4345d524e9e3bb0c388f8dc0b99236d166.1603937110.git.matheus.bernardino@usp.br>
Date:   Fri, 30 Oct 2020 14:36:38 -0700
In-Reply-To: <2caa2c4345d524e9e3bb0c388f8dc0b99236d166.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:42 -0300")
Message-ID: <xmqqk0v75rbt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF301A52-1AF7-11EB-A80F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> The declarations of entry.c's public functions and structures currently
> reside in cache.h. Although not many, they contribute to the size of
> cache.h and, when changed, cause the unnecessary recompilation of
> modules that don't really use these functions. So let's move them to a
> new entry.h header.

Good idea.  This is mostly moving things around, so there are only a
few minor nits.

> diff --git a/entry.h b/entry.h
> new file mode 100644
> index 0000000000..2d69185448
> --- /dev/null
> +++ b/entry.h
> @@ -0,0 +1,41 @@
> +#ifndef ENTRY_H
> +#define ENTRY_H
> +
> +#include "cache.h"
> +#include "convert.h"
> +
> +struct checkout {
> +	struct index_state *istate;
> +	const char *base_dir;
> +	int base_dir_len;
> +	struct delayed_checkout *delayed_checkout;
> +	struct checkout_metadata meta;
> +	unsigned force:1,
> +		 quiet:1,
> +		 not_new:1,
> +		 clone:1,
> +		 refresh_cache:1;
> +};
> +#define CHECKOUT_INIT { NULL, "" }
> +

It makes sense to have a blank here, like you did, as we just
completed the definition of "struct checkout" and things directly
related to it.

> +#define TEMPORARY_FILENAME_LENGTH 25
> +
> +/*
> + * Write the contents from ce out to the working tree.
> + *
> + * When topath[] is not NULL, instead of writing to the working tree
> + * file named by ce, a temporary file is created by this function and
> + * its name is returned in topath[], which must be able to hold at
> + * least TEMPORARY_FILENAME_LENGTH bytes long.
> + */
> +int checkout_entry(struct cache_entry *ce, const struct checkout *state,
> +		   char *topath, int *nr_checkouts);

The comment before the above block applies to both the function and
to the TEMPORARY_FILENAME_LENGTH preprocessor macro.  And this is
where we conclude the definition related to the function so it is a
good idea to have a blank line here....

> +void enable_delayed_checkout(struct checkout *state);
> +int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);

....and here, as we have finished talking about the "delayed" stuff.

> +/*
> + * Unlink the last component and schedule the leading directories for
> + * removal, such that empty directories get removed.
> + */
> +void unlink_entry(const struct cache_entry *ce);
> +
> +#endif /* ENTRY_H */
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 323280dd48..a511fadd89 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -16,6 +16,7 @@
>  #include "fsmonitor.h"
>  #include "object-store.h"
>  #include "promisor-remote.h"
> +#include "entry.h"
>  
>  /*
>   * Error messages expected by scripts out of plumbing commands such as
n
