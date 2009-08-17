From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] quick question about __stdcall at run-command.c
 mingw.c
Date: Mon, 17 Aug 2009 10:21:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171018490.4991@intel-tinevez-2-302>
References: <1976ea660908161619x5182762sade051f24fef13db@mail.gmail.com> <a5b261830908161703l2296448l698d07d01ae8a6d3@mail.gmail.com> <4A890C32.6010507@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@googlemail.com>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McxTW-00076n-8Y
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 10:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375AbZHQIVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 04:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757278AbZHQIVo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 04:21:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:33690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757223AbZHQIVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 04:21:43 -0400
Received: (qmail invoked by alias); 17 Aug 2009 08:21:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 17 Aug 2009 10:21:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ueogvIosu1lbzCrDYISnqePE76KqLZUdRHx3qR9
	bJkIFIJGo5rF1t
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A890C32.6010507@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126140>

Hi,

On Mon, 17 Aug 2009, Johannes Sixt wrote:

> Pat Thoyts schrieb:
> > 2009/8/17 Frank Li <lznuaa@gmail.com>:
> >> I am tring to clear VC build patch.
> >>
> >> I found __stdcall position break MSVC build.
> >>
> >> static __stdcall unsigned run_thread(void *data)
> >>
> >> MSVC require __stdcall should be between return type and function 
> >> name. like static unsigned __stdcall run_thread(void *data)
> >>
> >> I think msys gcc should support MSVC format.

I think that it does.

But it is _your_ duty to check.

> >> Should I directly change to MSVC format or add _MSC_VER marcro like
> >>
> >> #if defined(__MINGW32__)
> >> static __stdcall unsigned run_thread(void *data)
> >> #elif defined(_MSC_VER) /*MSVC must put __stdcall between return value
> >> and function*/
> >> static unsigned __stdcall run_thread(void *data)
> >> #endif

Noooo! NO _MSC_VER crap in mingw.c.  Really.  I am able to repeat that as 
often as you want me, but I'd prefer not to.

> > The win32 api prototype used for thread entry functions is declared as
> > a DWORD (WINAPI *LPTHREAD_START_ROUTINE)(LPVOID) type in the mingw
> > headers and WINAPI as #define WINAPI __stdcall. This is true for the
> > MSVC headers as well. So gcc and msvc are happy using the same
> > definition for such a function and just "static unsigned long WINAPI
> > run_thread(void *)" might well be sensible.
> 
> Change the code to
> 
> 	static unsigned __stdcall run_thread(void *data)
> 
> The documentation explictly says: "The routine at start_address passed to
> _beginthreadex must use the __stdcall calling convention...". So __stdcall
> it is.

I could not agree more.

Ciao,
Dscho
