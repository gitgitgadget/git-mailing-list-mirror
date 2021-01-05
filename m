Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE86C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92C822525
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 08:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhAEIxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 03:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbhAEIxF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 03:53:05 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E3C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 00:52:25 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw4so40210911ejb.12
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 00:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+adTROUNQcWdS8R3RRp5C9byHQdXcXJsGtzC6Z2orU=;
        b=XjCo5TIjcUsCfhM8gy3DJ3zMKJslrg61wtQ32WFI2MMcFNYglR6uecU/i26MLdKj15
         7ky06u2YjK0mn9JVIdn1GRUjpFotfYBy8Sg3fgtJWUMNleZsv/B03Q7xzqpYsNXpsU+Y
         7h1XEPzn4cOY+vqqu4OvMX3B1H1aFYqUH56tTNQxmFyXca2ppHOlHGihWfWkDaPsKWtj
         DKSCL0Lbz+im2ho2Sdc3sQiMJ2VY+eisPfzAQQDptBDlILEqvREN7WLO8kMfN5IeDWJi
         tBQvgOY4e6NfyhHjzj6AegQ7ANZSaAj/963u5cJoJjzrlR5Pf5QkkzELQ7j7OLE+zhYG
         v2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+adTROUNQcWdS8R3RRp5C9byHQdXcXJsGtzC6Z2orU=;
        b=Pel89g9OsdYbg+cgR97DHey+0DgY9Mr1TLwuEucIU4Jh3A960SUVyYtFIX9F7nRujK
         qBMCa6NThF09h858z1BHnIBX/8TYKtBbcvtCsjDFNJRexuBLsU6HzJ1K/DgIreyhxrV+
         ciAWfHPNXollaLyzmCB8kHYWnLpm0WKMw19O6a55aasTFhpysJJTSBWGEtflr6l3QGmN
         Ve4tA5CpBiyEXHsRmo5+UfnwMKD5udefw5CbxOuiR3oWEiw95ReDQ6Yag/DX0vox5omR
         SnpXcfc0IPGQWiAdwL/doNHhrAE35QIKzBh/fxVuTskBRBbTYzopdNT4d88BJTqGIX0d
         ErDw==
X-Gm-Message-State: AOAM5307TZ9LAaIRnhKbYt3XwFYTEoZJPLuYu+z1Vd9m9X30QQNUnOaw
        2ekpNjPx68aeQMRoNdKqRwCUj+SPhjQ=
X-Google-Smtp-Source: ABdhPJyEdcg1dtmKnRR5MRLpKKrg+zkwWxDY5CV0pxGE6o61wGWXW/gm+Q9WD62pSWo+y/UrxB5xWA==
X-Received: by 2002:a17:906:3499:: with SMTP id g25mr70931601ejb.18.1609836743767;
        Tue, 05 Jan 2021 00:52:23 -0800 (PST)
Received: from szeder.dev (84-236-109-79.pool.digikabel.hu. [84.236.109.79])
        by smtp.gmail.com with ESMTPSA id r24sm45036504edc.21.2021.01.05.00.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 00:52:23 -0800 (PST)
Date:   Tue, 5 Jan 2021 09:52:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs: allow @{n} to work with n-sized reflog
Message-ID: <20210105085221.GM8396@szeder.dev>
References: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c6885f15f5ce0be28142d9c69724362e72481a9.1609551262.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 01, 2021 at 05:36:06PM -0800, Denton Liu wrote:
> This sequence works
> 
> 	$ git checkout -b newbranch
> 	$ git commit --allow-empty -m one
> 	$ git show -s newbranch@{1}
> 
> and shows the state that was immediately after the newbranch was
> created.
> 
> But then if you do
> 
> 	$ git reflog expire --expire=now refs/heads/newbranch
> 	$ git commit --allow=empty -m two
> 	$ git show -s newbranch@{1}
> 
> you'd be scolded with
> 
> 	fatal: log for 'newbranch' only has 1 entries
> 
> While it is true that it has only 1 entry, we have enough
> information in that single entry that records the transition between
> the state in which the tip of the branch was pointing at commit
> 'one' to the new commit 'two' built on it, so we should be able to
> answer "what object newbranch was pointing at?". But we refuse to
> do so.

Great!  I've run into this issue quite a while ago with regular 'git
gc' expiring too old reflog entries, and wondered while the @{N}
notation errored out while the information was clearly still there in
the reflog.

https://public-inbox.org/git/20130619125059.GD20052@goldbirke/T/#u

> @@ -139,6 +139,19 @@ test_expect_success 'master@{n} for various n' '
>  	test_must_fail git rev-parse --verify master@{$Np1}
>  '
>  
> +test_expect_success '@{1} works with only one reflog entry' '
> +	git checkout -B newbranch &&
> +	git reflog expire --expire=now refs/heads/newbranch &&
> +	git commit --allow-empty -mexpired &&
> +	git rev-parse --verify newbranch@{1}
> +'
> +
> +test_expect_success '@{0} works with empty reflog' '
> +	git checkout -B newbranch &&
> +	git reflog expire --expire=now refs/heads/newbranch &&
> +	git rev-parse --verify newbranch@{0}
> +'

I agree with Martin about these tests: not failing is one thing, but
we should make sure that the right value is printed.

>  test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
>  	ln -s does-not-exist .git/refs/heads/broken &&
>  	test_must_fail git rev-parse --verify broken
> -- 
> 2.30.0
> 
