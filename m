Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4BEC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A0764E30
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 03:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBKDHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBKDH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 22:07:26 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9DC061756
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:06:46 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q85so3967849qke.8
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 19:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x7h1ecUwgaDH5Y98Fru7/E891HGahp/HTqnm/Lcgbe0=;
        b=Bqy56U/zsMu8WYqGKo5OOa8L5/VkI4xhpEB3kkCKzciawdQOn8BgHu68K1/bYaUlNZ
         jTYXp91rM5IJqrb+8C/ZhReTpvXPKwykUlwh75CMVzc2q3noovgDxBJco2zU2iB0i0Ee
         0Bh0A3sSLZ5rJwzasUFb4qNCFtSP5qm+ftrzmBCSMzui62mIIty4Oej7XYwgtDBTBgFy
         st0McqLWxDJaYs6k5JBUQS7igYxtGddX/OAkHyBUGbERZAqJZwqRc+g+CNevmD63APzl
         tTbrxfSyC4bv9ysZ2eXFrJvXZI4Ja1FcF7//9oMtJ5oF8JCcOQXtB8jIF3aKhpVO9bks
         y0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7h1ecUwgaDH5Y98Fru7/E891HGahp/HTqnm/Lcgbe0=;
        b=I2beKCAzVo3DYUAWmHetuCGlCbC4dIMl9Qwb1tyzokqrm8R8hcrcWXdQXsccgJ9WKb
         NZSKvqgOQKTIhHDzOy/KG/akRmL5hP6dZX3MRG1uP7wDMftcpUoivU0b2vZxvhj0t6bp
         CzyVLq9q4rdBMHtn7eez4aXyKuD986FNV9johJRVGUPNKdsG7oLUXX3whAu7XHVZtqnH
         pJRCCiPzgvQe7p66jfL2ZLu86my2eejxq8YyIRqhDpz6qXhVpLquu/W+s3yWK58iWW1B
         k60KzjN0kyegicbYQZwikccKetOgnmgx7EdVnytUriSaIgvh18P3DdjRFSLimW9Pdni7
         hRHg==
X-Gm-Message-State: AOAM530iHp9+Y/ezhzKElc51HqZSVynOFGe+ACxLSoDtyfvcW4lAEgnA
        JpDgCesI9IXok3etSd7IkrNY5EmzUT8hIAUz
X-Google-Smtp-Source: ABdhPJxneFst0iG1gZ2Ch0XLmMCHK0O/+aEyAd5jvxCv56cMAq5MeLOG4QQ2TVkHZvehHjIcPlDVlw==
X-Received: by 2002:a05:620a:b95:: with SMTP id k21mr6601239qkh.125.1613012805329;
        Wed, 10 Feb 2021 19:06:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:666f:3d4:2894:5ee9])
        by smtp.gmail.com with ESMTPSA id t8sm2826242qkt.125.2021.02.10.19.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 19:06:44 -0800 (PST)
Date:   Wed, 10 Feb 2021 22:06:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 0/9] midx: implement a multi-pack reverse index
Message-ID: <YCSfQredivkRj1Es@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <f783c173-6a0f-71d0-174c-78e310d2edfd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f783c173-6a0f-71d0-174c-78e310d2edfd@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 09:58:18PM -0500, Derrick Stolee wrote:
> This series is good prep, and my comments are very minor.

Thanks for your review, especially on a series like this one that adds
lots of code without any users :).

> Since the need for these multi-pack-index-<hash>.rev files doesn't show
> up until the reachability bitmaps can be paired with MIDX files, it
> would make sense to hold this series in 'next' until that one also
> stabilizes and they merge to 'master' together.

That's fine with me. It would be OK to merge this down to 'master', too,
since this is all dead code. In fact, that may be easier to work with,
since the next topic can be based directly off 'master' instead of
having to keep this branch around forever.

Either is fine, though.

Thanks,
Taylor
