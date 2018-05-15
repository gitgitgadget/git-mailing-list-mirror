Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B921F406
	for <e@80x24.org>; Tue, 15 May 2018 17:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeEORBn (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 13:01:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41187 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeEORBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 13:01:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id v63-v6so347163pfk.8
        for <git@vger.kernel.org>; Tue, 15 May 2018 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HYgz8u8w0ZW9kTMP/elC+TX6zUTYT46dcS0OxSNAHq4=;
        b=KLK9FzD8e+hd6EQ5KXkn15o7yS9pfNUdDkmnhEfAYwuFti4YyiYi1eMy8S+FxLSLXn
         UNjqybj6HFFCAyRGvQlYgtnATN/Wa/3z5T4yM8+MVRQtItbDLhFU5mVF0gRoU+pryJDZ
         5XPg2/znwlDNswxmU78x5yxDQfPikGbyyf5S14d36sj6ZQXtY3LPrvnNLYZALt+NNirt
         6q3PZmwXpkFsBfIXcnA5/3lO/VFVn+jrgTy1a5YIaGwc2VTNmrw0Jw50OGPoR5VFlBE+
         1SjAFFBnKFDR+Qv8bk70RQxb94hMhSwc6FQ/Ef9DNyqrJNie474hCZA9JguZEFnbMS6a
         Sg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HYgz8u8w0ZW9kTMP/elC+TX6zUTYT46dcS0OxSNAHq4=;
        b=cvzcNIGJjWbN3K/dAOhQ0E2LA530+32nNaD7z5M8hogH93dpzzRdvdzlzvfpHNzvJa
         H91S2yPzONy/FDhcf7hQPe7FwLtWKNKD2Quy+GacziQvrIrqUTQ/oLS5phkbvU+VIEq4
         xmAewUeyX6PjINfYX7Eb7PsD3oZ0gqXf5/jGm0UGGuSZHPe/p4tpK9RWQv7dNAXbQW7e
         a2+krL8EJHAGXN/Qjeg4xZO2TpMnL0jZgBidYpkPtj/XZYE6Rt0truY9wsQQX0cPtcMR
         5XGsXLf3e2Q3YmCZppyzZfHbWy/cDgUJ6EKX6W8pVvUtOg/FTvWjILg7TsU+T34LSLYa
         IylQ==
X-Gm-Message-State: ALKqPwdhSBWXWK8GIznx+mDFQO0UxRhyVjK5ajlpFvu7Rj3RiK67XCeH
        mOz2EAdJvgATVcNAwK2IhranYw==
X-Google-Smtp-Source: AB8JxZoQP2hj3A5u9C1COBqVhLMcYK9aFhpTFlZyhg53DeIi+tr2bBN2edm8R9AuhS4AwF6ViutK6A==
X-Received: by 2002:a63:79c4:: with SMTP id u187-v6mr5313870pgc.301.1526403702210;
        Tue, 15 May 2018 10:01:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id o10-v6sm517090pgp.30.2018.05.15.10.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 10:01:39 -0700 (PDT)
Date:   Tue, 15 May 2018 10:01:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, ao2@ao2.it
Subject: Re: [PATCH] grep: handle corrupt index files early
Message-ID: <20180515170137.GC72551@google.com>
References: <20180515010425.149200-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515010425.149200-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/14, Stefan Beller wrote:
> Any other caller of 'repo_read_index' dies upon a negative return of
> it, so grep should, too.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Found while reviewing the series
> https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/
> 
>  builtin/grep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 6e7bc76785a..69f0743619f 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -488,7 +488,8 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
>  		strbuf_addstr(&name, repo->submodule_prefix);
>  	}
>  
> -	repo_read_index(repo);
> +	if (repo_read_index(repo) < 0)
> +		die("index file corrupt");

Looks good to me!

>  
>  	for (nr = 0; nr < repo->index->cache_nr; nr++) {
>  		const struct cache_entry *ce = repo->index->cache[nr];
> -- 
> 2.17.0.582.gccdcbd54c44.dirty
> 

-- 
Brandon Williams
