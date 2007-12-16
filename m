From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] threaded pack-objects: Use condition variables for
	thread communication.
Date: Sun, 16 Dec 2007 20:00:16 +0100
Message-ID: <20071216190016.GC4999@xp.machine.xx>
References: <200712160018.54171.johannes.sixt@telecom.at> <20071216120558.GA4999@xp.machine.xx> <200712161941.38109.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3yjH-0002Ff-VD
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 20:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbXLPTAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 14:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbXLPTAW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 14:00:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:55760 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753293AbXLPTAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 14:00:22 -0500
Received: (qmail invoked by alias); 16 Dec 2007 19:00:19 -0000
Received: from p54AAA40E.dip0.t-ipconnect.de (EHLO localhost) [84.170.164.14]
  by mail.gmx.net (mp024) with SMTP; 16 Dec 2007 20:00:19 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19y2GJ+vp5ypJz/BAWoqUOzRRjNTmcqrz67IMxINg
	ppA9wjNgc5OqiO
Content-Disposition: inline
In-Reply-To: <200712161941.38109.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68477>

On Sun, Dec 16, 2007 at 07:41:37PM +0100, Johannes Sixt wrote:
> On Sunday 16 December 2007 13:05, Peter Baumann wrote:
> > On Sun, Dec 16, 2007 at 12:18:53AM +0100, Johannes Sixt wrote:
> > > +
> > > +		progress_lock();
> > > +		me->working = 0;
> > > +		progress_unlock();
> > > +		pthread_cond_signal(&progress_cond);
> >
> > Shouldn't the pthread_cond_signal be inside the lock?
> > e.g. swap progress_unlock() with pthread_cond_signal(&progress_cond)
> 
> No, that's not necessary. Both ways are correct, but if it's outside the lock 
> there is less contention on the mutex (because the waiting thread must 
> acquire the mutex lock before it can return from pthread_cond_wait).
> 

At least I was told otherwise and [1] backs my knowledge up. Are you
really sure?

-Peter

http://docs.sun.com/app/docs/doc/806-5257/6je9h032r?a=view#sync-53686
