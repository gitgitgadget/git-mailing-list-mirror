Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DB71FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 21:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbcKUVBm (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 16:01:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51910 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753978AbcKUVBl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 16:01:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C16C52BD4;
        Mon, 21 Nov 2016 16:01:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RWAYZd3kBP9uAD6A292KU7ycBrw=; b=QtmG0E
        au30cCyP68NcVpMrEpLENO2Ipi4Jcr30R+DNZThkLcGL/OY6weyibR0cPsJctI73
        cHWSt3PpgxTdmTtqU8PI1SNKmUuVfwOAgEu2SUM9B5jTuaBwUp24eNG9lLT/shiK
        2zxko/S6tW0hjW+dTry4qgG+XUxgVyp5ikh8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qb7D+SVi9Jnl5VWXcOhJktAPfXASxdkp
        nP3mC+GfmqX/wXR/QfGEVLKlLOc0an1plK1f5qDMxdKHpXq/D6+JNJ9YJ4QfJ89T
        kYOfC5N26v5FyiXn3FZKqIeTKY614cfe5+EYZiUxQw8esVSQGuzKencpu7AYFVu5
        ILK8avHnwBM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22F7B52BD2;
        Mon, 21 Nov 2016 16:01:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DE8852BCE;
        Mon, 21 Nov 2016 16:01:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, jrnieder@gmail.com, git@vger.kernel.org,
        Jens.Lehmann@web.de, hvoigt@hvoigt.net
Subject: Re: [PATCH 1/3] submodule: use absolute path for computing relative path connecting
References: <20161121204146.13665-1-sbeller@google.com>
        <20161121204146.13665-2-sbeller@google.com>
Date:   Mon, 21 Nov 2016 13:01:38 -0800
In-Reply-To: <20161121204146.13665-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 21 Nov 2016 12:41:44 -0800")
Message-ID: <xmqq8tscim31.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2698EDA-B02D-11E6-8BE0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Subject: Re: [PATCH 1/3] submodule: use absolute path for computing relative path connecting

connecting what?  IOW, has the subject line somehow truncated?

> This addresses a similar concern as in f8eaa0ba98b (submodule--helper,
> module_clone: always operate on absolute paths, 2016-03-31)
>
> When computing the relative path from one to another location, we
> need to provide both locations as absolute paths to make sure the
> computation of the relative path is correct.

Can the effect of this change demonstrated in a new test?  There
must be a scenario where the current behaviour is broken and this
change fixes an incorrect computation of relative path, no?

>
> While at it, change `real_work_tree` to be non const as we own
> the memory.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

>  submodule.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6f7d883de9..66c5ce5a24 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>  {
>  	struct strbuf file_name = STRBUF_INIT;
>  	struct strbuf rel_path = STRBUF_INIT;
> -	const char *real_work_tree = xstrdup(real_path(work_tree));
> +	char *real_git_dir = xstrdup(real_path(git_dir));
> +	char *real_work_tree = xstrdup(real_path(work_tree));
>  
>  	/* Update gitfile */
>  	strbuf_addf(&file_name, "%s/.git", work_tree);
>  	write_file(file_name.buf, "gitdir: %s",
> -		   relative_path(git_dir, real_work_tree, &rel_path));
> +		   relative_path(real_git_dir, real_work_tree, &rel_path));
>  
>  	/* Update core.worktree setting */
>  	strbuf_reset(&file_name);
> -	strbuf_addf(&file_name, "%s/config", git_dir);
> +	strbuf_addf(&file_name, "%s/config", real_git_dir);
>  	git_config_set_in_file(file_name.buf, "core.worktree",
> -			       relative_path(real_work_tree, git_dir,
> +			       relative_path(real_work_tree, real_git_dir,
>  					     &rel_path));
>  
>  	strbuf_release(&file_name);
>  	strbuf_release(&rel_path);
> -	free((void *)real_work_tree);
> +	free(real_work_tree);
> +	free(real_git_dir);
>  }
>  
>  int parallel_submodules(void)
