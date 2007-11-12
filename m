From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix rev-list when showing objects involving submodules
Date: Mon, 12 Nov 2007 20:21:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711122020270.4362@racer.site>
References: <Pine.LNX.4.64.0711112335020.4362@racer.site> <4738AF60.90207@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irfmr-0004Zi-96
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbXKLUVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbXKLUVV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:21:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:36668 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751306AbXKLUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:21:20 -0500
Received: (qmail invoked by alias); 12 Nov 2007 20:21:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 12 Nov 2007 21:21:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19auZYXNS9aZdnqTQ1S+TtRiQ1+cjYi2b5TKGy2A1
	Xpghz+t7oJ6OOS
X-X-Sender: gene099@racer.site
In-Reply-To: <4738AF60.90207@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64698>

Hi,

On Tue, 13 Nov 2007, Sam Vilain wrote:

> Johannes Schindelin wrote:
> > The function mark_tree_uninteresting() assumed that the tree entries
> > are blob when they are not trees.  This is not so.  Since we do
> > not traverse into submodules (yet), the gitlinks should be ignored.
> >
> > diff --git a/revision.c b/revision.c
> > index 931f978..81b5a93 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -69,7 +69,7 @@ void mark_tree_uninteresting(struct tree *tree)
> >  	while (tree_entry(&desc, &entry)) {
> >  		if (S_ISDIR(entry.mode))
> >  			mark_tree_uninteresting(lookup_tree(entry.sha1));
> > -		else
> > +		else if (!S_ISGITLINK(entry.mode))
> >  			mark_blob_uninteresting(lookup_blob(entry.sha1));
> >  	}
> >  
> >   
> 
> Wouldn't it be better to check for what it is, rather than what it is not?

You mean something like

		else if (S_ISREG(entry.mod) || S_ISLNK(entry.mod))

Hmm?  Sure, I have no preference there.

Ciao,
Dscho
