Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953C7C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352758AbiCXSvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352752AbiCXSvM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:51:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBD9232E
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:49:39 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p22so6476338iod.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F6ESojNoMdw1Nfki1n+oec4arwogP8XpgwhtpK3Itiw=;
        b=GvxkG3ZsXXF8Quo86YzV60oCiUQkNFRbAhgKFYQlq3gfR5AzMu5P3Dq14/Q9bG0Tj8
         /85mRzaakEMPciAi2XiJMhCKqPBueQ17n/pKUmu4BoWqb/tHnkepyFRRYupRmThAnkxx
         qbrGJqhauA2YL/pyXlJ/IBTYIbDFmMLv8++xSt3bIV/qfIRWvVDnsHJofHcAHpM8EEoJ
         U/qd6PAL13SbMK+cmm1OeakkdDaawpZz/BXXsdaFaQVbwQioG7r3ktVl0NOrjY9yMlBg
         nApFO+7b8Ha3Y1MrC3W8SljgAe0M7r3BE7GFtuQ87zxRRq6GQ7dldb6lR+Anr/OSJjcJ
         VfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F6ESojNoMdw1Nfki1n+oec4arwogP8XpgwhtpK3Itiw=;
        b=a9ghv8/6Ys39GsKSDyNxcwjIvEP/b3hP3oPieOArib3d3W6SswGA7aBv69wP8ejeU4
         Kxg9VI+YRicpT0t7CeeE50cyFBb08Z1n62GMFDzKC04xHFMKUPiEI5clD7NYgjBNWPJe
         rHbQEM5zhgCd//XT0UC54OWa7SOsjqkFvCBvieK0IUJSqs8H8hycWsXWNs2sRqNeH9U4
         In30gcgyaKuV9j5nM0GFU3DNVoEG9J1b4aGb20cmIgl02OxVHu3ExFfUCQcScpn32eR1
         6Nz5Pc5BwW3QYexFmcQRwwnA2mVsh54YRbbveLXWG3/3ls69lhE6UA/Hrv1vHcMIzFtD
         fxHA==
X-Gm-Message-State: AOAM533JnOympYtPdIz2+dMIKMsfVAQZXpMZyTLcmfUNo0IB/ReoUEJt
        zZAL0hnpU3TIEWIzpOhI3WSXNw==
X-Google-Smtp-Source: ABdhPJxY8kzgBS4MlP55Ym/2aaJyqDkWbW/WHFfIINe2U8B/9DrX5QdkhYZBNsPIJ0TVj5aLrR+5JA==
X-Received: by 2002:a05:6638:1608:b0:317:c115:8816 with SMTP id x8-20020a056638160800b00317c1158816mr3499243jas.84.1648147779304;
        Thu, 24 Mar 2022 11:49:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m5-20020a927105000000b002c60ed6d3afsm1863130ilc.69.2022.03.24.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:49:39 -0700 (PDT)
Date:   Thu, 24 Mar 2022 14:49:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/2] test-lib-functions: fix test_subcommand_inexact
Message-ID: <Yjy9QhGpd2C23ltg@nand.local>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
 <ed67b7489719a01c88d7a6765e7499c1157da32e.1648146897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed67b7489719a01c88d7a6765e7499c1157da32e.1648146897.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 06:34:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> All existing tests continue to pass with this change. There was one
> instance from t7700-repack.sh that was taking advantage of this
> flexibility, but it was removed in the previous change.

In my tree, the test modified by the previous patch was the only caller
of `test_subcommand_inexact()`. Looking through the output of:

    git for-each-ref refs/remotes/origin/ --format='%(refname)' | xargs -L1 \
      git -P grep -l test_subcommand_inexact -- t | sort -u

it doesn't look like there are any other topics in flight [1] that call
test_subcommand_inexact(), either.

Unless you have any pending series which want to call
test_subcommand_inexact, I'd be just as happy to get rid of the function
entirely.

Thanks,
Taylor

[1]: My `origin` points to Junio's tree, so I'm looking through all of
the topic branches before integration, not just the standard "master",
"next", etc.
