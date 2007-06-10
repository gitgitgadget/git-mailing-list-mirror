From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 19:56:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706101952180.4059@racer.site>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
 <200706101514.14954.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxSdi-0007PB-Lq
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 20:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbXFJS7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536AbXFJS7t
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 14:59:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:53772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754790AbXFJS7s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 14:59:48 -0400
Received: (qmail invoked by alias); 10 Jun 2007 18:59:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 10 Jun 2007 20:59:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dF0xMnkYdq859hvetbKW3eTIUJ9FvKz1HB5nKtt
	bbPq5skuNZT6Gh
X-X-Sender: gene099@racer.site
In-Reply-To: <200706101514.14954.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49756>

Hi,

On Sun, 10 Jun 2007, Johan Herland wrote:

> On Saturday 09 June 2007, Johannes Schindelin wrote:
>
> > With the provided script, edit-commit-annotations, you can add 
> > after-the-fact annotations to commits, which will be shown by the log 
> > if the config variable core.showannotations is set.
> > 
> > The annotations are tracked in a new ref, refs/annotations/commits, in 
> > the same fan-out style as .git/objects/??/*, only that they only exist 
> > in the object database now.
> 
> Very interesting. I have to say that after having played around with
> it a couple of minutes, I really like it. Needs some polishing here
> and there (i.e. cleaning up the COMMIT_ANNOTATION.NNNN* files), but
> it is a very good proof-of-concept.

Thanks. I composed it in a hurry, since I wanted it to go out before I 
took my flight home.

> > 	I have the hunch that this will be relatively fast and scalable,
> > 	since the tree objects are sorted by name (the name being the
> > 	object name of the to-be-annotated commit).
> 
> I think I agree with your hunch, although I initially thought that your
> solution was a bit heavy on the number of objects created. But, hey, git
> is _designed_ to handle massive amounts of objects. :)

Besides, these tree objects should delta really well, being almost as 
efficient as having only one tree object to begin with.

> > diff --git a/config.c b/config.c
> > index 58d3ed5..34db9b2 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -356,6 +356,11 @@ int git_default_config(const char *var, const char *value)
> >  		return 0;
> >  	}
> >  
> > +	if (!strcmp(var, "core.showannotaions")) {
> > +		show_commit_annotations = git_config_bool(var, value);
> > +		return 0;
> > +	}
> > +
> 
> Small typo here. "core.showannotaions" should be "core.showannotations",
> I guess.

Yep. I tested it with "core.shownotes", but decided before sending the 
patch that the name would be inconsistent with the rest of the code.

However, as I suggested later, I could imagine that an even better way 
could be to have "core.annotationsRef", overrideable by 
GIT_ANNOTATIONS_REF, which could possibly even be a list of refs.

BTW I am not married to calling it "annotations". If you like "notes" 
better, I'm fine with it.

Ciao,
Dscho
