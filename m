Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF3E92719
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjJERkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjJERkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:40:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA4EB
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:40:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c4c594c0eeso847081a34.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696527634; x=1697132434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrHDL/xPECvRvova41hELWNnICL6VF9y663Ipp18svU=;
        b=rK0EH8AluxJtb4Ajoj/RJkKzlb3NhmiZpgT+vN5dz7YpGDGpAaPsHsQF+/BBypJFIB
         2UYEP36GVPqSWnXIUwNF3iZ/KjjoRkzZFlgiJVFYgmIGWwc/aPlRvfsXT2ZRNNaSN03D
         8W1IkcP/Zs0cN+X/DHylIlOctII9hiLP1MBkYUxR9hOfxFIy/7r3mZCAHda3Lvy/LX/b
         NTQm+hJbMuIvgQnSP6UrR3lc61LMDA4pLuxodc0JrLuk0v3tpoplGzjAFH0QpO7Iq3XD
         rZDSxisaCSqe//zeL5lDtn23GhDPM4fYaK2XDiIzKR4ILkg5KMWte0kUTl2j2/iOdCzj
         V/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696527634; x=1697132434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrHDL/xPECvRvova41hELWNnICL6VF9y663Ipp18svU=;
        b=BK32O7Jmj4nyIuO0DXCcdm5aqty7eMAa2z9lyVfZaLyl/3VuoxHAFmysfHxk3bLXfm
         h49pmln6Y6HLU1avLoqiz9N6K6nHl436Fi55XhsxVLGseaC9UhXBmz9R4Dv6wzKlYe7Y
         brySFqsi7KLwZeZVhzaf4VJot4QX6NFvQuVm/0i1OsUBM/K3tBiNeyBqM66c/Zwcb5Eb
         F5VcQ6gID6rCc2S/xU1qGq/5PPJ2xbM7q8tdODovhG0kKKHIHoT+SBi+wOLem+UDYxmB
         zmOlsr82qRE2FZ5BaDIDZkJZeOoUtIoLAcHy/WgtO2lXvHGIXfR2SbkgtOwx2rLnT0f4
         lOYQ==
X-Gm-Message-State: AOJu0YyYhX6Krxb5Rf4zBaB/dYFeY4K69VyHzj/JGojxe+d3ebYLvpou
        36jeDx5FC8VpYyAZNKFJIWZEATstQ0f4rZs0OIOSWw==
X-Google-Smtp-Source: AGHT+IFc6F9p5ZRKmW5rk/SVuid8CDVObD46KqIwDPTfdmJxzAcWmgAgeLyP8zF7U9QMlcZU2f47HA==
X-Received: by 2002:a05:6358:70c:b0:142:d71b:59ce with SMTP id e12-20020a056358070c00b00142d71b59cemr6500114rwj.26.1696527634472;
        Thu, 05 Oct 2023 10:40:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j22-20020ac85516000000b0041803dfb240sm631431qtq.45.2023.10.05.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:40:34 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:40:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/10] t6700: mark test as leak-free
Message-ID: <ZR71EdeO1Ige1+Xe@nand.local>
References: <20231003202504.GA7697@coredump.intra.peff.net>
 <20231003202609.GA7812@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202609.GA7812@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 04:26:09PM -0400, Jeff King wrote:
> This test has never leaked since it was added. Let's annotate it to make
> sure it stays that way (and to reduce noise when looking for other
> leak-free scripts after we fix some leaks).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Obviously not directly related to the rest; this could be spun off to
> its own series, or put atop jk/tree-name-and-depth-limit and merged from
> there.

I wondered how I missed this in tb/mark-more-tests-as-leak-free, but the
answer is trivial: that topic preceded your tree depth stuff ;-).

This change makes good sense, and I don't think it's worth spinning off
into its own series.

Thanks,
Taylor
