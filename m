From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 14:24:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802201418590.19024@iabervon.org>
References: <alpine.LNX.1.00.0802201337060.19024@iabervon.org> <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:25:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRuZL-00020s-DB
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbYBTTYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbYBTTYw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:24:52 -0500
Received: from iabervon.org ([66.92.72.58]:59013 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbYBTTYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:24:51 -0500
Received: (qmail 2208 invoked by uid 1000); 20 Feb 2008 19:24:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2008 19:24:50 -0000
In-Reply-To: <7vzltv4ey8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74537>

On Wed, 20 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This allows users with different preferences for access methods to the
> > same remote repositories to rewrite each other's URLs by pattern
> > matching across a large set of similiarly set up repositories to each
> > get the desired access.
> >
> > For example, if you don't have a kernel.org account, you might want
> > settings like:
> >
> > [url "git://git.kernel.org/pub/"]
> >       aka = master.kernel.org:/pub
> >
> > Then, if you give git a URL like:
> >
> >   master.kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> >
> > it will act like you gave it:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> >
> > and you can cut-and-paste pull requests in email without fixing them
> > by hand, for example.
> 
> To me, "url.$this_is_what_I_use.aka = $how_they_might_call_it"
> initially felt backwards, but the point of the facility is to
> allow mapping many ways other people might call it to how you
> would (and the other way would not make sense as allowing to map
> one thing to multiple is only to introduce unnecessary
> ambiguity), so it makes perfect sense.

This order of values is definitely the right thing, for the mapping 
reasons you saw. And I think "aka" is generally used to indicate 
additional non-canonical names for something with an official name (see, 
for example, IMDB's usage). I haven't been able to come up with anything 
better to indicate "this is a name that I will recognize but not use 
myself".

> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index f2f6a77..44f4c4b 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -646,6 +646,11 @@ help.format::
> >  	Values 'man', 'info', 'web' and 'html' are supported. 'man' is
> >  	the default. 'web' and 'html' are the same.
> >  
> > +host.<name>.rewritebase::
> > +	Additional base URLs which refer to this host. If a URL
> > +	matches this, any access to it will use the URL formed with
> > +	the corresponding base URL instead of the given URL.
> > +
> 
> This still stands???

Oops, didn't quite remove all of it.

> > diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> > index 81ac17f..0115af7 100644
> > --- a/Documentation/urls.txt
> > +++ b/Documentation/urls.txt
> > @@ -44,3 +44,26 @@ endif::git-clone[]
> > ...
> > +If you have a section:
> > +
> > +------------
> > +	[host "git://git.host.xz/"]
> > +		aka = host.xz:/path/to/
> > +		aka = work:
> > +------------
> > +
> > +a URL like "work:repo.git" or like "host.xz:/path/to/repo.git" will be
> > +rewritten in any context that takes a URL to be
> > +"git://git.host.xz/repo.git".
> 
> This still stands???

And missed the "host"->"url" bit while I fixed the rest of the example. 
Want a replacement, or can you make the obvious corrections just as 
easily yourself?

	-Daniel
*This .sig left intentionally blank*
