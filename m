Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250E5C43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD8A20716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QKOuNFuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgICWdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgICWda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:33:30 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F15BC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:33:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j3so2123466qvi.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7AY+nwUG/7ZoX5Gvt85Upnd0bzqR+lSdS+DYfSAfo9s=;
        b=QKOuNFuFT7THOs2U0SMVYx1p4wtc5GdufFy4+oMErx11GVMyCiJewuo6HsKWf1MBZ4
         MfXUsB2QIgvQeQGdb/e/AlQJf9hwWBHW3xnheIqnEgm6cY/pL6OrZDo8mHF0vVLA9tlN
         zAXkgzkkAr5M4VtEKl/LqriFBYf/qDMjviCZGlESYvv4l0DnEI6K9hO8p/k8t6JIkDMy
         R8y8tSGAIl/qkn172ObepKFHwkDIyq4PddODMWVATcCM/j7hEJNjTc5CKeVjduSJQ8jE
         HJ1y7Vb3vPweL703Ul9UAf16lx4CCHdkmS4XwEJkkyf0pFty/CW72q9zYx/hgdqZDGb+
         JBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7AY+nwUG/7ZoX5Gvt85Upnd0bzqR+lSdS+DYfSAfo9s=;
        b=Mn3pw7nOuo+YTD1CB8oeNQlmQD5hJ60ELuh9kmC8ETILFbG3gCOzeC3kgnFqg1Ynqq
         2ZCX1FNt8a+KYuMr2DBRURmtktlYmVqkMIoAo7jFEri9WSJluXOKYpHZa5xyJ9P3oiGh
         udxz2DR0AlX6E91CtwWCCBvWD5KhjMSuihKAB4CdXRF+t4zC9M0vqJ0TJXl6ohXsHIkl
         6wRPJxPdAknRUaLN/Ht49WzBa3MZJJEDfRDlKw5UvVMXZTuNlZ1+qJGfqLS1gV5ir9XF
         ex7m5w8YYaMpy5nm4zBhjdycPv+L1w41L4wk5lbWEzmP7L2nXX+9zC6t6UQx5/oWr5CY
         HSkQ==
X-Gm-Message-State: AOAM5328NPMkVcrAEQZKJOGa9EAuuI01WxHBEaY2xX9PX3+TRcEkLS1w
        aZmXqWu50IYNkh/hds6KBCZBjQ==
X-Google-Smtp-Source: ABdhPJxq63SQdU8tJlABIsDO2f+U95TdQR4DU7UzZZ57yrr3sRFG/X0s1dzjtT/aVkKDQp4zfAv3ag==
X-Received: by 2002:a05:6214:1045:: with SMTP id l5mr5193293qvr.110.1599172409079;
        Thu, 03 Sep 2020 15:33:29 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id y20sm3137818qkj.70.2020.09.03.15.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:33:28 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:33:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/14] more miscellaneous Bloom filter improvements
Message-ID: <20200903223325.GA25635@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <xmqq8sdq8rg1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sdq8rg1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 03, 2020 at 02:45:50PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > Not really much has changed since v2, other than a rebase onto the
> > latest from master (the fifth 2.29 batch, at the time of writing), and
> > to squash in a few fixups that I sent in response to my v2 series.
>
> It seems we've seen more than enough comments and enthusiasm on this
> round to make another round of update worthwhile, but it seems it
> may take a bit more time (e.g. <20200903184920.GA8946@nand.local>)
> to get issues resolved?  Just pinging, no rush.

Yeah. I am definitely partially to blame, since I have been distracted
for the past ~month or so working on some bitmaps-related topics that I
am hoping to send soon.

The issues in <20200903184920.GA8946@nand.local> are already resolved,
and I have v4 ready to send. But, I need to give it a final proofreading
pass before letting it hit the list.

Patches shortly.


Thanks,
Taylor
