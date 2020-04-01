Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FD4C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87A72063A
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 18:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgSR8LI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgDASRy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:17:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35824 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbgDASRx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 14:17:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id v2so601905oto.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TAFX/vILoNGye6ppgemYpBVX0HdxBuUKUSAjOyAO8hc=;
        b=hgSR8LI+awDaJWOOlBuNEktgm/OlPFI9oI6xYiD3A7EMxq3+Lt+ZerPyl/BwLexSgV
         aXpT/0oQsp5HvBCNN4O1j+9C3LaOfZYRag5lYlk9fd2ieJeLBi2Y8mHDq7Wzl5pXz0Kl
         Ycq21p5pgY6hKke1wZLQOikJXIL72VyWcECfoVrglJ7jAnjmqHGw3V6jciTdZJh2hWRm
         3RvAC3X0EmulU4mi2mhc5uq7Zo99Cs2HbCBH5t7iaqAbfZF6bLwe7GacYUmjSu8Tt2Ws
         k7HnB44QJd6CvlOR+dOXsmrlVsUVWJuBXqjpQewjhJ5/Eh+KQUJomDYd860EBXKPpDsm
         fx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TAFX/vILoNGye6ppgemYpBVX0HdxBuUKUSAjOyAO8hc=;
        b=UR7RDXcLGfTE1pA6BtiC3mdKIYnSHTfAf5J8HoANUHwnyIesoBJhAONlbkGeMJjkVP
         v2TZbaNX7O2bWMpYIirVc7jhqxDz970icxsAhAwBaiboASGksp3hhUEgfG2EAIv7tcFc
         tQv+R0e8HIhLeGWXk1sTp5NOoncYrh7J8M1zslvJpblhGgtPYxwJ8v661YV3NzGIVgjG
         GZw4LDre+uCUzlF4vtzNswz57payyzDKktXuwh+mqoygVaYQ+RJk95jd/W/i+/3c5Ckv
         CEYudvN670AaswVq/oHAPvZS0Gl19RdLsX8mZHelCcRToRR/B4zbpovsFmiSHieeM9xI
         rKow==
X-Gm-Message-State: ANhLgQ3EZJHmJ7MVswSEndohx7N3mbyvtcoYMFQFjhBRtzbf8V4ppIgW
        qpRutqLbZD+8v4ZaYAYjs2VHzOjkBV4=
X-Google-Smtp-Source: ADFU+vuSTevffdKUunHW51oBIsGIfW/hdBkMsn024Bqs9hM/Ernu5oOYDW7ShVlswWqq+EWEpi3wEQ==
X-Received: by 2002:a9d:2c69:: with SMTP id f96mr7699474otb.62.1585765072826;
        Wed, 01 Apr 2020 11:17:52 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m134sm718922oig.14.2020.04.01.11.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 11:17:52 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix buggy --expire-time option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bbd2b8e4-47f5-a99e-fb14-b6c1ce2ad9a9@gmail.com>
Date:   Wed, 1 Apr 2020 14:17:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <pull.596.git.1585764695643.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 2:11 PM, Derrick Stolee via GitGitGadget wrote:
> Also I noticed that the help text was copied from the --max-commits
> option. Fix that help text.
...
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 4a70b33fb5f..8000ff0d2ee 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -140,7 +140,7 @@ static int graph_write(int argc, const char **argv)
>  		OPT_INTEGER(0, "size-multiple", &split_opts.size_multiple,
>  			N_("maximum ratio between two levels of a split commit-graph")),
>  		OPT_EXPIRY_DATE(0, "expire-time", &split_opts.expire_time,
> -			N_("maximum number of commits in a non-base split commit-graph")),
> +			N_("do not expire files newer than a number of seconds before now")),

and of course I messed this up even now.  Should be:

> +			N_("do not expire files newer than a given date-time")),

-Stolee
