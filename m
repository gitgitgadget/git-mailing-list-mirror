Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297C4C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 19:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJMT2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 15:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJMT2u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 15:28:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6F3169CE7
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:28:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g27so3973508edf.11
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 12:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQydvWGYhKfFRZ5rWYWBg22rvcr/yrNSuYzouIKhwSs=;
        b=fHCyNyqziQuf0NfEy2r3IJ20EC+IcH5xiN1R5vgi8xK5Vc6fFhFDZgQv5t5K2BDOw7
         U/SxPjxZVf7U4Cwb54luu1cQqwdnsY88ia5VofVEuV7sPR/WNINK4dfFn4gYRHgjcrYu
         x2Lbw4EAr+NhxBeaqCWYXo28CAYxPrso+GJ6hNeGBae61n70ONtZswaXB4BGUokXCT7n
         Niq7VU2rX5RPNqjy1bqkFPCa2rxky4Lx8g0PKdJshmLEPCWEfbFzw5d+I6vu7VrMa355
         1M/azObiSFvS4UIaCDkWeUovhOPRVoFzJtG+oezPL2t9HccBU93wJbwcNGITEhZaCruU
         Sl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQydvWGYhKfFRZ5rWYWBg22rvcr/yrNSuYzouIKhwSs=;
        b=rrIffsFbDpvzCXDWLF6TPtTtIWLS+i9aio+v4iYWm9ZRi5qnKHEMH2kHJ18dybFb6v
         Es0jm0sMnJ10luvGvFx5oQXfRJrCqRo6W0PrNkYyLyZahvRN63lGuTbK9fiOhOiP3RvB
         ZEPx1YUKKe5CikwyvMuJvh8pkVp5DBm9wzo94ovOrEi/J5O5YvLkAr2+KgBv7mk/et8f
         2eY2HjDBKHuNrWkWOOs2Eoo48qF8wA4i64SRrtLdWH1mNH2yVKpf6dZKUqw+kRUFckht
         RvEfE1PoXvNGrPhDWdLsWlaPLLkDogTARUfHwog5HGzqPMfstiqPsVjtXNqn1y7J7Z6C
         Z8Jw==
X-Gm-Message-State: ACrzQf186mrDVVN1wjeWeD9rnBYjFRrku4o8cs+dJY7UUxO1swQOO0WP
        RsoIfLvXeh3CXvWkJGHo6fmuwLmg6Jdltw==
X-Google-Smtp-Source: AMsMyM5sP7zn8w3Ejui2jenQvvTWmdsHVqwKpDZvX26Hjq7KCCFH023GDrDNFXn45MjZ6LPOhF3Nhw==
X-Received: by 2002:a05:6402:164c:b0:459:1e2e:e742 with SMTP id s12-20020a056402164c00b004591e2ee742mr1110950edx.125.1665689327539;
        Thu, 13 Oct 2022 12:28:47 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b007415f8ffcbbsm305498ejz.98.2022.10.13.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 12:28:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oj3sr-004wLZ-1q;
        Thu, 13 Oct 2022 21:28:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 6/8] rebase: factor out branch_base calculation
Date:   Thu, 13 Oct 2022 21:21:09 +0200
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
 <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
 <2efbfc94187d9f0968e5b670c9152651cd8f1a5b.1665650564.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2efbfc94187d9f0968e5b670c9152651cd8f1a5b.1665650564.git.gitgitgadget@gmail.com>
Message-ID: <221013.867d13ldzm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Separate out calculating the merge base between 'onto' and 'HEAD' from
> the check for whether we can fast-forward or not. This means we can skip
> the fast-forward checks when the rebase is forced and avoid calculating
> the merge-base between 'HEAD' and 'onto' when --keep-base is given.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index cbafcc41e75..40619a0fb2d 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
>  	struct commit_list *merge_bases = NULL;
>  	int res = 0;
>  
> -	merge_bases = get_merge_bases(onto, head);
> -	if (!merge_bases || merge_bases->next) {
> -		oidcpy(branch_base, null_oid());
> -		goto done;
> -	}
> +	if (is_null_oid(branch_base))
> +		goto done; /* fill_branch_base() found multiple merge bases */
>  
> -	oidcpy(branch_base, &merge_bases->item->object.oid);
>  	if (!oideq(branch_base, &onto->object.oid))
>  		goto done;
>  
> @@ -887,7 +883,6 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
>  	if (!upstream)
>  		goto done;
>  
> -	free_commit_list(merge_bases);
>  	merge_bases = get_merge_bases(upstream, head);
>  	if (!merge_bases || merge_bases->next)
>  		goto done;
> @@ -902,6 +897,20 @@ done:
>  	return res && is_linear_history(onto, head);
>  }
>  
> +static void fill_branch_base(struct rebase_options *options,
> +			    struct object_id *branch_base)
> +{
> +	struct commit_list *merge_bases = NULL;
> +
> +	merge_bases = get_merge_bases(options->onto, options->orig_head);
> +	if (!merge_bases || merge_bases->next)
> +		oidcpy(branch_base, null_oid());
> +	else
> +		oidcpy(branch_base, &merge_bases->item->object.oid);
> +
> +	free_commit_list(merge_bases);
> +}

I wondered if this could be a bit shorter/less wrap-y with shorter
variable names, anyway, I see it's code copied from above, so nevermind
in advance... :)
	
	static void fill_branch_base(struct rebase_options *o, struct object_id *dst)
	{
		struct commit_list *mb = get_merge_bases(o->onto, o->orig_head);
		const struct object_id *src = (!mb || mb->next) ? null_oid() :
			&mb->item->object.oid;
	
		oidcpy(dst, src);
		free_commit_list(mb);
	}

	
> @@ -1669,8 +1678,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		if (!options.onto)
>  			die(_("Does not point to a valid commit '%s'"),
>  				options.onto_name);
> +		fill_branch_base(&options, &branch_base);
>  	}
> -
>  	if (options.fork_point > 0)
>  		options.restrict_revision =
>  			get_fork_point(options.upstream_name, options.orig_head);

I wouldn't mind the stray whitespace change, but here it seems
unintentional, in 7/8 your change on top is:
	
	@@ -1680,6 +1691,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
	 				options.onto_name);
	 		fill_branch_base(&options, &branch_base);
	 	}
	+	if (keep_base && options.reapply_cherry_picks)
	+		options.upstream = options.onto;
	+
	 	if (options.fork_point > 0)
	 		options.restrict_revision =
	 			get_fork_point(options.upstream_name, options.orig_head);

Presumably we want to have \n\n spacing for both of those, and to not
remove the spacing here in 6/8, only to add it back?
