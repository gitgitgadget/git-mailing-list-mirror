Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B0EC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A44621582
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="uXqARHIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIROR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:17:29 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DEFC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:17:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v123so6162227qkd.9
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SX34QiqO3m5+E3PQEBW1C48BKFvUlcfPMkP0HuyILOo=;
        b=uXqARHIj31ANDvGI0vlf+ZfbEspgZDUOGUty+gBehtLY/3EvUma4hBQXVZzwzGbuxC
         8+LTvLudAVKdDZPiFYZiZIpxGv7lYtkiPJIQniqNe/DIZJFl76HyC+7zyIlfZNq92QTz
         dcKGl9+nhGiFbI+3b69nBHlD7pnOvZcmSoGEVkXQ4TeDu9dYuQaRKK515jygfUx8Uj9e
         j0jD6ImWv9JXFtMmWul0mqeXUDMglkbmmXxgVhtuAM8xobWu+zseCIHANeB5kHGyDhDv
         wEEZZr429m9fHSPL/TEEOYyDZzD6e4PdLwCyaDDfHjUWyH94fGYvGdVAsmVztHVWiTCx
         SB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SX34QiqO3m5+E3PQEBW1C48BKFvUlcfPMkP0HuyILOo=;
        b=IFVm1HdOvRXT1uwYRbcqMvy1SOW+4Cd/xS9zD8vtaMVIGQOsZhXQJj283syGBribzk
         Dzq5YWkZVO/C4Kg6Nhp9ma98YjT2pQjO9Q91CDHYd8a+Cm+Ix8CxaFYI0EPyWIA7TWxk
         UOOAVfOWCeiBYpVTK0ya2ghHY0Hbcyx1Abn1ReNrKvEbtPgbXnS2lLecFlPVBTkq3WlE
         5qyTDvmDGwzQEOZY6faBHXLXwQ+i0fF0noEYwgJrpSJebp1etpR3uCbnsIslaknjhkYG
         bM+iMhD7nwSyRV2yeRLGSb+B2tHCScvLPrc/5/E+DxocRk6bcRjrRYlbYCtSjnAFOoxm
         FFrQ==
X-Gm-Message-State: AOAM533KRx4eJbgrVXrd78+Wt7VPSmWshvIWDQmTpcw0CB2Oq5EPcUbC
        TmR4ribPyIPFCKrWENKCN8KgS6sKOTY6Z9baYfw=
X-Google-Smtp-Source: ABdhPJxaZHiA3s/MAtDJfBw+oPN4cBNDx+NsSZnbbmoJpFu6nbT6dOlkU0JOjgLBlFQkHx7BhrUHEg==
X-Received: by 2002:a37:674d:: with SMTP id b74mr34427391qkc.189.1600438648246;
        Fri, 18 Sep 2020 07:17:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id u18sm2262364qtk.61.2020.09.18.07.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:17:27 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:17:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: Apply git bundle to source tree?
Message-ID: <20200918141725.GA1606445@nand.local>
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <20200918140236.GA1602321@nand.local>
 <CAHpGcML=EFRngwjgaXNE53OOPoEBz+4Qi1v354gAv_vHNYS_gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcML=EFRngwjgaXNE53OOPoEBz+4Qi1v354gAv_vHNYS_gQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 04:12:09PM +0200, Andreas Grünbacher wrote:
> I was actually looking for a way to apply a bundle to an actual source
> tree, not a git repository. Fetching stuff from a bundle into a
> repository seems to be reasonably well documented.

Unfortunately I don't think such a thing is possible, or at least if it
is, I can't think of how to do it.

Thanks,
Taylor
