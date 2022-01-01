Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20153C433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 20:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiAAULp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 15:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiAAULn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 15:11:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D68C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 12:11:43 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g132so19148110wmg.2
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 12:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8q75R2q344pGTwPoWFFMOV8Y476Vd7zO3NeV3n4A2AQ=;
        b=TskB7oWH6OJOnYHFqlcPMN7vHHHzQR6vm3RxotYqXp3taC0S3m108ARl0d25RHGzw0
         hvUg3nVPN6/YkSydc2L920x4yce0VrjREULkZ+1P0dWBEh2jllnTuy42H6Q6T6wFrptR
         FOdT3rG7WFnu400csz4ID96kRa63ZIiyoxOvuXGexKTv6vAucZZFuh72MEUDi1KBPrHM
         iy13xEGLLixq7OQH1lfohC5fppqX5L71RmRbV0GIA43Hm0p4iIJnzgw2SEhzZ6qtooE2
         O3wh4274y8g+K4g3VW4NsHaLejjcH9ejNj/TRj2rx44ywsRboc7u7CPfN1FoNa80QPT1
         VB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8q75R2q344pGTwPoWFFMOV8Y476Vd7zO3NeV3n4A2AQ=;
        b=5vxsenoKh6IGPgBjvk4td6kmw9K+/WXMWf3koY71FAznkaDmN50nFcx9eNXNVL5gRN
         5ur5dTXt5VntiX75tWFc+E42bMTWUHRa7RXSWjcORez6h1fgYdSn/jxRO8f9Yj0UCb71
         JXwLGJPrAiAliiJKRbdaQ9XeR3vEsFpdidTfeGSLEpNWJ1czWZSTGNKPeL9lLVVBcWFU
         6Bf/Rb8AXjUDN0iwoVT43MHYWlRtQVQlVgxxA8kn/dfA26rg4lC4xNOHnrg1XuzOVvvW
         MpY4zL44hoLuoXm0D7+o4Egsgj0VpEybZOeIR4pqy+whooZpOa4pYfqbQLyJY3OkJ7fH
         LZAw==
X-Gm-Message-State: AOAM531SGAYGoz9YvcpAADKtd7IYz4S/3M/WmyrviBP94iwoPqlfupEX
        Q/KzTwd93AHSIdqYRG6tchkGCF4sCe0=
X-Google-Smtp-Source: ABdhPJxYj533JltUA1bYiohHFSHkYLYzMJj9x/Z0kZweOUIhTx3LfBhS0wwz0dMduxtJivIg1iqDHA==
X-Received: by 2002:a05:600c:2059:: with SMTP id p25mr33347021wmg.151.1641067902036;
        Sat, 01 Jan 2022 12:11:42 -0800 (PST)
Received: from gmail.com (62-47-8-46.adsl.highway.telekom.at. [62.47.8.46])
        by smtp.gmail.com with ESMTPSA id n12sm23213964wmq.30.2022.01.01.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 12:11:41 -0800 (PST)
Date:   Sat, 1 Jan 2022 21:11:39 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] merge-tree: move logic for existing merge into new
 function
Message-ID: <20220101201139.elxj76zr2ihrjkdr@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <9da8e77c1d7c3645fdad74080c0093f420dcfef4.1640927044.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da8e77c1d7c3645fdad74080c0093f420dcfef4.1640927044.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 31, 2021 at 05:03:58AM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In preparation for adding a non-trivial merge capability to merge-tree,
> move the existing merge logic for trivial merges into a new function.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge-tree.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 06f9eee9f78..9fe5b99f623 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -366,15 +366,11 @@ static void *get_tree_descriptor(struct repository *r,
>  	return buf;
>  }
>  
> -int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> -{
> +static int trivial_merge(int argc, const char **argv) {

I guess the brace should probably stay on its own line
