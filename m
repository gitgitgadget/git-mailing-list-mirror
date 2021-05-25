Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBBFC2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 00:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A28613F5
	for <git@archiver.kernel.org>; Tue, 25 May 2021 00:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhEYAOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 20:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhEYAOw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 20:14:52 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09179C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 17:13:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id v18so15135349qvx.10
        for <git@vger.kernel.org>; Mon, 24 May 2021 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2nw8+mI7/WIAXn6KEArxzpqG9kbnESFICN1Qm7hnqYM=;
        b=cLjD4HX6EPAAQCWoNSi+eGtkzHUGq2Cc3xrda2CHBGePq5/eqIMRBWK8aIoN6kZF2O
         UHKPnxuAgB6Sa0VoLQgOz/y3v2ccZFJIItoVOmm8bZI1ChdYLervIaKTsEV4WkSTHrjV
         bB4UWEKzALEgaGvNTEQz8mkU6npAnvRLQ0SUzKYCp2/OOeuESYZLHuKOxgL9LkrFIk8j
         RJ9HUPnB2QmKaqSf+7CoxqnTEwEd1AKGf8f7vL00iIbArVou5xEAS68LsSPCGEz94PwR
         GRPYqpIq0ZhanqlJH1L5I0GSHOLcj7xoAglpwxlh/zKNfCGSBGn8Z+SSPURbrIb6zDtY
         HLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2nw8+mI7/WIAXn6KEArxzpqG9kbnESFICN1Qm7hnqYM=;
        b=Gu7FNmZgJ+M9M0MhyceAZpnV7Drh5MNzvEkkhK5AF5NWcQOdt00emW0bg4P1llmAGb
         Nx49BIFQzjBcY/5QfJPSL3hGRHlGlntgnRUI9TX6gJiXyNjIY/Cw8fmuFWTxIWnqmBYd
         N3pN6vwwDaC5Ikl4++Zl1JSBLmEsBeqE65nJQ8Fnmf1TjJTPyE0DF64PRfozawAxrG54
         CIFEUO9AGrNc+7nfm5/INi6+1QIECLKn90CBHHA/tzeBmNdevToK3ufrVvTCRalrVUD3
         +QHlZl0Wb3AxGTw6T0d4YKkwf4sW70qLrghQQLKHBt7Z6uA1vm+dylv/9/B2BVBuygNl
         tXCQ==
X-Gm-Message-State: AOAM531IE2zDCZpLI/vsUA34S/gYq6jJXybUr17ILfT7CZPAZfIYUDSA
        CiWzYGUEOGTwwCXyXBZHMU1UNA==
X-Google-Smtp-Source: ABdhPJyzJpu/Ud3eQzGQ+wZEXkN7HoEUcUeolx7bvmNX2luaTKU9DE4O6tx7wwaql7610FvxHwfSbg==
X-Received: by 2002:ad4:5f07:: with SMTP id fo7mr32834210qvb.54.1621901602233;
        Mon, 24 May 2021 17:13:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1c2e:9388:c87:38ef])
        by smtp.gmail.com with ESMTPSA id 7sm12579218qtu.38.2021.05.24.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 17:13:21 -0700 (PDT)
Date:   Mon, 24 May 2021 20:13:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Message-ID: <YKxBIP4lkoPeCYvb@nand.local>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
 <YKwd2e5VxVmU6zqj@nand.local>
 <87fsybohy5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsybohy5.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 25, 2021 at 12:57:52AM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Mon, May 24 2021, Taylor Blau wrote:
>
> > But I don't think this isolated instance should push in the direction of
> > adding support for either of the above, regardless of how easy it might
> > be.
>
> I don't see why we wouldn't just tweak GIT_PROGRESS_DELAY to support -1
> or something for "inf".

Ironically, I think that this already works, since we parse the value of
GIT_PROGRESS_DELAY as unsigned, and don't bother checking for if the
input is negative (since we eventually call git_parse_unsigned(), which
doesn't have any extra checks other than for overflow).

So we silently convert -1 to 2^64-1, and call it a day.

Thanks,
Taylor
