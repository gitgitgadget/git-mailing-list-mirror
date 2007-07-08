From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sun, 8 Jul 2007 03:18:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080311280.4093@racer.site>
References: <20070405071615.2915.6837.reportbug@acer>
 <20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
 <6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
 <20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131354250.4059@racer.site>
 <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0706131543140.4059@racer.site>
 <20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
 <Pine.LNX.4.64.0707080148370.4093@racer.site> <7vabu765r0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707080248320.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 04:25:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7MSy-0002MR-6B
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 04:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910AbXGHCZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 22:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbXGHCZh
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 22:25:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:38712 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754813AbXGHCZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 22:25:36 -0400
Received: (qmail invoked by alias); 08 Jul 2007 02:25:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 08 Jul 2007 04:25:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XZNc0yghXsKFTpTbMNaj2z8HrC/7dqmuN6Fi0ke
	TUKgwy6fF2FKsr
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707080248320.4093@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51858>

Hi,

On Sun, 8 Jul 2007, Johannes Schindelin wrote:

> On Sat, 7 Jul 2007, Junio C Hamano wrote:
> 
> > IOW, don't make unpack-trees to make policy decisions on final 
> > resolution, unless it is operating under aggressive rule (where the 
> > caller explicitly allows it to make more than the "trivial" 
> > decisions).  The caller (in this case, merge-recursive) should see A 
> > at stage #2 with A/B at stages #1 and #3 and decide what to do.
> 
> Okay, so you're saying that merge-recursive should use the aggressive 
> strategy?

To refine on that: from my (limited, I admit) understanding of the code, 
by the time it hits that "if (o->aggressive)", in case of a df conflict, 
the chance has long whizzed by to decide anything useful, since either 
head or remote were set to NULL. So they are no longer what they would 
have to be in order to make any sense.

Well, I try to cobble up a patch for merge-recursive like you suggested, 
and stay away from threeway_merge() as far as I can, for the rest of my 
life.

However, it feels somehow wrong that I have to check all the files in the 
unmerged index, when unpack_trees could have easily seen that the tree did 
not change between all (in that case, just one) ancestors and the remote, 
but that head has changed that path to a file, and head agrees with index 
on that, and remote can stay where it is with its darned directory.

Ciao,
Dscho
