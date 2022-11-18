Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28F3C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 18:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiKRSlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiKRSlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 13:41:51 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7260B67128
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:41:50 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 11so4516395iou.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oiRHmMNP1Da+wFF6lcPADrSet0XXZm4k/o6O+4N4xUc=;
        b=z9z3sOFO7RFdTPlwzbtBgRTLEDqIysbfXBu7C1qYCj/pnhDRFn6AafiRfnlbLstnqT
         eMkd6GLPbo7TSQagsJ96TGHRzeqny3U+OxxBMA+N214BYJTYC1Av7jg6BNnHBXJka1Xt
         BbRY74Bf4UsbuenXO/aikWAREDyD+6Um1DzhyJRfzcDrqBuaxtEio0FVaGEveKxET79p
         v3lcRsq6sUxM+meo8RoHp6pAqFCynQ7wMvt2aNYE7p6PhB9XbTx40Ys1U8h9V///Y+Oj
         FPs1wPnFD62xF1j/eqUqQVdMz0NThmR/hyNBs7hJhuJdFbF+XGWxupCAMe4T7HldJUhX
         hTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiRHmMNP1Da+wFF6lcPADrSet0XXZm4k/o6O+4N4xUc=;
        b=6Sw1BqL7cjQT3gTtlGIV+YocDDf2fDJhVlMJsECiLPh7TkGihu/5gGkH/ts/Zjj/hC
         57keXauBpoA5cPg4AemB4D1V9keVJN0yh/0CUCwkIXm7cemAcFgao464Ue6LWRW+mCwP
         kx/uXaMxKE6WgLC8/JcCmtHY76cPjDhh2VObwKNEhU27AKB0a638zjUfK9OX0eLGaRVl
         OIr9RhGv1Farv4bqBNYSWXYveALVUcx+H3+2mQ5ooJ5S7aOGHUEZNvsCgmhbHQdlnog2
         dg38FMf3Oc+wEYc7RUXooZJqIAph0Jdx3RRvYfKqAoC1ecNqORc3czHN4do/ru2zy4nq
         WsfA==
X-Gm-Message-State: ANoB5pk7bY6rZ+Mf5Dqo+P7SDqjh0+dtPHBKRXbecBvjhF3F5/sDTxCJ
        yrsZODxFe0amWkkepAQbslKB146Ot5FVPw==
X-Google-Smtp-Source: AA0mqf49TDMKdTFQyueXo+RfvgAtsBkuGVj/EjM9JRmW8K92kLuqnmQtXfSaRXEphARpAIsxrPm80Q==
X-Received: by 2002:a02:c492:0:b0:375:c128:72a6 with SMTP id t18-20020a02c492000000b00375c12872a6mr3785124jam.151.1668796909750;
        Fri, 18 Nov 2022 10:41:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o12-20020a92c04c000000b002eb1137a774sm1442342ilf.59.2022.11.18.10.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:41:49 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:41:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/12] cache.h & test-tool.h: add & use
 "USE_THE_INDEX_VARIABLE"
Message-ID: <Y3fR7NMkfVKtfB4J@nand.local>
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
 <patch-10.12-9eda7916e75-20221118T112205Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-10.12-9eda7916e75-20221118T112205Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 12:31:04PM +0100, Ævar Arnfjörð Bjarmason wrote:
> In a preceding commit we fully applied the
> "index-compatibility.pending.cocci" rule to "t/helper/*". Let's now
> stop defining "USE_THE_INDEX_COMPATIBILITY_MACROS" in test-tool.h
> itself, and instead instead move the define to the individual test
> helpers that need it. This mirrors how we do the same thing in the
> "builtin/" directory.
>
> We could start using "USE_THE_INDEX_COMPATIBILITY_MACROS", but let's
> instead introduce a narrow version of it named
> "USE_THE_INDEX_VARIABLE". As the name suggests this doesn't give us
> any of the compatibility macros, but only "the_index" variable.
>
> Eventually we'll move other outstanding users of
> "USE_THE_INDEX_COMPATIBILITY_MACROS" over to using this more narrow
> and descriptive define.

The above two paragraphs look like they belong in the previous commit,
no?

Otherwise the rest of the changes here look reasonable.

Thanks,
Taylor
