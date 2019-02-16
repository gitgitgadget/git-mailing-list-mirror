Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079591F453
	for <e@80x24.org>; Sat, 16 Feb 2019 14:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfBPOia (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 09:38:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36119 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfBPOia (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 09:38:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so12480322wmj.1
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 06:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eokDVpHGs8ksJYI8sQp2BI0JHLvgcobbWqm8HsG/vsY=;
        b=iU8c01hpHNqDamSnpobMIcNnJQ4AJxcY1HHFGK+CVpdQ8XaQxd7XPY2RvMGE3MuF12
         JYK35sANF68A1+Wun+gR/ODoilMqrwTgHFuAFGebx0BJ676zAljgsSOUXAjBkNtz4Jjk
         pGtgzL3T8JJY4b5WefxfOnRJ0NN3Zri0BAhZ8axUGe+WU/V0kWBWc1KXc2O3HiQ/MW5/
         MHRnKXKaoZbmYihTZWkzdUSFP5/dbVqM95TIJ6WYA/+3cwgGtyY2MsnxJvbVsvdR30Op
         /9uVfh5J3sOGfBxc8DTSchgJmyC89FHHt+soRHCvdzGkSGOuSkMfCPqqa8eYJnWaKYMq
         R6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eokDVpHGs8ksJYI8sQp2BI0JHLvgcobbWqm8HsG/vsY=;
        b=R/8vhwjWIzH03xDyx0s8uakpxeeauAzJAVaBvQxLJmqD8DBg2vybc8bTESMloGACwd
         RbC3a8NDXp0odgFJUUWc3ya/DwCSh48bjWj6ePoLpgsT8LCCXJBWWkUD6/rKLe/O8X6i
         cxTQ3MSSLKSHG8yRuvChmZ0dduB/RcoV6YNHreKKYvqh9pLTkBDD4Tyz+MA9tsWnqQQ4
         1/UU6cp1A6AKJqToHxbHczTQosczNzQslnqnwkspNJ5BgKuHVcMksNU2Jf4DY18xzYvt
         SE56A9zvacDwp3t9ju3e2nXncXVuS1l2ej8/UQhyiINDwJLaFV3Fm4Q1ZXqtdhl8eOYL
         MuAQ==
X-Gm-Message-State: AHQUAuakqJ2/Jbx0zrjcQfbZdO8mce+iAZ9l9Xp+BLJly8mr0AdQt16K
        ydy+I6gTnZ3auh9FAQ6+o16PGBQg
X-Google-Smtp-Source: AHgI3IYuLx8y6frceLam59lZE1n+Y2rYeR+smfmQlncRj/CTpvqAMY39k/3glJGPHy8zWoFXg42MOA==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196mr2577724wmd.146.1550327907513;
        Sat, 16 Feb 2019 06:38:27 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id m21sm14941837wmi.43.2019.02.16.06.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 06:38:25 -0800 (PST)
Date:   Sat, 16 Feb 2019 14:38:24 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir
 traversal
Message-ID: <20190216143824.GJ6085@hank.intra.tgummerer.com>
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215154913.18800-3-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/15, Matheus Tavares wrote:
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at copy_or_link_directory function, by the dir-iterator
> API.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/clone.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 2a1cc4dab9..66ae347f79 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -23,6 +23,8 @@
>  #include "transport.h"
>  #include "strbuf.h"
>  #include "dir.h"
> +#include "dir-iterator.h"
> +#include "iterator.h"
>  #include "sigchain.h"
>  #include "branch.h"
>  #include "remote.h"
> @@ -413,40 +415,33 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
>  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  				   const char *src_repo, int src_baselen)
>  {

The src_baselen parameter is now unused, and should be removed.  Our
codebase currently doesn't compile with -Wunused-parameter, so this is
not something the compiler can catch at the moment unfortunately.
However there is some work going on towards removing unused parameter
from the codebase, so it would be nice to not make things worse here.

*1*: https://public-inbox.org/git/20190214054736.GA20091@sigill.intra.peff.net

> -	struct dirent *de;
> -	struct stat buf;
>  	int src_len, dest_len;
> -	DIR *dir;
> -
> -	dir = opendir(src->buf);
> -	if (!dir)
> -		die_errno(_("failed to open '%s'"), src->buf);
> +	struct dir_iterator *iter;
> +	int iter_status;
>  
>  	mkdir_if_missing(dest->buf, 0777);
>  
> +	iter = dir_iterator_begin(src->buf);
> +
>  	strbuf_addch(src, '/');
>  	src_len = src->len;
>  	strbuf_addch(dest, '/');
>  	dest_len = dest->len;
>  
> -	while ((de = readdir(dir)) != NULL) {
> +	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
>  		strbuf_setlen(src, src_len);
> -		strbuf_addstr(src, de->d_name);
> +		strbuf_addstr(src, iter->relative_path);
>  		strbuf_setlen(dest, dest_len);
> -		strbuf_addstr(dest, de->d_name);
> -		if (stat(src->buf, &buf)) {
> -			warning (_("failed to stat %s\n"), src->buf);
> -			continue;
> -		}

Why was this warning removed?  I don't see a corresponding warning in
the iterator API.  The one thing the iterator API is doing is that it
does an lstat on the path to check if it exists.  However that does
not follow symlinks, and ignores possible other errors such as
permission errors.

If there is a good reason to remove the warning, that would be useful
to describe in the commit message.

> -		if (S_ISDIR(buf.st_mode)) {
> -			if (de->d_name[0] != '.')
> -				copy_or_link_directory(src, dest,
> -						       src_repo, src_baselen);
> +		strbuf_addstr(dest, iter->relative_path);
> +
> +		if (S_ISDIR(iter->st.st_mode)) {
> +			if (iter->basename[0] != '.')
> +				mkdir_if_missing(dest->buf, 0777);
>  			continue;
>  		}
>  
>  		/* Files that cannot be copied bit-for-bit... */
> -		if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
> +		if (!strcmp(iter->relative_path, "info/alternates")) {
>  			copy_alternates(src, dest, src_repo);
>  			continue;
>  		}
> @@ -463,7 +458,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		if (copy_file_with_time(dest->buf, src->buf, 0666))
>  			die_errno(_("failed to copy file to '%s'"), dest->buf);
>  	}
> -	closedir(dir);
> +
> +	if (iter_status != ITER_DONE) {
> +		strbuf_setlen(src, src_len);
> +		die(_("failed to iterate over '%s'"), src->buf);
> +	}

Interestingly enough, this is not something that can currently
happen if I read the dir-iterator code correctly.  Even though the
dir_iterator_advance function says it can return ITER_ERROR, it never
actually does.  The only way the iter_status can be not ITER_DONE at
this point is if we would 'break' out of the loop.

I don't think it hurts to be defensive here in case someone decides to
break out of the loop in the future, just something odd I noticed
while reviewing the code.

>  }
>  
>  static void clone_local(const char *src_repo, const char *dest_repo)
> -- 
> 2.20.1
> 
