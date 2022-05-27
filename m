Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC1C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351597AbiE0RCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiE0RCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 13:02:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D91339C7
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:02:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso4849620pjb.3
        for <git@vger.kernel.org>; Fri, 27 May 2022 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VchNMBXHzcj3xIQwtXMP9e5lQ4ExlXDWl5D2vQEg9Ss=;
        b=NnsPYfQ9jVTOVHFDeKSNjspQlZIuVPG4TurXtXN/X9JkJ81Si/tUKkko56GcSdNBkg
         EaMxfCo/EUlCXpDY6sz1D9y7OaCU8vIFJlzHjFBOmde2Hjez/Pubi7gO2t7aBrzMeEJD
         psb8XajIC7dz06O4adATsCCs8+kyomgbrCSJv4T7bbrQ9amEtBZipL2JRN5ws2yGvw4N
         yZHhI7hVytfa89u406tSlmoqQ0AKnPJGDgvo5JZbpNoRt91cPsMN2tK5pAo+FjNE8Aam
         4Ukqrlbkwx3hcUbMKmExfBS+XnbmtzbjW8//h6FDNFa53MFE76grm5EAacscNLTmgDqu
         Nnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=VchNMBXHzcj3xIQwtXMP9e5lQ4ExlXDWl5D2vQEg9Ss=;
        b=0R7AvjB55u9srHWddcZ5GLb98kJwdyDpc/uT8x9OQ4Ayzan/lSKs1VBqD4kcV1jvYG
         qGhj1uMFb0z0akqQqunA58t7pyzW6g01NiW/x7skeSywnMcE2XhfskhTE+Z5LNhZBZqv
         R8Z9sjbyU4FlsZ8PxECJJV0cq5WZh3Z8fFg2vixxbLUnNk3zYyJhIXAZKHM9ZgXYyExY
         Ip0r1116bgBIVAaLpenPQwIWPXchumuXUdj7Ad/iym65TCm1Mvh5jsm+Gm7w11ob4wXu
         1a9lwsFpUUaQ41xK3hmuzPjlJepY0witw63G/+LKjNwW1UCieEmgzV16JWi3TjIffDjd
         drlw==
X-Gm-Message-State: AOAM532Fp7yuN9iHj5h3cn2GlW/rrirwve4PiWg1mYLs1x9BToTSXq5e
        KbjiBovUL39Th+WJOUJ3IfEZXw==
X-Google-Smtp-Source: ABdhPJx79Xjsmn8ai8KwlHyWwhU3MSOVsFYT8ypgSuynM99AWNmDn2oSRnXXtlafcYdVzmUu0p2sNA==
X-Received: by 2002:a17:902:b58b:b0:162:2e01:9442 with SMTP id a11-20020a170902b58b00b001622e019442mr23640369pls.6.1653670934871;
        Fri, 27 May 2022 10:02:14 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:fbc7:30a9:c3f6:e550])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902b20900b001621ce92196sm3907353plr.86.2022.05.27.10.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 10:02:14 -0700 (PDT)
Date:   Fri, 27 May 2022 10:02:08 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 0/5] usage API: add and use a bug() + BUG_if_bug()
Message-ID: <YpEEEAprJOXYj5VK@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.21 19:14, Ævar Arnfjörð Bjarmason wrote:
> This series adds a bug() (lower-case) function to go along with
> BUG(). As seen in 2-5/5 this makes it much easier to handle the cases
> such as parse-options.c where we'd like to call BUG(), but would like
> to first exhaustively accumulate the N issues we spot before doing so,
> and not merely BUG() out on the first one.
> 
> I have more fixes for parse-options.c queued up on top of this
> locally, including a fix for one (tiny) recent-ish regression, but
> found that it was much easier to do so with this new API, as we'll now
> be able to freely use normal sprintf() formats in these cases, instead
> of xstrfmt() (where we'd also memory leak).
> 
> Ævar Arnfjörð Bjarmason (5):
>   usage.c: add a non-fatal bug() function to go with BUG()
>   parse-options.c: use new bug() API for optbug()
>   parse-options.c: use optbug() instead of BUG() "opts" check
>   receive-pack: use bug() and BUG_if_bug()
>   cache-tree.c: use bug() and BUG_if_bug()
> 
>  .../technical/api-error-handling.txt          | 17 +++++-
>  Documentation/technical/api-trace2.txt        |  4 +-
>  builtin/receive-pack.c                        | 16 +++---
>  cache-tree.c                                  |  7 ++-
>  git-compat-util.h                             | 12 +++++
>  parse-options.c                               | 50 +++++++++---------
>  t/helper/test-trace2.c                        | 21 +++++++-
>  t/t0210-trace2-normal.sh                      | 52 +++++++++++++++++++
>  trace2.c                                      |  6 +++
>  usage.c                                       | 30 +++++++++--
>  10 files changed, 165 insertions(+), 50 deletions(-)
> 
> -- 
> 2.36.1.960.g7a4e2fc85c9
> 

Thank you for the series! I am generally in favor and think this is a
useful change. There are a few minor comments that I'll leave on
individual patches.


Thanks,
Josh
