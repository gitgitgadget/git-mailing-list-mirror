Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C08C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 21:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiFVVeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 17:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFVVee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 17:34:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526135850
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:34:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 88so23630230qva.9
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ar2Wi6aIczYtdNAoUTRgcBWqC5IuZNHMG8f5vRHC4dU=;
        b=JBP9l5/peWWqfAFEAiwRzqMVlFkXzNetDJ72p9MS8SngL7wdxjBhzVih+2hc/8YZP0
         SXr6SoxVdMsoL1B+V7YxFZl+l8yRG9vk7dBXyqUzAAO/oSNycTvYHYM1APjo/lOnjKyY
         XKbozzxz4mRMGv9WnI4XD5XpanM4lSozKpWjL2euC3nXOMV+G/ZyhoV1NX6wILhvER5f
         Vyi6Q0SpmWeZUVUeQBNRtHYHXU9GEwmdrn6IHS8f4oZne5XiEEQntOVy8JvIa7KAdbkV
         N5Kr3q5RCj2w9HTXE/9IkVD/eeQiJg7buQjxuI2g49Q5sja76tFfqhwjOi2E2zLiDoQ8
         HGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ar2Wi6aIczYtdNAoUTRgcBWqC5IuZNHMG8f5vRHC4dU=;
        b=7uInC3p1xwF9zFqdTjzyti6HDvXDdc99TDOyyITm4bBbA/MDG7OuMBneAM33E0K8jf
         1DZMAQXGdXE/NAXB9S1DBf4ADJAEp+wkZUB2nhYOi2W4tDYZFYaEfpInjhW5d5WdQH5L
         mDgjmkQ84ENmFnP43z8hLhI79RN176cBkBgIIER0BxsKPr6JYmzel+ni6mqaHaOkE5bi
         Nn8tnaf3c/hlVoZ3TU/bQqYtNtBRRSTApJ1hlXs5iQlUMkoSuUQ6VlDsjLOB+9gdc/9b
         xREzSvHvqanVMpBLm45wDFtXroPU0yl6LZgt6vdpWQ6lv70XPHYqDXxjd38HBBDmpsRq
         /lDg==
X-Gm-Message-State: AJIora+dvFOxwuj7AW/DRM9aaE6LjUoesJzD6J5jx5ZepaRgeRoL2oB+
        1x/Vwvpa2pyLxHCanEbNOkVswH2MPc34H3BP
X-Google-Smtp-Source: AGRyM1uQDwP6LHEzchIdiNqUR11NoWdXuhOnuNB/bp+YvLwMcuPYcO2O0STI/rDaFqvzfs36WxddAw==
X-Received: by 2002:ac8:7f03:0:b0:305:2b81:95ec with SMTP id f3-20020ac87f03000000b003052b8195ecmr4890634qtk.523.1655933672967;
        Wed, 22 Jun 2022 14:34:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cp8-20020a05622a420800b00304bc2acc25sm15231601qtb.6.2022.06.22.14.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 14:34:32 -0700 (PDT)
Date:   Wed, 22 Jun 2022 17:34:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Message-ID: <YrOK5wf/tvGSFbSH@nand.local>
References: <YrNIJ6z+a4++MGQ8@nand.local>
 <20220622171814.46313-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622171814.46313-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2022 at 10:48:14PM +0530, Abhradeep Chakraborty wrote:
> > Ahhh. Thanks for refreshing my memory. I wonder if you think there is a
> > convenient way to work some of this into a short comment to help other
> > readers in the future, too.
>
> Actually, Derrick has suggested to go with iterative approach[1] instead of
> Recursive approach. What's your view on it?

I don't have a strong feeling about it. In practice, we seem to top out
at ~500 bitmaps or so for large-ish repositories, so I would be
surprised to see this result in stack exhaustion even in the worst case
(every bitmap xor'd with the previous one, forming a long chain).

But it doesn't hurt to be defensive, so I think it's worth it as long as
you don't find the implementation too complex.

> [1] https://lore.kernel.org/git/92dc6860-ff35-0989-5114-fe1e220ca10c@github.com/

Thanks,
Taylor
