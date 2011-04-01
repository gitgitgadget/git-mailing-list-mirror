From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 22:36:12 +0200
Message-ID: <201104012236.12844.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <20110401200537.GA15778@sigill.intra.peff.net> <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 22:36:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5l4w-0002Lk-IG
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab1DAUgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 16:36:17 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:10253 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752179Ab1DAUgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 16:36:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1B068130049;
	Fri,  1 Apr 2011 22:36:13 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EA73019F5DA;
	Fri,  1 Apr 2011 22:36:12 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=ro88pwpA+Gfu5p2dB3ntn8PUcwvjHRh3iRy_H@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170620>

On Freitag, 1. April 2011, Erik Faye-Lund wrote:
> On Fri, Apr 1, 2011 at 10:05 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Apr 01, 2011 at 09:57:14PM +0200, Erik Faye-Lund wrote:
> >> > But this does not help the case at hand in any way. How would you
> >> > interrupt a thread that is blocked in ReadFile()? The point of
> >> > pthread_cancel() is that it interrupts blocked system calls
> >>
> >> There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
> >> Cancellation), so relying on that is undefined behavior.
> >
> > Eh? My pthreads(7) says that read() is required to be a cancellation
> > point acrroding to POSIX. I didn't dig up the actual reference in the
> > standard, though.
>
> I don't understand where the implementor would get that from after
> reading through it, but if there's something I've missed we can fix it
> by replacing my pthread_cancel with this, no?
>
> static inline int pthread_cancel(pthread_t thread)
> {
> 	SetEvent(thread.cancel_event);
> 	CancelSynchronousIo(thread.handle);
> }

Do I deserve this? There *is* a function that does what we need. I get what I 
deserve when I don't study all 100,000 functions in the manual...

Wait a minute! I *did* study 100,000 functions. This is one of the 25,000 
functions that are new in Vista... Those I haven't studied, yet.

;)
