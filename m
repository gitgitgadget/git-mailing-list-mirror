From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 21:41:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002162140110.1946@xanadu.home>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002160914140.20986@pacific.mpi-cbg.de>
 <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002170200370.20986@pacific.mpi-cbg.de>
 <7vvddwodox.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 03:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhZqz-0000x2-2E
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 03:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933716Ab0BQClY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 21:41:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53394 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933523Ab0BQClX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 21:41:23 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXY003OGSSWM900@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Feb 2010 21:41:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vvddwodox.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140200>

On Tue, 16 Feb 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The program can decide at runtime not to use threading even if the support
> >> is compiled in.  In such a case, mutexes are not necessary and left
> >> uninitialized.  But the code incorrectly tried to take and release the
> >> read_sha1_mutex unconditionally.
> >> 
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >> Acked-by: Fredrik Kuivinen <frekui@gmail.com>
> >> ---
> >
> > Yes, this one looks much, much nicer.
> 
> The structure may be much nicer, but one remaining thing is that I do not
> think foo_locked() is a good name; IIRC, kernel folks use _locked() suffix
> when the caller is expected to already hold the lock.  So a typical naming
> convention goes like this:
> 
> 	foo()
>         {
>         	lock();
>                 foo_locked();
>                 unlock();
>         }
> 
> but what the patch did was the other way around:
> 
> 	read_sha1_file_locked()
>         {
>         	lock();
>                 read_sha1_file();
>                 unlock();
> 	}
> 
> which is probably against the convention many readers of our codebase are
> already familiar with.
> 
> We need a better name to unconfuse people, I think.

lock_and_read_sha1_file()


Nicolas
