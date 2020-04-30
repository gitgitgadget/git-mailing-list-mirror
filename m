Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33350C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CF520731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="iZO8UHHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgD3Tt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgD3Ttz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:49:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E7C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:49:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so382974pfn.5
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TT9pWGpWEeFgZoOJtVqISqldFmxMdRjDZfVGH2SFs24=;
        b=iZO8UHHdrx4jz/D23zurjOzx4es1JopwvYieMjJvjZogEXmCFfb8/JnOROvdAJJx+9
         RI6OqM+6fMdnFdLDkK26ZadVoqM31z55NjRYEurBB5tKqkmXjkzaaC/vw2v9iStnnMe9
         K5pYVMTS7hj/ahGTUBsnLuDVDAyecm7zkBrXMo4kGKK4orqxwduqats1LLWXhO03OhQq
         GXjI6FAoVubnyW2TbTjnHL5sPvSoqayuYsQxjVAVJeH9RPw9DjoIghypLROQMgdOJsdL
         4/av1yOEO4hbAsLTSNWk6jIWvsT5T7llT6Mk30dR+vlFqoBC6BRulfLwmcy4IhRrNM76
         a1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TT9pWGpWEeFgZoOJtVqISqldFmxMdRjDZfVGH2SFs24=;
        b=TSt7IIwt1TYReu6RL1Vb6WgxDwmVa7nn+2tL+eTG94/MUh8w+GaqGxfYn1I1cG8sTL
         axTemrU4vA6c2A1VxfUzTx6zA4t/Y3VeDWR3tgszhbn8eW9vau65bFe5HGUT8ld63b6i
         ApBIbbVIWxuPJ7RAvgws5jNLwy+mxQXimdFv6q5DtUR5aiTOd3uEvO3Hxl2atii19QWI
         bmvP3hwAsECPMEtPf90qebImWEKJXWtgQuj/35f6/K88VTvp7tITf1aFX12U8jZJ/A2d
         pPyXoIaNPv1NQbe5I1tVVMaXOZB32/9RXVm5VQi0jMkgVIIkL9g2Yq8xh1mjncIZK/1I
         HeCg==
X-Gm-Message-State: AGi0PuYT43kXRct24DDODri0mLv1zO5HRozdb/3FqEZMy1nI0ViKGTCY
        CjNl92aoXKxqsf3KqYHI7wXgxw==
X-Google-Smtp-Source: APiQypI1Ol+yUBY1Wj/g+kyVkGVxKaxj0XPn49Ypty42pTJv5fS7mgJ7u6SyIXqgoHfYAuhLehoUnw==
X-Received: by 2002:a63:a101:: with SMTP id b1mr597940pgf.292.1588276194677;
        Thu, 30 Apr 2020 12:49:54 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id gl4sm482503pjb.42.2020.04.30.12.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:49:53 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:49:52 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 0/4] shallow: extract a header file
Message-ID: <20200430194952.GA2014@syl.local>
References: <cover.1588275891.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588275891.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 01:48:43PM -0600, Taylor Blau wrote:
> Hi,
>
> Here's a reroll of my series to introduce 'shallow.h' after some very
> helpful review from yesterday evening and early this morning.

Oops. Forgot to set --in-reply-to to the v1 of this series, which can be
found in [1]. Since I already sent the cover letter and patches, let's
just pick it up from here.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1588199705.git.me@ttaylorr.com/
