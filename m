From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Sat, 7 Jun 2008 16:19:35 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806071612460.1783@racer>
References: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl> <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl> <7v8wxirwi1.fsf@gitster.siamese.dyndns.org> <DB158BDE-70D1-4779-9B03-A85C60EB2FA7@ai.rug.nl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-67652928-1212851737=:1783"
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Jun 07 17:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K50Em-00019H-7c
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 17:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbYFGPUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 11:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756907AbYFGPUy
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 11:20:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:46574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752350AbYFGPUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 11:20:53 -0400
Received: (qmail invoked by alias); 07 Jun 2008 15:20:51 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp018) with SMTP; 07 Jun 2008 17:20:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180om4/jmk0ysED1k0mZCJf7jLCXMANScv4x0RxDF
	x44oavjjTIeOkx
X-X-Sender: gene099@racer
In-Reply-To: <DB158BDE-70D1-4779-9B03-A85C60EB2FA7@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.0806071619220.1783@racer>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84204>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-67652928-1212851737=:1783
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.0806071619221.1783@racer>

Hi,

On Sat, 7 Jun 2008, Pieter de Bie wrote:

> On 7 jun 2008, at 01:09, Junio C Hamano wrote:
> 
> >I am confused.
> >
> >The type of object_decoration.decorattion is a (void*).  Why isn't it
> >sufficient to do it in a naïve and straightforward way?
> >
> > mark = (uint32_t)(deco->decoration);
> >       add_decoration(&idnums, object, (void*) mark);
> >
> >Is this twisted pointer arithmetic done in order to avoid cast between 
> >int and pointer of different size in the code?

Yes, it was done in response to a remark that pointers might not be 
allowed to be unaligned.

> I'm not sure why this is done; I simply copied what the existing code 
> already did.

Okay, I looked again, and indeed, you _copied_ it.  Instead of using the 
functions mark_object() and get_object_mark() which are there only to be 
used by you.

So please fix.

> >Even if that is the case, doesn't "(uint32_t *)deco->decoration - 
> >(uint32_t *)NULL" mean the value range for deco->decoration is 
> >one-fourth of U32?

It is.  But since every object needs already at least 20 bytes, and we do 
not even have the complete address space to put objects into, and we do 
not plan to support 64-bit only repositories, I think we are fine.  At 
least for the moment.

Ciao,
Dscho
--8323329-67652928-1212851737=:1783--
