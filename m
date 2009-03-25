From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/5] Add option for using a foreign VCS
Date: Wed, 25 Mar 2009 12:20:05 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903251042280.19665@iabervon.org>
References: <alpine.LNX.1.00.0903242303330.19665@iabervon.org> <7v1vsm9jwd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:21:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVrS-00078D-Ls
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698AbZCYQUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 12:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbZCYQUJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:20:09 -0400
Received: from iabervon.org ([66.92.72.58]:41929 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597AbZCYQUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 12:20:08 -0400
Received: (qmail 23960 invoked by uid 1000); 25 Mar 2009 16:20:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 16:20:05 -0000
In-Reply-To: <7v1vsm9jwd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114616>

On Tue, 24 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This simply configures the remote to use a transport that doesn't have
> > any methods at all and is therefore unable to do anything yet.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  Documentation/config.txt |    4 ++++
> >  remote.c                 |    2 ++
> >  remote.h                 |    2 ++
> >  transport.c              |    3 ++-
> >  4 files changed, 10 insertions(+), 1 deletions(-)
> >
> > diff --git a/remote.h b/remote.h
> > index de3d21b..e77dc1b 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -11,6 +11,8 @@ struct remote {
> >  	const char *name;
> >  	int origin;
> >  
> > +	const char *foreign_vcs;
> > +
> >  	const char **url;
> >  	int url_nr;
> >  	int url_alloc;
> 
> What are these extra blank lines for?  Isn't it pretty much part of the
> URL group that immediately follows it?

I'd been thinking of it as being a higher-level switch than the URLs, but 
it could go together.

> > diff --git a/transport.c b/transport.c
> > index 26c578e..8a37db5 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -939,7 +939,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
> >  	ret->remote = remote;
> >  	ret->url = url;
> >  
> > -	if (!prefixcmp(url, "rsync:")) {
> > +	if (remote && remote->foreign_vcs) {
> > +	} else if (!prefixcmp(url, "rsync:")) {
> 
> 	if (...) {
>         	; /* empty */
> 	} else ...

I don't think I've ever tried writing an empty block for git before. It's 
braces containing a semicolon and comment? (Of course, the reason I wrote 
this one this way is so that the next patch could put two "+" lines in 
there and have no "-" lines)

	-Daniel
*This .sig left intentionally blank*
