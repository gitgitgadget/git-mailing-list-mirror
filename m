Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3963CC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C87220707
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 13:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw4oYFme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgAaN0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:26:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34844 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgAaN0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 08:26:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so6499365qki.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 05:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3eK71taDTOOpA0m9N2gVOCf+RvB6UESwf8DpdjwRk/A=;
        b=Tw4oYFmeYYNboABvNLgijHl+czI9KdlXbEPfwUfLcq160zt+/fid6iG9fa/3czMSaa
         ONv5viFyAwvmuLmTBKIkf/vzqAHz/vYVT1pBgV/PfQno6OKSmndr23X9uS5eZJsh7JSN
         /pzMgWFXqYcU9Bzg096EDq8WkwrLgr4J71ICR72kKQBvsBokGCy8koroQlMGfkRrigWm
         N0ruCTX3iupVXFSkTC2x3NaMO0PfInu6evrsd2gj2Ei94jDx23kvK5sWUKaVrfHm6L8x
         fxrWVGW4mPhviLK2v3o+h+deUuxILJlU3EAtRrrntMxxpyh5ogLq18mXek1tBzo+n6Fk
         pDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3eK71taDTOOpA0m9N2gVOCf+RvB6UESwf8DpdjwRk/A=;
        b=BhkLB72/yd/cgaphqyIjh0hndTTdHVs3TFrPA/48FoniBH49Slbm5OO7SmCuc2A59C
         VrJ4WYb9Q3k9vO377TyDuME6jlgs0XIit05XAywVKf6CTT/rQCxwBE2Fk6k51RFBEojC
         bXQH/TSsrgiTBISJc2jxdtFoukxLw4j0aomOf6lNKPXz7upBBLWXJSJsC3OsmJSyqdhv
         TiOoSpJArxBKik6xqBbJ9ldZovy+npdTUvhNgP72eRuWiaMmKzVIWroHo2kKBx+DszL4
         7EmLPL5c+xlHSc+lvG7FuH9moadzsD6mmId4AQnfekGnduJ3fVUJ5PywfZ0UpRG/wNrx
         9oIw==
X-Gm-Message-State: APjAAAVgigNzkBLrM8qPYCx/ru6xTFclIP7KcdBbmw1Wq3CyUj2UeJPY
        EMbWlNxlBnflRBTdJRaNyns=
X-Google-Smtp-Source: APXvYqyum6qQlwPKHmsauPHsrVOY502zOmp8ODah0yQ2HKHeGdhuNkX1gX6+IEiGnE84cy29CNqxeA==
X-Received: by 2002:a05:620a:1472:: with SMTP id j18mr10836679qkl.184.1580477180866;
        Fri, 31 Jan 2020 05:26:20 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:e1f4:827:3448:54f3? ([2001:4898:a800:1010:932a:827:3448:54f3])
        by smtp.gmail.com with ESMTPSA id x126sm4526687qkc.42.2020.01.31.05.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 05:26:20 -0800 (PST)
Subject: Re: [PATCH 0/3] builtin/commit-graph.c: new split/merge options
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
References: <cover.1580430057.git.me@ttaylorr.com>
 <20200131003210.GA91635@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ecb789c0-1a6e-244d-1b7f-de136e0173d2@gmail.com>
Date:   Fri, 31 Jan 2020 08:26:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20200131003210.GA91635@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2020 7:32 PM, Taylor Blau wrote:
> On Thu, Jan 30, 2020 at 04:28:14PM -0800, Taylor Blau wrote:
>> Hi,
>>
>> Here are another few patches that came out of working on GitHub's
>> deployment of incremental commit-graphs. These three patches introduce
>> two new options: '--split[=<merge-all|no-merge>]' and
>> '--input=<source>'.
> 
> I should have mentioned: these patches are based on top of my
> 'tb/commit-graph-use-odb' branch, which I sent to the list in:
> 
>   https://lore.kernel.org/git/cover.1580424766.git.me@ttaylorr.com
> 
> I think that it makes sense to queue the above other topic first before
> this one is applied, at least since these patches are based on that
> branch. I can prepare a version that is based on 'master' if that is
> preferable, there are only a handful of conflicts to resolve around use
> of '->obj_dir' vs '->odb->path' in changing the order.
> 
> The two just felt a little too large and disjoint to send as one larger
> series.

I think the order you recommend is good, especially because the obj_dir
cleanup is less likely to be controversial. Command-line interface changes
should have more time to cook.

Thanks,
-Stolee

