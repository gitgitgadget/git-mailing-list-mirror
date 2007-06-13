From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 19:34:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131931410.4059@racer.site>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
 <200706131854.59605.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0706131804080.4059@racer.site>
 <200706132017.31379.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:38:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyXjW-00023x-5u
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045AbXFMSiQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759015AbXFMSiQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:38:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:57647 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758657AbXFMSiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:38:15 -0400
Received: (qmail invoked by alias); 13 Jun 2007 18:38:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 13 Jun 2007 20:38:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rM14gztBre+S1a54gnDif6883A0DsFQY4c6cZ0I
	7R7FVtoKYmlJDc
X-X-Sender: gene099@racer.site
In-Reply-To: <200706132017.31379.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50112>

Hi,

On Wed, 13 Jun 2007, Josef Weidendorfer wrote:

> On Wednesday 13 June 2007, Johannes Schindelin wrote:
> > So, I should have realized earlier that "git-log -z" _without_ anything in 
> > the way of "-p", "--stat" or friends does not make sense at all.
> 
> But it does make sense: it separates commits using '\0'.

Indeed, I missed that. Of course, you could do something as simple as 
this, although it looks really hacky to me:

diff --git a/revision.c b/revision.c
index b12c25e..1f4590b 100644
--- a/revision.c
+++ b/revision.c
@@ -1180,7 +1180,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
-				revs->diff = 1;
+				if (strcmp(argv[i], "-z"))
+					revs->diff = 1;
 				i += opts - 1;
 				continue;
 			}

Ciao,
Dscho
