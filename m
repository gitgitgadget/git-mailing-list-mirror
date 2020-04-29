Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD3C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE87D214AF
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lH1mIEhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgD2WlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2WlX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 18:41:23 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842DC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:41:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z1so1831291pfn.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/W267zWwbmvjRZCgaDwzPP8FmfGDJC7rPAuET+776G4=;
        b=lH1mIEhcmIPgKFiqir0K4nxQyCzWpjyKqToVnpZEncslKRJQ2VESEAfv+Bf2sRn/zg
         WkNUHwLSYN/lAkW/9xAGqzaOCeu+a1QFboaND6uQL5li/VqMaBcuHsQOIYIKpm7M+A8I
         r56GTFW526DgW9gbPuQOTZeydZHuq4URoD2a/wyeVfeN/YqZs1g+3/o++wYAj5MjFo3F
         JOodXvPVq2N4SxzfbPspGJlt0+JV8TYzQyauct+AzKVKAdIf/XfEK8NQJxlsxUnEF99O
         lWgwJMV/NsHMxevwz0KE+3DjnhIhx17oPHc4Bh46D11xL/ZSqvRbLCAY8p0QFG8KDR8b
         T93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/W267zWwbmvjRZCgaDwzPP8FmfGDJC7rPAuET+776G4=;
        b=CtBaKmmENMTBXFVK+7Z0lDnJto04nFvkG2IK2xdybfNXgHPmaR/l8ij07KEW0wUUH7
         jDa+/SXOxa0B2dMdYRLgCqOq7BIw2GLBH1UtsErgsHztuZOssEdga/jruKotA97usb9T
         4S2zXgq2/jhTsxNNKo9itW05Cv3RnP+Dl/DdjtF/0ho2NsQPd0x81FGXOykFBBeSzVyz
         HK33W/8e2yETPouJYCks2l4Q/b7EcxSjZkrk/3VOjCq4600D+pRKi0ybXQFOJYCdpBfI
         CxmtKMdHtBLOs932n/3C6sDTaUGmRr2S5yz8UypR/7GFige5AnVs3aEWCUCHf8CrbiS9
         P1dw==
X-Gm-Message-State: AGi0PuaK+qsBwAO/JMHY5/Yo80T+twI1yVEypl1BUJqYapBu0KNjb7IL
        tX6PeKQrfWRxYV2x/uJV6ZCiPg==
X-Google-Smtp-Source: APiQypKuQ5Dtb853NQhJFzvlieALuxHjEeFzrsjDPsyi1iUxNmJA8LOARHfSsKSVSKUAkRR+hYKySw==
X-Received: by 2002:a62:3006:: with SMTP id w6mr376481pfw.29.1588200083224;
        Wed, 29 Apr 2020 15:41:23 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n34sm1731638pgl.43.2020.04.29.15.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 15:41:22 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:41:21 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* [PATCH 0/4] t: replace incorrect test_must_fail usage (part
 5)
Message-ID: <20200429224121.GA18172@syl.local>
References: <cover.1588162842.git.liu.denton@gmail.com>
 <20200429195035.GB3920@syl.local>
 <90edb162-e035-bdb7-a2d2-ffc6bd075977@kdbg.org>
 <xmqqblnaufyt.fsf_-_@gitster.c.googlers.com>
 <20200429214906.GA12075@syl.local>
 <xmqqsggludg6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsggludg6.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 03:36:25PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Hmm. I say this as somebody who just re-rolled a series to add two
> > 'test_might_fail umask 022' lines, so am a little disappointed to learn
> > that this is not considered to be idiomatic.
> > ...
> > Junio: do you want another reroll of that series? :/
>
> The one I saw and remember was two new umask calls protected in POSIXPERM
> prerequisite but without test-might-fail involved.
>
> Perhaps there is nothing to reroll?  Or perhaps I am not checking my
> mailbox often enough?

You are checking your mailbox often enough, but unfortunately my memory
isn't as good as I thought ;). You're right: those calls are in
POSIXPERM-only tests, and don't have a 'test_might_fail' in front of
them as such.

That was easy ;).

Thanks,
Taylor
