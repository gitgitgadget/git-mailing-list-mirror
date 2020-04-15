Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB41C3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8156E20775
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 09:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=booking.com header.i=@booking.com header.b="5R1Kef3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895121AbgDOJQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:16:32 -0400
Received: from mailout-101-r1.booking.com ([37.10.31.1]:8659 "EHLO
        mailout-101-r1.booking.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895194AbgDOJQ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 05:16:27 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 05:16:26 EDT
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=blwBy3BK4chIXlby7TUeHEDaPbqGssned+VXTJ0RTU4=;
        b=kqsX+KYCr/02MTAESRMWYoRtNvxuYz+UQ1ASgC9ixpuvOyn0BAwekyALH7zWQ65Q2r
         sdqhn/dEkv9tzXdUV60LNYpa7eWd3esrN9CrzQgUlXYq6GCuFsL7wG5Q9e1oUxlc5P8Q
         +DdShpxsxylWHxAxsjiCvdosaoe0uHoPdKrwdHiXhnfQnupCCrEg9C7OsTbhodZFC5lk
         q0/MsaRsVSdoM3v5SYXudSWlaszAJm2CnoKUdaDKkfF4Nq9zHhfr/N5mGaoKuajz1c5Y
         8R+sRxnc3+BTPUhh65MEGLZKv7iW+15Lv6PZr2DzZANmhJj3A2qMtbyqlAe5aY8CxXGq
         Po1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=booking.com; s=bk;
        t=1586941753; bh=blwBy3BK4chIXlby7TUeHEDaPbqGssned+VXTJ0RTU4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=5R1Kef3/pYbzoG/WlY+BHAEcGErHxJOuC6CR8Af3h3sFB4A5EjQUrcLYA8fTUZ1rk
         b5vvSLKu4X1M7yElRCzQIyZJ0V2L0n9ubW4reRcftqafjXnOA9Fft7BtOtOczVOLNp
         xx/hqVra6KsQo86f70pwWGNg/hq9Q5bRaBFL75wE=
X-Gm-Message-State: AGi0PuZI8HvEFI4iWj9VV31rwbIf2ktcudV2a/DXzKPaqAAnjkrUSxQK
        gaO1K1bjMFhINyU0e/JaQL1UkXCDMXgHWmL+LrnYI9yleStO9y1w2dqSzP5LsNodybksFQksZ6F
        plUIBqf+hkeOD+4MnftK7OAQ=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr4157195wmj.35.1586941752032;
        Wed, 15 Apr 2020 02:09:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJDOjeHEk1JkbzXRkHvjapueUR0eroagd56bpp07NAUPnIHuRKwBrBxT6WcqHIUWsiOSr28CA==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr4157169wmj.35.1586941751720;
        Wed, 15 Apr 2020 02:09:11 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:09:06 +0200
From:   luciano.rocha@booking.com
To:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [External] Re: [PATCH 1/1] freshen_file(): use NULL `times' for
 implicit current-time
Message-ID: <20200415090906.wudutxpiyw7ooas6@C02Z11TTLVDN.corpad.adbkng.com>
References: <5e95d37d.1c69fb81.2b4ec.ce9f@mx.google.com>
 <20200414195535.GA1879302@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414195535.GA1879302@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 03:55:35PM -0400, Jeff King wrote:
> On Tue, Apr 14, 2020 at 04:27:26PM +0200, luciano.rocha@booking.com wrote:
> 
> > Update freshen_file() to use a NULL `times', semantically equivalent to
> > the currently setup, with an explicit `actime' and `modtime' set to the
> > "current time", but with the advantage that it works with other files
> > not owned by the current user.
> > 
> > Fixes an issue on shared repos with a split index, where eventually a
> > user's operation creates a shared index, and another user will later do
> > an operation that will try to update its freshness, but will instead
> > raise a warning:
> >   $ git status
> >   warning: could not freshen shared index '.git/sharedindex.bd736fa10e0519593fefdb2aec253534470865b2'
> 
> Thanks, this makes sense. And as a bonus, it's less code. ;)
> 
> I don't recall having any particular reason not to use NULL in the
> original (I may simply not have been aware it was an option), and I
> can't find any discussion either way.
> 
> One observation:
> 
> >  static int freshen_file(const char *fn)
> >  {
> > -	struct utimbuf t;
> > -	t.actime = t.modtime = time(NULL);
> > -	return !utime(fn, &t);
> > +	return !utime(fn, NULL);
> >  }
> 
> The old code was setting the time based on the system time from time().
> We've occasionally hit cases where the filesystem time and the system
> time do not match exactly (this might be true on an NFS mount, for
> example).
> 
> It's not clear to me whether utime(NULL) would be using the system or
> filesystem time in such a case. If the former, then there's no change in
> behavior. If the latter, I'd argue that it's probably an _improvement_,
> since we're simulating the case that we wrote a new file with a new
> mtime.

I'm not that familiar with kernel code, so can't say for sure. From a
cursory look, it doesn't seem like it uses the remote server's time.

But it does seem to have a higher precision, for filesystems that
support it.

In Linux, it ends up calling current_time(inode), which says:
  * Return the current time truncated to the time granularity supported by
  * the fs.

And uses ktime_get_coarse_real_ts64(). That could explain any previous
case where utime() of time(NULL) was different that just utime() or an
effect from writing to a file.

Arguably, even more of an improvement if it gives higher resolution.

Regards,

-- 
Luciano Rocha
