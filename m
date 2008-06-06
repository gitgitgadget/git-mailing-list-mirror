From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/10] Introduce get_octopus_merge_bases() in commit.c
Date: Fri, 6 Jun 2008 13:36:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061331560.1783@racer>
References: <cover.1212698317.git.vmiklos@frugalware.org> <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org>
 <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org>
 <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org>
 <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org> <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org> <7vmylzw1l4.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806061316350.1783@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 14:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4bDF-0004j9-6Y
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 14:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbYFFMhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 08:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbYFFMhk
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 08:37:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:37690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750884AbYFFMhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 08:37:40 -0400
Received: (qmail invoked by alias); 06 Jun 2008 12:37:37 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 06 Jun 2008 14:37:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+/9BsZEV+O1lXRp1mCtEJdxV6yGeFdVPtiwlRN7
	QdqLHg6U1I1yYY
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806061316350.1783@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84060>

Hi,

On Fri, 6 Jun 2008, Johannes Schindelin wrote:

> >  	one->object.flags |= PARENT1;
> > -	two->object.flags |= PARENT2;
> >  	insert_by_date(one, &list);
> > -	insert_by_date(two, &list);
> > +	for (i = 0; i < n; i++) {
> > +		twos[i]->object.flags |= PARENT2;
> > +		insert_by_date(twos[i], &list);
> > +	}
> 
> Ah, now that is clever: I thought we would get into a lot of problems 
> because we would need a bit for every initial commit.  But what you are 
> basically doing is reusing PARENT2 for all the merge bases that have 
> been found for the heads up to, but not including, the current one.

I spoke too soon.  This is not going to work easily: after doing this for 
two heads, the PARENT1 flag must be reset to PARENT2 before traversing for 
a third head.

Or am I missing something obvious?

Ciao,
Dscho
