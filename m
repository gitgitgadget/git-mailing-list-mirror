From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote
 HEADs
Date: Sat, 14 Feb 2009 15:21:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902141503230.19665@iabervon.org>
References: <20090214034345.GB24545@coredump.intra.peff.net> <1234607430-5403-1-git-send-email-jaysoffian@gmail.com> <20090214175420.GA3457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:23:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYR2S-0003kU-88
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbZBNUVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbZBNUVc
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:21:32 -0500
Received: from iabervon.org ([66.92.72.58]:37142 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbZBNUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:21:32 -0500
Received: (qmail 27987 invoked by uid 1000); 14 Feb 2009 20:21:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Feb 2009 20:21:30 -0000
In-Reply-To: <20090214175420.GA3457@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109916>

On Sat, 14 Feb 2009, Jeff King wrote:

> On Sat, Feb 14, 2009 at 05:30:30AM -0500, Jay Soffian wrote:
> 
> > +		else if (states.heads.nr == 1)
> > +			printf("  HEAD branch: %s\n",
> > +				states.heads.items[0].string);
> > +		else
> > +			show_list("  HEAD branch%s:", &states.heads, "");
> 
> I was happy to see the common case of "we unambiguously determined HEAD"
> falls back to nicer output (though I admit I did a double-take seeing
> both show_list and the states.heads.nr check, I see it is because
> show_list always insists on a newline).
> 
> That should help current users with simple setups, but also support
> unambiguous HEAD reporting in the future (and based on what Daniel said
> earlier, http should just need a client patch to pass the information
> up the callstack).

I haven't checked lately, but I think that what's actually needed is to 
have the locate_head() function notice if the struct ref for HEAD actually 
has the symref field non-NULL, and report that as the unambiguous answer. 
This should also allow it to automatically pick up any other 
disambiguation by future sources of lists of refs that include HEAD, 
whether that's git protocol extensions, filesystem access to the repo, or 
foreign VCSes where some branches is inherently primary, or whatever.

(The direct purpose of collecting the information for http was so that it 
could figure out the sha1 at all for the remote HEAD when it's a symref; 
the code just doesn't then explicitly throw the information away.)

	-Daniel
*This .sig left intentionally blank*
