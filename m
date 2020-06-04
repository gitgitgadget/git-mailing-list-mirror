Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F372C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 20:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FEA2067B
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 20:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mn/bMHkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgFDUaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:30:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58439 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgFDUaK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 16:30:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9998C2C3B;
        Thu,  4 Jun 2020 16:30:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LV7RtmXWrQEvivJdxw02uNHLF5g=; b=mn/bMH
        khUmnyDsPgeDnqCQhYQt8EvPHc5Dx5ChOD/sukRJRpUGz2Op2zsvVI5h5jR901g9
        i7Kgz5CiaqYltTvxs9edLjBRWC0OCGUeImWSo8aFNE2J3GjZB0KEnDpAYgjacCqE
        3sIz1p+QjKn/SaxV8MgwNt7gb8WP+1Jm4pY2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Aio14dky7VCF9s5g9SITm0xILhuZY8l1
        ObGwG5zEYJntv70urN5wFWN1fBvjAGtRh/U25eSk2rREMTnDiKPeEpN9H1Zzymjc
        eYeXgztsxajAMiMEWXIFjL2hZclEaD3CZnL+7xV8BAnPSS299nhTRD/iXTbnllHe
        I9OqLscd7z8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1B49C2C3A;
        Thu,  4 Jun 2020 16:30:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE467C2C38;
        Thu,  4 Jun 2020 16:30:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] clone/fetch: anonymize URLs in the reflog
References: <pull.797.git.git.1591039202561.gitgitgadget@gmail.com>
        <pull.797.v2.git.git.1591301309308.gitgitgadget@gmail.com>
Date:   Thu, 04 Jun 2020 13:30:03 -0700
In-Reply-To: <pull.797.v2.git.git.1591301309308.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Jun 2020
        20:08:29 +0000")
Message-ID: <xmqqy2p2o9pw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C65279E-A6A2-11EA-9B07-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 1ad26f4d8c8..002d23ab0a2 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -939,7 +939,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  {
>  	int is_bundle = 0, is_local;
>  	const char *repo_name, *repo, *work_tree, *git_dir;
> -	char *path, *dir;
> +	char *path, *dir, *display_repo = NULL;
>  	int dest_exists;
>  	const struct ref *refs, *remote_head;
>  	const struct ref *remote_head_points_at;
> @@ -994,10 +994,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	path = get_repo_path(repo_name, &is_bundle);
>  	if (path)
>  		repo = absolute_pathdup(repo_name);
> -	else if (!strchr(repo_name, ':'))
> -		die(_("repository '%s' does not exist"), repo_name);
> -	else
> +	else if (strchr(repo_name, ':')) {
>  		repo = repo_name;
> +		display_repo = transport_anonymize_url(repo);
> +	} else
> +		die(_("repository '%s' does not exist"), repo_name);
>  
>  	/* no need to be strict, transport_set_option() will validate it again */
>  	if (option_depth && atoi(option_depth) < 1)
> @@ -1014,7 +1015,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		die(_("destination path '%s' already exists and is not "
>  			"an empty directory."), dir);
>  
> -	strbuf_addf(&reflog_msg, "clone: from %s", repo);
> +	strbuf_addf(&reflog_msg, "clone: from %s",
> +		    display_repo ? display_repo : repo);
> +	free(display_repo);

The new patch is easier to see because display_repo becomes non NULL
only when anonymization was necessary and done.  Makes sense.

Will queue.  Thanks.
