Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BBCC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 16:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiF3QAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiF3QAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 12:00:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697351C127
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:00:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 136so13435114pfy.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9a1q//juDUcUUvpWv3hHIJcxv1zcRmmRhN944pOIPG0=;
        b=J4tPI41o7N6gYAlLstRPrpbVRbRXyARkflcWYm7awuMksVoCgsEExP7n5fwdL0LCnx
         /3NZHaWpzz0rouZBTT1zk/ng+HxlG52qXqvjTj64yJdVtkEE8j9SF/TqKB2pNEQAyjGa
         m8jsZJPzXc42rmA0hwcZMBEzh40z1tGSYorajZK/nLANL35o5kHPSqcNk73wXtI1xh1o
         qwqXlg0A/FZ43GdHGsjqrXV7M3EDp3rSDmJDfFkrl5uRfxaSe6p+JlU16jG1KNEoLGp3
         a+68mKZrZi1Xp3ltlE4h3i8UotUcNHtAVAVsSgSuupRfpisTj3ZSrHQcp6nL5vUeDsbn
         gK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9a1q//juDUcUUvpWv3hHIJcxv1zcRmmRhN944pOIPG0=;
        b=VACWTQaOBDjyAu6aD5MFNYgyqVFXyie9YjSX4RSJn0ZI/4iE5aJ8zJO9l6uI73gq1V
         kpFeFxYLmb0OEY1CA+A/t2cpXC9J5ZznEDzT0v4boI0abax7RWYFqPHg7AZ24iblM/z5
         JCG2CzHtHmT1wFJsEJRddILvJfgEGWuJgwXjtRazDQw8VttOh5eb9Ihnhd4lsQlEHWaQ
         +UzU8RnK6uZcIXHJlmfrw99eijxTafTMjBJunQz21VGjMGXEoYjR/hSaON3Qxh4eekxj
         i9Zud5qww6zTF1zwFg0uoXurcSCHTMjBTUSve9Ys3PJRXcw3SYzC0kzJIxy8nnTq18r5
         2/rQ==
X-Gm-Message-State: AJIora/JTXOAKD85y4Xei5cTJxA4cGLxOGpZ95ZSOkdUkk1ja+DzfwPe
        Z1rUwE5GvAAzoy734bOJIis=
X-Google-Smtp-Source: AGRyM1tdc5P3Znw++tHL4PbVT8arE9i3fERem6vQFqvzDdfa73KUT5G7wwFILmLU7Wpw46tlVe8RMw==
X-Received: by 2002:a63:6886:0:b0:40d:c2f9:2dfa with SMTP id d128-20020a636886000000b0040dc2f92dfamr8460956pgc.352.1656604816841;
        Thu, 30 Jun 2022 09:00:16 -0700 (PDT)
Received: from localhost ([2001:ee0:4fc8:e0b0:4ee7:6ef1:618c:a53f])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0016a4db1343fsm13643590plb.190.2022.06.30.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 09:00:16 -0700 (PDT)
Date:   Thu, 30 Jun 2022 23:00:10 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] ident: move commit_rewrite_person() to ident.c
Message-ID: <Yr3Iii8rRfnXzoUI@danh.dev>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
 <20220630142444.651948-2-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630142444.651948-2-siddharthasthana31@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-06-30 19:54:42+0530, Siddharth Asthana <siddharthasthana31@gmail.com> wrote:
> commit_rewrite_person() is a static function defined in revision.c.
> As the name suggests, this function can be used to replace author's,
> committer's or tagger's name in the commit/tag object buffer.
> 
> This patch moves this function from revision.c to ident.c which contains
> many other functions related to identification like split_ident_line. By
> moving this function to ident.c, we intend to use it in git-cat-file to
> replace committer's, author's and tagger's names and emails with their
> canonical name and email using the mailmap mechanism. The function
> is moved as is for now to make it clear that there are no other changes,
> but will be renamed in a following commit.
> 
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> ---
>  cache.h    |  8 ++++++++
>  ident.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  revision.c | 45 ---------------------------------------------
>  3 files changed, 53 insertions(+), 45 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index ac5ab4ef9d..442bfe5f6a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1688,6 +1688,14 @@ struct ident_split {
>   */
>  int split_ident_line(struct ident_split *, const char *, int);
>  
> +/*
> + * Given a commit or tag object buffer, replaces the person's
> + * (author/committer/tagger) name and email with their canonical
> + * name and email using mailmap mechanism. Signals a success with
> + * 1 and failure with a 0.

I'm not sure if this is important or not.
However, in this project, a function which does something usually
return 0 on success and a negative integer on failure.

However, the old code is there, so ...

> + */
> +int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap);
> +
>  /*
>   * Compare split idents for equality or strict ordering. Note that we
>   * compare only the ident part of the line, ignoring any timestamp.
> diff --git a/ident.c b/ident.c
> index 89ca5b4700..8c890bd474 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -8,6 +8,7 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "date.h"
> +#include "mailmap.h"
>  
>  static struct strbuf git_default_name = STRBUF_INIT;
>  static struct strbuf git_default_email = STRBUF_INIT;
> @@ -346,6 +347,50 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
>  	return 0;
>  }
>  
> +int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
> +{
> +	char *person, *endp;
> +	size_t len, namelen, maillen;
> +	const char *name;
> +	const char *mail;
> +	struct ident_split ident;
> +
> +	person = strstr(buf->buf, what);
> +	if (!person)
> +		return 0;
> +
> +	person += strlen(what);
> +	endp = strchr(person, '\n');
> +	if (!endp)
> +		return 0;
> +
> +	len = endp - person;
> +
> +	if (split_ident_line(&ident, person, len))
> +		return 0;
> +
> +	mail = ident.mail_begin;
> +	maillen = ident.mail_end - ident.mail_begin;
> +	name = ident.name_begin;
> +	namelen = ident.name_end - ident.name_begin;
> +
> +	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
> +		struct strbuf namemail = STRBUF_INIT;
> +
> +		strbuf_addf(&namemail, "%.*s <%.*s>",
> +			    (int)namelen, name, (int)maillen, mail);
> +
> +		strbuf_splice(buf, ident.name_begin - buf->buf,
> +			      ident.mail_end - ident.name_begin + 1,
> +			      namemail.buf, namemail.len);
> +
> +		strbuf_release(&namemail);
> +
> +		return 1;
> +	}
> +
> +	return 0;
> +}
>  
>  static void ident_env_hint(enum want_ident whose_ident)
>  {
> diff --git a/revision.c b/revision.c
> index 211352795c..da49e73cd6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3755,51 +3755,6 @@ int rewrite_parents(struct rev_info *revs, struct commit *commit,
>  	return 0;
>  }
>  
> -static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
> -{
> -	char *person, *endp;
> -	size_t len, namelen, maillen;
> -	const char *name;
> -	const char *mail;
> -	struct ident_split ident;
> -
> -	person = strstr(buf->buf, what);
> -	if (!person)
> -		return 0;
> -
> -	person += strlen(what);
> -	endp = strchr(person, '\n');
> -	if (!endp)
> -		return 0;
> -
> -	len = endp - person;
> -
> -	if (split_ident_line(&ident, person, len))
> -		return 0;
> -
> -	mail = ident.mail_begin;
> -	maillen = ident.mail_end - ident.mail_begin;
> -	name = ident.name_begin;
> -	namelen = ident.name_end - ident.name_begin;
> -
> -	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
> -		struct strbuf namemail = STRBUF_INIT;
> -
> -		strbuf_addf(&namemail, "%.*s <%.*s>",
> -			    (int)namelen, name, (int)maillen, mail);
> -
> -		strbuf_splice(buf, ident.name_begin - buf->buf,
> -			      ident.mail_end - ident.name_begin + 1,
> -			      namemail.buf, namemail.len);
> -
> -		strbuf_release(&namemail);
> -
> -		return 1;
> -	}
> -
> -	return 0;
> -}
> -
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>  	int retval;
> -- 
> 2.37.0.3.g2093cce7fe.dirty
> 

-- 
Danh
