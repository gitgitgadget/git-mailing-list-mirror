From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 14:22:00 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911051418190.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <4AF21283.3080407@gmail.com> <4AF214D5.6050202@gmail.com>
 <alpine.LFD.2.00.0911041915120.10340@xanadu.home>
 <16cee31f0911050051m4cd29827nca9c8238b21461a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_W1GUnWm7AsP8uDeR+kzNJw)"
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N67uk-0003ey-JX
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 20:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758772AbZKETWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 14:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758774AbZKETWX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 14:22:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:57186 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758770AbZKETWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 14:22:22 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSN0087THSOUA80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Nov 2009 14:22:00 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <16cee31f0911050051m4cd29827nca9c8238b21461a0@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132236>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_W1GUnWm7AsP8uDeR+kzNJw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> 2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> > Careful.  At the beginning of the function you'll find:
> >
> >        if (delta_search_threads <= 1) {
> >                find_deltas(list, &list_size, window, depth, processed);
> >                return;
> >        }
> >
> > That is, if we have thread support compiled in but we're told to use
> > only one thread, then the bulk of the work splitting is bypassed
> > entirely.  Inside find_deltas() there will still be pthread_mutex_lock()
> > and pthread_mutex_unlock() calls even if no threads are spawned.
> 
> Ah, I wasn't aware of that. Actually why would find_deltas lock if no
> threads are used? Maybe, for non-threaded call to find_deltas, locking
> could be factored out?

It is already factored out when thread support is not enabled.

When thread support is enabled but there is only one thread, there was 
no point duplicating the code just to have a path without any mutexes, 
especially on Linux where no performance difference could be measured.


Nicolas

--Boundary_(ID_W1GUnWm7AsP8uDeR+kzNJw)--
