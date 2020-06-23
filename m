Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667A6C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420BE20774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfYUThe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgFWM7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWM7g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:59:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7CC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:59:36 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j189so18698379oih.10
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WgZb+GJXfPeym66DiEwbUjuj6x09M1v88lkGG0ajy9g=;
        b=GfYUThe8SIhFg7GqTKoxuRfmclliRPynN8TkVlbmPlm1++++MD1iFTbJS5N7GkKcG0
         BiYPut0dQKbChQe3KrnG+qEdUWVDE3q11fIngjAxTmU7Y+aFaaI1hRfXIur9KeHy5XoO
         7rrrSHLbOpAEyV3S9/ap796hHoA6/MVYmiqLqWcGe69a6J0ccuM0K+7In5y/vVmlUDcR
         XQPfjvyw9zAl/92U941APmGwRFNj8TdQxgmann72LOt8cso2j/xYsz/cSpZYO5Y2driG
         Ljn3HvUoqqdp94wZFxkX9IPUYEFM4rgbjlJ+P9mFPPNQ9REPGKoPVglZFO7nuxy5oE09
         lfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WgZb+GJXfPeym66DiEwbUjuj6x09M1v88lkGG0ajy9g=;
        b=LtnmOZnd4GLx2Or94ba4PEDykkqlm7Vq2c65r8C97Pnyfo2DtU81G1B4SO/t0ftrsF
         pFg8VWPIRQ0ol4uEV97sIiPd8ucK2xcQgaBZScRKZIcBpybe6uiGFFwzhwvr/Hv+pUfo
         5OgSqk+ArYNtGjEF7TL9AjCyjl6Ue40zwreKmLhwZ8C+JcqwP0UbdFZPNm7cJae1fj5g
         b6aPzjVbolbh9e/xLbU/72RCszPbVI8WZt97+XaGTI4Fjx3Agz2X0/YgdiJ6NVG2G87s
         56Xd8haTvuedcuc5NW5c0UDRd/natNGIgKPuuUOXxPRdvNdiiRZS+yXQhj5IeXc4pknl
         yl1A==
X-Gm-Message-State: AOAM530A44y6LpAXdm1fBxH1cZLjMY9V9NyjBGFPyMg37o7WQJywP76p
        U8WrMt7BMS7OsUMm+dbvLcU=
X-Google-Smtp-Source: ABdhPJz69j8I5TdRDL9w/CS+YUciGJvYsLmNUVHbT4bHdzOQKuo0Xi4F+bkBfMMfsQ7UwNxYP2D+rg==
X-Received: by 2002:aca:902:: with SMTP id 2mr15409981oij.151.1592917175468;
        Tue, 23 Jun 2020 05:59:35 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w10sm4033624otp.44.2020.06.23.05.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 05:59:34 -0700 (PDT)
Subject: Re: [PATCH] commit-reach: avoid is_dependant_of() shim
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     dstolee@microsoft.com
References: <20200623081701.52607-1-carenas@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4cf84b43-0837-5737-f937-fad9ca13178b@gmail.com>
Date:   Tue, 23 Jun 2020 08:59:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200623081701.52607-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2020 4:17 AM, Carlo Marcelo Arenas Belón wrote:
> d91d6fbf26 (commit-reach: create repo_is_descendant_of(), 2020-06-17)
> adds a repository aware version of is_dependant_of() and a backward
> compatibility shim that is barelly used.> 
> Update all callers to directly use the new repo_is_dependant_of()
> function instead.

In your commit message:

s/dependant/descendant/
s/barelly/barely/

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  builtin/pull.c        |  3 ++-
>  commit-reach.c        | 16 ++++++----------
>  commit-reach.h        |  4 +++-
>  t/helper/test-reach.c |  2 +-
>  4 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 8e6572d305..babc6a4e36 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1025,7 +1025,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  			commit_list_insert(head, &list);
>  			merge_head = lookup_commit_reference(the_repository,
>  							     &merge_heads.oid[0]);
> -			if (is_descendant_of(merge_head, list)) {
> +			if (repo_is_descendant_of(the_repository,
> +							merge_head, list)) {

nit: left-align "merge_head" with "the_repository". Should look like this:

+			if (repo_is_descendant_of(the_repository,
+						  merge_head, list)) {

>  				/* we can fast-forward this without invoking rebase */
>  				opt_ff = "--ff-only";
>  				ran_ff = 1;
> diff --git a/commit-reach.c b/commit-reach.c
> index 1761217663..82c73171dd 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -283,9 +283,9 @@ struct commit_list *repo_get_merge_bases(struct repository *r,
>  /*
>   * Is "commit" a descendant of one of the elements on the "with_commit" list?
>   */
> -static int repo_is_descendant_of(struct repository *r,
> -				 struct commit *commit,
> -				 struct commit_list *with_commit)
> +int repo_is_descendant_of(struct repository *r,
> +			  struct commit *commit,
> +			  struct commit_list *with_commit)
>  {
>  	if (!with_commit)
>  		return 1;
> @@ -310,11 +310,6 @@ static int repo_is_descendant_of(struct repository *r,
>  	}
>  }
>  
> -int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
> -{
> -	return repo_is_descendant_of(the_repository, commit, with_commit);
> -}
> -
>  /*
>   * Is "commit" an ancestor of one of the "references"?
>   */
> @@ -433,7 +428,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
>  		return 0;
>  
>  	commit_list_insert(old_commit, &old_commit_list);
> -	ret = is_descendant_of(new_commit, old_commit_list);
> +	ret = repo_is_descendant_of(the_repository,
> +					new_commit, old_commit_list);

nit: align the whitespace so "new_commit" is left-aligned with the start
of "the_repository" in the line above. It should look like this:

+	ret = repo_is_descendant_of(the_repository,
+				    new_commit, old_commit_list);

>  	free_commit_list(old_commit_list);
>  	return ret;
>  }
> @@ -554,7 +550,7 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>  {
>  	if (filter->with_commit_tag_algo)
>  		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
> -	return is_descendant_of(commit, list);
> +	return repo_is_descendant_of(the_repository, commit, list);
>  }
>  
>  static int compare_commits_by_gen(const void *_a, const void *_b)
> diff --git a/commit-reach.h b/commit-reach.h
> index 99a43e8b64..b49ad71a31 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -27,7 +27,9 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
>  
>  struct commit_list *get_octopus_merge_bases(struct commit_list *in);
>  
> -int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
> +int repo_is_descendant_of(struct repository *r,
> +			  struct commit *commit,
> +			  struct commit_list *with_commit);
>  int repo_in_merge_bases(struct repository *r,
>  			struct commit *commit,
>  			struct commit *reference);
> diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
> index a0272178b7..1d640f4757 100644
> --- a/t/helper/test-reach.c
> +++ b/t/helper/test-reach.c
> @@ -108,7 +108,7 @@ int cmd__reach(int ac, const char **av)
>  	else if (!strcmp(av[1], "in_merge_bases"))
>  		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
>  	else if (!strcmp(av[1], "is_descendant_of"))
> -		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
> +		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));

This is the most subtle of the changes, but it is done correctly.

This is a worthwhile patch. Some of the callers _look_ more complicated,
but overall this simplifies the codebase. Further: it pushes more
the_repository references higher up the stack.

Thanks,
-Stolee

