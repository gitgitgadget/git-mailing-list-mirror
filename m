From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/10] rev-list: call new "filter_skip" function
Date: Wed, 1 Apr 2009 16:36:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904011631300.13502@intel-tinevez-2-302>
References: <20090326055549.e1f244d9.chriscool@tuxfamily.org> <200903310845.23674.chriscool@tuxfamily.org> <alpine.DEB.1.00.0903311117400.10279@pacific.mpi-cbg.de> <200904010809.41110.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-350035510-1238596604=:13502"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 16:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp1a9-0007tx-MS
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 16:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918AbZDAOgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 10:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756347AbZDAOgt
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 10:36:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:57246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016AbZDAOgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 10:36:48 -0400
Received: (qmail invoked by alias); 01 Apr 2009 14:36:45 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp051) with SMTP; 01 Apr 2009 16:36:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hKxEYwJ0hM2WB6jq3kooQtMpkLncywQT6l1+Ydz
	ao3ErsSHS2XkDv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200904010809.41110.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115391>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-350035510-1238596604=:13502
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 1 Apr 2009, Christian Couder wrote:

> Le mardi 31 mars 2009, Johannes Schindelin a écrit :
> > Hi,
> >
> > On Tue, 31 Mar 2009, Christian Couder wrote:
> > > Le lundi 30 mars 2009, Johannes Schindelin a écrit :
> > > > On Mon, 30 Mar 2009, Christian Couder wrote:
> > > > > Le jeudi 26 mars 2009, Junio C Hamano a écrit :
> > > > > > I've learned to suspect without reading a qsort() callback that
> > > > > > does not derefence its arguments.  Is this doing the right thing?
> > > > >
> > > > > I think so.
> > > >
> > > > I suspect something much worse: you are trying to build a list of
> > > > sha1s of commits that need to be skipped, later to look up every
> > > > commit via binary search.
> > > >
> > > > But it has been proven a lot of times that using a hash set is
> > > > superior to that approach, and even better: we already have the
> > > > framework in place in the form of struct decorate.
> > >
> > > I had a look, and "struct decorate" can be used to store objects, but I
> > > want to store only sha1s.
> >
> > No, you want to _look up_ sha1s.  And struct decorate is not about
> > storing objects, but to attach things to objects. 
> 
> The problem is that I don't have any object to attach things to when I 
> read the bisect skip refs. I just need to store the sha1 from the skip 
> refs in some sha1 container.

I see, so you do not want to parse the commits just to register them as 
skipped.

Fair enough.

But I still think that a hashmap/set would be better suited.

In any case, it should be refactored into something usable in all of 
libgit.a.  You are basically duplicating the grafts code in commit.c, 
sharing that shortcoming that your code would be static again, not 
encouraging reusage.

Ciao,
Dscho
--8323329-350035510-1238596604=:13502--
