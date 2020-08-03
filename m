Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC2DC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B7720781
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5u6Q51h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgHCXRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgHCXRs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 19:17:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C0C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 16:17:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so3056827pgb.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ofIhVUQefbMostzEnDZaIPKBmPrUk894k95ixcpV39A=;
        b=b5u6Q51hiQDFFwoHLuVHL4SSq130Fybfl/yLkTz6YGrXDtPjZghyXntP0aoAgh12ma
         366vxBMV19KFXjgX0SmCLjqH5c3cUii72u+O5pUZCWH7YqB/2tTPr9USxSUV/c/YZNlH
         B1sFH51JqejDb639ojdB64QDwVr3WrDc68kyJvOTu5z5A55mORiA/MNQ6V16/SUOqKA/
         ZTWEieq2PuQnkaOWAQsPVNNdn6c0yMDZnVysuN3qHkMen+rpbb8QBIg3Wdx1q3oCFN8O
         jZLPxeqvq9A+8qTv4ZN6iTzHY0fU4UhOxYe1wgSlmXpKlwC+7O2f4xozpUI7l6QrZ+y/
         DbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofIhVUQefbMostzEnDZaIPKBmPrUk894k95ixcpV39A=;
        b=DO+ND+QEqbAa+mrGE9YxhtxOHehnw2cMwKAcwiUDN1Km2UTDv9YvfuYl2GiMr9wGrn
         CioTflgYvTFhBNlMAN/iCz90/iwZsUXZxPAfp6CU45ItDhONeRgNxdLzAvmKWKWRQ3aJ
         20EDlMM1kJdplA0rnKy898SNOdsiSwOXh7+MGHq8LhzD+ONE+7LvZLpre7A1F11Q3NCQ
         PGSWC+ko5490amcQJS4Fl9CCdcs6n842Zc0EW8Yfsc/yk2SjC+kiP+/Pf52VtS5ko6ck
         nSnwYrodJ6miMwZTdPQRsLehEY1QG3TkHZVs1rRjaga+xl15P8rRz1BnMqkLFG33Gtgd
         o5dA==
X-Gm-Message-State: AOAM530taEsQNfDQmy4GKWDedWkHFtHdengklXCmn2QjsYfDYbUS+1lB
        v/P1KLEzy0dCyMhte7Kdms0=
X-Google-Smtp-Source: ABdhPJz5S+WGy37PWNcuAKrcWZF4nYcv8ReqMinGYWS5hr6gEL/HOR4uvJhpuCAjCEUrH4on+9gYxA==
X-Received: by 2002:a63:77c1:: with SMTP id s184mr7057315pgc.420.1596496667902;
        Mon, 03 Aug 2020 16:17:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id d2sm18726679pgp.17.2020.08.03.16.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:17:47 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:17:45 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200803231745.GB58587@google.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com>
 <20200803224631.GA73022@syl.lan>
 <20200803230134.GA58587@google.com>
 <20200803230814.GA73765@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803230814.GA73765@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> I still only partially buy into this, though. I had to deal with some
> rather fragile grepping through trace2 JSON in t4216 (? or something,
> the log-bloom tests) recently, and found it a little fragile, but not
> overly so.
>
> I'd rather just move forward,

This means we're promising to never change the JSON serialization, or
that we're willing to pay with time in the future to update all tests
that assume the current JSON serialization.

I do not want to make that promise.  I've lived through the same work
of updating tests that assumed particular sha1s and having to change
them to be more generic and do not want to have to do that again.

If you're saying that you are willing to do that work when the time
comes, then that counts for a lot.  If you're saying that we should
not change the JSON serialization, then it makes me worry that we made
a mistake in choosing JSON as a format, since using a well defined
format with an ecosystem of serialization + deserialization libraries
was the whole point.

Jonathan
