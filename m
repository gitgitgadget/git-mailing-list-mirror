Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E79208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756598AbdHYRSV (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:18:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54672 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755629AbdHYRSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:18:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38E979F55F;
        Fri, 25 Aug 2017 13:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N3LKm94FBxYoynObbtLYjB+VmqE=; b=Clg3Ge
        1NzFaRjGx7D68wl4yrVrO3H+6Yo2jWyLdlf+nWqxr59t9WBsKR0T12XbSBl2EwXg
        4bDLNlJqs7ovXhFl5zi2f+99hAdrw5Df/qD6RO1NC74Gx50fXhruuuecqUFSM3zs
        I/rogeiTkjv08ZUfku1DLjzW2dVPSkiQkecho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JLfl8Kc2d94wdmdesoIINit32adJPBej
        GtA9W9bJlum8MDaKJqyy3LNPoycfDs0/hnH63c9HVgrg0jjBpNTcmKwchAWkOKPE
        oRHvZg7ry1Vv3S4bUUp45hcf3WZC8/Qr5Yq/iQvKdwqZkR6mkQH3ZJl9XOK1jSF9
        Hny25Lm1Dzo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 311049F55E;
        Fri, 25 Aug 2017 13:18:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 939119F55C;
        Fri, 25 Aug 2017 13:18:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage_with_options: omit double new line on empty option list
References: <20170825164837.30118-1-sbeller@google.com>
Date:   Fri, 25 Aug 2017 10:18:18 -0700
In-Reply-To: <20170825164837.30118-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 25 Aug 2017 09:48:37 -0700")
Message-ID: <xmqq7exrtvl1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63E7F07E-89B9-11E7-A7EB-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Currently the worktree command gives its usage, when no subcommand is
> given. However there are no general options, all options are related to
> the subcommands itself, such that:
>
>     $ git worktree
>     usage: git worktree add [<options>] <path> [<branch>]
>        or: git worktree list [<options>]
>        or: git worktree lock [<options>] <path>
>        or: git worktree prune [<options>]
>        or: git worktree unlock <path>
>
>
>     $
>
> Note the two empty lines at the end of the usage string. This is because
> the toplevel usage is printed with an empty options list.
>
> Only print one new line after the usage string if the option list is empty.

Good find.  Shouldn't the last word in the sentence "non-empty", though?

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 0dd9fc6a0d..1307c82861 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -603,7 +603,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
>  		usagestr++;
>  	}
>  
> -	if (opts->type != OPTION_GROUP)
> +	if (opts->type != OPTION_GROUP && opts->type != OPTION_END)
>  		fputc('\n', outfile);
>  
>  	for (; opts->type != OPTION_END; opts++) {
