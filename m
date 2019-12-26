Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1951C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664C220740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhJ/+A7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfLZUDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:03:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37074 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfLZUDT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:03:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so10825629plz.4
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Cu1mkxGKLCqkn8l0LbK22sF0FftB2wpDzb5hFW8PBQ=;
        b=QhJ/+A7QsTOuLxngbwZfuK0J9nIzWNXtaeZEiEIzkFnqXvDOgtywqe0DYfgKtcJ4qC
         N9yjVKbxa2kEZ14cpBkgKo6QTOHCMA1rjiZ4LCUHfg+2+WPDskiNB+QbDgBtUSEQwIyx
         CtQf6+Y//D4bV6mKgyOSomgxLpKo9h5gZcurkHqCjRD7nijx4YzqMxgrOZxjvWNzP7yR
         1VDUBuwLBirXDC5HnjFND2apGC1ej/8WZza24ehacgRQ9arfu+/sTiaOQMwlT6DyjKxE
         DNjjY0aBHFxQ20Fy/9Ex3sLGCDpfmIVgQVKEP9UtxKlAqTh1hNdF9Iva8VPyJqiM/NDx
         J0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Cu1mkxGKLCqkn8l0LbK22sF0FftB2wpDzb5hFW8PBQ=;
        b=awP5aQZ8TS+2EgYx/SaAQ0BrZRE81o0pjycnNOEqNBrWPjE4jIDvpW+Kg9F/yXrMzQ
         8GxFQe24wwjcMZTwkkCavkGXbvuC6RyeCP+h0/ze75RhSxZ7iQbdPFEWOBV+BsCourFg
         nRS9hrJon/Bu1JPhiPySks5QCWvmIlL5pBWd0NGgukPbipzKfLnRPtQxAEdDrBivW5nD
         0z8VHRlos9QmscRlf2MTqUclr9QZPa019pJIvRdEnpxWhv9Hf/kurWvuMC3NuTwVF/TV
         lT9CcYQEP6KqubPgcaEIzWggFZH+M4cTfCshV/4N0q7wmb1qX8Yg6a19mb669t8HKfIK
         b3SA==
X-Gm-Message-State: APjAAAWutmxlTMSyaqrJqFcFsWDt4n3LvxdteCdjHPJvD+KEyVxRcoKT
        9zngOdyzmJW35hd7ezW5KMY=
X-Google-Smtp-Source: APXvYqzhf0kJMwo6OKdLTLMUbBxAEAU1O5Bkb1gzpTcwrng/6PhIsZozv14HH77dFegfrHA6IHQ1pA==
X-Received: by 2002:a17:902:64:: with SMTP id 91mr48629566pla.307.1577390598602;
        Thu, 26 Dec 2019 12:03:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id s131sm18735707pfs.135.2019.12.26.12.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 12:03:18 -0800 (PST)
Date:   Thu, 26 Dec 2019 12:03:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
Message-ID: <20191226200316.GD170890@google.com>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
 <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> During a clone of a repository that contained a file with a backslash in
> its name in the past, as of v2.24.1(2), Git for Windows prints errors
> like this:
>
> 	error: filename in tree entry contains backslash: '\'
>
> While the clone still succeeds, a similar error prevents the equivalent
> `git fetch` operation, which is inconsistent.
>
> Arguably, this is the wrong layer for that error, anyway: As long as the
> user never checks out the files whose names contain backslashes, there
> should not be any problem in the first place.

Hm.  The choice of right layer depends on what repositories in the wild
contain.  If there are none containing filenames with '\', then fsck et
al would be an appropriate layer for this.  With hindsight, it was not
a good idea to support this kind of filename.

However, between the lines of this commit messages I sense that there
*are* repositories in the wild using these kinds of filenames.

Can you say more about that?  What repositories are affected?  Do they
contain such filenames at HEAD or only in their history?  If someone
wants to check out a revision with such filenames, what should happen?

> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1278,6 +1278,11 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
>  	int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
>  	int new_only = option & ADD_CACHE_NEW_ONLY;
>  
> +#ifdef GIT_WINDOWS_NATIVE
> +	if (protect_ntfs && strchr(ce->name, '\\'))
> +		return error(_("filename in tree entry contains backslash: '%s'"), ce->name);
> +#endif
> +

Why is this specific to the GIT_WINDOWS_NATIVE case?  Wouldn't it affect
ntfs usage on other platforms as well?

[...]
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -43,12 +43,6 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
>  		strbuf_addstr(err, _("empty filename in tree entry"));
>  		return -1;
>  	}
> -#ifdef GIT_WINDOWS_NATIVE
> -	if (protect_ntfs && strchr(path, '\\')) {
> -		strbuf_addf(err, _("filename in tree entry contains backslash: '%s'"), path);
> -		return -1;
> -	}
> -#endif

Ah, it's inherited from there, so orthogonal to this patch.

To summarize: I think the commit message and docs could use some work
to describe what invariants we're trying to maintain and what
real-world usage motivates them.

Thanks and hope that helps,
Jonathan
