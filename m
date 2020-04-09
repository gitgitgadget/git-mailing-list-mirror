Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3BEC2BA2B
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68902074F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 15:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx9kV5Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgDIPVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:21:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46462 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgDIPVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 11:21:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id x2so1322871plv.13
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HI16aODzsz+SNlYyGaHEJrFuucGsFvnhl4NtZy3Mmyk=;
        b=Gx9kV5NgELpmlWTHyNuXPsw7QGcNQ4uRb1ojxyAbRTIDuUgOquHPabKn85VJH3FE7a
         hUL/BdhavAcvJ8HXSTS+xfSA2Mhn0Yl/Ovmfc10cnV1mWP03J5zuN2f4mEgwkr6fRRiq
         3lMLB13lM/IXCNxgeAcFBdwu0XcJ9ws52Z9SbmG7xzcUYarW7WeJbv8zzngjhlutoDGk
         pJDXn2E66ivkyfJQRoJBjL732lxTeWj/6h+AMzAA5yWXg0cdz3mNMwR19I/c8JwsL7pn
         Bf5SAIej8yvvFp3JgN4SZZIF8GAzYSi1cDlnNavRBt3d8E0fPJJ8rJYLWGuzTLb6m8h1
         TI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HI16aODzsz+SNlYyGaHEJrFuucGsFvnhl4NtZy3Mmyk=;
        b=puZhPQ6XwLvo26tLgutbvpOWlORqrC6VFlO/oIDd21bwv/pQ88uwAC+MakuP0aW2eB
         eZNcxY2dkVX4V8a7nObnEJRatc+HkaOPADhzVVTR0Y08zop696U2SW+qU/nMNRmIvxOK
         C/Dfc35oj7+76ThYu9luPC//jcoIrY65Ve1s1Ba7KcHhSbnFIJRc3UcULFHGnxyAQpFT
         gy9hPRoW07HqLlbJ6Tr3A+CTjfbTGRlZ6XbWkJmzFkI4t7Bl7m23BXwt2ym4Ov3o1KxV
         leK21LL0sWAawm3Lkbdqr2iC48ScAevx9pn6T5Oe5qpNV9h2ZJoayGpc/wjgCTzVvNpQ
         u+hA==
X-Gm-Message-State: AGi0PuYYdN3xiMAZXmgG/KyJ0snd48IXDmfQ9kBwnNdKbZVr+pGqsXrf
        +2AAR9tiAZSpbYE0HV1Tps8=
X-Google-Smtp-Source: APiQypIpQeYucTPZjbgDmq+fbD/4/fem46yWP2DD1uHlBAkOvkQhfXn+hkqYAI2MrYBx9S2cfkVr9g==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr12443390pjb.109.1586445696780;
        Thu, 09 Apr 2020 08:21:36 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id v25sm18691428pgl.55.2020.04.09.08.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:21:36 -0700 (PDT)
Date:   Thu, 9 Apr 2020 22:21:34 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Allo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Allo <dinoallosaurus1111@gmail.com>
Subject: Re: [PATCH v2] t4200-rerere.sh: use test_path_is_* functions in the
 script
Message-ID: <20200409152134.GC1937@danh.dev>
References: <pull.595.git.1585588586605.gitgitgadget@gmail.com>
 <pull.595.v2.git.1586444061576.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.595.v2.git.1586444061576.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-09 14:54:21+0000, Allo via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Angel Pan <dinoallosaurus1111@gmail.com>
> 
> Subject: t4200-rerere.sh: use test_path_is_* functions in the script

"in the script" looks too verbose to me. Because the script has been
mentioned earlier.

> The original code works fine. However, since the code base has already had help-functions(in test-lib-functions),

We wrap lines at 72 characters per line.
And, missing space before open parenthese.

I'm not good at wording, but I think this commit message is too
verbose. I would say something like:

	Prefer "test_path_is_dir" to "test -d" and test_path_is_file
	to "test -f" because they're more friendly to debug.

That's not a good message, either. But, it's some what simpler and
cleaner.

> the change is able to help people understand the code better, as well as improve debug-friendliness.
> 
> * t4200-rerere.sh: replace "test -d" with "test_path_is_dir"
> * t4200-rerere.sh: replace "test -f" with "test_path_is_file"
> 

-- 
Danh
