Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A70C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A352208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VabIM7+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgEAXov (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 19:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgEAXou (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 19:44:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C49C061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 16:44:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so2253769pfg.2
        for <git@vger.kernel.org>; Fri, 01 May 2020 16:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5f15zPYMyi5K/DbHZLTS1bbW19UC3bE5W6osVEMNC4E=;
        b=VabIM7+ioRXp5yywxmupvclJOWMsc2zUULsr5W4KB49DrudbQAOkJEs68xjaNVltGP
         D4+uKxg3bdwFgfMtVjdFmdxdeEG+P3G3SoE1ez5Z6urq9DeFOmMwmjmNiCtR6EIoM+ln
         Y26/fC7aEX7ithfkgEVPFTr8IIjTJWoKRmFuCZoY6r8VY2rgBOmKNaw/nfGotMfu202O
         vUlWIjz745GCIZ5+tR5vvTsqVWPRoOjqKREnkOGrXgZPueU8iCspZSe6EJBtMGKRu4Yj
         UvJJSWf6qNZf+OAOy6T7bTVrHEAQ0eXGTBpcBdaaUi2+KNYfy1UMn1tX8aMpnffg90WW
         AiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5f15zPYMyi5K/DbHZLTS1bbW19UC3bE5W6osVEMNC4E=;
        b=dRQfW7O/+N6jEj3ih0kW836/YXPdiiPV6g52nvGR0QlUCuFpq5RLytUTCTb8QnH2en
         jmfsgY9wsLn1QhQYDovkEJgIfRhLsIQv09mHggmf5jKl6FZH1JTAL7fihh4O2XzqbjmP
         QfA1ze7Beq/a2XzHZ+7krVRqh4/NEkOKfvVBWyBUnjhLLlpQekD5PWOVE+RwDsbRnpvd
         u7wn2uxrhAexvgfW1QvZujNUXpTl6yF6u/3STK4gyc+pcDd1pcJPdP5MyiqDnbOcgUeu
         U/ygBJVW78PGlmdi7lCYtrJ1LEArp7zastt8K+PmmmZcBsyJYMpHwQpUXZ+QrtfudYbP
         LlHA==
X-Gm-Message-State: AGi0PuZpsgbOJIjQJwqaNBBFIguJEtM98jZp0FtaSjW8rbhTQd7ikp8c
        tEbVv7k0NZjBbVoU2jEzLYHrnux0vVJzUYhb
X-Google-Smtp-Source: APiQypIMQEkIPMiq+CC2yzQTL4MGuyEHmmBw9eJIvEEYZiO51tCfJVwQ522JDnekFwWYAq1VtbNS7A==
X-Received: by 2002:a63:340e:: with SMTP id b14mr1757148pga.290.1588376689970;
        Fri, 01 May 2020 16:44:49 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d126sm3261561pfc.81.2020.05.01.16.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 16:44:49 -0700 (PDT)
Date:   Fri, 1 May 2020 17:44:47 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 07/12] completion: offer '--(no-)patch' among 'git log'
 options
Message-ID: <20200501234447.GD46422@syl.local>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <35d2901957efbb8727142ef633ae0953b613c0d1.1588347029.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35d2901957efbb8727142ef633ae0953b613c0d1.1588347029.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 03:30:24PM +0000, SZEDER Gábor via GitGitGadget wrote:
> From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

This doesn't look quite right ;). Interestingly, Git applies it just
fine, and your encoding looks reasonable to me.

> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c21786f2fd0..ec6ff1d5fb8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1860,6 +1860,7 @@ _git_log ()
>  			$merge
>  			$__git_diff_common_options
>  			--pickaxe-all --pickaxe-regex
> +			--patch --no-patch
>  			"
>  		return
>  		;;
> --
> gitgitgadget
>
Thanks,
Taylor
