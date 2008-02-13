From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Wed, 13 Feb 2008 11:22:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131116370.30505@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802130003370.3870@racer.site> <alpine.LSU.1.00.0802130108060.3870@racer.site>
 <alpine.LFD.1.00.0802121758220.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Voltage Spike <voltspike@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 12:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFhJ-0006xg-RF
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 12:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbYBMLWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 06:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbYBMLWF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 06:22:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:44593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755172AbYBMLWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 06:22:03 -0500
Received: (qmail invoked by alias); 13 Feb 2008 11:21:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 13 Feb 2008 12:21:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/KwIR1w+fKnBWD7LMGDExN3VyC2WyIpFixZUEf64
	S9SLCrDIS5/i6E
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802121758220.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73774>

Hi,

On Tue, 12 Feb 2008, Linus Torvalds wrote:

> On Wed, 13 Feb 2008, Johannes Schindelin wrote:
> > 
> > With XDL_MERGE_ZEALOUS_ALNUM, we use the following heuristics: when a 
> > hunk does not contain any letters or digits, it is treated as 
> > conflicting.
> 
> [...]
> 
> So the "merge adjacent conflicts" logic should actually be pretty 
> simple: if there is less than three lines between two conflicts, the 
> conflicts should always be merged, because the end result is smaller.
> 
> (And with three lines in between the end result is as many lines, but 
> arguably simpler, so it's probably better to merge then too).
> 
> Hmm? What do you think?

Makes sense.  As I said to Junio, I'll think about an interface to do 
this.  The obvious choice is to have a struct, but that has to be memset() 
to 0 for future compatibility.

OTOH there's xpparam_t already, and we could just have that as a member of 
the new struct, something like

typedef struct s_xmergeparam {
	xpparam_t xpp;
	enum {
		XDL_MERGE_MINIMAL = 0,
		XDL_MERGE_EAGER,
		XDL_MERGE_ZEALOUS,
		XDL_MERGE_ZEALOUS_ALNUM
	} mode;
	/* minimum number of inter-conflict lines goes here */
} xmergeparam_t;

Hmm.  This has to simmer in my head a bit.

Ciao,
Dscho
