Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA43C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FA620738
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YZCwzHAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGGPJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:09:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55909 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgGGPJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 11:09:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB3CA773BC;
        Tue,  7 Jul 2020 11:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c7K5nIqik34dLClR6NBWZR23Kso=; b=YZCwzH
        ApQJDnq/OhjxFUK82iQpvplIq8ylRVWcXcv5FUvbEKlqvpwbGi6NKBgiuebvVD4B
        VqxqDK89yYPzlYhONnctPoneR2G7B93AvaQu/v8PXMl4tgympbU4NVZHa0g9frHC
        o7OZmf18N0oJnFwhOL7mO8hwJpQoNK/J+4YFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FirU/jZ8gzxGyUXGlCFDi0aK/jcWZK/O
        WInu2jg2moiF2DI+vVt260hDujfNqaxz4DGpAzUiZqeuasLcUVbDD2vqKWUolfAA
        S0hBcB/uMaXQ4cpUD0FNurmW3xlsUj8+Wvhb/xQeh9+7F3NY+W+uXY2IFl2T/Loc
        o1zQoTYD8yk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFBFA773BA;
        Tue,  7 Jul 2020 11:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49518773B9;
        Tue,  7 Jul 2020 11:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] experimental: default to fetch.writeCommitGraph=false
References: <20200707062039.GC784740@google.com>
Date:   Tue, 07 Jul 2020 08:09:36 -0700
In-Reply-To: <20200707062039.GC784740@google.com> (Jonathan Nieder's message
        of "Mon, 6 Jul 2020 23:20:39 -0700")
Message-ID: <xmqq8sfv745r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF8F2588-C063-11EA-BEC5-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The fetch.writeCommitGraph feature makes fetches write out a commit

> In other words:
>
> - this patch only affects behavior with feature.experimental=true
>
> - it makes feature.experimental match the configuration Google has
>   been using for the last few months, meaning it would leave users in
>   a better tested state than without it
>
> - this should improve testing for other features guarded by
>   feature.experimental, by making feature.experimental safer to use


In other words, fetch.writeCommitGraph in its current form is too
broken to be recommended even for brave souls with "experimental"
bit on.

I wonder if we perhaps wnat to add to the documentation for
writeCommitGraph configuration that its use is currently not
recommended in a shallow clone or something (I know it is not
a problem just to use it with shallow but the breakage needs
to involve unshallowing, but by definition those who do not
use shallow would not hit the unshallowing bug, so...).

> Reported-by: Jay Conrod <jayconrod@google.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> I realize this is late to send.  That said, as described above, I
> think it's a good way to buy time by minimizing user exposure to
> fetch.writeCommitGraph=true until a fix for it is well cooked.
>
> In other words, I'd like to see this patch in Git 2.28-rc0.

Yes, I do, too.

Thanks.

> diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
> index b1a9b1461d3..b20394038d1 100644
> --- a/Documentation/config/fetch.txt
> +++ b/Documentation/config/fetch.txt
> @@ -90,5 +90,4 @@ fetch.writeCommitGraph::
>  	the existing commit-graph file(s). Occasionally, these files will
>  	merge and the write may take longer. Having an updated commit-graph
>  	file helps performance of many Git commands, including `git merge-base`,
> -	`git push -f`, and `git log --graph`. Defaults to false, unless
> -	`feature.experimental` is true.
> +	`git push -f`, and `git log --graph`. Defaults to false.
> diff --git a/repo-settings.c b/repo-settings.c
> index dc6817daa95..0918408b344 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -51,14 +51,14 @@ void prepare_repo_settings(struct repository *r)
>  		UPDATE_DEFAULT_BOOL(r->settings.index_version, 4);
>  		UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_WRITE);
>  	}
> +
>  	if (!repo_config_get_bool(r, "fetch.writecommitgraph", &value))
>  		r->settings.fetch_write_commit_graph = value;
> -	if (!repo_config_get_bool(r, "feature.experimental", &value) && value) {
> -		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
> -		UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 1);
> -	}
>  	UPDATE_DEFAULT_BOOL(r->settings.fetch_write_commit_graph, 0);
>  
> +	if (!repo_config_get_bool(r, "feature.experimental", &value) && value)
> +		UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_SKIPPING);
> +
>  	/* Hack for test programs like test-dump-untracked-cache */
>  	if (ignore_untracked_cache_config)
>  		r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
