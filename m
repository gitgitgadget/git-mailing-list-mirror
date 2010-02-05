From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] fix an error message in git-push so it goes to stderr
Date: Fri, 5 Feb 2010 14:39:50 -0500
Message-ID: <20100205193950.GA18108@cthulhu>
References: <20100205004140.GA2841@cthulhu>
 <20100205150638.GB14116@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:39:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdU20-0007dG-UZ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 20:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670Ab0BETjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 14:39:51 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:37443 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0BETjv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 14:39:51 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 7146D82217D; Fri,  5 Feb 2010 14:39:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100205150638.GB14116@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139069>

* Jeff King (peff@peff.net) [100205 10:06]:
> On Thu, Feb 04, 2010 at 07:41:40PM -0500, Larry D'Anna wrote:
> 
> > Having it go to standard output interferes with git-push --porcelain.
> > ---
> >  builtin-push.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/builtin-push.c b/builtin-push.c
> > index 5633f0a..0a27072 100644
> > --- a/builtin-push.c
> > +++ b/builtin-push.c
> > @@ -124,9 +124,9 @@ static int push_with_options(struct transport *transport, int flags)
> >  		return 0;
> >  
> >  	if (nonfastforward && advice_push_nonfastforward) {
> > -		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
> > -		       "Merge the remote changes before pushing again.  See the 'Note about\n"
> > -		       "fast-forwards' section of 'git push --help' for details.\n");
> > +		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
> > +				"Merge the remote changes before pushing again.  See the 'Note about\n"
> > +				"fast-forwards' section of 'git push --help' for details.\n");
> 
> I agree that stderr is a more sensible place for such a message to go,
> but shouldn't the porcelain output format just suppress it entirely? 

I think you're right.  There are some other messages that are similar that
should probably also be suppressed.

Also it seems to me that git push --dry-run --porcelain should exit successfully
even if it knows some refs will be rejected.  The calling script can see just
fine for itself that they will be rejected, and it probably still wants to know
whether or not the dry-run succeeded, which has nothing to do with whether or
not the same push would succeed as a not-dry-run.  

    --larry
