Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3035C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 21:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385012AbiDUVdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbiDUVdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 17:33:17 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017BD49C8E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:30:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id fu34so4244770qtb.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 14:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DBXaeUfEkR0zyrkfk27T5+6ZyGDlNF3+/abJCEnCj4Q=;
        b=d3niAeHr5NfXUrazgxXifUSGYT1AGnaZZpAdGcrItaiMUEprEHPiM0ryUFympiTUCy
         ZqpYrAZCcPZVtW/w5OitOyF1TWPJKipPbVYGlyBaYab8gm3rRSyKXBuMRMwIfdJBorGf
         8tRKHoVKupxERDw5k0dUFvPg8K6uk6tHamPKAoYq8G0Q8xlnHtAamLJ2Wz36FhWkl1+s
         V7d1CiezAYXNelG/3IIgd2zETVSMN3n/cTd9mT6aSM0MFPjAZwFXyiwl4vJxaLtwEP8C
         X5sfSpWGcP4oDQwl/xx9M33fZVt2+wy6zUREnNdntcvYKGI1XtUAJaQM5kJsIpavuIVw
         MNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DBXaeUfEkR0zyrkfk27T5+6ZyGDlNF3+/abJCEnCj4Q=;
        b=V9oM8E7ql0bBaLoke0PwF3IlKqtorzdNC+5RV+B7eTe2il4x1tC04tnIzwPr+f/owR
         Va9F2MmvqBa8vYiGjzTU3R2qnFyHefb7OpKfeW2rti+mQtz4RVIMCZUVwQfZImOr2MEe
         1LGY/KoMSlWbpFA/sZ4ugaUC73zRgqD+4QDdZQnLeQd9qI0A9Q0TYQLE9um5B7vT6CLE
         tYYdi04exwvyPtZX30WWtJS/t2f8rALLPHXxLr1WcQwrlIH1is9PcnDqaBc6rPWUVqFE
         jX82TF6pLG06Wb+b9bJQvpEavLycTyW3e5XWcEEiWHgoJEYFEqi0MxchTUfnqz6lCrez
         mCYw==
X-Gm-Message-State: AOAM533bdTwr0QV3WsflKNDNIQ/7ATXgvPG+QzDEcCRtGmApKz1hEEGx
        GXSoiSivVK03EgLNqxzY0dc=
X-Google-Smtp-Source: ABdhPJxPjTHd2u9sgc/r1nbd+5if7FbX4xK9MuQXBfCRRqWnzUk6au+DIqH+aD1T6wj7s4gbS51+zA==
X-Received: by 2002:a05:622a:1354:b0:2f1:f1ab:dbb5 with SMTP id w20-20020a05622a135400b002f1f1abdbb5mr1120576qtk.76.1650576626157;
        Thu, 21 Apr 2022 14:30:26 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a28-20020a05620a02fc00b0069e8e766a0csm49883qko.94.2022.04.21.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:30:25 -0700 (PDT)
Date:   Thu, 21 Apr 2022 14:30:24 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] CI: don't fail OSX tests due to brew v.s.
 perforce.com mis-matchy
Message-ID: <20220421213024.xzkzuy3l7q5assxo@carlos-mbp.lan>
References: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2022 at 02:53:50PM +0200, Ævar Arnfjörð Bjarmason wrote:
> For the past days we've again had CI failures due to "brew install"
> detecting a SHA-256 mismatch when trying to install the perforce

Since the only reason why that is a concern is because it aborts the
rest of the run and is a recurring problem, wouldn't it be better to
tell the script to continue regardless and therefore skip all perforce
tests?

Sure, there is a window where that integration could be broken which
will be only visible once the perforce cask gets fixed and perforce
installs again, but wouldn't that be less intrusive and overall safer
than the currently proposed change?

Carlo
