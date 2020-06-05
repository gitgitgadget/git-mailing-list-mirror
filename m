Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94DCC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 04:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DDB207D3
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 04:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um2jGK0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgFEEjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgFEEjf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 00:39:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108ECC08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 21:39:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f3so4323644pfd.11
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mv/tpU1HJBycryKCgQxqtTjziasRz18wPk98ebOurfM=;
        b=Um2jGK0VmInT/AIeLZr8VRNzho9pXmySZaoOoH3m09YOJtJGfyyTs6IP7cRo34ueCf
         9mSYCjzUecJItm6fks2Z2oNoqIA8T/Yzq3DG7C0djJkC/YClyTSx/eueHqPpURSE7npS
         2uMnPmWD//9ECeQ4MeqpQdW3+9OWeNFUTMWdz9W2pMY2Cf/ZDQ9lHotQnLDqa60Pv46e
         FDVrqjbocNVFKoVOO+Nx8H6tI4PFWTlEVs3OWOpkqABIrCtdrbW0qd2CHzkBf2dzA/kZ
         AMkYOaIzqhm/jzsWPfmPNuok94mxWxiJq8UhvZsJXdZWDf1TLbtb0APAGVoky2lU2Hzh
         na/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mv/tpU1HJBycryKCgQxqtTjziasRz18wPk98ebOurfM=;
        b=JQP9ocRoxqBgEqwl08P8dIE5+9W5TqEULEJLUwUMAmwGy5EU9Vh/kXU+A3LPkA341W
         CsuzS+uMKc8SyJHzAkYcr2tYGR2cKLLjPpjbxOeQYlKEDe96zr6H4U2SjSqVeMnU+bt4
         NxgYHqW6Jk1ZG/dPv8J4T0Fe9+0cM/WWlJ7hBChHCk7dfo+Ze56qCKdeP3Jfmzlnfzks
         7upAXl5lf0xb2FtBEtBaFou4oNeGeoTtP3hPhWiFAk1V5YUZIzkSRthPKcMDpEeLWQYU
         gN3+06EZz+d7STK4QihuOzbVjju2WqIG+rRtIZAEiQ3lXIJgDG+Cq9b4cPMAy008eBBF
         rPOg==
X-Gm-Message-State: AOAM533uADtCH+ryufWfYpL+61GBFMcU/LjTLMn0knieFSrG0JtbBFIa
        Qxlb97oKzbs7xlgs+xUMV9A=
X-Google-Smtp-Source: ABdhPJy7Q7xFK3pjgJ228MlUV19Zz/XTi26AIJVAPFCaP4UvJS80ZmKPHdVfpHVesVfMRVRHFAgrLg==
X-Received: by 2002:a63:4cc:: with SMTP id 195mr7680958pge.294.1591331972959;
        Thu, 04 Jun 2020 21:39:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 17sm6107082pfn.19.2020.06.04.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 21:39:32 -0700 (PDT)
Date:   Thu, 4 Jun 2020 21:39:30 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Steven Penny <svnpenn@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Change Native Windows shell
Message-ID: <20200605043930.GB193658@google.com>
References: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com>
 <20200605000039.GB6569@camp.crustytoothpaste.net>
 <CAAXzdLVk3jLzuB2vgKGObQDjPydpdiawKJJ+-NMa376Gu1zt1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXzdLVk3jLzuB2vgKGObQDjPydpdiawKJJ+-NMa376Gu1zt1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Steven Penny wrote:
> On Thu, Jun 4, 2020 at 7:01 PM brian m. carlson wrote:

>> If you really need Git functionality that doesn't rely on sh, you can
>> look into libgit2 and its assorted language wrappers.
>
> Uh yeah, no. Im not reimplementing the entire Git program, when the fix is 7
> lines. Here it is, if anyone is interested:

Understood: that's perfectly reasonable for your own use, and I can
hope that this is the first step toward becoming an active Git
contributor in the future. :)

However, for the reasons Brian said, it's not going into Git upstream.

Thanks and hope that helps,
Jonathan
