Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3361EC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 22:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKIWSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIWSW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 17:18:22 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADFB1F3
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 14:18:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id z3so15106071iof.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 14:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmAXdlVnNfB8Fk9paBctnPZOpkrUH8ffDMChf/VCGEM=;
        b=Q7jezhLRbtN0PgjnYh62tInIdlnSXL3VaFkItD/lIbc7eb20qyD3LW8V04fSSCS4zo
         +PmMXmk6oogBY5NVCs//M8YY+oIdRZFhyXlxmF9PCC39MgPKqEmxayFP7Sz25y0gTSws
         nMvgCfiKr/4spLFY7wrSiSpLG0KFgacjJgK5GfLEq1/p8fRYhk37Fxq82lT5GVfyCCra
         XWiNsvaNIibZDwPURN5+R9KTTWVKoRT5WPIb+2I9N9GJGQMVB+oCwU+FX++RJJt+M7Gl
         ueKp5niHbtD+/x30L9huJ7Yn4joABEMuGxM8b8oG59HK+f0BbvHvTUN/lj3j/LZ0ML2w
         nxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmAXdlVnNfB8Fk9paBctnPZOpkrUH8ffDMChf/VCGEM=;
        b=SBsAdsXBf/fR8cWV8U6O/D7dv8B3s54bODoW7tnNXaVnZ/u3spWqTUtuUT6iOvSQ86
         K0uTc9AN50abUqEN9JA6ezSU/JHPTC+mhQZR32+pcnzJvb41qxIwvN0BVqOSpav1moYS
         0qEq0ZM6O4nWo79YPRwvb3X0mI5/EfEuSH1O5qiTdXmVoGVHh43GpHf9V5ed/mfdmYYJ
         WnpRorUJ9BtqRMx6Iw/x1oNXzluXKo1RRK4ik5gZMKfYyHjr9K0kEmRo44X3hoz+NXe5
         XMCcITDZ3pJS5gc/3JCJJ9ny495kTn+n7lXJyJ6SD/hLXAoHa9HA5Yyy8SVmwLDeJe32
         I1QA==
X-Gm-Message-State: ACrzQf0MvgAnXapfY123Dxzb1Gg67wETh1GvpnpdJsJegKAyT08Yayil
        fUo3HxPYj5oHaN4Nn1D0HWJw0gKBTboEIQ==
X-Google-Smtp-Source: AMsMyM579clrnXqjeWeYACGPBXrw4RqRFdUnRq1LkcAgn0JHscQJs+upwRbvQT8WJpyGjlSdnXw5Fw==
X-Received: by 2002:a05:6638:4122:b0:375:2d83:f970 with SMTP id ay34-20020a056638412200b003752d83f970mr2253170jab.205.1668032300684;
        Wed, 09 Nov 2022 14:18:20 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 65-20020a6b1544000000b006bb5af55ddfsm5728191iov.19.2022.11.09.14.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:18:20 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:18:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] chainlint: sidestep impoverished macOS "terminfo"
Message-ID: <Y2wnJ1h7xwyrpRYs@nand.local>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 04:58:32PM +0000, Eric Sunshine via GitGitGadget wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> Although the macOS Terminal.app is "xterm"-compatible, its corresponding
> "terminfo" entry neglects to mention capabilities which Terminal.app
> actually supports (such as "dim text"). This oversight on Apple's part
> ends up penalizing users of "good citizen" console programs which
> consult "terminfo" to tailor their output based upon reported terminal
> capabilities (as opposed to programs which assume that the terminal
> supports ANSI codes).

Hmmph. Too bad that Apple isn't doing the right thing here, but your
approach is reasonable and well-explained. Looking good.

Thanks,
Taylor
