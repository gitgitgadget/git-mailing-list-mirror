Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B93C433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 10:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbhL1K4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 05:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhL1K4r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 05:56:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EBDC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:56:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t26so37589233wrb.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OeHz+lRRjEY+62lbB7CgmWwlIcwb1O0UrgLYotrgKFE=;
        b=BzmRoSntL6OC2+LoSOJEXUEGORLrHMbLmSFeGd1XJ54r3uf8ONCZghlnHVWJ8VGoEp
         yczc0oW6B25yqJZBV+hGTOmm+RE/B07VUg6mA3jPqyOsY/iSeXWEmm8Y2RLTHZ9ebGUO
         hMmonrYomHuuxxfTIFlq59O7N07nexmlwpb2H3ejYtc+pV8UXdvRiJuGo55Tt+MQmjjT
         usNwhq31MI/WgVTJVbcpmpNAYAg8P8MIdakTmzfnFMPDBQpn8OvVUOMUjLdom2fy+KDk
         KApdSd6yVhGm7LhAHEFNgz5B4xb+8CzUlw9lwgeIqtSGrtWFFfHrmn8N+CaLCZpzW1t0
         Dprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OeHz+lRRjEY+62lbB7CgmWwlIcwb1O0UrgLYotrgKFE=;
        b=DnfOReWLxzIzO6e67K09NQ/FhvAymlXdfqd9bDJBjfBaMduBKT0EoGqzqBuDn4fY9n
         bDMbyaD3XyZJ3o4op8b9ugmvkyR2SG9g+QCZbzI7CsP5kNJPAjiCfOy0UPs0qW37GUCi
         SPLYjV9Bfi8p4XM59taqXOtFG5buVzt7UCvdNti/PD+NaOGowh7iObioEyRK+EtArY2S
         +q6sV6w3ImmIxpwBI2+2cxS/5c7Mf4i/KREjueZfURgt7RUPXp0zWftNfIojrc+thlB+
         HLwBZEUbmsNprwNXtXq7xNBAFi0frOKQ04YWyTnDoUc24Ahl3YLtUAmu2ylQ/7lXouYB
         e3Lg==
X-Gm-Message-State: AOAM531TvXO/caCXNXO9X/rSjkYFfDZB3FFbaFdz72codzBxBRVuZoql
        ELFXz/bwK4hnhJEEvN/jNG0vi9UE5Ej6OQ==
X-Google-Smtp-Source: ABdhPJwl5oUdFHFkQSAZrlpWivtFag7EtPipRmLVvz+ZrKzobQjU31nsMmfUmpHgHk2nBNVXxRPExg==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr16522484wrd.362.1640689005261;
        Tue, 28 Dec 2021 02:56:45 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id n41sm21222299wms.32.2021.12.28.02.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:56:44 -0800 (PST)
Date:   Tue, 28 Dec 2021 11:56:42 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH v2 6/8] merge-ort: format messages slightly different for
 use in headers
Message-ID: <20211228105642.ajmr2kqjm5yikneu@gmail.com>
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <887e46435c0561e86f1858682fe53e9de926b69c.1640419160.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887e46435c0561e86f1858682fe53e9de926b69c.1640419160.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 25, 2021 at 07:59:17AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When users run
>     git show --remerge-diff $MERGE_COMMIT
> or
>     git log -p --remerge-diff ...
> stdout is not an appropriate location to dump conflict messages, but we
> do want to provide them to users.  We will include them in the diff
> headers instead...but for that to work, we need for any multiline
> messages to replace newlines with both a newline and a space.  Add a new
> flag to signal when we want these messages modified in such a fashion,
> and use it in path_msg() to modify these messages this way.

makes sense (same for patches 4 & 5)

> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c       | 36 ++++++++++++++++++++++++++++++++++--
>  merge-recursive.c |  3 +++
>  merge-recursive.h |  1 +
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 998e92ec593..9142d56e0ad 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -634,17 +634,46 @@ static void path_msg(struct merge_options *opt,
>  		     const char *fmt, ...)
>  {
>  	va_list ap;
> -	struct strbuf *sb = strmap_get(&opt->priv->output, path);
> +	struct strbuf *sb, *dest;
> +	struct strbuf tmp = STRBUF_INIT;
> +
> +	if (opt->record_conflict_msgs_as_headers && omittable_hint)
> +		return; /* Do not record mere hints in tree */
> +	sb = strmap_get(&opt->priv->output, path);
>  	if (!sb) {
>  		sb = xmalloc(sizeof(*sb));
>  		strbuf_init(sb, 0);
>  		strmap_put(&opt->priv->output, path, sb);
>  	}
>  
> +	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
> +
>  	va_start(ap, fmt);
> -	strbuf_vaddf(sb, fmt, ap);
> +	strbuf_vaddf(dest, fmt, ap);
>  	va_end(ap);
>  
> +	if (opt->record_conflict_msgs_as_headers) {
> +		int i_sb = 0, i_tmp = 0;
> +
> +		/* Copy tmp to sb, adding spaces after newlines */
> +		strbuf_grow(sb, 2*tmp.len); /* more than sufficient */
> +		for (; i_tmp < tmp.len; i_tmp++, i_sb++) {
> +			/* Copy next character from tmp to sb */
> +			sb->buf[sb->len + i_sb] = tmp.buf[i_tmp];
> +
> +			/* If we copied a newline, add a space */
> +			if (tmp.buf[i_tmp] == '\n')
> +				sb->buf[++i_sb] = ' ';
> +		}
> +		/* Update length and ensure it's NUL-terminated */

I think this and the two comments inside the loop are mostly redundant. I'd
drop them (except maybe this one because it's a common oversight I guess).

> +		sb->len += i_sb;
> +		sb->buf[sb->len] = '\0';
> +
> +		/* Clean up tmp */

Also this one I guess

> +		strbuf_release(&tmp);
> +	}
> +
> +	/* Add final newline character to sb */
>  	strbuf_addch(sb, '\n');
>  }
>  
> @@ -4246,6 +4275,9 @@ void merge_switch_to_result(struct merge_options *opt,
>  		struct string_list olist = STRING_LIST_INIT_NODUP;
>  		int i;
>  
> +		if (opt->record_conflict_msgs_as_headers)
> +			BUG("Either display conflict messages or record them as headers, not both");
> +
>  		trace2_region_enter("merge", "display messages", opt->repo);
>  
>  		/* Hack to pre-allocate olist to the desired size */
> diff --git a/merge-recursive.c b/merge-recursive.c
> index bc73c52dd84..c9ba7e904a6 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3714,6 +3714,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
>  
>  	assert(opt->priv == NULL);
>  
> +	/* Not supported; option specific to merge-ort */
> +	assert(!opt->record_conflict_msgs_as_headers);
> +
>  	/* Sanity check on repo state; index must match head */
>  	if (repo_index_has_changes(opt->repo, head, &sb)) {
>  		err(opt, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> diff --git a/merge-recursive.h b/merge-recursive.h
> index 0795a1d3ec1..ebfdb7f994e 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -46,6 +46,7 @@ struct merge_options {
>  	/* miscellaneous control options */
>  	const char *subtree_shift;
>  	unsigned renormalize : 1;
> +	unsigned record_conflict_msgs_as_headers : 1;
>  
>  	/* internal fields used by the implementation */
>  	struct merge_options_internal *priv;
> -- 
> gitgitgadget
> 
