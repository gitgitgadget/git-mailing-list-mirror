From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 17:50:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131748400.4059@racer.site>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
 <e5bfff550706130708k601514c9o1ba2747582027699@mail.gmail.com>
 <Pine.LNX.4.64.0706131553390.4059@racer.site> <200706131827.08163.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyW6r-0001js-Ip
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757750AbXFMQx1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758040AbXFMQx0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:53:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:51962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757664AbXFMQxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 12:53:25 -0400
Received: (qmail invoked by alias); 13 Jun 2007 16:53:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 13 Jun 2007 18:53:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+C4osVSfaC6r8XGnEeez4VuR6MovSyrK/nzSi3Ve
	Ftwq+9Mh9Ofa+b
X-X-Sender: gene099@racer.site
In-Reply-To: <200706131827.08163.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50096>

Hi,

On Wed, 13 Jun 2007, Josef Weidendorfer wrote:

> On Wednesday 13 June 2007, Johannes Schindelin wrote:
> > ~1.4s	log _with_ --pretty=raw
> > ~3.5s	log _with_ --pretty=raw _and_ -z (!)
> 
> That happens on linux, too.
> 
> I am not really familiar with that code, but comparision
> of the call graphs of "git log" vs. "git log -z", as
> produced by callgrind (shameless plug) and visualized
> by kcachegrind (again, another shameless plug) shows
> that the difference happens in log_tree_diff, called
> >from log_tree_commit.

That's a cool trick!

And indeed it is:

This code in revision.c is responsible:

1181                            opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
1182                            if (opts > 0) {
1183                                    revs->diff = 1;
1184                                    i += opts - 1;
1185                                    continue;
1186                            }

Now, to tell which diff options actually need revs->diff to be set to 1, 
that is the question.

Ciao,
Dscho
