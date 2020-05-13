Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A3DC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBED205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 20:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bRIpCCcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEMUnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 16:43:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65055 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgEMUnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 16:43:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 469D3550A5;
        Wed, 13 May 2020 16:43:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OmgguVIf9ffHqn0Ucpm5ruGfRJU=; b=bRIpCC
        cJEciECWS57e6OX9HHT5/WQq0+ZdUNgy6aBTkT9i/nN0/izb+Q2AwETy2f+q+Reg
        lbuJO5/aHjpvFgXF8dcirVjLT33haCV4m45Qvd3b9o4/GsgyDr0As6hTABXvdAoL
        RIzp998VMmi6GwXS89Kb6RH6JSadnYFQ8k9rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pnfFwoFK3ZTndj2e/uULxjt8XJHV5nm2
        bgd8EqyvTV1LYOljkWM59AiZLeOVW5Q4hflHZZ9352mUArOiRI/LioCALB6pQK4f
        oWTntOlIvr43F8BUYskyrAy4Q4wBIxSsQHWJnQ/IbXP14Sw+AODcJSxgTz0kzmYW
        6OItnKzA7ZI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E62C550A4;
        Wed, 13 May 2020 16:43:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B70A0550A3;
        Wed, 13 May 2020 16:43:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org, jrn@google.com
Subject: Re: [PATCH] fetch: allow adding a filter after initial clone.
References: <20200513200040.68968-1-delphij@google.com>
Date:   Wed, 13 May 2020 13:43:14 -0700
In-Reply-To: <20200513200040.68968-1-delphij@google.com> (Xin Li's message of
        "Wed, 13 May 2020 13:00:40 -0700")
Message-ID: <xmqqo8qrsh0d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC31574-955A-11EA-848A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Xin Li <delphij@google.com> writes:

(nothnig).

Can you help readers by describing what this change is about?

This space is reserved for the patch author to describe why this
change is a good idea (if this patch is adding a new feature), what
is already broken without this patch (if this patch is a bugfix),
and why this change is a safe thing to do (if this patch lifts a
limitation we had before that has been protecting us from getting
into a bad state).


> Signed-off-by: Xin Li <delphij@google.com>
> ---
>  builtin/fetch.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 3ae52c015d..e5faa17ecd 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1790,8 +1790,16 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (depth || deepen_since || deepen_not.nr)
>  		deepen = 1;
>  
> -	if (filter_options.choice && !has_promisor_remote())
> -		die("--filter can only be used when extensions.partialClone is set");
> +	if (filter_options.choice && !has_promisor_remote()) {
> +		char repo_version_string[10];
> +
> +		xsnprintf(repo_version_string, sizeof(repo_version_string),
> +			  "%d", (int)GIT_REPO_VERSION);
> +		git_config_set("core.repositoryformatversion",
> +			repo_version_string);
> +		git_config_set("extensions.partialclone", "origin");
> +		promisor_remote_reinit();
> +	}
>  
>  	if (all) {
>  		if (argc == 1)
