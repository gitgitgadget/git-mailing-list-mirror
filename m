Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EED1C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33E06109E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbhIWRqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhIWRqh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:46:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EAFC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:45:05 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b6so7575011ilv.0
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/+ZsqTMmoZMDtyMhnS93lf9O6mu50Z9E4EdSsXdBhk=;
        b=hDrdG6aG9VR4t0ulvR4IUeYd+pgVU/56VBQGsC3JdafIrlzJbEDStveZwH2GWz5BHb
         C1EKQ+mHTjbJzZk/5P1enOhT4F6cS3BbOHBlqVzC0hDxibUXbMfcNWwibYsJ/CH0yhNC
         0zWJU8Wgl2CMf34B5GDgUqTJf8noM0SSM7rODxELVS25PNouIOef9aeoE+DfeHDRFWG7
         B5ucZW56DzFgH1YLhHwlun8+byJU6oUNED3PuZqZP05US/JEH50CPJE2AUaMDsF04Yg+
         nMm55o4tUcKhtZR66UEVvSGnrlplOEYpdY39gnKHYyBpmNRG1MHBbIE+ErNRv0s1wqQi
         eX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/+ZsqTMmoZMDtyMhnS93lf9O6mu50Z9E4EdSsXdBhk=;
        b=ldoHu7Cp6vNT6/EzNxR6D02x/ClEFhnbCEcrIymaGAFBAuiY/lLEQmpWJYMNvLXL4c
         5RmXuZoTajMUV0oky/4ioM16YTwB0YQeRkJk/pfqHOVegkg6OgUzotRA1b0LWwI9WCnL
         MQV/hcKGaZRfEDOmWtzJGJz/snwFDRCkU3Ft+0+S5G0IFFH6SCLzVOKV48tPDI5TgVhG
         R9IFK1MtGInEc1XpS5K5tU3LwtHPhvNVQa7fm5s+pLGF6QojeScNefJPh+CjcVv30FE2
         YC+47mNXd1UsW5IgIXH0CgvCf+VkyN9PWCSJhDQyI29OaEWe6QJsNXUpB5kJo9ZjZlWN
         lpAQ==
X-Gm-Message-State: AOAM530n1bGoUfFBqlQ/vOckrKBYT1a257kRK3In8mPgyytbFN8VlSuS
        FfbWk2jXJEpouy1XdsFq4TVxLQ==
X-Google-Smtp-Source: ABdhPJxh1BjDnZgVq/7WF+89iMmaWRXnRV7fQFyyKCiwTOSaJdH7xtGJDvAvp/0Z05JQin2kH7HF7g==
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr4744313ilv.179.1632419104857;
        Thu, 23 Sep 2021 10:45:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a12sm2822210ilb.66.2021.09.23.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:45:04 -0700 (PDT)
Date:   Thu, 23 Sep 2021 13:45:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc/technical: remove outdated MIDX default note
Message-ID: <YUy9HzRgHU2zvI4P@nand.local>
References: <20210922221342.6867-1-e@80x24.org>
 <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 09:47:03AM -0400, Derrick Stolee wrote:
> On 9/22/2021 6:13 PM, Eric Wong wrote:
> > Multi-pack-index files are used by default since
> > commit 18e449f86b74bab35b150549c8342d252fe7ae00, so the
> > outdated note was misleading.
>
> You are correct that the note is misleading, but it is still correct.
>
> A user can _disable_ reading MIDX files by setting core.multiPackIndex
> to false. If this was in the user-facing docs, not the technical docs,
> then I might push back on trying to make that distinction.

It may present a fuller picture to instead say:

  The core.multiPackIndex config setting must be on (which is the default)
  to consume MIDX files. Setting it to `false` prevents Git from reading a
  MIDX file, even if one exists.

Thanks,
Taylor
