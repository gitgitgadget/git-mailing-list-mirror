Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA49C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9D320735
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="byH9sv6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgDMRXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732579AbgDMRXm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 13:23:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F54C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 10:23:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b7so4114474pju.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nr3/U6thSJr5xhjLkdaoE7XntqO/5rjkHLxy5d+zsBE=;
        b=byH9sv6VqA1Ql/sLDOSpa8vTrMNe9F4m/TgDPFJLp3HWmuEhICuMcMf2tK+Ya6xixE
         8t+zWohp7lZUMuE+KVckuoQAFTf1PNHfYIirVN/GV6ao3+x5M39L4RndszudGIndZMK8
         kka+uLhMO6neCnQ4r+2p+prdAAZLKR3Ibu6Ou6Y87AejSj7R7V/AWm0TekTMJqNi2eiR
         T2bieCX3D827w3crR6xPSNm/S75CGARNA1O5OP6hg20B+WRtH+LuZsRh/QucruDwzEle
         9IlumSZkNkSAygQDqVoCkq49b+26iscQwv8ZgOY91clqfzDw3aMEHf+pJWD6YoglJAMA
         TvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nr3/U6thSJr5xhjLkdaoE7XntqO/5rjkHLxy5d+zsBE=;
        b=Q9Bo9CK4hlsZQ+dXRwc/xp8XtpjaqlrpZ+Xn7f1f1HuXoudzFPygjm3TPUdWfOUJmL
         0j2fSbeqLnowoKB/vqoFNNJkQRKSNdRhlNoBBo8MSGHLKC+TtQmSw53C/Q0ufLF1dbh+
         hCPIQ3eoqcrMqQYtPoGk32a44cIazzy++ArPbCb864huZuI/TKdq4h9dUbejuz7Erq6w
         YCuZbJK4BAVRNJtsn2PHEc+PvsagkPN9UjhkFqOcHQI/QzvmwQ4BRqRbV5yUxPIFStsO
         QeqXptG2pazY4yD1iH5pWZiHpnOMLg2tbGoCPGJys1dNUpbZGY1xG2+s4iV494RTXGt0
         Suzg==
X-Gm-Message-State: AGi0PuYNhcyzwtoRz7Gg8DvGpDX81UxLZ0PGa5yj8aeowG3+CyfMmkrG
        SmyWgAKgtvqZYPfwsrMqBLSb4En/aRZXNg==
X-Google-Smtp-Source: APiQypIzo6Vplx+z5m80UcwLzoHq42zM+SiyHCKBW8hfuGPYfIetRestdioJHi0eqbu/C58l4ru/HQ==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr2613030pjq.1.1586798621407;
        Mon, 13 Apr 2020 10:23:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r4sm8264656pgi.6.2020.04.13.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:23:40 -0700 (PDT)
Date:   Mon, 13 Apr 2020 11:23:40 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] better handling of gigantic config files
Message-ID: <20200413172340.GB63249@syl.local>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
 <20200413004927.GC55122@syl.local>
 <20200413172052.GB8183@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413172052.GB8183@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 01:20:52PM -0400, Jeff King wrote:
> On Sun, Apr 12, 2020 at 06:49:27PM -0600, Taylor Blau wrote:
>
> > Thanks for doing this. I knew that it rang a bell for some reason, but
> > it was because of the upload-pack changes to limit the set of allowed
> > object filter choices that I'd sent as an RFC somewhere.
> >
> > I was using 'parse_config_key()', and I think that you noted somewhere
> > that it was odd that it filled an int and not a size_t. So, thanks very
> > much for fixing that case.
>
> Yes, your patch was part of why it was on my mind, though really all of
> this is the culmination of many years of annoyance. :)
>
> You'll have to update your code to use size_t when the two are merged
> together. I don't think there's anything else in flight that needs
> similar treatment, though.

Nope, just that. Easy enough :).

> -Peff

Thanks,
Taylor
