Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20307C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21A360EFE
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 17:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhHSRlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhHSRls (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 13:41:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566D8C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:41:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 7so6185906pfl.10
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DjnUR0gqOdP1SJgjdPB5ldGU8gxEAajPO1vTcNM0+zo=;
        b=Zrf66nkHo5REmp73qEojmlRWSUl+v1ObXDo7YMzeG2TtwIS/AzJy4UTJD9yDMJVBQI
         ziIoBpAgyIU0OqoSJIS6sNPkgzsW91Wl9lrRz/d2PiT7CVkOHquH4Ay+SdugWMGAk1Jm
         L1XseVykBxkXYULNAaNG/FKMw3Qs1dp1fQ3GBYZVsqEKGIITpBZ+DqfVf/MtY2vv8JnE
         +GDsLEDDo9whZa+mR3XD2GuChNI27NjAOBp4et7wkiaMpZJ4LS7LT714nOFMz9TwlTCN
         MXJ9BR/SzB8/YHAhQNgD5hf/x6bk4FiLDdYSAYKrAz23nqHojAz2yD1eRrZA2CwMv/eV
         e7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DjnUR0gqOdP1SJgjdPB5ldGU8gxEAajPO1vTcNM0+zo=;
        b=W9g8tFw6g2iDC5LbIu6KxVzw8TXPqdLaG7BFBFi20uvcrYQzERauW8C6G08w0fMBI1
         i+uo8C2fOAe/JQ04/u/5e195B2Kv+37cIY8LwPQ3S5Lg/rwsyGpvhgKpaCuXI+nE4oG0
         JdcjHt7QsT7YaxVYof6iwrOdpJBuqrBEdL11Rv4oe9ykePh+y4M3KpITDKj8x0DfxmOm
         lc+80PU9/jiU7UeC4YH0cT+2DUleYmuO+H3LDF2nIlTpC/6KLTafgG3gG6HN+Nq9rko0
         c0KyiLSvbECFN+bRUnAV+1zR1+kyIagh3yaUfNjC8ROZk4eYmdtYn4Ry7n7c3rYL1/It
         +kfQ==
X-Gm-Message-State: AOAM533lFMZq/E3jFJ3Lm4yesf2Mj/1vdAaJiBRTyGZwQSCEbMJN/nzB
        CwcIcxGcb7MNjS5wEF3PesOuRI3nRQH7fgSprRE=
X-Google-Smtp-Source: ABdhPJwujUOhs12rzdCW/EPUTuhr4edCBxQTMhAdWiOTz3W1uZLuMESr7zF/U7Tk+lXy2348Cu3asA==
X-Received: by 2002:a63:ec45:: with SMTP id r5mr15020391pgj.440.1629394871622;
        Thu, 19 Aug 2021 10:41:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a999:9b6d:55c3:b66c])
        by smtp.gmail.com with ESMTPSA id b1sm4062442pfv.151.2021.08.19.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:41:10 -0700 (PDT)
Date:   Thu, 19 Aug 2021 10:41:03 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fixup! clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
Message-ID: <YR6Xr3SMZjlJ1ZaK@google.com>
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
 <xmqqy293ucju.fsf@gitster.g>
 <YRw/8tThN7djNE+E@google.com>
 <xmqqk0ki5xwk.fsf@gitster.g>
 <xmqqa6le5x1f.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6le5x1f.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 01:15:56PM -0700, Junio C Hamano wrote:
> 
> Narrow the scope of a temporary variable used only once and
> immediately die, and rename it to a shorter, throw-away name.
> 
> Also lose a {} around a single statement block.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
Acked-by: Emily Shaffer <emilyshaffer@google.com>

Thanks.
