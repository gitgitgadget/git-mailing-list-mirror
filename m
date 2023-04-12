Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C4C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDLWCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDLWCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:02:14 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780585FF7
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:02:12 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54f6fc7943eso128399007b3.3
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681336931; x=1683928931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AefJ6G8VTrnAVPO3Zt8Rh+p5hjheOwrPOD/rRV5RnNA=;
        b=44aSQ77gukZNMWBpsXNZsEPbdatyTTkIY/QjqUO+9XW1TyI3/4lWkyFXQVsPx1oEVR
         Sz7du/fQUcVDhV44GRoI0fVZPzqdL+YNcqfjjrqlnK0D+fEdOtL9w5DhOXCaCNVkiCbP
         WgSkgmUvzF+0vaz8CwNaqVdv9F052/4AnBX+zcMHq3IWDlUCqUqnX4knlS459IFGRBVm
         IYZeTdwyKJkkwOYhp+fJnYWFVAfH5t1rdC9Jz30NPPC8ClgdNfdXaqLGJAZ88B+9NK1q
         9oOd3qKeGPJgmX3/08nwtgjnFLhJQMROkg7HEMspLBDD2GSYS7kqPubp4x3O0MRfbCvx
         hiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336931; x=1683928931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AefJ6G8VTrnAVPO3Zt8Rh+p5hjheOwrPOD/rRV5RnNA=;
        b=hdr2v6mnD/SRFIXNxKBDzqGEdXWlL8lRclXNPOdACCQ+is8qh7TUSCBxZmhD0w3uTv
         /DHg+qCuUOLdS4ZW2enSK5mFW6W/NHKULLqm+cSghdXYIp0hPVXmIiFnwz/f9KBwNj0y
         xgmmbhzKyG6wm3bvcu6tyKqVOIP+/4+9rWUDqBzQcKXMQpqBNj1gUyMnRQbJZ/iZvS2H
         z2mOKC1Jmh3GRWXz341BcX5k6b6lVJTHA063WL5whaK8hKBSpUHrfoIJRgH0LbyXUZLY
         W7p9sxGCxpXQ72ikqBcWH3wWwp2SwN+pIQYXYHdo5+dq8aOIMyIANC3zlyl/sXAGzhxp
         VmKQ==
X-Gm-Message-State: AAQBX9d6gQtO8EOk4J89eyV6pnsU49SPazYfMDW7gxCzdbx6/HoKOrAD
        BWKCA7vg8BQaSynS1DdefkX7wA==
X-Google-Smtp-Source: AKy350a+GH+WfdQf4i7zxAiRsgIpTksdAnb6VkUWwghm3ioPiZShScCuRTPXkQZjAPIjk2yt3j4P6A==
X-Received: by 2002:a81:a0d5:0:b0:54e:ed44:a866 with SMTP id x204-20020a81a0d5000000b0054eed44a866mr60016ywg.19.1681336931457;
        Wed, 12 Apr 2023 15:02:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 135-20020a81128d000000b0054f8b7b8514sm839634yws.128.2023.04.12.15.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:02:11 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:02:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 0/8] repack: fix geometric repacking with gitalternates
Message-ID: <ZDcqYn7urrkwzX+z@nand.local>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 12:22:27PM +0200, Patrick Steinhardt wrote:
> Patrick Steinhardt (8):
>   midx: fix segfault with no packs and invalid preferred pack
>   repack: fix trying to use preferred pack in alternates
>   repack: fix generating multi-pack-index with only non-local packs
>   pack-objects: fix error when packing same pack twice
>   pack-objects: fix error when same packfile is included and excluded
>   pack-objects: extend test coverage of `--stdin-packs` with alternates
>   repack: honor `-l` when calculating pack geometry
>   repack: disable writing bitmaps when doing a local geometric repack

This is looking like it's on a good track. I gave this a fairly thorough
review, and left a handful of comments ranging from "you could do it
this way, or not", to "we should probably adjust this before merging".

Let me know if you have any questions, and I'll be more than happy to
review a v2 ;-).

Thanks,
Taylor
