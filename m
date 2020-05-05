Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15965C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1790206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GJ/Mgd2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgEEQED (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgEEQEC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 12:04:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B4C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:04:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so997220plo.7
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p9Q7GIEpm2YZjToJElLVfrI4ISN3pDVZJLAq1injc2E=;
        b=GJ/Mgd2nS5rwf3sdXQq8HHpni3k+F4OjLfl92UlK1v9NLA4KDKwqI70DkVB//B17cw
         guEVQfRG0/Q5eJjSOW4ALwd2feNN/5npr8Up0zv6XIKxXDPCIsSWO5CuKdF63Bm11WST
         Q62kSBmEBVMcsT5+MiCBVNyuZpjeljqrUoJV3a7CbIE95Ta/Uz8ux4HpR46JIS/9DXex
         0r4oGuDHxXhPL5h8WCWMnOfagJ6YvFWLp4zDr7xjyuS+JXmH39a+GrfGN1atFDYclIyB
         df96plGEvH/x3iTSBC2eyFK6ZRam/WFAjOqapla/MPekGFdyTBldgB/nGVoywf5Lh2EI
         6OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p9Q7GIEpm2YZjToJElLVfrI4ISN3pDVZJLAq1injc2E=;
        b=a/3z5Lp8waE2SsPiFHF55kYUoSZVcOCXoaaV60c8rpFfNjwZbG8GKCpnz6HKeJ4TMR
         39alPeG2nJSSL3kRN2ltbCEniUZVCW/vtgQpxXkxn/M19B5m2O6Gg4isIPjcMEPfqYa4
         a6NFH11J181sSTZx7pqwyH3fR5mYQKI1LS1JGw2gMyyfB0+ODh4vM+kZiQfW9NZAXyqn
         AqiSXIx+Rlf3uHVJrRJeOoVCTepNAoWzvDTAWfgno8YNTEPhmcOcgIgO6AZjrUIQq5Xr
         mk7SKAOk+BMyRIYotbBflEE4W/1fJJ5lSrCm1xTRsTWdHXURSdFnBPKFeWv269yOc9bl
         T4Zw==
X-Gm-Message-State: AGi0PuY65wbikqP7cUOk3IhmmMuRVf3v7L7/SQPjUnR02GKchLjFt/Zy
        dfxWyc2Sb8fC8l4fHl3J72nTL+IpAj6zmQ==
X-Google-Smtp-Source: APiQypKSlJrZjQfUqRbGGZixi0K6FVZOT7Wb1Bsr7fLQ8/Kj/7cTSGG2eHfGbVg3RdnYAj4xZVRMdQ==
X-Received: by 2002:a17:902:24b:: with SMTP id 69mr3687014plc.52.1588694642210;
        Tue, 05 May 2020 09:04:02 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z190sm2332694pfz.84.2020.05.05.09.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:04:01 -0700 (PDT)
Date:   Tue, 5 May 2020 10:04:00 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Harri =?utf-8?B?TWVodMOkbMOk?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/1] restore: default to HEAD when combining --staged
 and --worktree
Message-ID: <20200505160400.GC69300@syl.local>
References: <20200505071716.23240-1-sunshine@sunshineco.com>
 <20200505071716.23240-2-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505071716.23240-2-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 03:17:16AM -0400, Eric Sunshine wrote:
> By default, files are restored from the index for --worktree, and from
> HEAD for --staged. When --worktree and --staged are combined, --source
> must be specified to disambiguate the restore source[1], thus making it
> cumbersome to restore a file in both the worktree and the index.
>
> However, HEAD is also a reasonable default for --worktree when combined
> with --staged, so make it the default anytime --staged is used (whether
> combined with --worktree or not).
>
> [1]: Due to an oversight, the --source requirement, though documented,
> is not actually enforced.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-restore.txt | 11 ++++-------
>  builtin/checkout.c            |  6 +++---
>  t/t2070-restore.sh            | 11 +++++++++++
>  3 files changed, 18 insertions(+), 10 deletions(-)

Thanks, the new version looks good to me, too.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
