From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to be
 used
Date: Sun, 05 Apr 2009 22:31:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904052220060.6741@xanadu.home>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
 <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
 <20090404180601.GA14888@coredump.intra.peff.net>
 <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
 <20090404232505.GA26906@coredump.intra.peff.net>
 <alpine.LFD.2.00.0904042001540.6741@xanadu.home>
 <449c10960904051909v5ec5d7danc10d13d9a1d613f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_ttdepqwb7MDRScsxZoMOwA)"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 04:32:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqedh-00037u-Ij
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 04:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbZDFCbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 22:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbZDFCbN
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 22:31:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28025 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZDFCbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 22:31:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHN00388QZSJPP0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 05 Apr 2009 22:31:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <449c10960904051909v5ec5d7danc10d13d9a1d613f0@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115752>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_ttdepqwb7MDRScsxZoMOwA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 5 Apr 2009, Dan McGee wrote:

> On Sat, Apr 4, 2009 at 7:11 PM, Nicolas Pitre <nico@cam.org> wrote:
> > On Sat, 4 Apr 2009, Jeff King wrote:
> >
> >> On Sat, Apr 04, 2009 at 01:20:18PM -0500, Dan McGee wrote:
> >>
> >> > > That makes sense to me, though I wonder if it may confuse and frustrate
> >> > > users who are expecting their awesome quad-core machine to be using 4
> >> > > threads when it only uses 2. Is it worth printing both values, or some
> >> > > indicator that we could have been using more?
> >> >
> >> > I thought of this, but decided it wasn't really worth it. The default
> >> > window size of 10 makes it a very rare case that you will use fewer
> >> > than 4 threads. With the default, each thread needs a minimum of 20
> >> > objects, so even a 100-object repository would spawn the 4 threads.
> >>
> >> Good point. Though by that logic, isn't your patch also not worth it
> >> (i.e., it is unlikely not to fill the threads, so the output will be the
> >> same with or without it)?
> >>
> >> I still think yours is an improvement, though, however slight.
> >
> > I don't think this is worth it at all.
> >
> > This display is there mainly to confirm expected number of available
> > threads.  The number of actually active threads is an implementation
> > detail.  Sure if the number of objects is too low, or if the window size
> > is too large, then the number of active threads will be lower.  But in
> > practice it is also possible that with some patological object set you
> > end up with 2 threads out of 4 completing very quickly and the other 2
> > threads still busy with big objects and total remaining work set too
> > small to split it further amongst idle threads, meaning that you'll end
> > up with only 2 busy CPUs even though the display said 4 threads
> > initially even with this patch.
> >
> > In other words I don't think this patch is a good idea as we don't
> > update the display with remaining active threads along the way.
> 
> Why do we show this misleading at best piece of information at all
> then? I'd rather completely remove it than show lies to the user.

As you might imagine, I don't share your above appreciation.

> It
> sounds like it is only there for debugging purposes.

... which is still worthwhile nevertheless.

> If we choose to keep it, I propose either accepting my patch so we are
> not mislead, or dropping the thread count completely from the output
> and saying only something like "Using multi-threaded delta
> compression."

Your patch is not better.  Instead, it will confuse people who 
explicitly told git to use x threads but the display might say x-y 
threads, with 0 <= y < x.

The number currently displayed has real meaning: this is the number of 
threads git is allowed to use.  The number of threads it will actually 
use is variable and it changes with time.


Nicolas

--Boundary_(ID_ttdepqwb7MDRScsxZoMOwA)--
