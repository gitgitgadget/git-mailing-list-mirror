Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87105C4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4747621D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 21:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjMn3C+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgIYVYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 17:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbgIYVYa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 17:24:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742EFC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 14:24:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so4451105pfp.11
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Ub7wEeFnRjZ1q0aUDvHdqX+fT9067J5YyFnttZGwdk=;
        b=UjMn3C+TOPm7Kp8foCQ0dEB6Rjb+BrhM1bjssx8By+fG9gZ+z/+mLzH7JmBvcyY0hu
         1u01JQFI2PUX/0IiEmSNOaXcE9SwnrtO/ULKXRaRpWQzpZ5LJsMyccKkamm4vo8doLAW
         9CnlMSsNxOYm2EYv4o4xwM8YhtRy4MEDiXvCR4VTGGqAZgfA6Z++oBSzPo2Ge3XiYuy9
         d3b1P5teCrymqQuBvJH8FQfR6ugotTtcMsSm3nOliRhBSmFgsQlh8cisUQ4q5XlLFWUF
         +79GiJAi6ifZIuebUxidVBdoxdKgojtzDhr8wggTlKzAFU7pF88oN/gLWfXuXcp1bSS0
         pe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Ub7wEeFnRjZ1q0aUDvHdqX+fT9067J5YyFnttZGwdk=;
        b=KBIUVbmwUNvcnZavgpa46LOCRmEg4+dZr3IcYAUpe2AhdZuPEGcXDG4mKpYW8Y47by
         8acvsFju98PCxCFetMAYBHUQHed6uBBUEjnIFtxsLa5GQW/I/39h+cMJDJ6RMeyGVlQy
         1ihidY5zf/DLO6Y3dGpJ6vEEzIkCqbAiVydxqCTzVerMHqPNk0YS7wjqObFr7M1O+s1D
         hCZHUSP0nbwXViu6/JbFk7Ab2Dny7u+fsJutFGa5mIAKoabQSQBkx4dohlYDkpPS+Bv5
         SnYGoq25UCPws9K0ytDh/8pQS+Wdu2cvUgrjpsf6Y5mAb0aTJMKr6sWGWD4txZjwK72q
         a3iQ==
X-Gm-Message-State: AOAM532Bx/nYZF7DLbrYL5CqLiAIOaO227nR/RloD2mlhtW3LgUZr5yQ
        88j7vZDxeT2ADlWrsBbrjmE=
X-Google-Smtp-Source: ABdhPJysEFDojyDahd6bVKnIbJqjd9WYGF4dNZHJS+m18uG41javk/3KAQOiUOyq11q+IYj818bc3w==
X-Received: by 2002:a62:7747:0:b029:13f:d779:5f95 with SMTP id s68-20020a6277470000b029013fd7795f95mr1074433pfc.2.1601069069937;
        Fri, 25 Sep 2020 14:24:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id b4sm118968pjz.22.2020.09.25.14.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 14:24:28 -0700 (PDT)
Date:   Fri, 25 Sep 2020 14:24:27 -0700
From:   jrnieder@gmail.com
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] protocol: re-enable v2 protocol by default
Message-ID: <20200925212427.GA1270882@google.com>
References: <20200925183436.GA659633@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925183436.GA659633@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Let's move forward with v2 as the default again. It's possible there are
> still lurking bugs, but we won't know until it gets more widespread use.
> And we can find and squash them just like any other bug at this point.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config/feature.txt  | 4 ----
>  Documentation/config/protocol.txt | 3 +--
>  protocol.c                        | 6 +-----
>  3 files changed, 2 insertions(+), 11 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
