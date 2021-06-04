Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96279C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7509361153
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 20:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFDUVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhFDUVm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 16:21:42 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EADAC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 13:19:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k5so1628102iow.12
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lbk/goq7ZcS587dbvx8sq0GdywPWsyq+MIBSRWiJGWM=;
        b=UClyLmShv00d+LD+MhiRD2MI1ot7MHfeuYhV66EppwKGiYfAUORG6oodLAeZsAafZ2
         odb8955rb4LVtNq3MEnUcMDhHBMWBYFslSGPrAJ3jGvow1LKpGbKFtPJ3TpLONzLgLfk
         Ph653u5NImTUA3lJkVUOA7GArCIKevQRK4lHd/0w2D9xxVWrL1XBCIAYn2SWztTwTxH/
         y1o4OjFsswUQ1MzBgnFtHysJ7k4AnjcTJiYZIULUdp9J4b33UKCYlwRNYsRUi2yyfCCN
         QvMFiEQZnqrS4eHu0FNm7uUgmVAJ2FyZZ6TiPRD/8rGTxAHEXR56Vc0IxbwfJjn5uCeN
         jKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lbk/goq7ZcS587dbvx8sq0GdywPWsyq+MIBSRWiJGWM=;
        b=fPEt5rYLJZKb01mVBkfH2EVyUmh4V0oZvnEia4chP6p8fGpsO9LyLUTLehEAEefXrI
         9b7Ho1ymHJeNMcY+YCJ8O/uLQnj1Q3oD5MuOLV7Xyz3nmcPjGSFxt66W9dBTojyFKkv2
         OwplBllxMPt35zcpPgYyZC7aEpHs5TOBblDG1dH6Vn3/aIEXy1geWd86DhIuJfTcXh95
         QJVD8prwR0EgsAIDoeRoCZK+F41noYzDSNLboMgxer4dBwqX2DqVHiiE8sg0mnJgzwt6
         z2H0pz2uJQDvQBUCCw93rrZKatxFSnBmnXhZrqFrMxW6GwHDJ2b1yQXbOAr5VNeKqqCm
         WXcw==
X-Gm-Message-State: AOAM532eVEtRfnBs47wQndsc7V3Zc+RHuAy3wYnZ+tp3MilorB2PJm+6
        XgnmWrd7j9Emk01AnQ10+mbeQg==
X-Google-Smtp-Source: ABdhPJzzj/Hx0DIxHMDalLiBvC9b6bBji9WBSPZ9NeDw1YevD8Nnhsg0wdkG7ocyVlFqLi5XPkHLCw==
X-Received: by 2002:a6b:8ec2:: with SMTP id q185mr5086533iod.22.1622837995305;
        Fri, 04 Jun 2021 13:19:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e28c:b821:dd88:1fd1])
        by smtp.gmail.com with ESMTPSA id a11sm3818348ioq.12.2021.06.04.13.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 13:19:54 -0700 (PDT)
Date:   Fri, 4 Jun 2021 16:19:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] run-command: move envvar-resetting function
Message-ID: <YLqK6XTmnaQoFycz@nand.local>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <c5307a9f02f3f0f9b30c87bb3e9f8fa3163f839d.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5307a9f02f3f0f9b30c87bb3e9f8fa3163f839d.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:18PM -0700, Jonathan Tan wrote:
> There is a function that resets environment variables, used when
> invoking a sub-process in a submodule. The lazy-fetching code (used in
> partial clones) will need this function in a subsequent commit, so move
> it to a more central location.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

All seems pretty normal to me. I did have one question, though:

> +/**
> + * Convenience function that adds entries to env_array that resets all

Hmm. Why "resets"? IIUC local_repo_env is the array of environment
variables that change behavior. With that understanding in mind, I
probably would have written something more like:

    Convenience function which adds all GIT_* environment variables to
    env_array with the exception of GIT_CONFIG_PARAMETERS. See
    local_repo_env in cache.h for more information.

(Confusingly, cache.h calls this variable CONFIG_DATA_ENVIRONMENT, but
binds it to GIT_CONFIG_PARAMETERS. I think it probably makes more sense
to use the environment variable's name rather than our #define, since
we're saying "all GIT_* variables, except this one", so it would be
weird for "this one" not to start with "GIT_".

Otherwise the movement looks fine to me.

Thanks,
Taylor
