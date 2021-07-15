Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF97C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440C9608FE
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 09:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhGOJ6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhGOJ6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 05:58:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60DC061760
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:55:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p67so5931443oig.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=tJXzip6QWCETYB5Bukk/Mei/IzN/KdHeDoFdDOEaQSE=;
        b=hbD5oBSHC1uFPBsm1jGEFifxbms55NvcIS0AqRyoR8ITRWClpP9j3VMKjb6T1K+EMd
         j6r4S56FlM+IiIqp7Dp/QLFRvkELhyqMPycyK90RsRSZtsVE3djsjepfGr6/CEu7zUlm
         rZGhI2BVZrwIZHYGP1DiV4MqYOzQ5eXiVd7tEQEt8HmANXk0MUU9+z/U/aDf6MVHRzCX
         rqEgdOASMpUMMcq0m8gbpVvfftzX6v9/HM306yYsFFsKi1tBdj25YeC42JFQpduzr+wm
         QCAQ9n6m+p5Lxy+AxRLpNA4dctte/5+83nAhjkUhoSluTZCE99HO4qe0soAONldh2PEi
         q/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=tJXzip6QWCETYB5Bukk/Mei/IzN/KdHeDoFdDOEaQSE=;
        b=fNi2XUpaA1bFgJKutVhcgWH4Cz6MN9u+KyPg6zXcckZ2dnnbnPd6+nZoCB1P4yAgUi
         hvbPxuGe97cBVtl2LV4wiawc2UfBeDiQyYl8fcZxFfonGGp6Mz8tOMFYw9F80tOK0225
         Oqm5eDV45SZGtpzXwUqOisLz8HFjOXp3cK6dx141+QqVoGoTuPuCc1o6OZ76S+g4XP+f
         s/v0NH4/MSvTaTKDLsXcENauJT0+uZzMgPSCMnrGFAqBMZ/PQ74mCSQzzvCtK4nlc6m4
         w3SLHZqtKNyb2r8modvmjvqeTgGo/OKL8tn/LLraep8K3ynlaRy3qG/iINrB6tw299gB
         Snzw==
X-Gm-Message-State: AOAM531wb/Yq4YTEbwv3i2kDnWRpsppaPiK8AIu7K3HQQizgZXx+qu8U
        fcNtDIvinZBID0rRMhexMyM=
X-Google-Smtp-Source: ABdhPJzuMzEVD9v0kO3rRJzWbsmQmVCqLYzQrV3iYQc1R4WbJhgaFOW9AUChZOdAG+oVf+ND5wgr7A==
X-Received: by 2002:aca:4b04:: with SMTP id y4mr3049940oia.4.1626342931311;
        Thu, 15 Jul 2021 02:55:31 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id k2sm973263otr.52.2021.07.15.02.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:55:30 -0700 (PDT)
Date:   Thu, 15 Jul 2021 04:55:29 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, newren@gmail.com, phillip.wood123@gmail.com,
        avarab@gmail.com, felipe.contreras@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Message-ID: <60f00611796d0_2e672085d@natae.notmuch>
In-Reply-To: <20210715050559.3371470-1-alexhenrie24@gmail.com>
References: <20210715050559.3371470-1-alexhenrie24@gmail.com>
Subject: RE: [PATCH v2] pull: abort if --ff-only is given and fast-forwarding
 is impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> The warning about pulling without specifying how to reconcile divergent
> branches says that after setting pull.rebase to true, --ff-only can
> still be passed on the command line to require a fast-forward. Make that
> actually work.
> 
> Per the discussion on the mailing list, explicitly passing --rebase on
> the command line countermands pull.ff=only in the configuration or a
> previous --ff-only on the command line.
> 
> The --no-ff in `git pull --rebase --no-ff` is still ignored.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> This is the code I was working on when Elijah sent his patch set to
> accomplish the same general goals. Mine is a less ambitious (and less
> invasive) approach, but I don't care which solution wins.

This is a better approach than Elijah's because it doesn't fail if both
pull.ff and pull.rebase are configured.

But there's still the problem that the new behavior cannot be
configured.

-- 
Felipe Contreras
