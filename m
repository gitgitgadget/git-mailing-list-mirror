Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3EDC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC34E61263
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhKPVqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhKPVqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 16:46:20 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A1DC061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 13:43:22 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id h23so637913ila.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 13:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDEfbmkfmPUHFsLQsYIptzN+s8Jfl0jqo8nVKKnxr6A=;
        b=o1LCyt0toAKzwO/mnoSrKxnPYEU/BxlUGciQGhFO5jXeiJ+MVU1+HAO8+Y9XiNTWfW
         Zhd1sbihSExCErVCmFOaRlglYj1kb5DBHzrSU4rh/ay5rHRh3rmKveBVFJTHd8daOF1z
         aWt6RXybYQSrpR7Iq/LZI196Uv/OVZ0SbeJbUDyf707FrnccsHWY+Cwqlaj2QCGdkRop
         vs3f2mV+HFNkHnFg1KdOO804Nrr0ufDF4fIkXB8ma9cgC5U9/wNd58iisTsZIltrdWLX
         khBFAHFUiCLI8KYyciYmbOfgz+y2gUYyW0CdqQ0X0ScTwjZjY3t1zpQG1HB94U1TDqZt
         mC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDEfbmkfmPUHFsLQsYIptzN+s8Jfl0jqo8nVKKnxr6A=;
        b=rgJIl9LZK8dDZGDpXJldId9Xl5PE7hUFwltfGh69aHJN2pjCLEG0s8eu7Dlcp2AnEe
         p02w/KPu0pzeKUifXhlYLVu8PHIpMady7/11d/h7Cv3tugy9TclJhwX6Uq9l+2/BVhsk
         1XM1wYDj/uX86wdt5kGgkudS+3unDKkcIzpcD7h/ssLvybDJ+q0LcX2e7OjJlqlckil/
         bLRfgW+lgb9x14LgsTW+o6Xz3Kv0GGcAzo0ph3BFB99Ts7+Bh7q44g9y82w7MWbC/5j2
         68OqjKfCgJyfpHD2U7BTJAUtiDas6DnTM3K+bkdhKGh7VFmLt6nlnZxfPaX9OrGF34dF
         zLOw==
X-Gm-Message-State: AOAM5331A2cH1QAtreXQAE5BjHwjRui1HoHFMfnb6Qs+/BDLrKc0pgF1
        xX17tRLS8kTjRD2/fyFnh2hvKQ==
X-Google-Smtp-Source: ABdhPJzD20XOvWomWoLJJjmYJsRKgWp1cmTvU+CZRBGQuuUMqWalO/lVNi2wsYk2w2+1iuJ0ZmmGBA==
X-Received: by 2002:a92:c983:: with SMTP id y3mr6618245iln.24.1637099002255;
        Tue, 16 Nov 2021 13:43:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11sm10089357ioy.19.2021.11.16.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:43:20 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:43:19 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] t5319: corrupt more bytes of the midx checksum
Message-ID: <YZQl95aaW5loTFCW@nand.local>
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
 <20211110231132.GB5811@szeder.dev>
 <YYzq0uBr+uoVvkbC@coredump.intra.peff.net>
 <YZQeMjjtxS2LU2Tk@nand.local>
 <YZQk6t1veegeAlYh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZQk6t1veegeAlYh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 04:38:50PM -0500, Jeff King wrote:
> On Tue, Nov 16, 2021 at 04:10:10PM -0500, Taylor Blau wrote:
> > Peff: do you want me to turn this into a patch or were you planning on
> > it?
>
> I hadn't thought that far ahead. ;)
>
> One thing I did wonder is whether other corruption tests might have the
> same problem. But if they're not triggering in practice, I don't think
> it's worth spending a bunch of time looking at them.

Definitely agreed. We can apply a similar fix if and when any other
spots become a problem.

> So here's this fix wrapped up with a commit message.

Thanks, what you wrote looks good to me.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
