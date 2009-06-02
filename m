From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC
 4.4.0
Date: Tue, 2 Jun 2009 14:52:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-2-git-send-email-prohaska@zib.de> <1243786525-4493-3-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de>
 <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> <7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 14:53:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBTUC-00068f-HQ
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 14:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbZFBMwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 08:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZFBMwt
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 08:52:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:54209 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751183AbZFBMwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 08:52:49 -0400
Received: (qmail invoked by alias); 02 Jun 2009 12:52:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp009) with SMTP; 02 Jun 2009 14:52:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XZWp0tHXXxVeZDqgxVdOZFgWSITJogG/g1WwkcI
	ZRUtGA9mz5eagS
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120506>

Hi,

On Mon, 1 Jun 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
> >> > index a381a7d..60a4093 100644
> >> > --- a/compat/nedmalloc/nedmalloc.c
> >> > +++ b/compat/nedmalloc/nedmalloc.c
> >> > @@ -34,7 +34,7 @@ DEALINGS IN THE SOFTWARE.
> >> >  /*#define FULLSANITYCHECKS*/
> >> >  
> >> >  #include "nedmalloc.h"
> >> > -#if defined(WIN32) && !defined(__MINGW32__)
> >> > +#if defined(WIN32)
> >> >   #include <malloc.h>
> >> >  #endif
> >> 
> >> Can somebody enlighten me what this hunk is about, and how it helps GCC
> >> 4.4?
> >
> > It helps in that malloc.h is included even if we happen to compile the 
> > stuff as a MinGW program.  Otherwise necessary function declarations are 
> > missing.
> > ...
> > Hopefully less so, now.
> 
> I wish enough information were in the commit log message from the
> beginning.

Okay, how about this in the commit body in addition?

-- snip --
Nedmalloc's source code has a cute #define construct to avoid inserting
an if() statement, because that might interact badly with enclosing if()
statements.  However, there is no danger of that now, but GCC > 4
complains "warning: value computed is not used".

Also, with the version of MinGW's headers in msysGit, we need to include 
malloc.h lest the compiler complain about an "incompatible implicit 
declaration of built-in function 'alloca'".
-- snap --

Hmm?
Dscho
