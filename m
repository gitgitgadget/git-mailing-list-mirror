Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51325C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 02:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiKPCJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiKPCJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 21:09:22 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED955F8E
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 18:09:21 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id b2so12186435iof.12
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 18:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XiuaCjsXH8KKr5LWNqTZlcKN4zjSmvDK31n9Dfw//8=;
        b=LIiXHjIH3E0SNQciQRrQuuM6Ria3+2SbtafPbje/TRVGsgG/klzTgA4xMF9B94IWps
         6a84a530Wg4HnW3WztXvMUlkdCr5LunJqscL6jndzCoEs3/4ywjaDTUdHLf+BQggIoMP
         iTd2vyoASzSWa+xSLUmKl91v07Cxv5Rb+Xf0M/5AZ05dKq1xiyilSWuDXqX9H2pSQOCs
         wjNdHPEDXMCFWuXNEQ0mioflMmcBt+tEBzmZ4tTL+/Bk6r3GLn+cCVq+nWJVx6oKyaIU
         +9Im8R2AO3A6GB8tIdd6UXRHuZPH4sTE5OpB0wWJZFSGlxIbOO0/0aOzdsvc2+VoQjNO
         5D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XiuaCjsXH8KKr5LWNqTZlcKN4zjSmvDK31n9Dfw//8=;
        b=nQvpvEt5Qa1TrszlXZdWjARAgRDl6BKA2GDsuwLkRD3qugd5BQvFkPT/KAx+8m8HlI
         HaIF1YnN9sktcSL18vnBy4aetXgSrAFyrKSDk9sWqCaWNi2RkjJToGuCizAQIDNPxblx
         5nwo4diCBZ9uwsU2b95siJl5k1foc7o7a3PS3v6kYLU98npS8aRE3KScOgkPCaJunjUO
         vBFwzeAtHhLFgpkl6xsZKd9jfvxkIAQesNx+zjzYZP/x1lAhfIFe4uK8UKObVnj4unEY
         dTmnAB83yCqbTedy9F/c/2Dm8/LU7CN8PcTDhg9Fwlr+0JpHBLh+bKeIPOrITGTUjY/z
         r2Iw==
X-Gm-Message-State: ANoB5pkIxAjNS+2MV96wBuN8eXQ/4cNUJS2W4ap95j3g95U39wPN2aWD
        kUXCzE67MvnD1qLtTnyz/Fk3Nw==
X-Google-Smtp-Source: AA0mqf559cpjLGV2HPGPvsnYt9KprdLoFrLnBHHC7F5lA703emOePjhYaUKTs9sFimMdLKgkFKVNTA==
X-Received: by 2002:a6b:ca07:0:b0:6a1:2062:9855 with SMTP id a7-20020a6bca07000000b006a120629855mr9225647iog.214.1668564560992;
        Tue, 15 Nov 2022 18:09:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c12-20020a02330c000000b00363a4fcd3a8sm5149553jae.5.2022.11.15.18.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:09:20 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:09:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] range-diff: support reading mbox files
Message-ID: <Y3RGT+KCxkI36bFo@nand.local>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 06:20:05PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Let's offer a way to read those patches from pre-prepared MBox files
> instead when an argument "mbox:<filename>" is passed instead of a commit
> range.

Very cool. Thanks for working on this. I don't have time to review the
whole parser right now (and I agree that it would be nice to see it hook
into the existing stuff in mailinfo.c), but the idea sounds delightful.

If it's possible to use the battle-tested parts of mailinfo.c without
much effort, I'd be in favor of waiting on that. But in case that it's
not, I agree with you that we shouldn't let perfect be the enemy of the
good[^1], either.

Thanks,
Taylor

[^1]: Though let's make sure that "good" doesn't have any buffer
  overruns in it ;-)
