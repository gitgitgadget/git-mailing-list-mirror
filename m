From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 14:25:27 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911051422590.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
 <4AF20534.2030004@gmail.com> <alpine.LFD.2.00.0911042111270.10340@xanadu.home>
 <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_QH8xeF45SB6CziVjEFYvlw)"
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N67xd-0005Cr-QI
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 20:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758741AbZKETZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 14:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758713AbZKETZX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 14:25:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20175 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758506AbZKETZW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 14:25:22 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSN00CS9HYFN260@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Nov 2009 14:25:28 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <16cee31f0911050100v76316dacye7edd8718a893f01@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132237>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_QH8xeF45SB6CziVjEFYvlw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> 2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> > On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:
> >
> > What about:
> >
> > typedef struct {
> >        HANDLE handle;
> >        void *(*start_routine)(void *);
> >        void *arg;
> > } pthread_t;
> >
> > DWORD __stdcall windows_thread_start(LPVOID _self)
> > {
> >        pthread_t *self = _self;
> >        void *ret = self->start_routine(self->arg);
> >        return (DWORD)ret;
> > }
> >
> > static inline int pthread_create(pthread_t *thread, const void *unused,
> >                                 void *(*start_routine)(void *), void *arg)
> > {
> >        thread->handle = CreateThread(NULL, 0, windows_thread_start,
> >                                      thread, 0, NULL);
> >        [...]
> > }
> 
> The problem I see is not with pthread_init, but pthread_join. Here's
> how it looks:
> 
> int pthread_join(pthread_t thread, void **value_ptr);
> 
> If pthread_t would be a struct, then we can't call pthread_join like
> that...

Why not?  At least gcc is quite happy with such a construct.  It 
probably makes a copy of the stack before passing it though.

> At least that's what I though yesterday, but maybe it can be done like 
> this:
> 
> int win32_pthread_join(pthread_t *thread, void **value_ptr)
> {
>         [...]
> }
> 
> #define pthread_join(a, b) win32_pthread_join(&(a), (b))
> 
> That way we don't need allocations to simulate pthread init/join API

Right.


Nicolas

--Boundary_(ID_QH8xeF45SB6CziVjEFYvlw)--
