Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1DC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B082F21841
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpREOZbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgFSN7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgFSN7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:59:41 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2CC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 06:59:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j68so5616887qkb.10
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3r2B7c8b9n/uDOzJH+PExdgDqRgWmhFt9+vo/viDX+s=;
        b=hpREOZbXbCFrzOS8f1BzLFuTSy+tWwBRWoclRQ7yG8P0Y4arkPhAcMvPfSyq4glw9i
         vm6i69kjBtWoVXVvI/ZncWsxyA1RYASn6gWLWorR/SZ5KenxqHj76efa/xRZ0IpEMhJH
         aZ3HPZC6oTp6lXbWk+swntn2e26pulySRc29LvuPY6GlXbCl75BoTtwy2iZseOrBKqxW
         rMr+fm+B0QJEra0jaUnNxG2k49rS8QCONzunygCxeVFHWfbKe5KfKJ8ajPV5wRXpZBqf
         np05ihM2BMfU9QpOBDQ74ZR8uY6KHTwQFtKKqme/6bPxoC8SuoPH1Piiw3GNmwkl7Q9i
         ZCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3r2B7c8b9n/uDOzJH+PExdgDqRgWmhFt9+vo/viDX+s=;
        b=p/h++n1Pm69r2bQ+pJ9noVB2reUawoV0Cgof8nrZEDF4nnP9gdQrHr81BIc2RVP85z
         dYPFnUUISyWZ2BiA4iqJSqxsIymT8bKwETDxuo+XE8ZufXH01rhs5gO2neemagV49RMt
         Iu9pOKWZ0WN046smqqR3zQuUN6MRb7vAzyYGjk11JA2rgznDO0+MCAaOYyqK880LltCv
         3XRVWIazerSSDTcW9lRbYphLUlZ4m70vJitt8bCdYeOB5oDavCe5EZIKlvlcfOGOqOxK
         7D/19mCmKy5ZAfmCeA/mF6YANvNvTq/utVM7uRTQSMqzeZy/TWEBhHbzL80wtfWp5Lr3
         Go7g==
X-Gm-Message-State: AOAM530gllzbcYA7lHVzRBuLrinkmjraux1V83wb06SATypWBSdXBR7W
        AzdRAacAhHaV/jlCzqCXuGlSi7lZoD8=
X-Google-Smtp-Source: ABdhPJx46KnHgquKxagRlfuXrd7VjqUcxLb+2wfF8rTrpaRCT3MiuSFDJSY/u48gh6+VgbVBs0hPOg==
X-Received: by 2002:a37:a949:: with SMTP id s70mr3548183qke.111.1592575179692;
        Fri, 19 Jun 2020 06:59:39 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f19sm60513qte.53.2020.06.19.06.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 06:59:38 -0700 (PDT)
Subject: Re: [GSOC Patch v4 0/4] Move generation, graph_pos to a slab
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
Cc:     jnareb@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200617091411.14650-1-abhishekkumar8222@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d5131361-2945-3daa-d91c-67761908b8ef@gmail.com>
Date:   Fri, 19 Jun 2020 09:59:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200617091411.14650-1-abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/17/2020 5:14 AM, Abhishek Kumar wrote:
> The struct commit is used in many contexts. However, members
> `generation` and `graph_pos` are only used for commit graph related
> operations and otherwise waste memory.
> 
> This wastage would have been more pronounced as we transition to
> generation nuber v2, which uses 64-bit generation number instead of
> current 32-bits.

Thanks, Szeder (CC'd) for the quality review in the previous
versions. I manually built and tested all of the patches here
and verified they passed all tests.

I think this series is in good shape.

Thanks,
-Stolee


