Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F94C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 00:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKEA1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 20:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKEA1R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 20:27:17 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890C3E0BA
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 17:27:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y6so5058567iof.9
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 17:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtsH4QKXg8jdWceGHqnGL1fah/jdx6mJk19UOpGl1Ps=;
        b=oapvGwCB+oXPOwgZM0QNQYxlGcwPC6xzBSlPTwMJc4oWXqFNSGpETnMXIhiwKYxfTT
         ctXcmaBQXojIT+fXJ6Sn0f/RXOKIzI7T++o+yU4yuKTi+bLm+nD3mgiHYfJDsMS/9U+5
         wEHGMfybYr0ChiSR/GmrkGR9MUukChHqJdbQbXmDoAkex2njIBiOoVnpkc41WjCqn/e1
         34d9fNRtXh/o1rb90KtL9i+9YGjLldIyngveOU861Ry3ARCbzcwxWHx9QqDDZRrMHEXv
         Xg5K45VkhIif2/WvKG7uBK2DIA2mTO+HCCT6VjKcbaoqboI5DLV8/c+9dPvVV99qjnlk
         uiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtsH4QKXg8jdWceGHqnGL1fah/jdx6mJk19UOpGl1Ps=;
        b=lK/lcRwWTsKs7joNR/LN0U4MDFSwstVRKPYlZodZEdPAD3be/agv0VsBZKnxqvTQ3M
         Y7rNTGTzoPB0IkzgI7EGe9TwFSW5ZgEYksNrXEjedgG1xaDANoInDNfv01d+vp2p8N+c
         BKplH1Ftaf+lLTVgqPHfVIYffHxefDCWH4EUXUNzh5QBRnbuApsrKaSksdVRbh9hFGBq
         1UfYnuNAj5oJBPG677PkByFBdPXbOwCVgicxQGJdXeRPF4kekN/IKTa6v8YQrQRJwdfM
         zmZc0gVkgwgH4fpm0/6GUToqEHefpCc0827xYANwx3WdWuKUyaBisDURLWkCxByIAxoZ
         Grtw==
X-Gm-Message-State: ACrzQf3vfsXqBgzrjEF7WW/0AGT66yzv4Mj7ppTR5id7c11dKzYEXrzz
        BdpRdtbZ3nXjpiKN4ssvHl3b8A==
X-Google-Smtp-Source: AMsMyM4gjnnCjV8t14ymh4tVFrW6Tk0crYEAIJ+E38d4Mrvq9emVeRrdPkeahPUQzyl5xuauwDnvgg==
X-Received: by 2002:a05:6602:168c:b0:6d0:7335:ec25 with SMTP id s12-20020a056602168c00b006d07335ec25mr18738115iow.66.1667608035162;
        Fri, 04 Nov 2022 17:27:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e30-20020a056602045e00b006a102cb4900sm201367iov.39.2022.11.04.17.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:27:14 -0700 (PDT)
Date:   Fri, 4 Nov 2022 20:27:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v4 00/14] cmake: document, fix on *nix, add CI
Message-ID: <Y2Wt4SK1PX+kfL/G@nand.local>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
 <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 05:37:50PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This topic gets our tests from passing ~80% with ctest on *nix to
> passing 100%.
>
> See passing CI job for "cmake + ctest" on Ubuntu at:
> https://github.com/avar/git/actions/runs/3387253536/jobs/5627772317
>
> See
> http://lore.kernel.org/git/cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com
> for v3.

Thanks, will queue.

Thanks,
Taylor
