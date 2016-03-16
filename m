From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] t9117: test specifying full url to git svn init -T
Date: Wed, 16 Mar 2016 22:34:18 +0000
Message-ID: <20160316223418.GS29016@dinwoodie.org>
References: <20160316190954.GR29016@dinwoodie.org>
 <20160316193407.GA3781@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 23:34:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agK1L-00084j-LZ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 23:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935227AbcCPWeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 18:34:23 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37094 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546AbcCPWeW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 18:34:22 -0400
Received: by mail-wm0-f51.google.com with SMTP id p65so92730969wmp.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWmYJJm47mAdokutOnIT5msHIKVniNWxOHalf8/bSBQ=;
        b=USpgaBZDgEjMQTkMDSLi2sFDgb1IfKTVXZAZjnwAPqRZhySn/Pqc49OE8phbreUoJJ
         x8CPVHGVk6NjusZCKAEqfpt+Nqq1EQxM2fHbV77PzT9jNZ6QASvJ/jyOIBZZe7H7VWAz
         S70G0gn8v5BLtSZSQo/eqciyXbCOjJ2C+GtAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWmYJJm47mAdokutOnIT5msHIKVniNWxOHalf8/bSBQ=;
        b=jpXg9Mz5PfqHM3NbyjJfOirbPybpSS4BFPBjD3L6S/gUcVClbXZ7ETnMCDLtByCZdh
         qDokHe5LIS6LUpVYNExjuTykKNRzQkej0RdNYY1VcoVvRK6pkgt+vJqpfTdUACjoiw3l
         9a32N7qSIqaXCdSmFBcuTjDvyIb70zvPl1NZqFDth38anruEfqft2M1+Mkfavansnc+y
         rj+pG4Bd0kvJ6NYpTyxcmRENv8fko0oDNg/b7GtbIRm4NEsz2Rr4Mxx4cUOQcrtXvX8F
         jPk3noc2LDWsGcAiF3rrMYA95Q9xhQHIe3RJlZ/94mtCrxBjGTk+cyIsE5XZW4JCYxut
         T3LQ==
X-Gm-Message-State: AD7BkJKxBmWTnUoPA4aPPYzcGS3LMPHkge4VMCYddoGGhaa42YG2ukoPnTuXRFcakJKNwQ==
X-Received: by 10.28.55.74 with SMTP id e71mr33244865wma.26.1458167660779;
        Wed, 16 Mar 2016 15:34:20 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id 202sm5407298wmo.7.2016.03.16.15.34.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 15:34:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160316193407.GA3781@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289056>

On Wed, Mar 16, 2016 at 07:34:07PM +0000, Eric Wong wrote:
> Adam Dinwoodie <adam@dinwoodie.org> wrote:
> > According to the documentation, full URLs can be specified in the `-T`
> > argument to `git svn init`.  However, the canonicalization of such
> > arguments squashes together consecutive "/"s, which unsurprisingly
> > breaks http://, svn://, etc URLs.  Add a failing test case to provide
> > evidence of that.
> > 
> > On systems where Subversion provides svn_path_canonicalize but not
> > svn_dirent_canonicalize (Subversion 1.6 and earlier?), this test passes,
> > as svn_path_canonicalize doesn't mangle the consecutive "/"s.
> > 
> > Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> 
> Thanks, I was just working on a patch to fix this problem
> when I got this patch :)

Awesome, thank you!

> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> 
> > ---
> > 
> > I think the bug here is in using perl/Git/SVN/Utils.pm's
> > `canonicalize_path` on the `-T` argument.  If it's available, that
> > function calls Subversion's `svn_dirent_canonicalize`.  The Subversion
> > code[0] makes it clear that this function is fine for relative and
> > absolute local paths, and for UNC paths on Windows, but it isn't
> > suitable for use on URLs.
> > 
> > [0]: https://svn.apache.org/repos/asf/subversion/trunk/subversion/include/svn_dirent_uri.h
> 
> Yep, we should be using canonicalize_url for URLs.  I was able
> to reproduce this on Debian jessie (GNU/Linux), too.

Good to know.  I didn't get as far as digging through to see what a code
fix would look like or how much existing code there was that could be
used.

I'd initially thought it was a Cygwin-specific problem on the grounds
that my Linux box wasn't reproducing the problem, but that's evidently
actually my Linux box having Subversion 1.6 installed, while Cygwin has
1.9.

> > It occurs to me that the correct "fix" here may simply be to stop
> > claiming support for specifying URLs as arguments to -T, and mandate
> > users use the `git svn init $url -T $dirent` syntax instead,
> 
> Nope, we should never stop supporting existing behavior without
> very good reason and adequate deprecation warnings.

Fair enough.  I was thinking here that the existing behaviour seems
little-used, given the bug has existed for some time, although I guess
there may still be a significant subset of users who do have it working
thanks to using an old Subversion release.

> > --- a/t/t9117-git-svn-init-clone.sh
> > +++ b/t/t9117-git-svn-init-clone.sh
> > @@ -119,4 +119,10 @@ test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
> >         rm -f warning
> >         '
> 
> For future reference, your mail editor is expanding tabs to
> spaces and munging your patches.  mutt won't do that itself
> (at least not with my config), so I guess it's your editor.
> 
> Manually fixing up the whitespaces damage on my end.

Mea culpa.  I copy-pasted the patch into Vim out of laziness, and
completely forgot that'd mangle the tabs.  I'll try to remember for next
time :)
