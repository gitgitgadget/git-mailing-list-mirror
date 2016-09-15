Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259891FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 01:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756264AbcIOBWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 21:22:20 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37011 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755955AbcIOBWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 21:22:19 -0400
Received: by mail-it0-f45.google.com with SMTP id 186so51777789itf.0
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+iwKqATkiaiheyknKeL6F/1Urv+G+dZ+GRvUdA8Hrro=;
        b=JaKaCjjkyaNQpMbdMJHYNkGj/HjoxKwYPA56iEhdkC64vyUP6EABJxrMx4JQP67upQ
         eIemhY7dkBDphIgDbLdBBiDInbPadk0Wj59uYCpsXHdOOnq+nbeqSVUNkFmZhsgKMrIy
         W7X1KKvF1jZ2TDvK2rESg1R55PfiiKQDxkZWPVHDXfSbmtb0SQbyxVpPz3Bmpc3c10Gk
         HXqRivFOORQgj6P4c/nkRiSgP33X1LpboWVWvviiu+lSXMgRv0xgxwF6kZXrxewIobmY
         Q+ZeDK3VYsWAZrnfk/80bjYYavMLHRtR1EVv0B3csgyv7ZTyJYa8P8/XSBh9MTeLUtbo
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+iwKqATkiaiheyknKeL6F/1Urv+G+dZ+GRvUdA8Hrro=;
        b=fEtQywTULjFIYunNuqW/IRtOT76o1PL3wb44OLIorN2aMkVJGo7fAt7dJI36bZMCYv
         /pcnF5W7HiyWFGmyb0AexDWVolomwXRnUT1E4a7CktTK1LPoGmT23R8zq1H1YTQi/qWv
         EGGP3fGAZLR3GfaRH0i8gbwooxTp/vKuK6nMlK3dz0eaI32qbYXjjy4pZUKpbIehmPzd
         9ttDWOLRVYVZ68SQdi0rb7osGP0KN1dsE2YOWsoCCUE+s01bzWqCxA31GymIQ8lX6+gi
         gAIC3u6Ii5u+Hi3D55D0K44iMLTAalDvKldP/gBHIHcxLO4b3Qy6COwn/zpI+CiNtzld
         7Ypw==
X-Gm-Message-State: AE9vXwPlnImkoDsnCw/x7DX51wt6xc0ZWnudhcxu9J091bv9ZuuABE2BdckVNVrbwMbJISOFjgSo/KZTkHZGtL5v
X-Received: by 10.107.170.168 with SMTP id g40mr11837998ioj.173.1473902537922;
 Wed, 14 Sep 2016 18:22:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Wed, 14 Sep 2016 18:22:17 -0700 (PDT)
In-Reply-To: <20160914235843.nacr54ekvl6rjipk@sigill.intra.peff.net>
References: <20160914235547.h3n2otje2hec6u7k@sigill.intra.peff.net> <20160914235843.nacr54ekvl6rjipk@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Sep 2016 18:22:17 -0700
Message-ID: <CAGZ79kYcB-x40_w1fcWL3NSp8JU9SPrTAEiru-6Jpb7fDM1Y0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] use zstd zlib wrapper
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 4:58 PM, Jeff King <peff@peff.net> wrote:
> There's a fancy new compression algorithm called "zstd". The
> idea is that it's supposed to get similar compression ratios
> to zlib, but with much faster compression and decompression
> times. And on top of that, a nice sliding scale to trade off
> size versus time on the compression side.
>
> The zstd site at https://facebook.github.io/zstd/ claims
> close to 3x speedup for both compression and decompression
> versus zlib, with similar compression ratios. There are
> other fast algorithms (like lz4), but they usually compress
> much worse (follow the link above for a nice table of
> results).
>
> Since any git operations that have to access objects need to
> do a zlib inflate, in theory we can speed up everything by
> using zstd. And then on the packing side, use higher
> compression levels when making on-disk packfiles (which will
> be accessed many times) and lower ones when making loose
> objects, or deflating packed objects on the fly when serving
> fetches.
>
> The catch, of course, is that it's a new incompatible
> format. This would be a pretty huge change and totally break
> backwards compatibility for git, not just on disk but
> on-the-wire as well. So my goal here was not a finished
> product but just a quick experiment to see if it did indeed
> bring the promise speedups.
>
> Disappointingly, the answer seems to be "no".

After having looked at the data, I disagree with the conclusion.
And for that I think we need to reason about the frequency
of the operations happening.

* As an enduser, happily hacking away at one repository,
  I probably do not care about the pack size on disk as much
  as I care about timing of the local operations. And I assume
  that for each repack we have about 1000 reads (log/rev-list)
  The 1000 is a wild speculation without any data to back it up.
  So as an end user I'd be happy about [zstd, ~5]
  For the end user LZ4 seems to be the best solution if it were available.

* As a service provider, I know we have a lot more reads than
  writes, and repacking is annoying. Also at that scale the disk
  isn't negligible cheap. So we need to weigh the numbers differently,
  but how? I suspect depending on the weighting it could still be
  considered beneficial to go with zstd5. (No hard numbers here)
