From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 15:36:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911051527570.10340@xanadu.home>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
 <1257439548-9258-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911051434090.10340@xanadu.home>
 <16cee31f0911051209jcc490e2pabeab9a1b6e3b11d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_YOOPxTwgNT6RusKoLb6LVA)"
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:44:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N69Bv-00013Y-K0
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758514AbZKEUoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 15:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758428AbZKEUoM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:44:12 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65461 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbZKEUoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 15:44:12 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KSN00D64L9FPOC0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Nov 2009 15:36:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <16cee31f0911051209jcc490e2pabeab9a1b6e3b11d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132248>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_YOOPxTwgNT6RusKoLb6LVA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> 2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> > On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:
> >
> >> +static unsigned __stdcall win32_start_routine(void *arg)
> >> +{
> >> +     pthread_t *thread = arg;
> >> +     thread->value = thread->start_routine(thread->arg);
> >> +     return 0;
> >> +}
> >
> > I suppose you could reuse thread->arg for both the argument and the
> > returned value to save a word.
> 
> You're right! J6t committed already, what can I do now?

Just post a replacement patch.

> > Why are you casting thread->handle here?  Why not simply declaring it as
> > a HANDLE?
> 
> Just to silence MSVC warnings. WaitForSingleObject requires HANDLE,
> _beginthreadex() returns uintptr_t. It's just a matter of where would
> I put cast ;).

Wonderful.  One could wonder why Windows can't have coherent 
interfaces...

Well, given that all existing usages in the tree (run-command.c and 
compat/mingw.c) already cast the _beginthreadex() return value instead, 
then that might be a good idea to follow the same model.


Nicolas

--Boundary_(ID_YOOPxTwgNT6RusKoLb6LVA)--
