From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Thu, 23 Apr 2009 21:33:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904232132380.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <200904232116.10769.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4hf-0006xn-DS
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbZDWTdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 15:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbZDWTdt
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:33:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:57193 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751841AbZDWTds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 15:33:48 -0400
Received: (qmail invoked by alias); 23 Apr 2009 19:33:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 23 Apr 2009 21:33:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ygpg+wdZYwt2PiOJiqc6NLUBqwhK1V09D7qoaSn
	YtmqtOS3PYNMuy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200904232116.10769.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117372>

Hi,

On Thu, 23 Apr 2009, Johannes Sixt wrote:

> On Donnerstag, 23. April 2009, Johannes Schindelin wrote:
> > It seems that accessing NTFS partitions with ufsd (at least on my EeePC)
> > has an unnerving bug: if you link() a file and unlink() it right away,
> > the target of the link() will have the correct size, but consist of NULs.
> >
> > It seems as if the calls are simply not serialized correctly, as
> > single-stepping through the function move_temp_to_file() works flawlessly.
> >
> > As ufsd is "Commertial software", I cannot fix it, and have to work
> 
> "commercial software"

I just quoted the license string of that wonderfully high-quality kernel 
module.

Maybe I should have added the beloved "[sic!]".

> > At the same time, it seems that this fixes msysGit issues 222 and 229 to
> > assume that Windows cannot handle link() && unlink().
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ...
> > @@ -2225,7 +2225,9 @@ int move_temp_to_file(const char *tmpfile, const char
> > *filename) {
> >  	int ret = 0;
> >
> > -	if (link(tmpfile, filename))
> > +	if (unreliable_hardlinks)
> > +		ret = ~EEXIST;
> 
> It took me a while to see why we need a tilde here, but it's ok. Perhaps this 
> helps others:
> 
> +		ret = ~EEXIST;	/* anything but EEXIST */

Will do.

> Nevertheless:
> 
> Acked-by: Johannes Sixt <j6t@kdbg.org>

Thanks.

But it will have to wait for Saturday.

Ciao,
Dscho
