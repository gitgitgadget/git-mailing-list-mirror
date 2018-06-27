Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C1C1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965690AbeF0T5O (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 15:57:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37946 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964784AbeF0T5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 15:57:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so6663443wmf.3
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EP9ExSofoVK2FDkpNUfAxikmq5eQY6qQuTqZ3fzi1G4=;
        b=qsIW4tPr/aYqRY7LMj1txO1LFfB4QQGIUl4cIMONgEQsq4k9JJmdReuktxCz/RBmN4
         QQZFqbQ3YxZXMxq+5X1oWmRClJdnyM9KQb2ld1d0jFjeJDodR7eknfRoMm/IS7pRXIS0
         pLOZZSf+sw56JinYSfNZO549+AxtdOclPUwsQy9gN7z4POmMCYb3BKkdNdVN9SCbxZ8+
         6NWRi1zzBiEikiq6Er4kFXA0BjnxBZYp9o9ElcOQIXR6wN/d2IRopi2tYt9Zr11dMQR4
         ig4mfXSmppdZfRgczgW+CalgxJdV7Qj1GdSbEQ85WP8J4/dy58UhBPxmElCQLwtkajn+
         BF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EP9ExSofoVK2FDkpNUfAxikmq5eQY6qQuTqZ3fzi1G4=;
        b=Y3bZIAYi0wuz2rz+G3mdZm1q+uJyAt2EjR4HJ6J6BtX3BG9hnf/q3SKVK8qZ7dTEr6
         ftbgfVS4jQyLnhcOyfYbtomw+DIM9dVfRIp2ggeP6XFxQyDjdm/yeDXm3mqT+btgwgtx
         qMVGL8AWQVA952lXXRFAme1+z6bYswf8oLekxYQ9F/7ZM8ZcQSprgz7WV7INWc8zLNTz
         HXOR68CaeFPoehOjZ5zncGt2ovWko2qu0Kx/Y0dL54M/D9SgcY4aXgzyX1jiv4qVLQXg
         JD7ycVcOUUuOoCCL6F9xQTNC86I1Q6sA/l887w9cfLcA6FFKtipphwOLaYdXFzfFLhTl
         PU0g==
X-Gm-Message-State: APt69E3HCbN3hFSGyRojlo5UX1gHiig9jSKxEmQXPD/UxGSDRyUc7J+6
        lqqP1QhBNFcuIP4Rru8csqs=
X-Google-Smtp-Source: AAOMgpecQ/G3Tlz4HQSAUHACAgUmg2yK6ucCbcbQz8CojHIELda8sLYHNX4x9mQ3y9Imdj7T7mvJIw==
X-Received: by 2002:a1c:bc3:: with SMTP id 186-v6mr6479018wml.39.1530129431997;
        Wed, 27 Jun 2018 12:57:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d10-v6sm8177237wrj.38.2018.06.27.12.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 12:57:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: when deepening, check connectivity fully
References: <20180627173237.25620-1-jonathantanmy@google.com>
Date:   Wed, 27 Jun 2018 12:57:09 -0700
In-Reply-To: <20180627173237.25620-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 27 Jun 2018 10:32:37 -0700")
Message-ID: <xmqqin64dmui.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Do not stop at ancestors of our refs when deepening during fetching.
> This is because when performing such a fetch, shallow entries may have
> been updated; the client can reasonably assume that the existing refs
> are connected up to the old shallow points, but not the new.

OK.

> diff --git a/connected.c b/connected.c
> index 91feb78815..1bba888eff 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -58,8 +58,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  	argv_array_push(&rev_list.args, "--stdin");
>  	if (repository_format_partial_clone)
>  		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
> -	argv_array_push(&rev_list.args, "--not");
> -	argv_array_push(&rev_list.args, "--all");
> +	if (!opt->is_deepening_fetch) {
> +		argv_array_push(&rev_list.args, "--not");
> +		argv_array_push(&rev_list.args, "--all");
> +	}
>  	argv_array_push(&rev_list.args, "--quiet");
>  	if (opt->progress)
>  		argv_array_pushf(&rev_list.args, "--progress=%s",

Hmph, remind me how old and/or new shallow cut-off points affect
this traversal?  In order to verify that everything above the new
cut-off points, opt->shallow_file should be pointing at the new
cut-off points, then we do the full sweep (without --not --all) to
ensure we won't find missing or broken objects but still stop at the
new cut-off points, and then only after check_connected() passes,
update the shallow file to make new shallow cut-off points active
(and if the traversal fails, then we do nto install the new shallow
cut-off points)?

If so, that sounds sensible.  By not having "--not --all", we
potentially would do a full sweep, but if we are really deepening to
the root commits, then we do need one full sweep anyway (as these
deepest parts of the history were previously hidden by the shallow
cutoff points), and if we are only deepening the history by a bit,
even if we do not have "--not --all", we would hit the updated
shallow cutoff points (which may be at older parts of the history)
and stop, and for correctness we need to visit there anyway, so I
think we are not being overly pessimistic with this change, either.

