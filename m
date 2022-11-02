Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE55C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 00:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiKBAtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 20:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKBAts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 20:49:48 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB50F13F2F
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 17:49:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id o13so2380668ilq.6
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HR/9bPxf53uZ/Nv2vbc6E39ur1rE7IafgetckbglBnA=;
        b=1RibSOjMFrbSeFcT6+x6hUNbacE4ZrQYdy4xKc9A923fL1Ha6NdGh+f/9nSeorCPz0
         v1/NeloocJPOc6hOH6+Lk4h4yTGP2QQxY0+qMBiewY/mTlRzfn12/zCVX/PYrbPZpHgT
         BXvDptaZiP0sE/kkdxtB1reozFCZ3rhCTOJu9Sg7YU0N5NWf/+f2yUDnJYrNOXVebagV
         SddkYocMdYZR8BlOOE1fYUpr2AzKsdShSDBHLnrTWqrCf1DAZm+DvqRZ3wWonC8AhRQr
         IxdPPPb4bhhhpIZFmsf2bleh1b1JFRPUqXdyrFUmy9AN3Y5WMijUIdm9anob1fAij0nb
         O7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HR/9bPxf53uZ/Nv2vbc6E39ur1rE7IafgetckbglBnA=;
        b=lqRWRHqyY8BjjmoEJzBcYwwGCv80F6CrUv/PHJwvoGXvTh1TPyu3xziIYkFx5bZN6s
         Evn3LZ1WRTXHqyQRJRor6azIZT6eyqzHgCqC/EnXJU/Mi3nQu2KgEdHhN1PZaT0qybBV
         A5v8vLB3y64jEzhuwNyP1QPLVwMJvJpenltwAmd/Thj33CAB3cRkAGN2yB6RMJtBoawW
         AMY61nQ2aq68jMrv0ViZcwLdPPz7VOWbQQYzkLNAWlhDxyFUj9XF4dKCqDR+CDrqyWrr
         swUViLlCYSgpmvY7uKAdsNMHbcFhtKbAoZx+8MHzWwPQIGtEMCqZpeSQ/5wAh+ie+9EP
         kyTw==
X-Gm-Message-State: ACrzQf2gmXCqQ0D+CLPQ+pX956QlHlH2nx0lKmGnpX9Yvk4Sx+eI99ja
        ezSsMUUq7B4qq396uiiXqSNjNw==
X-Google-Smtp-Source: AMsMyM4g+LL4Zs7FmgF/P9qCyARUYnst7EdFkKVRJ2RmZ+B71UNMCFFI9csfvr4d4DGOnFW9Kck8Yw==
X-Received: by 2002:a05:6e02:489:b0:300:b6f1:34fe with SMTP id b9-20020a056e02048900b00300b6f134femr6964700ils.123.1667350187289;
        Tue, 01 Nov 2022 17:49:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o17-20020a02a1d1000000b00374fa30a0d3sm4346589jah.143.2022.11.01.17.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 17:49:46 -0700 (PDT)
Date:   Tue, 1 Nov 2022 20:49:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/9] config API: make "multi" safe, fix numerous
 segfaults
Message-ID: <Y2G+qczur9eLVtk5@nand.local>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 12:05:11AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Ævar Arnfjörð Bjarmason (9):
>   for-each-repo tests: test bad --config keys
>   config tests: cover blind spots in git_die_config() tests
>   config tests: add "NULL" tests for *_get_value_multi()
>   versioncmp.c: refactor config reading next commit
>   config API: have *_multi() return an "int" and take a "dest"
>   for-each-repo: error on bad --config
>   config API users: test for *_get_value_multi() segfaults
>   config API: add "string" version of *_value_multi(), fix segfaults
>   for-each-repo: with bad config, don't conflate <path> and <cmd>

Thanks. I took the updated round, and will review it more closely when I
have a chance to tomorrow.

Thanks,
Taylor
