Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4698BC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 11:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C582074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 11:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgcHanCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgFJLun (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbgFJLum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 07:50:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C1C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 04:50:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so751187pjb.5
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CY0lOaiNw8/tk6u7TgJirTp3AEZaDyjUdmM+b0qxI3E=;
        b=OgcHanCeNKu0Jo3DzODLHFrJFgFGJ/u8Byn+XsHPmzm5SCGSXiJWQqWYSvP6DWqllu
         UKNLxbCK0r7NmKkVmjAKN+5rq7T26EJoCoGnTVZ2jgJlwrZniMkOI9b9uvByypXV3Y8M
         k/hKgdDBD44V5Szhu7yHrE4DBrDmilA1NWpYRncLw0HIIp90XVomo77s3d7Y6i/YMZp8
         x41ySckfkK0B0PB65BKa2NE4sCHRf3WtMi2KPath0uOQ1bhCbaRIWUeLpX6g/BYvgKGO
         8nisrAZl3gF13+HWGtjSrc+lLkWzMdZDQsz8YTgfh6TOauePoRPEZ/y6dTIa6u3htlxP
         s9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CY0lOaiNw8/tk6u7TgJirTp3AEZaDyjUdmM+b0qxI3E=;
        b=P8QTorjFfe49PMY0Y0zJBmSaz5aiA2WIcz+AzpdO0HKTyZtGShJg8XpwZWeqKo4Fnj
         LclSm0cTQ2qkBreUs+W5+dfXlgqX9mMuC2dTSjIgt6Ova9Cx4Yl0lt2v1APgz52Uo49V
         1+4YfLns0ibT3wiuIh8N2ct6MXMZcy9WZnbCnl9+CqVcvlvLJjmBv/DDyFTbLC2WVuWC
         o7URCqXh4oRM+d2l3lMQUGAqjDrVkJZREpJ4ZMgAgohxCCLwESPUffkDvrFVNUY6aOsw
         uqUCynSls2CBWRmroSqvPVy5TXxdpUGZlVyLCjBToNjhY55x5MNF5gR6VJdyt24AJzfG
         I4DQ==
X-Gm-Message-State: AOAM531s51THMieE3kjpgynMubtNMqNhQklWYNmNlq18ReAO7GTIpGD5
        z68Xs2geg+420RRrF4U09OY=
X-Google-Smtp-Source: ABdhPJzhpznq0JAgTxZcVuAkGVqs3B5kO+eZXqQ4gOFaZ5IsQowZrWGEbK7ZOxCfQqE37MLXuCsskA==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1mr2628249plb.63.1591789840740;
        Wed, 10 Jun 2020 04:50:40 -0700 (PDT)
Received: from konoha ([2401:4900:30d9:a742:7cb4:f017:cb8b:7b2e])
        by smtp.gmail.com with ESMTPSA id m22sm1567832pfk.216.2020.06.10.04.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:50:39 -0700 (PDT)
Date:   Wed, 10 Jun 2020 17:20:28 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     pclouds@gmail.com, jonathanmueller.dev@gmail.com,
        gitster@pobox.com, git@vger.kernel.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 4/7] worktree: prune duplicate entries referencing
 same worktree path
Message-ID: <20200610115028.GA11750@konoha>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
 <20200610063049.74666-5-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610063049.74666-5-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 706ac68751..65492752a7 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -67,7 +67,12 @@ static void delete_worktrees_dir_if_empty(void)
>  	rmdir(git_path("worktrees")); /* ignore failed removal */
>  }
>  
> -static int should_prune_worktree(const char *id, struct strbuf *reason)
> +/*
> + * Return true if worktree entry should be pruned, along with the reason for
> + * pruning. Otherwise, return false and the worktree's path, or NULL if it
> + * cannot be determined. Caller is responsible for freeing returned path.
> + */
> +static int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath)
>  {
>  	struct stat st;
>  	char *path;
> @@ -75,6 +80,7 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
>  	size_t len;
>  	ssize_t read_result;
>  
> +	*wtpath = NULL;
>  	if (!is_directory(git_path("worktrees/%s", id))) {
>  		strbuf_addstr(reason, _("not a valid directory"));
>  		return 1;
> @@ -120,16 +126,17 @@ static int should_prune_worktree(const char *id, struct strbuf *reason)
>  	}
>  	path[len] = '\0';
>  	if (!file_exists(path)) {
> -		free(path);
>  		if (stat(git_path("worktrees/%s/index", id), &st) ||
>  		    st.st_mtime <= expire) {
>  			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
> +			free(path);
>  			return 1;
>  		} else {
> +			*wtpath = path;
>  			return 0;
>  		}
>  	}
> -	free(path);
> +	*wtpath = path;
>  	return 0;
>  }

What exactly is the role of 'wtpath' in here? Maybe this is explained in
the later patches. 

> @@ -141,22 +148,52 @@ static void prune_worktree(const char *id, const char *reason)
>  		delete_git_dir(id);
>  }
>  
> +static int prune_cmp(const void *a, const void *b)
> +{
> +	const struct string_list_item *x = a;
> +	const struct string_list_item *y = b;
> +	int c;
> +
> +	if ((c = fspathcmp(x->string, y->string)))
> +	    return c;
> +	/* paths same; sort by .git/worktrees/<id> */
> +	return strcmp(x->util, y->util);
> +}
> 

Can we rename the function arguments better? 'a' and 'b' sound very
naive to me. Maybe change these to something more like: 'firstwt' and
'secondwt'? Yeah even this sounds kiddish but you get the idea right? Or
like 'wt' and 'wt_dup'?

> diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
> index b7d6d5d45a..fd3916fee0 100755
> --- a/t/t2401-worktree-prune.sh
> +++ b/t/t2401-worktree-prune.sh
> @@ -92,4 +92,16 @@ test_expect_success 'not prune proper checkouts' '
>  	test -d .git/worktrees/nop
>
>  
> +test_expect_success 'prune duplicate (linked/linked)' '
> +	test_when_finished rm -fr .git/worktrees w1 w2 &&

Nit: maybe make it 'rm -rf' as that's the popular way of doing it?

Otherwise this looks good to me. But again, we need comments from others
too.

Nicely done! :)
