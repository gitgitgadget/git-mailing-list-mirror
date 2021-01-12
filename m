Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B3C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B73223E8
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbhALJHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbhALJHw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 04:07:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E6C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 01:07:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k10so1201153wmi.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 01:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UBZqa/OdvJ9JMaBWYCUGu64VgZWa3o8EMAzryiXGEkE=;
        b=KlRwLQWRQjf7tmJkJKh39YuF0e+o9KGwErsGv0b0J1wYnC0Ve6wp1M37n4hcaBgct1
         jr/BtSRG4TVbpdhHKoY+gqaAToSeAsRVJQb7eX+5KVYFZjCFQmToAhOmakUAX3/qp5Pq
         XM0aAJsaksCBDV6JP0O9IDA8K3ibSLjCMA8zJt9OopxjBM8TSRpqeM9vzNWyN4mlFM/o
         lArqkblduZjCEs5XkXbO30V8DmfkezbY4380/4z5buAYufDdCLLE5Ek789FaaChehGxe
         UVwo2qgF0IChTY/SBxFiQpAPnlZS6mPIa5aep4IStk9IpvtTc8A+2qh6MFhdUr7T1X9o
         BcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UBZqa/OdvJ9JMaBWYCUGu64VgZWa3o8EMAzryiXGEkE=;
        b=au3nKgRUIdIaky6+gPC0H4QBtVH62iedGkqTYdm/rSCwqjgVDA+GRRllmZN88DHOL8
         5AXQb+nIhnzQocPheHNdeIHwrWZyryJd7QaKmsbKOPD9q1y4KaXu6Lb+TJY7gBFC5ai6
         5/o0JHRUFYsRLwd4vhJFCFlSs9p2DyW4GjCgN6C7f10qLiQKpkGlfsqfcOKnY906jiu9
         kCVY/SHvpYLJz/sLGegq7EeI+otyKdf9XalcF/+r5dmcU0zTQSzLL7RvmYgpAlzCwIu2
         bSWN8nFZfzAV0PFtiwsGDbZkpI2/hiGT6iUju7KfsMQzjN460NIYUdyi4R5PGcJXvZ51
         1VoQ==
X-Gm-Message-State: AOAM532bJqVhs4ad5WlbvD8r6At78igHe2ZAvsmnJhhoDGLakzDyMpgY
        fOUydco9JX6t5U1N2+gspds=
X-Google-Smtp-Source: ABdhPJx+s8XfNXhbvQzcYvIRRuleQY1MzXEdhSLpfGSwYDGoS6QHePAs7aTfgbtoLCFTUekWVo/6uw==
X-Received: by 2002:a1c:790f:: with SMTP id l15mr2564677wme.188.1610442430267;
        Tue, 12 Jan 2021 01:07:10 -0800 (PST)
Received: from szeder.dev (84-236-109-1.pool.digikabel.hu. [84.236.109.1])
        by smtp.gmail.com with ESMTPSA id m82sm2840695wmf.29.2021.01.12.01.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 01:07:10 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:07:08 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] tests: remove unnecessary
 GIT_TEST_GETTEXT_POISON=false constructs
Message-ID: <20210112090708.GW8396@szeder.dev>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
 <004f90026031cb7ce71689481fabd27aa63485dd.1610441263.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <004f90026031cb7ce71689481fabd27aa63485dd.1610441263.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 08:47:32AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The idea of the `GETTEXT_POISON` mode is to test translated messages, at
> least _somewhat_.
> 
> There is not really any point in turning off that mode by force, except
> _maybe_ to test the mode itself.
> 
> So let's avoid overriding `GIT_TEST_GETTEXT_POISON` in the test suite
> unless testing the `GETTEXT_POISON` functionality itself.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index a1c4f1f6d40..e5adee27d41 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2363,7 +2363,6 @@ test_expect_success 'sourcing the completion script clears cached commands' '
>  '
>  
>  test_expect_success 'sourcing the completion script clears cached merge strategies' '
> -	GIT_TEST_GETTEXT_POISON=false &&

I think this change caused the failure in t9902 that you mentioned in
the cover letter.  

If 'git merge' is invoked with a nonexisting merge strategy, then it
errors out with an error message that contains a list of available
merge strategies.  The completion script relies on this behavior and
"parses" this error message to get the available merge strategies, but
it breaks when it can't find the expected text because it was
poisoned.

>  	__git_compute_merge_strategies &&
>  	verbose test -n "$__git_merge_strategies" &&
>  	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> -- 
> gitgitgadget
> 
