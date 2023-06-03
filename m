Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF764C7EE29
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 00:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjFCABA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 20:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjFCAA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 20:00:59 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA611A6
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 17:00:56 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6af6f49e41cso2465499a34.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685750456; x=1688342456;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m8qnbm9NFirggkbEc4Xg0vuVaDCcQBT/C24wE1C5zY=;
        b=pTS284OwMwqKd9ZlSlNR3MtuN00umHZ9edwScfLA/NTiSArGKlnOM5EHUYrLZ+WdfT
         O2VVjVCCnGxHMfkDKAj8lcV95zw2N+3dZLFl32vP/MQNtJPM5FOQfLrkK3smgWoD4MXd
         sZPy4UdjUizrAONhGHdOMMTShsafKZR7ahNbcEkSeoqF4pfjY3i4NTDRvRq0bjEuhScE
         fzyKUbM6xx5Na1HETA8rgzGVscJ4vGkz0MCcXgVsjQllvNbgzP44WCvJa0jwxt6i9VB/
         ikuT25HdxvVxKt9cxnSUL3VqHGH2N6qR9gdPFENrO+D/IoFkBJ73ihItlsPWhKZBoZm+
         7IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685750456; x=1688342456;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8m8qnbm9NFirggkbEc4Xg0vuVaDCcQBT/C24wE1C5zY=;
        b=IjuOsDDgb5xf9Q9BOCX36IPQvsXUMM9LErD1b5rS2vaCrinC/6iS0Yzxie5GecpnuL
         P1AJODl01fPz6tGkfpykG0P0GG807Wv+yXYw3epjx2Jo1PQ9IRwLUGonxV97zUBVECf2
         D/ZWy8kYbI/iIyW4OwODlnuV8HHXC4ehmWzswovmKMus1lHn3IfT3e5F1NUNysD2DaxI
         Vkhk0t1obXna9p3c95FAAXI597rSVqzOx7PzVT6E3fG0Ca4jxnZEKSpm6H2L/okvKlCo
         y1Qk9faLrzsDimjLrY6TnYlwliqPfRkJIIKSqXDZIjGeIw5XleWx3KL2xQqRQt2YejAa
         BzxA==
X-Gm-Message-State: AC+VfDwsJdooedwg1DlExOrwPOYF1/Oa5AI4wQcpHXvulaBGDffH4LK8
        g500ZTjHEek22EUKpKGFBjY=
X-Google-Smtp-Source: ACHHUZ6gF7GVPgEBidEQGNslV8cmalnwNcVD0HHm3BIQSfO5/U965VrKf1Cbo4YC/el16hs0As5GzQ==
X-Received: by 2002:a9d:5a1a:0:b0:6b0:cde0:d9b with SMTP id v26-20020a9d5a1a000000b006b0cde00d9bmr3809918oth.2.1685750455823;
        Fri, 02 Jun 2023 17:00:55 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b00646ebc77b1fsm1483557pfo.75.2023.06.02.17.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 17:00:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/1] surround %s with quotes when failed to lookup
 commit
References: <cover.1685366301.git.dyroneteng@gmail.com>
        <1f7c62a8870433792076fae30d6c4dc4b61a00d8.1685366301.git.dyroneteng@gmail.com>
Date:   Sat, 03 Jun 2023 09:00:55 +0900
In-Reply-To: <1f7c62a8870433792076fae30d6c4dc4b61a00d8.1685366301.git.dyroneteng@gmail.com>
        (Teng Long's message of "Mon, 29 May 2023 21:27:56 +0800")
Message-ID: <xmqqsfb98le0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> The output maybe become confused to recognize if the user

Probably "may become confusing to".

> accidentally mistook an extra opening space, like:
>
>    $git commit --fixup=" 6d6360b67e99c2fd82d64619c971fdede98ee74b"
>    fatal: could not lookup commit  6d6360b67e99c2fd82d64619c971fdede98ee74b

I'd prefer a space between the prompt "$" and the command "git".

>
> and it will be better if we surround the %s specifier with single quotes.

Indeed.  Everything else in the message I am responding to, I am
100% happy with.

Will queue with manual fixups.

Thanks.

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/commit.c     | 6 +++---
>  builtin/merge-tree.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e67c4be2..9ab57ea1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -763,7 +763,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			struct commit *c;
>  			c = lookup_commit_reference_by_name(squash_message);
>  			if (!c)
> -				die(_("could not lookup commit %s"), squash_message);
> +				die(_("could not lookup commit '%s'"), squash_message);
>  			ctx.output_encoding = get_commit_output_encoding();
>  			repo_format_commit_message(the_repository, c,
>  						   "squash! %s\n\n", &sb,
> @@ -798,7 +798,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		char *fmt;
>  		commit = lookup_commit_reference_by_name(fixup_commit);
>  		if (!commit)
> -			die(_("could not lookup commit %s"), fixup_commit);
> +			die(_("could not lookup commit '%s'"), fixup_commit);
>  		ctx.output_encoding = get_commit_output_encoding();
>  		fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
>  		repo_format_commit_message(the_repository, commit, fmt, &sb,
> @@ -1189,7 +1189,7 @@ static const char *read_commit_message(const char *name)
>  
>  	commit = lookup_commit_reference_by_name(name);
>  	if (!commit)
> -		die(_("could not lookup commit %s"), name);
> +		die(_("could not lookup commit '%s'"), name);
>  	out_enc = get_commit_output_encoding();
>  	return repo_logmsg_reencode(the_repository, commit, NULL, out_enc);
>  }
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index b8f8a8b5..4325897a 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -448,7 +448,7 @@ static int real_merge(struct merge_tree_options *o,
>  
>  		base_commit = lookup_commit_reference_by_name(merge_base);
>  		if (!base_commit)
> -			die(_("could not lookup commit %s"), merge_base);
> +			die(_("could not lookup commit '%s'"), merge_base);
>  
>  		opt.ancestor = merge_base;
>  		base_tree = repo_get_commit_tree(the_repository, base_commit);
