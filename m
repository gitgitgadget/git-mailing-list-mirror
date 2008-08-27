From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [egit PATCH] avoiding output in the error log
Date: Wed, 27 Aug 2008 23:50:56 +0200
Message-ID: <200808272350.56819.robin.rosenberg.lists@dewire.com>
References: <218798.11648.bm@omp221.mail.ukl.yahoo.com> <200808272228.07060.robin.rosenberg.lists@dewire.com> <20080827203343.GN26523@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: robert_no.spam_m@yahoo.fr, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 23:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYT1o-0003f6-Cm
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 23:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYH0V5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 17:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbYH0V5H
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 17:57:07 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:45695 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYH0V5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 17:57:07 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id D3CD43A5ED; Wed, 27 Aug 2008 23:56:34 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id B63FA3A65F; Wed, 27 Aug 2008 23:52:59 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 97C1837E45;
	Wed, 27 Aug 2008 23:52:59 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080827203343.GN26523@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93962>

onsdagen den 27 augusti 2008 22.33.43 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > @@ -197,8 +199,10 @@ synchronized (resources) {
> > >  	} // End ResCL
> > >  
> > >  	void clearDecorationState(IResource r) throws CoreException {
> > > -		r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> > > -		fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
> > > +		if (r.exists()) {
> > > +			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> > > +			fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
> > > +		}
> > 
> > Shawn, you removed the test from the code in 4a230ea1. Perhaps you could care to
> > comment on this patch to restore the test, though slightly different.
> > 
> > 		if (r.isAccessible())
> > 			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> 
> This may be a patch queue reordering bug.
> 
> If you look at 4a230ea1 I moved the isAccessible test higher up,
> such that we shouldn't enter into clearDecorationState unless the
> resource is accessible.  But there may currently be two code paths
> that enter this method, and a patch I did not yet submit had removed
> the other code path.

Good. So then the question is whether we should use isAccessible() or exists()? Normally
this makes no difference, but for a Project (at least) there is a difference. I project that exits
is not accessible when closed. 

-- robin
