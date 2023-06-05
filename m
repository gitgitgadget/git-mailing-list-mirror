Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A5C7EE24
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 11:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjFELge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 07:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjFELgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 07:36:32 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A5F1
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 04:36:29 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-56974f42224so34676837b3.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1685964988; x=1688556988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RTiVi9im9fDCKFiD9pK22R6NWa1NRMj5K7EvoAFpyrM=;
        b=5FXH7C9bbdvzliVKt3sMV8TF1b1xLXNs30LxY1d2/HfHOJvZAczDNG/lx3+2vY/Prh
         jKfsmcM8kNmdQMksUXXudVNkEIdnMBJq0Y4A4T3Jz+1ehlmQQuY3GvLO/5/5swZjDJcS
         q5YMHRKNN8OlSM5NAmoWTD6yyDpsFeMc4Sgssuk7CS69z04Md4SK+4Gc7xE7PioDp+jw
         BIl9KZ8FzGMJWRllFtsimFQh2ygXWfH/kQf53oJVhc7vcZB0I2rzAzstSTcTgdClSGsy
         lZ64o7DGx/ELDgVXjoeR8ypQfDWnxkj796W5cDLAjT6zPFXunw3V+0tM84H2UmFCiflI
         L4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964988; x=1688556988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTiVi9im9fDCKFiD9pK22R6NWa1NRMj5K7EvoAFpyrM=;
        b=iuwnN4USj5SjBWYPeabogBpruXPkj6zI2SvzXE7uH8xBS6ZBjcIPFsTsYAV5eT+9La
         A+IPhx7o3qsyCHb1YCOcY5WrPtRC1JMQ/nfjmtVPvo8SCS5lzV2ZttB0LyvSr2qMNO8Z
         aNkzjINOOWp+im/IXyzIIUXFco9F3NXL2fugDKbgMcFjagpkvPITItvOgWdPii5iols5
         yohcNmhNoWzvNOdHAW2aEclubY9ZFF4qldWK/Z3g4yHPlyP4orWAX3tC8Ps+Hj8yFpBD
         Ks65B6QWgkmJ7royoy0HuIVM7z+qWmI4NbOSnOoNq3cZELIXKapg1WfNGZgjA2IZqQBQ
         Z6cw==
X-Gm-Message-State: AC+VfDxRiX4tEpswvV8QVs+MNWDj5B8T7HdMrVoVrmSybMyIgh+kpbyT
        HX1Dzjs+DvLdmTTc6+MVLA7eseLe69/mCPUWgpjoMWrGjds=
X-Google-Smtp-Source: ACHHUZ5dCHOX51WIrvmgoduq/IBbNoBSqEtP2Q2B0Eiz/Bv37VLH9m3+GCzoJRfs83835SxU3au34A==
X-Received: by 2002:a81:9286:0:b0:565:edf7:69c1 with SMTP id j128-20020a819286000000b00565edf769c1mr12499738ywg.36.1685964988728;
        Mon, 05 Jun 2023 04:36:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p205-20020a8174d6000000b00565862c5e90sm3267774ywc.83.2023.06.05.04.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:36:28 -0700 (PDT)
Date:   Mon, 5 Jun 2023 07:36:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git push --quiet is not quiet
Message-ID: <ZH3IufbB/mJBBKsv@nand.local>
References: <20230519101505.416d0963.hanno@hboeck.de>
 <20230519090559.GA3515410@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519090559.GA3515410@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2023 at 05:05:59AM -0400, Jeff King wrote:
> So I think this is a bug / lack of feature in GitHub's server
> implementation.  It used to be a thin proxy around Git (and Git has
> supported "quiet" since c207e34f7733 in 2012). But I suspect they may
> have recently replaced it with something more custom (based on the agent
> field).
>
> +cc a few relevant GitHubbers

Sorry for missing this. Indeed, this is a missing feature from GitHub's
custom reimplementation of receive-pack [1]. The rollout of this new
implementation is relatively recent, which is probably why this wasn't
noticed until Hanno wrote about it.

I mentioned this to the team that is working on spokes-receive-pack, and
they have graciously implemented support for the quiet capability here:

  https://github.com/github/spokes-receive-pack/pull/49

Hopefully that gets merged and rolled out soon, at which point I think
we can call it a day here.

Thanks,
Taylor

[1]: https://github.com/github/spokes-receive-pack

