From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Windows: only add a no-op pthread_sigmask() when
 needed
Date: Wed, 11 May 2016 17:06:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605111655350.4092@virtualbox>
References: <26c2fb5560246fc7f980da24a239edc333864527.1462885167.git.johannes.schindelin@gmx.de> <xmqqvb2lpzij.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 17:06:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Vij-0007bM-2q
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 17:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbcEKPGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 11:06:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:50999 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751333AbcEKPGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 11:06:33 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LbdiB-1bSRju3H6B-00lDi6; Wed, 11 May 2016 17:06:25
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqvb2lpzij.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:CmD7+GNjTAMvGWODvVzddmsw4/k4YqzcqL1Lxy9QxOg3QGcmjJq
 o1EUStmj2vKjKHO27KVliplcXupUrnNiKKHublWTWFPpMIVRI8yCVsk3/+UmIrX0SSywYWk
 rAhpuQxXU9MaXkmYrvr9lMGxpPKujLBZW8CeYKbaDoB7natEZPRIhjvj9mbCoeGwvt5vaH9
 AsaTjLFVw+Cj3y2QVNjWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/BNJA6hXQHo=:Z+R4EuJHgN7TWb3ns/bq06
 Um2M2SA7uRDAaEW/NFs53DjDQJH7UO4I+UD8SXotFJxYCSV53RelZFKsOsKwEC5XT3uPjxEMD
 gdfisR3M2qdARCZzN9lmaGgHlaeVrMyVsbUa10/pSDuRFj7pegFeR5HVhKhSJzitoEuPZXn/A
 spHDyMk/EFuUCsK/O06ecpkTF4P4pLMCOkxMVf5fTuxjlXNeIM2SJzPMpuzD/+sQ1AKSbDzxY
 jqBB3N/4iHdTbmKZBDn532j1NvqbSPqC9YtNgASh+1/QlqRVxYb8kjbqzfDwmufmTksh3g7Lf
 YWnM7qqfUO3pkfS9aBi2hVPHnuQXIlGuYr2xCCKkJQ3pjiswxpXsFNppM9odu/rpuqhYu9iO4
 1/GUJvReOFWAcS8VKTrFQiFuOIYO08bIxdyTkn3D+XUpAd4cw1yoq9WMf9QbeSnuvvv9PXjLY
 Ow45SdOlLP1bak8x3suqXl2vZAGoR+Zo50/TDtpegOgAdVZL3BjXiSRx5jhnfZZTzzAemFR5q
 IE9i1sW6UB3cK31GJb16SdelWqZkBrmAOXVFP/Eth0N9GmXlBVrPGzydW51Ydk7Z3LM1mUu2f
 OQGdkDbxsuSp/A9jcpo9KPmlVDOLo+AnCWi5MTzE2h6Q0i3Kg7bFfHYkzoBsEMFMWtHju9c62
 wN92b7s68oeUg68cr1qptmOvKoF+/3s5ldxcpHV8VMK2NzSqpHKjNpRt2WbCSHCfdhL5y4Dy/
 MUzNtnbh3Z0CHrioBDiI+UvyGtFpYlsHPTCksIbihEX6JKXcjRVHoghu0xA8iCTWXKUFOuAA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294348>

Hi Junio,

On Tue, 10 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > In f924b52 (Windows: add pthread_sigmask() that does nothing,
> > 2016-05-01), we introduced a no-op for Windows. However, this breaks
> > building Git in Git for Windows' SDK because pthread_sigmask() is
> > already a no-op there, #define'd in the pthread_signal.h header in
> > /mingw64/x86_64-w64-mingw32/include/.
> >
> > Let's guard the definition of pthread_sigmask() in #ifndef...#endif to
> > make the code compile both with modern MinGW-w64 as well as with the
> > previously common MinGW headers.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	This patch is obviously based on 'next' (because 'master' does not
> > 	have the referenced commit yet).
> 
> One thing that makes me wonder is what would happen when
> /mingw64/x86_64-w64-mingw32/include/pthread_signal.h changes its
> mind and uses "static inline" instead of "#define".  How much
> control does Git-for-Windows folks have over that header file?

We have no control over this, it is defined by one of the MSYS2 packages.
(I think those headers come directly from the MinGW-w64 GCC project.)

I can think of two different ways to resolve this, would you please
indicate your preference?

1. fix the non-POSIX-ness:

	#ifdef pthread_sigmask
	#undef pthread_sigmask
	#endif

   or even shorter:

	#undef pthread_sigmask

2. just go with whatever MSYS2 provides:

	#ifndef __MINGW64_VERSION_MAJOR
	[... define the no-op ...]
	#endif

> Also, could you explain "However" part a bit?  Obviously in _some_
> environment other than "Git for Windows' SDK", the previous patch
> helped you compile.

Yes, Hannes uses his own MSys environment. (Which is different from
everything *I* have, I think, it's not even msysGit.)

> What I am trying to get at is:
> 
>  (1) If the answer is "we have total control", then I am perfectly
>      fine with using "#ifdef pthread_sigmask" here.
> 
>  (2) If not, i.e. "they can change the implementation to 'static
>      inline' themselves", then I do not think it is prudent to use
>      "#ifndef pthread_sigmask" as the conditional here--using a
>      symbol that lets you check for that "other" environment and
>      doing "#ifdef THAT_OTHER_ONE_THAT_LACKS_SIGMASK" would be
>      safer.

So I guess that you're preferring my 2. above. Going on that assumption, I
will send out another iteration.

> Also is
> https://lists.gnu.org/archive/html/bug-gnulib/2015-04/msg00068.html
> relevant?  Does /mingw64/x86_64-w64-mingw32/include/ implement "macro
> only without function"?

Yes, it has that problem. Do we care, really?

Ciao,
Dscho
