From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit PATCH] avoiding output in the error log
Date: Wed, 27 Aug 2008 13:33:43 -0700
Message-ID: <20080827203343.GN26523@spearce.org>
References: <218798.11648.bm@omp221.mail.ukl.yahoo.com> <200808272228.07060.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robert_no.spam_m@yahoo.fr, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRj7-00028P-3f
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbYH0Udo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbYH0Udo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:33:44 -0400
Received: from george.spearce.org ([209.20.77.23]:44519 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYH0Udo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:33:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8559638375; Wed, 27 Aug 2008 20:33:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808272228.07060.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93945>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > @@ -197,8 +199,10 @@ synchronized (resources) {
> >  	} // End ResCL
> >  
> >  	void clearDecorationState(IResource r) throws CoreException {
> > -		r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> > -		fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
> > +		if (r.exists()) {
> > +			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> > +			fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
> > +		}
> 
> Shawn, you removed the test from the code in 4a230ea1. Perhaps you could care to
> comment on this patch to restore the test, though slightly different.
> 
> 		if (r.isAccessible())
> 			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);

This may be a patch queue reordering bug.

If you look at 4a230ea1 I moved the isAccessible test higher up,
such that we shouldn't enter into clearDecorationState unless the
resource is accessible.  But there may currently be two code paths
that enter this method, and a patch I did not yet submit had removed
the other code path.

So in the short/medium term I agree with your patch, basically undo
the second hunk of 4a230ea1.  But keep the middle hunk, it was a
real bug I ran into.

-- 
Shawn.
