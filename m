Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8515FC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4782722284
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOYFNzYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbgJIRqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbgJIRqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 13:46:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A29C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 10:46:10 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l4so9734544ota.7
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CMWIYgcZuHSgHr2+aU5jLfetKa5uAtMKdjOeI1tNk5E=;
        b=VOYFNzYOn08/oeP+X/kMh+s1w/6cRMcOoZ5pzGMM2q5/s1zjnQ/+q5+aqxFWZH8207
         wOAdddiI3CER84Perih+0FOa2AJGuFZvTOV9W/puMp58ltgxN+gds8aGtxnI9aoPlL2Z
         nfVkWeKQwJd36IZoQfdyPKO9mb3UzK2S5OKYYA3CtJAsXFQ1c//tcJzBO3sa40XFtuQy
         E1vzLOQV+iEFBvtYby4TBcO8m74KvyPq87pizzFFY3vOzlxipFFb68Xlbi3IyfXyYVmb
         3fc6RkoRFj+y6YeuWNqfEiPASE1TLkFNSjW32+r98Wd5c7182rWGQqZIUBtZJaWxHcMZ
         e8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMWIYgcZuHSgHr2+aU5jLfetKa5uAtMKdjOeI1tNk5E=;
        b=lF19k7zvK6m99FauM1L72ajPB4Rnu/9WSVQUnLmyVqcboDUIEIjo/9giZWNZxSS9lr
         gdFHLynwdUe/6nuoNF9Eyj/v3snhtJc9nj7i6u/xJToxWFtgbI8NJLwyD0M1peyvorDj
         LuZwTe4efwfcdSiiNpnbilcE+WsgKvJvBjVQJ7nJteMqaoZ+H6h4NxEffgK0PjRTPP6w
         vejIi5l2lMP2MemUVxUSdF61tmrS1YvU46alRbE02DCG1PcET1ogrWDh2Q5E5B2UlCNV
         KegmCyjkz/iH8v/VqAtXVdCmMNiY06gGhe9gd17iufvgWq2I5Es/UI7JSInTeZXViIIT
         Pdsw==
X-Gm-Message-State: AOAM53086dN4iYfczb2ReSXEr82uprPk6fhgHDQZvhcDeCf5YDYix1uM
        xFRAxb0210+kHOEGcuPv64HcRtcnYj6u+Q==
X-Google-Smtp-Source: ABdhPJzCgaFaOOqIyiBKhvsw+oGOA6qGbzdHvl5y3D1By2sUErmubdfNcmvXwpWilcgiCXsEo5QUiQ==
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr8252453ots.367.1602265569318;
        Fri, 09 Oct 2020 10:46:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7515:c4a7:ed16:ef48? ([2600:1700:e72:80a0:7515:c4a7:ed16:ef48])
        by smtp.gmail.com with UTF8SMTPSA id t5sm5438911ool.8.2020.10.09.10.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 10:46:08 -0700 (PDT)
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
 <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
 <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
 <0d25e0ab-31ab-54c2-b518-bd9c0b0c4b7a@gmail.com>
 <2f30099a-4a3d-00f7-bb08-ca6c1f76bcd4@virtuell-zuhause.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <64de22fd-2e1b-aaab-3a8e-f6f1d630a46e@gmail.com>
Date:   Fri, 9 Oct 2020 13:46:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <2f30099a-4a3d-00f7-bb08-ca6c1f76bcd4@virtuell-zuhause.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2020 1:12 PM, Thomas Braun wrote:
> Sure! Please find them attached. I retried with no jobs parameter as
> well, same issues.
> 
> I did some more bisecting of my git settings. And now it's getting
> embarrassing...
> 
> Can you reproduce it if you do
> 
> git config core.commitGraph false
> git config fetch.writeCommitGraph true
> ?

I _can_ repro it in this case! I think there must be something
very interesting going on where the commit-graph is parsed in
_some_ places, but not in others. This is something that I can
really start to dig into.

It's important to note that the final "git fetch" adds a layer
to the commit-graph chain even though we shouldn't be reading
from the commit-graph file! This is an unusual situation that
is unexpected, but should be handled correctly.

My gut reaction is to end early in any commit-graph write
method when core.commitGraph is false. But that only papers
over the real issue here. I'll keep digging.

Thanks for the logs, they may come in handy!
-Stolee

