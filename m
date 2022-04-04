Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E33EC47082
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380350AbiDDVVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380445AbiDDUIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 16:08:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821702B180
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 13:06:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d15so3704847pll.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CZfA4340ipnjW2yDydpNfqKZzAK3dnH9DTnsfCEFRPU=;
        b=PjgJOxNh23dmALW/aL9Ojmc1ofxVGxsxazq97es5OdtsyUZO7SCAKKRfsrqU63Pjrt
         Lff767XmSU9qwTb0QHUt7NQXBfsthLS2KxGHhoj/ipxR8MdWy3YQeWKQONJUjD1xmr2J
         apmHeM3Ai2/IKmNv3IQe3I/XvvfKucDb1kAVDP5qY9efQm3hruUPB5QDj0owp1Ez3NK4
         PTuiKIzieLQOKwfQkmEw2UKDTQNf0I++I6s1rfGTrXGsq4ic6oSC90N0A7HwrRG3QefW
         IO/gKhNxoY+/Thxbpb1xcKHAoRxfz1DSUd8jQGWvzwgTNBgfp5d7RBlalD6FJMjLWZrs
         IzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=CZfA4340ipnjW2yDydpNfqKZzAK3dnH9DTnsfCEFRPU=;
        b=LufFwax69Dl0fUqbb/7AigxIWy2y8k9UVnVp66y7a+0rc0QgqmS8VpDy9XtqYSZKn5
         GtLqRfjf/Xu4Fk5+KbgAaJRWf/U4O2nvJD/35dUGN+LYV2qVb8xlBWuJxZbXu3tUzcuN
         qmGqlxS7jSNpVCY2liYD4dHTw2s1PUZ8alD8yvtX4f5UrseBXdMLD5ibQOsFED3PBFVC
         7l3sHanUHhlTM/lfxyfGMotBEu1/tA1pK45vZNm00cX+/mm8115MbhBvqRs3s8LQz0Wv
         q0q11blUeAuAofoh6571pEcFiQuQaeYklMaSiv2Rq0OhxaOh1gdo+e2Au4/64mGHVO/i
         zm1Q==
X-Gm-Message-State: AOAM5310M1bXHkGdevhTaWGS4sm41YJK7lkHUYScsjX8hM+GHUSepO7u
        XJKuGzYz471EOMFu5f9iiVPcfQ==
X-Google-Smtp-Source: ABdhPJwoR6+km2t0/WhnhSFmzQE13G0CcPwTjNLSxgcVnPI3JnlQ8OJVhQkjT8GmsafWz+d1bri6og==
X-Received: by 2002:a17:90b:4ac9:b0:1c9:a345:6b9a with SMTP id mh9-20020a17090b4ac900b001c9a3456b9amr918550pjb.118.1649102808706;
        Mon, 04 Apr 2022 13:06:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:dfc5:ffd9:354:5789])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090ab01100b001ca8458964esm9274pjq.18.2022.04.04.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:06:46 -0700 (PDT)
Date:   Mon, 4 Apr 2022 13:06:40 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v14 15/15] ls-tree: split up "fast path" callbacks
Message-ID: <YktP0LltNKq7JZZs@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Teng Long <dyroneteng@gmail.com>, Johannes.Schindelin@gmx.de,
        avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
References: <cover.1648026472.git.dyroneteng@gmail.com>
 <55a96e933b0949bbf3f33153b8e370af6c6299bb.1648026472.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55a96e933b0949bbf3f33153b8e370af6c6299bb.1648026472.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.03.23 17:13, Teng Long wrote:
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> 
> Make the various if/else in the callbacks for the "fast path" a lot
> easier to read by just using common functions for the parts that are
> common, and have per-format callbacks for those parts that are
> different.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 199 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 125 insertions(+), 74 deletions(-)
> 
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 6550f27dfe..44a91cf9d0 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -173,108 +173,157 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
>  	return recurse;
>  }
>  
> -static int show_default(struct show_tree_data *data)
> +static int show_tree_common(struct show_tree_data *data, int *recurse,
> +			    const struct object_id *oid, struct strbuf *base,
> +			    const char *pathname, unsigned mode)
>  {
> -	size_t baselen = data->base->len;
> -
> -	if (cmdmode == MODE_LONG) {
> -		char size_text[24];
> -		if (data->type == OBJ_BLOB) {
> -			unsigned long size;
> -			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
> -				xsnprintf(size_text, sizeof(size_text), "BAD");
> -			else
> -				xsnprintf(size_text, sizeof(size_text),
> -					  "%" PRIuMAX, (uintmax_t)size);
> -		} else {
> -			xsnprintf(size_text, sizeof(size_text), "-");
> -		}
> -		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
> -		find_unique_abbrev(data->oid, abbrev), size_text);
> -	} else {
> -		printf("%06o %s %s\t", data->mode, type_name(data->type),
> -		find_unique_abbrev(data->oid, abbrev));
> -	}
> -	baselen = data->base->len;
> -	strbuf_addstr(data->base, data->pathname);
> -	write_name_quoted_relative(data->base->buf,
> -				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
> -				   line_termination);
> -	strbuf_setlen(data->base, baselen);
> -	return 1;
> -}
> -
> -static int show_tree(const struct object_id *oid, struct strbuf *base,
> -		const char *pathname, unsigned mode, void *context)
> -{
> -	int recurse = 0;
> -	size_t baselen;
>  	enum object_type type = object_type(mode);
> -	struct show_tree_data data = {
> -		.mode = mode,
> -		.type = type,
> -		.oid = oid,
> -		.pathname = pathname,
> -		.base = base,
> -	};
> +	int ret = -1;
> +
> +	*recurse = 0;
> +	data->mode = mode;
> +	data->type = type;
> +	data->oid = oid;
> +	data->pathname = pathname;
> +	data->base = base;
>  
>  	if (type == OBJ_BLOB) {
>  		if (ls_options & LS_TREE_ONLY)
> -			return 0;
> +			ret = 0;
>  	} else if (type == OBJ_TREE &&
>  		   show_recursive(base->buf, base->len, pathname)) {
> -		recurse = READ_TREE_RECURSIVE;
> +		*recurse = READ_TREE_RECURSIVE;
>  		if (!(ls_options & LS_SHOW_TREES))
> -			return recurse;
> +			ret = *recurse;
>  	}
>  
> -	if (cmdmode == MODE_OBJECT_ONLY) {
> -		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
> -		return recurse;
> -	}
> +	return ret;
> +}
>  
> -	if (cmdmode == MODE_NAME_ONLY) {
> -		baselen = base->len;
> -		strbuf_addstr(base, pathname);
> -		write_name_quoted_relative(base->buf,
> -					   chomp_prefix ? ls_tree_prefix : NULL,
> -					   stdout, line_termination);
> -		strbuf_setlen(base, baselen);
> -		return recurse;
> +static void show_tree_common_default_long(struct strbuf *base,
> +					  const char *pathname,
> +					  const size_t baselen)
> +{
> +	strbuf_addstr(base, pathname);
> +	write_name_quoted_relative(base->buf,
> +				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
> +				   line_termination);
> +	strbuf_setlen(base, baselen);
> +}
> +
> +static int show_tree_default(const struct object_id *oid, struct strbuf *base,
> +			     const char *pathname, unsigned mode,
> +			     void *context)
> +{
> +	int early;
> +	int recurse;
> +	struct show_tree_data data = { 0 };
> +
> +	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
> +	if (early >= 0)
> +		return early;
> +
> +	printf("%06o %s %s\t", data.mode, type_name(data.type),
> +	       find_unique_abbrev(data.oid, abbrev));
> +	show_tree_common_default_long(base, pathname, data.base->len);
> +	return recurse;
> +}
> +
> +static int show_tree_long(const struct object_id *oid, struct strbuf *base,
> +			  const char *pathname, unsigned mode, void *context)
> +{
> +	int early;
> +	int recurse;
> +	struct show_tree_data data = { 0 };
> +	char size_text[24];
> +
> +	early = show_tree_common(&data, &recurse, oid, base, pathname, mode);
> +	if (early >= 0)
> +		return early;
> +
> +	if (data.type == OBJ_BLOB) {
> +		unsigned long size;
> +		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
> +			xsnprintf(size_text, sizeof(size_text), "BAD");
> +		else
> +			xsnprintf(size_text, sizeof(size_text),
> +				  "%" PRIuMAX, (uintmax_t)size);
> +	} else {
> +		xsnprintf(size_text, sizeof(size_text), "-");
>  	}
>  
> -	if (cmdmode == MODE_LONG ||
> -		(!ls_options || (ls_options & LS_RECURSIVE)
> -		 || (ls_options & LS_SHOW_TREES)
> -		 || (ls_options & LS_TREE_ONLY)))
> -			 show_default(&data);
> +	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
> +	       find_unique_abbrev(data.oid, abbrev), size_text);
> +	show_tree_common_default_long(base, pathname, data.base->len);
> +	return 1;
> +}

This commit makes `git ls-tree -l ...` list files recursively,
regardless of whether `-r` was provided or not. I believe it's due to
show_tree_long() returning 1 instead of the value of recurse. Is there a
reason why we unconditionally return 1 here?
