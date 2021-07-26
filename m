Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBB5C4320A
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3606960FBF
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhGZSIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhGZSIi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 14:08:38 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342AC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:49:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id u15so13077475iol.13
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fnWt2kdkaGvIVi85NrzlIhXltb/T+b7V8IgYUD/LZyk=;
        b=ZsEcWJDYbnSCql46Vj1A0CpKXB+4CZWlwuncNUo7wkbwqmLToFJ7fgrrfvxEw1qfF3
         ffk+UeALj72+MAkzeJtES8Vn5bye5/iXj+Wu43E2V25Lgk5hsPfaFp0oIjSlBFeN2Qc2
         GTMDY/JY0NtDbFlJ/tbhlTrK6LnetVwlBtvahxD3Fy6duPo4qjWG11WjXecVyI1lu48P
         ItZiyv/5n4xNyNGhonX0x7hvujW+FRi5ZVOuTHZtNQs487vto7i/BWOYFuypsw4Q3bnG
         UIJCK6FGvYYbr5P3eZy7jy20qU2YUd0Af/Zttr8TMNPxHheVNHoPUXJLPVSxtycajE3U
         pxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fnWt2kdkaGvIVi85NrzlIhXltb/T+b7V8IgYUD/LZyk=;
        b=ECxTAehHLIW6o79NjJ4joK8JDdIYseHUy5QRxgbdjHY8HYfuhI0ylqrc4XrJFNEGZV
         kLPhLF1hwcBx4p6nURaJctUE73XAPPShZJQ+rcp9kEQ34LgbLAazwa9IWNKMmzcTyoSn
         9fRyEWs61DQl+XwnzsiRziojQvhVfkg1G726YQMaceVBEyNpOVBIEP2k8dbsw/42PB8v
         868XIf8uPRMBPOlrOPmayk1BtYGPq+UE038esGn6jP3wE4AKukUSkLRgtw0bRrrPRZ+o
         wA6ctv1XzxtzZJrLytI6F1A9zJ7gUKc63HvxUuIyEtCYu1DEdo09601GjvEp9l5yAQjp
         L7Mg==
X-Gm-Message-State: AOAM530uyvUlh9oUsPrrzX+Uvg1G0R1WPD3h9bWqY2avzDpzNe3bKQLb
        usCzfBHcDUjHjfmv8GqwonHkQg==
X-Google-Smtp-Source: ABdhPJz/vSsQunReibK3f2RcMitzJaia5RRsgDVclfjTB2ThW5fe1P7QuQmyv+Vz3u5tgcHzvKmR6g==
X-Received: by 2002:a05:6602:248f:: with SMTP id g15mr1583036ioe.198.1627325345529;
        Mon, 26 Jul 2021 11:49:05 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:18ae:76f8:f6b8:4b88])
        by smtp.gmail.com with ESMTPSA id b9sm309902ilf.16.2021.07.26.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:49:05 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:49:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Message-ID: <YP8DoCEclqD3bXKP@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <YPfv0YoLtpYp9866@coredump.intra.peff.net>
 <YPfyEiXw7szt5mjl@coredump.intra.peff.net>
 <YPhYFnudmHJ9lQek@nand.local>
 <YPpyLaM1Rc9+w6KT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPpyLaM1Rc9+w6KT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 03:39:25AM -0400, Jeff King wrote:
> The question here is: should we continue to omit it from the html build,
> since it does not render well (i.e., should we simply drop this patch).

I think that's a nice way of putting it. Since the HTML rendering is
terrible, let's just drop this patch and leave cleaning it up as
#leftoverbits.

Thanks,
Taylor
