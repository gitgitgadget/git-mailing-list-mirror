Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781FBC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiKPUOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPUO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 15:14:29 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001FA554DC
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 12:14:28 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y6so14125323iof.9
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 12:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zu1NQCKsAN6y6Dhog23lttNAEuaOeUqEWuGzOnhlHmY=;
        b=B2YVwvrSc5GIefheE5N4oo4bshWEO6hBrcTFQPFrw8coJcoq2DT5x1Gdt7XF0I2d+1
         94pEFP8hc4aDWM79ycxFTp3/Y83XFjr/x5vyoI803pFPZwIqT6NgEhD7GWrNIN/6+JTv
         cIkxjfUzmC5TdXyO1w+2uuTrIp1zWxkxMd9Gu4JT1OmXqmghc5sFPnGRA765l6IS1/uw
         DybvyWMa5TmiaFZJa9rLarE2Td3s9IO0Yt0hGoe9whPdc3B7oqX3pEoZldw7rb8kdR1y
         4XDRS7lalAWQsNs69vWTcP2g+OQmZ85xBNMerU/jDT9tmmwYDQYhEpakSXvVjBUHwih5
         kgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zu1NQCKsAN6y6Dhog23lttNAEuaOeUqEWuGzOnhlHmY=;
        b=ul2DWLB1Y9DVHgVbjNsMTBYzy0oMbWe2hgwipboE5Y6jEyrhGw9m6mPD6MbYFlSK+/
         udNuNwpcH9RubMOdpkv5Jkf7+zIlECQ3FE0htpyU+K0AQG5CHMvX09Je/B5WHUswdkNF
         QIJ5zxX197fYw9Ph2RkoZANiY4LAS+XfKdg+c6I4HsYqCip01ywqmzGhqTQ0UHGzjK3I
         CjsMtaR39EB9ZLNyo+Yo8W53f7eSKpVJnHvE2YYhMS9K3YJJ8M8fU42ijY9qlmrosstY
         BNyq3Fc6bkXvmMRxDW8jwPp3i9lHnPh0w7UAYQBeUi2+/VQ8pw/D2d1gcmzvOv5HNyLX
         9Fdw==
X-Gm-Message-State: ANoB5pmzWz3cEw1sc7e/i45+3mntFlEMFY6AWtJFpaEWZBDOGIREb6Va
        zfd08419MPAJvMHHKvvkyrO97w==
X-Google-Smtp-Source: AA0mqf4KE7cxeWDeYQzwzEvMRahWuTRfkVQrQd92wfvJTtU2YEIbDOFaKvX89nYBRP0TWrmqRO5OEA==
X-Received: by 2002:a02:93a5:0:b0:374:fe5b:668 with SMTP id z34-20020a0293a5000000b00374fe5b0668mr11484129jah.165.1668629667306;
        Wed, 16 Nov 2022 12:14:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h24-20020a02cd38000000b0037532823a17sm6098794jaq.122.2022.11.16.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:14:26 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:14:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect; remove unused "git-bisect.sh" and ".gitignore"
 entry
Message-ID: <Y3VEoWSH0PihWI8l@nand.local>
References: <patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com>
 <Y3T5PQmrIHrV9m46@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3T5PQmrIHrV9m46@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 09:52:45PM +0700, Đoàn Trần Công Danh wrote:
> On 2022-11-15 10:32:42+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > Since fc304fb52f9 (Merge branch 'dd/git-bisect-builtin' into next,
> > 2022-11-14) we've used builtin/bisect.c instead of git-bisect.sh to
> > implement the "bisect" command. Let's remove the unused leftover
> > script, and the ".gitignore" entry for the "git-bisect--helper", which
> > also hasn't been built since fc304fb52f9.
> >
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > ---
> > This goes on top of "dd/git-bisect-builtin", which just landed in
> > "next".
>
> Ack,
> Sorry, I forgot to remove it :(
> Other than the reference for commit, looking good.

Thanks for the ACK.

Thanks,
Taylor
