Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C5520986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754087AbcJSWmE (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:42:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60207 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753152AbcJSWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:42:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5861F49709;
        Wed, 19 Oct 2016 18:42:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nsMHXSxic/lnXTrDGS6bVN9ckUE=; b=BdBZMR
        D2wxAnl4RSqLqmBejRcqnQ/fuKaSDak1gz6Uz1Frls3+r34l+s7dSNwgCPrCST9d
        9dF2D7J19OTW8TnoqwudqMdmupOCyYwZ5mMCYbP3zJ6gLt6OI5HVlT5Tv4Z8QAPx
        BtvcKT7k/P3apc07G0P9wUd2WfoT61V1o87Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c/L9fq9KrK00EAof/8153K6RbpyPrl1c
        v9VfasG3xWGYV57keN2+npQ8z6GnF/T69AhoY75PGhHlEm+XwCyT/fR1InjDqXWK
        yPF1H3UPoYK6fU7bMvPNTdyp3B7qL7zsU3ayzpjo11IEh8c/ihEbu6FFNROLJfzO
        zxqKlGR9nHE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 505AE49708;
        Wed, 19 Oct 2016 18:42:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C56E49705;
        Wed, 19 Oct 2016 18:42:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org, jacob.e.keller@intel.com,
        stefanbeller@gmail.com, peff@peff.net, j6t@kdbg.org,
        jacob.keller@gmail.com
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header mode
References: <1476908699.26043.9.camel@kaarsemaker.net>
        <20161019210448.aupphybw5qar6mqe@hurricane>
Date:   Wed, 19 Oct 2016 15:41:59 -0700
In-Reply-To: <20161019210448.aupphybw5qar6mqe@hurricane> (Dennis Kaarsemaker's
        message of "Wed, 19 Oct 2016 23:04:51 +0200")
Message-ID: <xmqq4m48j70o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40501EDA-964D-11E6-A7F2-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> +	touch expect &&
> +	printf "\0" > expect &&

What's the point of that "touch", especially if you are going to
overwrite it immediately after?

> +	git rev-list --header --max-count=1 HEAD | tail -n1 >actual &&

As "tail" is a tool for text files, it is likely unportable to use
"tail -n1" to grab the "last incomplete line that happens to contain
a single NUL".

> +	test_cmp_bin expect actual
> +'
