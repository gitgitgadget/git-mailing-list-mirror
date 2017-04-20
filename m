Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2608207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 06:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941646AbdDTGaS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 02:30:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61758 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941111AbdDTGaR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 02:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C78826F7FB;
        Thu, 20 Apr 2017 02:30:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a2XQQBGkYJPIzmD43Nzc0FrjoNs=; b=GOntmk
        JOja+aKjeTRHnrEQrGJtI6+HoN3e0kL12uQjijeOKzulLuqtw1h7XzidLnSNi1/+
        yxgpFk4lxo9inqr421lNUPiZXwpBnbFiMh2xrHYHqDXGiV4CBZQqXH91kGtpyts6
        D6+b7WCJazGkEol9o/I5y6cG/x05MDSXT3UTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nZbvWYhrnQfJJTGAMCy69GIAuIGcgLP8
        4/mnACRtkjbgqDmm9/ZpnuSycKMP06rK06Mu9FqsWgOqsTic9JtqCSJkdjnM/KuK
        Vs9+3HEmIfVFkLQFIc3LIIo9lytPMNEhBl3m4HXnAGXCJnL2FD2+Nh7DqqMK/rJG
        mTtolqb2mQ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0CE96F7F9;
        Thu, 20 Apr 2017 02:30:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BD8B6F7F8;
        Thu, 20 Apr 2017 02:30:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Kent <smkent@smkent.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add color slots for branch names in "git status --short --branch"
References: <201704556286334.8b7dc718029e6dd189dadb3703bfa@localhost>
Date:   Wed, 19 Apr 2017 23:30:14 -0700
In-Reply-To: <201704556286334.8b7dc718029e6dd189dadb3703bfa@localhost>
        (Stephen Kent's message of "Wed, 19 Apr 2017 22:57:08 -0700")
Message-ID: <xmqqzifb8ubt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D084FEEC-2592-11E7-9829-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Kent <smkent@smkent.net> writes:

> Subject: Re: [PATCH] Add color slots for branch names in "git status --short --branch"

We spell one-liner title of our commits as "<area>: <summary>"
typically.  In this case, this is about the output from the status
command, so

	status: make the color used "--shrot --branch" output configurable

or something, perhaps?

> Signed-off-by: Stephen Kent <smkent@smkent.net>
> ---
>  Documentation/config.txt               | 5 ++++-
>  builtin/commit.c                       | 4 ++++
>  contrib/completion/git-completion.bash | 2 ++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874..96e9cf8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1137,7 +1137,10 @@ color.status.<slot>::
>  	`untracked` (files which are not tracked by Git),
>  	`branch` (the current branch),
>  	`nobranch` (the color the 'no branch' warning is shown in, defaulting
> -	to red), or
> +	to red),
> +	`localBranch` or `remoteBranch` (the local and remote branch names,
> +	respectively, when branch and tracking information is displayed in the
> +	status short-format), or
>  	`unmerged` (files which have unmerged changes).

OK.

>  color.ui::
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 4e288bc..43846d5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1263,6 +1263,10 @@ static int parse_status_slot(const char *slot)
>  		return WT_STATUS_NOBRANCH;
>  	if (!strcasecmp(slot, "unmerged"))
>  		return WT_STATUS_UNMERGED;
> +	if (!strcasecmp(slot, "localBranch"))
> +		return WT_STATUS_LOCAL_BRANCH;
> +	if (!strcasecmp(slot, "remoteBranch"))
> +		return WT_STATUS_REMOTE_BRANCH;
>  	return -1;
>  }

OK.

I know we do not test color.status.<slot> at all (other than t4026
that makes sure a configuration from future version of Git that
specifies a slot that is not yet known to our version of Git is
safely ignored without triggering an error), but perhaps we would
want a new test or two at the end of t7508?

Thanks.
