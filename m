From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3 v3] Use an external program to implement fetching
 with  curl
Date: Wed, 5 Aug 2009 22:10:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052156360.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907310112400.2147@iabervon.org>  <alpine.DEB.1.00.0908051203550.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051135080.2147@iabervon.org> <fabb9a1e0908051115u145b2b0bi2973bcf41d5ef68f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmo3-0003s3-PJ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZHEUJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbZHEUJq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:09:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:37734 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752446AbZHEUJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:09:45 -0400
Received: (qmail invoked by alias); 05 Aug 2009 20:09:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 05 Aug 2009 22:09:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EJCpEPB1EJLBybTf80P9mP8De/t8EiIRQKsbp6Y
	uJ+LAFg6tM4Li5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0908051115u145b2b0bi2973bcf41d5ef68f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124961>

Hi,

On Wed, 5 Aug 2009, Sverre Rabbelier wrote:

> On Wed, Aug 5, 2009 at 08:45, Daniel Barkalow<barkalow@iabervon.org> 
> wrote:
> > Someday, I want to have a diff output format that makes these things 
> > clear somehow. I think it would be not-too-hard to get the diff code 
> > to determine that an addition matches or almost matches a deletion (or 
> > some unchanged code), and provide library access to this information, 
> > but representing it to humans (and getting patch to still work) is 
> > hard.
> 
> I started on this a while ago (as part of some post-GSoC git-stats 
> work), but I had a hard time finding a good rule to determine whether an 
> added hunk is similar enough to a deleted hunk elsewhere. Perhaps a 
> variant of Levenshtein can be used to determine how different two hunks 
> are; I tried diffing the two hunks and then looking at the ration 
> between the size of the diff and the size of the original hunk, but as 
> said that didn't really work out.

I think that there are two complications:

- how to present it in a format that helps the human to understand, yet is 
  well-defined enough to be used as a machine-readable edit script (I 
  really do not think that it can be well-designed if it only fulfills one 
  of the two purposes).  I could imagine something like this:

	diff --git a/remote-curl.c b/remote-curl.c
	partial copy from transport.c +394,130
		#ifndef NO_CURL
		static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
		{
		[...]
		}

		#endif
	@@ -1,4 +1,6
	+#include "cache.h"
	+#include "transport.h"
	+#include "refs.h"
	+
	 #ifndef NO_CURL
	 static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)

- how to determine efficiently where to spend a lot of time to determine 
  what could be similar enough.

For example, the diff would still look pretty unreadable if you determined 
that there was a code move which involved a reindentation, so I am not at 
all sure if it is worth to try hard to detect that that was a move after 
all.

Ciao,
Dscho
