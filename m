Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2611F406
	for <e@80x24.org>; Tue, 15 May 2018 23:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeEOX6X (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 19:58:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50897 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeEOX6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 19:58:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so3861297wmt.0
        for <git@vger.kernel.org>; Tue, 15 May 2018 16:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4FfADYHp2ZT+yvHkPYyHUZZjizersCBxEMaqL3JrRNQ=;
        b=Mao9wh9/pSDAaYcYmLjX7FOaY/+ozUgAdEBHxcEh0wm8nqvs6Dqk8JBXb3UB5Y4KNt
         NBRe8cqCMLg2W21/Sx8J6jEefWh71bwM5zCn4Y2izfBEQB9xzhDyHMCuyR1HAsygnlPB
         9q3KBupXHbSy7uzEF85/Jazw5uTBvrGO7lmgZorrxyn3BPKrhJsoMe7fMYiUxW8UGZ6G
         KoZA/McLfVVNJG1rtmWeQYPvhXJMilYc2dzXEj66M5azMVkUftR/WWOZFH2JUkRj8RQQ
         4swhJ3GOsM7LPbHYgrpnztF6pj+vehs/Rzw9yZ8r8Xi7fE06va/lr8UvvSfPdrax/RQI
         Dn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4FfADYHp2ZT+yvHkPYyHUZZjizersCBxEMaqL3JrRNQ=;
        b=Pyw83ilJdwLjouRTl0vU7yRRJfnJeTjeGBm5WzbvqshCp4BqULffFvTffGrOm928iu
         2fPq2jsrdDZBezv24CTBU1+5x7G3RNAp5vLx6oK/sDh4t2kcwJHRJlbdmbfDo52gC1va
         c+4QPXFXFd0H9I1RRZxvzLyb0mm6D5RK6x8vk0i1QHXvGm4XHlXaU96CInUwVXPLeuac
         gDKEDPl2J8JBoaHL+75e0PB+Cm4Cmm8Kn4X2DHbJLcxTyUkE0vtXmDx+QuiDe9SxtIpf
         2wgU/rC4UtehLwBM2dKfXObnrwrnfRjz6LHqnOVHUBHeT8R/KdiC1ca/wpcS4bBLOEyQ
         3xvw==
X-Gm-Message-State: ALKqPweYbNJ1MFLBG6DEDs+Y8pOZe1sLYl1viyfnOwPoMokKfU61/H/3
        FMrVvLSQTzntYUskgN8wqDl2KNDl
X-Google-Smtp-Source: AB8JxZo7zTPQSPGIOlnBxLP8p/1IV4lA1D6JzGfHPhhS+iU0pGIeIxbKq1dW7phu9EqZ7YmIBe3KFA==
X-Received: by 2002:a1c:1bcc:: with SMTP id b195-v6mr34469wmb.63.1526428700373;
        Tue, 15 May 2018 16:58:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d125-v6sm1613924wmd.24.2018.05.15.16.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 16:58:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, ao2@ao2.it
Subject: Re: [PATCH] grep: handle corrupt index files early
References: <20180515010425.149200-1-sbeller@google.com>
Date:   Wed, 16 May 2018 08:58:19 +0900
In-Reply-To: <20180515010425.149200-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 14 May 2018 18:04:25 -0700")
Message-ID: <xmqq603o8o9w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Any other caller of 'repo_read_index' dies upon a negative return of
> it, so grep should, too.

Makes sense.  When the function returns a failure, there is no
sensible fallback action anyway, so dying here is alright.

Will queue; thanks.

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
>  
>  	for (nr = 0; nr < repo->index->cache_nr; nr++) {
>  		const struct cache_entry *ce = repo->index->cache[nr];
