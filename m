Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C22EC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 22:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353288AbiCXWIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353144AbiCXWIC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 18:08:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDCBADD4D
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:06:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 125so7016698iov.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7zjjR6uF192ZqUhtNZJZuBBiZUR0fzAnyjQx0W4Mng=;
        b=KOIMxQpog4FGt4c9fHht6UbCMlm1O/MgjPHzZT8xWAfRWRiP/2AFvPuyiYkF+kkyUN
         5N+y+Msxpqun0rWC6xpk717iJsIyp5CcnDnEgx8wSxGUSSpBEz4ewVHt/eKscAGpLmpN
         89rK5k65xPFddfWeFYtTHvS1Yu3nxFusnBNw5a5en1g2CgtY8mwuGSed/Gt2wrx7U3hm
         1cwSuxJRKa6sOQo2/Xnw7y34J7AHviKa8YVxvOJeCdObFbsp/PsxuITLeXd6PFpIh2Mn
         sEHy9hC7P7uJn4ssRYWWMceWUizl7cIoGCwapsjAcsSQcPw9vP57YzrKju7jmNbHId5J
         C/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7zjjR6uF192ZqUhtNZJZuBBiZUR0fzAnyjQx0W4Mng=;
        b=yhEitY9jmRMH8N9EU10zkpNCrmsOoCWqhf47VGv7UP0+IbW+N+yiSZirQVGTUmotaS
         Zrqtk2vesk3AIdhj7gePIGA4fnfmicvOISK8HBSeh2ZciMdeWhhz87dv9hQW/xTSvGI+
         zN/X+SB90R9IYxxnsoI3b7bo5vbl1EJtUVUATSQWUmyVP2JxvLfx8NECPuSrI4a7LSNI
         pZO5DlpOU0pKPv3eauW3xty4D1egCtkOS4+gxseKyILS0yZoRf/PBHDrXnW+UoqjrVE+
         vQ0tcX/2lqacQmqI+1X38x1gwU61BP6ROs47GCJegArXHY2r5B+FstnEqaYffJMmjqPc
         2L1Q==
X-Gm-Message-State: AOAM53251AOA8YaoUEixfPQeLQ5tmjeFNtB1KVcG2nNmCegFT2TtQh/5
        RVCu2w4iF+Go9065JSTXPAptgA==
X-Google-Smtp-Source: ABdhPJyqOIxgF0lCs7pisdkyMbWpOYWSHfNkAOH4NyjlfZI49ZIeV66BefFtA9QbLU+tye0v1T18uw==
X-Received: by 2002:a05:6638:4112:b0:319:f1aa:6e64 with SMTP id ay18-20020a056638411200b00319f1aa6e64mr4354547jab.318.1648159589493;
        Thu, 24 Mar 2022 15:06:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d8785000000b00604cdf69dc8sm2023106ion.13.2022.03.24.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 15:06:29 -0700 (PDT)
Date:   Thu, 24 Mar 2022 18:06:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
Message-ID: <YjzrZNQZ7cBIr+Kx@nand.local>
References: <20220323210803.1130790-1-jonathantanmy@google.com>
 <xmqqbkxwp7qp.fsf@gitster.g>
 <34da1688-7d94-d54c-6b3a-3106d0f15380@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34da1688-7d94-d54c-6b3a-3106d0f15380@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 11:27:34AM -0400, Derrick Stolee wrote:
> > This sounds quite tricky.  In this case we may know which commit we
> > need to avoid (re)parsing to avoid the bug, but would it always be
> > the case?  It feels almost like we want to unparse the commit
> > objects when we clear the grafts information in the previous patch,
> > doesn't it?
>
> I agree that the adjustment to paint_down_to_common() is a bit too
> coupled to this scenario, when we should just trust our commits to
> be valid if they have been parsed. We should always be able to
> parse our parents.
>
> Finding this bug is interesting, but I agree with Junio that a
> better fix would be to "unparse" a commit when modifying its graft
> in any way. That will universally fix it for any potential future
> commit walks that might be hit due to future code changes.

I agree completely with you both.

This made me think of some of the difficulties we encountered back in
ce16364e89 (commit.c: don't persist substituted parents when
unshallowing, 2020-07-08), particularly:

    One way to fix this would be to reset the parsed object pool entirely
    (flushing the cache and thus preventing subsequent reads from modifying
    their parents) after unshallowing. That would produce a problem when
    callers have a now-stale reference to the old pool, and so this patch
    implements a different approach.

if I can recall back to when that patch was written, I think the issue
was that dumping the entire set of parsed objects caused us to have
stale references in the commit-graph machinery.

I'm not sure whether or not the same difficulties would be encountered
here, though. The shallow stuff is so tricky to me...

Thanks,
Taylor
