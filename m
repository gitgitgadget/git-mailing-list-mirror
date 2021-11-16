Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FEC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E5561929
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhKPSbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239109AbhKPSbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:31:43 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD9C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:28:46 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id k21so27380431ioh.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ysJ2mMdLyTjXbnChybak2WM/V5yUyP1goXVXKCw1SM=;
        b=HGU5TmRxoieWzwzfZlGcOgX5xHJT257rOeW2RXx3Um30Fl9ijx6vuS16zFVf9hN/+O
         b0lqMPXV2i0FcOm1qVUReyLnTd772904z4pzA+OBGfC0zyajGR0Y7yVLrL2ddtJue6TC
         qLCnNFNSWxYd2OUW/XMRK3M76COFRnBHFhfk3j1huzPsHRYKmvgv0Ktnfsqk5MQ8OBsN
         O3uTDToQgJHiTEN4o36g23JNJqFRZJS/+XONxXPByefqTLakE2FGkRapXl9j/wLjk/ur
         vueMWwFdmUByqX37LY6bGg5b2hgj0/+6F7Kxn9dtoNLw/M+x9CgXLOEIS3St9g0Rpw4K
         Jyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ysJ2mMdLyTjXbnChybak2WM/V5yUyP1goXVXKCw1SM=;
        b=o/ZLqs1OegCUyiG/HBev8z1QGbsGCGDkRUpjDwBszEWKROv+szKXtGJc77jzsE+Pnr
         v1hvtwaaRtEXhDyRH111ADZ9N+VDNBPOcx3NJMTwiBZisRLX2MBn9bUahXpkd8L7N6cM
         Xu/5iVmhNdP2DrzsVKPLjfDFUF3s2JM8Pjz3EnAAAUAAlF5zFqp4YHsyc5c22N0U4oe3
         6zdUmjS4rlLatbDmSPWksbD1AE0XOzJUokj8uug8QRLl8A9IMGXSRfkt6dU9KI/RAQd+
         b2enUSbGeKv85DFIktn39LF1H7klMoGhqJBmv9pcVkkvTHdMamKeZHaeEYoXPUOQbsfH
         jfHw==
X-Gm-Message-State: AOAM5320ZOcFNllF+RJQUvjhVfilnpUvThyk2iZfa3R6tV4SomGBJOlN
        7Z+a6+SOcfSMrLvE5Echdqqsh/tWPQlfP/DU
X-Google-Smtp-Source: ABdhPJzngway6OFkMGNdkf+DXnAf1FbstpGGjqzvwGtDvYMitXx8SC5NEkuFnx0D+t7bYA5X9MOxvQ==
X-Received: by 2002:a05:6602:3407:: with SMTP id n7mr6433410ioz.37.1637087325495;
        Tue, 16 Nov 2021 10:28:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t188sm10716309iof.5.2021.11.16.10.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:28:45 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:28:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] wrapper: use a CSPRNG to generate random file names
Message-ID: <YZP4XDtF7O7Sxh17@nand.local>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-3-sandals@crustytoothpaste.net>
 <YZPQE+SKVXjexXMT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZPQE+SKVXjexXMT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 10:36:51AM -0500, Jeff King wrote:
> On Tue, Nov 16, 2021 at 03:35:42AM +0000, brian m. carlson wrote:
>
> > The current way we generate random file names is by taking the seconds
> > and microseconds, plus the PID, and mixing them together, then encoding
> > them.  If this fails, we increment the value by 7777, and try again up
> > to TMP_MAX times.
> >
> > Unfortunately, this is not the best idea from a security perspective.
> > If we're writing into TMPDIR, an attacker can guess these values easily
> > and prevent us from creating any temporary files at all by creating them
> > all first.  POSIX only requires TMP_MAX to be 25, so this is achievable
> > in some contexts, even if unlikely to occur in practice.
>
> I think we unconditionally define TMP_MAX as 16384. I don't think that
> changes the fundamental issue that somebody could race us and win,
> though.

Yes, we do. Right above the declaration of this function (and so hidden
from the context) we do:

    #undef TMP_MAX
    #define TMP_MAX 16384

I don't think that the value of TMP_MAX makes this substantially less
likely, so I agree that the fundamental issue is the same.

> > @@ -485,12 +483,13 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
> >  	 * Replace pattern's XXXXXX characters with randomness.
> >  	 * Try TMP_MAX different filenames.
> >  	 */
> > -	gettimeofday(&tv, NULL);
> > -	value = ((uint64_t)tv.tv_usec << 16) ^ tv.tv_sec ^ getpid();
> >  	filename_template = &pattern[len - num_x - suffix_len];
> >  	for (count = 0; count < TMP_MAX; ++count) {
> > -		uint64_t v = value;
> >  		int i;
> > +		uint64_t v;
> > +		if (csprng_bytes(&v, sizeof(v)) < 0)
> > +			return -1;
>
> If csprng_bytes() fail, the resulting errno is likely to be confusing.
> E.g., if /dev/urandom doesn't exist we'd get ENOENT. But the caller is
> likely to say something like:
>
>   error: unable to create temporary file: no such file or directory
>
> which is misleading. It's probably worth doing:
>
>   return error_errno("unable to get random bytes for temporary file");
>
> or similar here. That's verbose on top of the error that the caller will
> give, but this is something we don't expect to fail in practice.
>
> I actually wonder if we should simply die() in such a case. That's not
> very friendly from a libification stand-point, but we really can't
> progress on much without being able to generate random bytes.

Alternatively, we could fall back to the existing code paths. This is
somewhat connected to my suggestion to Randall earlier in the thread.
But I would rather see that fallback done at compile-time for platforms
that don't give us an easy-to-use CSPRNG, and avoid masking legitimate
errors caused from trying to use a CSPRNG that should exist.

Thanks,
Taylor
