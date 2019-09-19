Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4442B1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 22:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405093AbfISWr6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 18:47:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32859 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405047AbfISWr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 18:47:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so4827045wrs.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k8+zJVE+ynFXpE8TDawW7RKmHC+SdLDbN0Egi/mTxwg=;
        b=Wex2wmJapam6vGzPRS1rxMiJgYrDtR3i7/FyqOGsAUA0dEuTuytNLY/SqvFBCdi8/Z
         fFMDAzw6wgj5jZhLNujuXKsecXi5EF/gPhwDVkcSbRwQPIWMmiZDn0+Zf/sUatC2PtqW
         gxDljznYMQHLti7AiCVN606Kk7KJVn+Alb0UmMJtdfai0+il4lw1BZLFkrP+cDL4Wpla
         SwYJwaDNHks+VNX90qvwB97I7N61BxbqtP30yHepfPpFo+MM+f8M+G5jOvKPKSyp6/3F
         0CpnwUTHvsQg9PvmyK3tPPaWHrZgNkjykyvy0C0f4/XzEDGL3gjV0TK4Hz6IT3IKqWx0
         00uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k8+zJVE+ynFXpE8TDawW7RKmHC+SdLDbN0Egi/mTxwg=;
        b=rY6qG7t+9A4rdL+EXWW1oUC9fwPlUd1w9cr5Zebb7X9khn6p9VdMxMD97v0vUm0/no
         rdSTy7Waha/ijd3Kw8jksWN2lkpIj7zoGVLtWNepB30sVZ+AN73PAP+EQBCnFpx+YgS2
         O1FD7DRllCINGU/xuBRHsJloAtRl0ihoQWg6BPhI131FGzk7X7ciOlsDiwJ/mEOB5U/b
         amGzlFjI0hQWp2H3mUvu38E9XmtVei7TVIaVNpu7gddYnXKn9eVs4VP+tXVj/+A3wRqM
         jgdxn9dNAB1LNjRZmwxuSpg6yMB1R3VF2Jc6wOIN9T4in5N5T7x4yEZNxmfMmCqbULSJ
         J4ig==
X-Gm-Message-State: APjAAAWYF+XqxPHbEdDU6oO/mr5YSBqf02sbvzQv06QuBBEI9OZxN/TQ
        PIw+IK1cqdLjNpr6gwyS4qU=
X-Google-Smtp-Source: APXvYqzQpbVXcgzXeWhl1UPQCD2kTr1lQQiURxoVfu/1d/oUfcrbFHPIQIsUrzratXV13YS1v77tIQ==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr7380646wrv.55.1568933275432;
        Thu, 19 Sep 2019 15:47:55 -0700 (PDT)
Received: from szeder.dev (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id s5sm120740wro.27.2019.09.19.15.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 15:47:54 -0700 (PDT)
Date:   Fri, 20 Sep 2019 00:47:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/15] name-rev: plug memory leak in name_rev() in the
 deref case
Message-ID: <20190919224752.GC29845@szeder.dev>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-16-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190919214712.7348-16-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please ignore this mail.

On Thu, Sep 19, 2019 at 11:47:10PM +0200, SZEDER Gábor wrote:
> The name_rev() function's 'tip_name' parameter is a freshly
> xstrdup()ed string, so when name_rev() invokes:
> 
>   tip_name = xstrfmt("%s^0", tip_name);
> 
> then the original 'tip_name' string is leaked.
> 
> Make sure that this string is free()d after it has been used as input
> for that xstrfmt() call.
> 
> This only happens when name_rev() is invoked with a tag, i.e.
> relatively infrequently in a usual repository, so any reduction in
> memory usage is lost in the noise.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index e202835129..f867d45f0b 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -101,18 +101,22 @@ static struct rev_name *create_or_update_name(struct commit *commit,
>  }
>  
>  static void name_rev(struct commit *start_commit,
> -		const char *tip_name, timestamp_t taggerdate,
> +		const char *start_tip_name, timestamp_t taggerdate,
>  		int from_tag, int deref)
>  {
>  	struct commit_list *list = NULL;
> +	const char *tip_name;
>  	char *to_free = NULL;
>  
>  	parse_commit(start_commit);
>  	if (start_commit->date < cutoff)
>  		return;
>  
> -	if (deref)
> -		tip_name = to_free = xstrfmt("%s^0", tip_name);
> +	if (deref) {
> +		tip_name = to_free = xstrfmt("%s^0", start_tip_name);
> +		free((char*) start_tip_name);
> +	} else
> +		tip_name = start_tip_name;
>  
>  	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
>  				   from_tag)) {
> -- 
> 2.23.0.331.g4e51dcdf11
> 
