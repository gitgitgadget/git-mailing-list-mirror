Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A6C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C989B20708
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 01:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CCpn+2aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgIQBLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 21:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgIQBLH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 21:11:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13BEC06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 18:10:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so594091qkf.4
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 18:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rInxkmY/QvBRHXho4TodJiQuUuejGAIWgwlP9nkLVzY=;
        b=CCpn+2aJwppOGui1Nfk5mVWfEY7mM/qzm6ceaj70kwMua9RfYk3kDDFoQoz2Nr9AJR
         GuLbQz4WMOmbgKzOu7V6DJ666hCv1xtYUod50k6aYnQQ3MR1PnPj1QCvwOE0sQvxC9AA
         TYjWnj7xFj0KDAUpkDCJzZRCDxDNB2PnPVESsaMYeiiGuf/60ObZJMRNywdNttutG531
         O9xdKp3/iLM5IsUpgBNgihgNMgzvGOK77UrnBerkaHZ2WxkBCrVt6jqhKg+XXFgrMZkI
         ne5xWy7gh/MjPYjkRywDwuncV9/mupD7oYz3JBvRqvlJBU6XBCDumtR9ldBdqHdRBjoK
         hujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rInxkmY/QvBRHXho4TodJiQuUuejGAIWgwlP9nkLVzY=;
        b=E90iTb02oWLOhNmj1/8xaVn/+tTd8X5G0cKOLF/vLL9VJ7R9aZGEhECf4cwYafO152
         tgy8gnDPY5pbdKEhyTjyJjQj2Dy6GrLdmJhNNUiIapeoQFok8n3DP/yzqJVzZqpfTOmK
         V2NOv2Lej8QUaX9j30x9FynsxUr/6sfcjSlUCJ003R93gO6LOpzi+JR3MlbL4WROkgNH
         WUlU0WACrDM5MkaPxi9o02nM758lelTqh4P0Wegjuy34CfThHNnhHig8L8hrGtLV9N9S
         OJHTlcqtOnt/x4/579Wvwb1Ph+LrS9UvwfpIc9xcp2gD5Sf5MHZ0BXI/cRQ57An9XBvv
         zhOg==
X-Gm-Message-State: AOAM533BDBMn+EMcDim7mIT5nWm0o1OUMA1Sti2SDNrV6b0yc5oMwXhj
        b1PX+QTmpsh6wr6OvmVhUVT9Dw==
X-Google-Smtp-Source: ABdhPJzBT+lEAadYKXxFhY+IqEjwojcIm/4PP/xqWE699L0w87s9ihSydM0hjS4x3zJqiK9zJeuggQ==
X-Received: by 2002:a37:a992:: with SMTP id s140mr24869865qke.485.1600305052585;
        Wed, 16 Sep 2020 18:10:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id h18sm20036189qkl.12.2020.09.16.18.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 18:10:51 -0700 (PDT)
Date:   Wed, 16 Sep 2020 21:10:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 00/13] more miscellaneous Bloom filter improvements,
 redux
Message-ID: <20200917011049.GB6478@nand.local>
References: <20200917004518.GA6478@nand.local>
 <xmqqd02ltdzl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd02ltdzl.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 05:59:26PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Sep 16, 2020 at 04:07:51PM -0700, Junio C Hamano wrote:
> >> Yup, lets merge it down soonish.
> >
> > It's me, the bearer of bad news. I noticed an uninitialized read when
> > running the tests with SANITIZE=address,undefined. I *think* the fix is
> > as simple as a single replacement, but let me double check before you
> > merge this.
> >
> > Sorry this topic has been such a disaster. Assuming the fix is isolated
> > to a single patch, do you want a new version of that patch, or the whole
> > series?
>
> Depends on the timing---if it takes less than 2 days, please expect
> that the topic would still be in my cache and "squash this into
> patch 07/13" would be sufficient.  More than 10 days, wholesale
> replacement would be the easiest.  A single patch replacement in
> between.

I should have the patch in your inbox by the end of tonight, depending
on how fast my workstation can run the ASan-enabled test suite 13 times
;).

> Thanks.

Thanks,
Taylor
