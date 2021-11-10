Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D34C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 02:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE36661184
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 02:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhKJC03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 21:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhKJC02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 21:26:28 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF290C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 18:23:41 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id l8so876789ilv.3
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 18:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KMVEcgw8J/xR4kySBAefiX2c6Dx+Amuuy9hmnt9WRHM=;
        b=Jh69iSauhwWMvtzfIdft39MlXNt4XChr+Z9tjBHE+5zz2MOjiMoLR6aMROV5q5Q/34
         gpGoCfT1/kTfDB+uvpmAHtXVFjmU1CjRleTlEoAX4OPWeRe+dqAyZYcGZ47KQ262Ea4T
         /50nAeyxJ7xSlTbxEE/J3OUFonsjBRgeMKTWnZpepTJcfgnYzefKR+7MfAmY7qaNGbXp
         425RXif3HhxSMgDEkEyf0hxzegrG+VYAJXRii84QHQ5r/HCfuvbt/6A6X1COr3bFg+eh
         XzI3fvyto94DbAKMeiu16fSXyqVi3M+cF29F4Z7hbYMxf4ASGEu1eLOaGhwLrkSXHU61
         Wk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KMVEcgw8J/xR4kySBAefiX2c6Dx+Amuuy9hmnt9WRHM=;
        b=giZVc3EYvTsoni+4uXYh657TzAMaZ8w3TuS6DczPrDRNfTTYWkJ5gNptSZjuJalAbZ
         yT403LPgGWjiAVFsLCc3kfoLFReH2QURcITufZR81uYzQ+DlHfahyKb1k6NYvBGp/kly
         lfZsEkdtYc2NV9zGKFuUZrxEfLHiiRJGPkU0ki+WeR3+CfPjTBLHPaEgBsIvTGQlHGWQ
         s6oQRqnoBmvQI6byUgDrRjue+2e1C85nekK96ASKO/Fj8jwQXRleyDrHJhHy2yV7GbX4
         hYnGyC1z+/PveLPilYC94RW4qi5sB+DdtyaSVUyKVJTNaK03aHC7G4f4tQOfeykaEwIn
         2xgQ==
X-Gm-Message-State: AOAM5319Fpy/JWHzL3eTTdWV0i3JkLWeNAeKEvPbRoGlxuQTN8MgTYsk
        8u1Ca6sAw9XDs5dovVvBubpA/Q==
X-Google-Smtp-Source: ABdhPJzk36sb+cOHw4fmous/OPFynxEcO266YyNn530LeR4uY62AQLfRvmwm/gU7tDmnBC39vwbxxQ==
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr9012531ilq.307.1636511021176;
        Tue, 09 Nov 2021 18:23:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k8sm12453814ilu.23.2021.11.09.18.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:23:40 -0800 (PST)
Date:   Tue, 9 Nov 2021 21:23:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/8] grep: simplify & delete code by changing obscure
 cfg variable behavior
Message-ID: <YYstK7qP5c7U6rn0@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 02:43:42AM +0100, Ævar Arnfjörð Bjarmason wrote:
> For v1 and a more extensive summary see [1]. Thanks a lot Taylor for
> the detailed review on v1!

Thanks. I'm going to put this version on my review backlog for now if
you don't mind, since I think it's more pertinent for us to focus on the
upcoming release.

But I look forward to getting back to this once the release has
stabilized a little bit.


Thanks,
Taylor
