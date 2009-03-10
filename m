From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] winansi: support ESC [ K (erase in line)
Date: Tue, 10 Mar 2009 13:54:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101352240.14295@intel-tinevez-2-302>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de>  <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <eaa105840903100529lc29664hd6e6fde29e06844a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-444786719-1236689674=:14295"
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 13:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh1VD-0004fA-Jo
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 13:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbZCJMyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 08:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754779AbZCJMyi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 08:54:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:43758 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754181AbZCJMyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 08:54:37 -0400
Received: (qmail invoked by alias); 10 Mar 2009 12:54:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 10 Mar 2009 13:54:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VSR4J8YWVEakSceHFZRTBQtm9mCQg+HgSF2wy4V
	vLK0ml+F3fkUQb
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <eaa105840903100529lc29664hd6e6fde29e06844a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112812>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-444786719-1236689674=:14295
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 10 Mar 2009, Peter Harris wrote:

> On Mon, Mar 9, 2009 at 8:41 PM, Johannes Schindelin wrote:
> 
> > +int winansi_write(int fd, const void *buf, size_t len)
> > +{
> > +       if (isatty(fd)) {
> > +               init();
> > +               if (console)
> > +                       return ansi_emulate((const char *)buf, len,
> > +                                       fd == 2 ? stderr : stdout);
> > +       }
> > +       return write(fd, buf, len);
> > +}
> 
> Switching an unbuffered write to a buffered fwrite makes me a little 
> nervous. In practice, all writes probably go through this function, so 
> it doesn't matter. And if the write is going somewhere it matters, it 
> likely fails isatty anyway. But I would still be less nervous with an 
> fflush() after ansi_emulate.

That would make the code substantially more messy, though.

Besides, half of it is already there: when encountering an ANSI sequence, 
your code already fflush()es the fd before setting the new attributes.  
And stderr does not need the fflush() anyway.

Ciao,
Dscho

--8323329-444786719-1236689674=:14295--
