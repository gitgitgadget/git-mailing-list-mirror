Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AAFC28CB2
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D7561355
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348424AbhIUCXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244703AbhIUCJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:09:15 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614DC09C2A4
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:24:16 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d18so11071280iof.13
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wMSJ8CloCDMBFeJcQT4nu/kjG1TN2bU8jjPp1ypv4eo=;
        b=qBOC/pkpiLKVRDqA3jv56rNjR6ck22IRkYT1GOZFmm+aSRItpSWuPFXMajSAQNF+ie
         gc4Rg12Q/EVJJuo0b8doZJLtcCUiUV2BWfSe0t1KsMEZVr/Nd6nKi+Fr8z8hZntHqvnb
         2KoYuXHDHcViiwfddPrUKDCvkufRNo4VLndnyn/6BCg1LMMBaUAHxw6gqP9uKLDanH+4
         NtAMk6RPZl2yTOOmfcQBR7b55jdeNzp4N2bdRQOGUnWoiONjnnloO3rOwn/WQ8cS0jkf
         Tmp/UxOoO40X2qawc/t+TfBkTOamcsg2S6jBuDhBuk7cjJKahxOt8CZpkWC9+oTcNUy6
         9nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wMSJ8CloCDMBFeJcQT4nu/kjG1TN2bU8jjPp1ypv4eo=;
        b=xbUtR8YOKHxoGfBB+1TnVK2ekL21vNW0HUjxqurAj0zGcESKkOTO+43TCXMlMzPjFE
         s8XGrtKS5UTrV2OOCR6HNW+CbTYGdjxHJUme/wHhnquufjybx3VkNhjy4jE2GcoPyWUO
         ccGQOgFjCayTB1S2Jf53gaU2TgOu0dVfZ4X/4AqeN4OvIicFxnNEfBhE6kIcfLLCW/hY
         JHPnVBT4EuAKrsiJCgczpUJjGsvQ9PUElT881EZU0a52WpoRRTrulYMlTUsb7N6uUL9J
         dg0t0/tYvup6PQpi6ByzMYO3HiY2HV7nAtccY+YLK3I7dygh9AM/90+Uw1q30YVwwyR4
         D+GQ==
X-Gm-Message-State: AOAM533EgaJDPRRnjh3FV/J/1bOvFz//hT/m9btTqGnV1SKuxP4y1Jkz
        cFG7OpnALgrR7fsCvuoMKBlc2w==
X-Google-Smtp-Source: ABdhPJwL2urINKqK2T62nJwzhB3PCXFQPF3NaKwYvHtW40jSh5d5dC7k5kSTdqxBueYwSt0/Iigkeg==
X-Received: by 2002:a6b:6b08:: with SMTP id g8mr1985441ioc.199.1632162256004;
        Mon, 20 Sep 2021 11:24:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b12sm4123051ilv.46.2021.09.20.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:24:15 -0700 (PDT)
Date:   Mon, 20 Sep 2021 14:24:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        calbabreaker@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] sparse-checkout: fix OOM error with mixed patterns
Message-ID: <YUjRziaIoVtJWGsS@nand.local>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
 <d90937b9ac9aaa6170f56d18ddb7a327b2af27d6.1632160658.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d90937b9ac9aaa6170f56d18ddb7a327b2af27d6.1632160658.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 05:57:36PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add a test to t1091-sparse-checkout-builtin.sh that would result in an
> infinite loop and out-of-memory error before this change. The issue
> relies on having non-cone-mode patterns while trying to modify the
> patterns in cone-mode.
>
> The fix is simple, allowing us to break from the loop when the input
> path does not contain a slash, as the "dir" pattern we added does not.
>
> This is only a fix to the critical out-of-memory error. A better
> response to such a strange state will follow in a later change.
>
> Reported-by: Calbabreaker <calbabreaker@gmail.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c          | 2 +-
>  t/t1091-sparse-checkout-builtin.sh | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 8ba9f13787b..b45fd97a98b 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -389,7 +389,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
>  		char *oldpattern = e->pattern;
>  		size_t newlen;
>
> -		if (slash == e->pattern)
> +		if (!slash || slash == e->pattern)
>  			break;

If we are preparing to make it so that we do not blindly copy patterns
from a sparse checkout without cone mode enabled, then wouldn't this new
case be a BUG()?

Of course, users could still tweak the contents of their sparse-checkout
file as they wish, but I'd expect that we'd catch those cases, too
(i.e., by validating the contents of the existing sparse-checkout before
calling this function).

> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 38fc8340f5c..a429d2cc671 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -103,6 +103,14 @@ test_expect_success 'clone --sparse' '
>  	check_files clone a
>  '
>
> +test_expect_success 'switching to cone mode with non-cone mode patterns' '
> +	git init bad-patterns &&
> +	git -C bad-patterns sparse-checkout init &&
> +	git -C bad-patterns sparse-checkout add dir &&
> +	git -C bad-patterns config core.sparseCheckoutCone true &&

Makes sense that we'd want to update the config rather than call "init
--cone" here, since a subsequent patch would change the thing that this
is testing (from "doesn't OOM in the above-described situation" to
"clears the existing contents of your sparse-checkout").

> +	git -C bad-patterns sparse-checkout add dir
> +'
> +

In other series I've suggested a cosmetic change to move all of these to
a sub-shell that begins with "cd bad-patterns &&", but obviously that is
a relatively unimportant suggestion.

Thanks,
Taylor
