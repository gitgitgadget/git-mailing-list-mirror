From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Thu, 19 Jun 2008 12:12:19 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806191146210.19665@iabervon.org>
References: <alpine.LNX.1.00.0806182327090.19665@iabervon.org> <alpine.DEB.1.00.0806191510060.6439@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 19 18:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9MlC-0000WP-2K
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbYFSQMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 12:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755759AbYFSQMV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 12:12:21 -0400
Received: from iabervon.org ([66.92.72.58]:36706 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945AbYFSQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 12:12:20 -0400
Received: (qmail 28308 invoked by uid 1000); 19 Jun 2008 16:12:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 16:12:19 -0000
In-Reply-To: <alpine.DEB.1.00.0806191510060.6439@racer>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85487>

On Thu, 19 Jun 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 18 Jun 2008, Daniel Barkalow wrote:
> 
> > diff --git a/setup.c b/setup.c
> > index d630e37..1643ee4 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -292,7 +292,8 @@ void setup_work_tree(void)
> >  	work_tree = get_git_work_tree();
> >  	git_dir = get_git_dir();
> >  	if (!is_absolute_path(git_dir))
> 
> I suspect it needs "work_tree &&" here.

I'm not clear on the semantics of !get_git_work_tree(); is a non-absolute 
path for git_dir right then?

> > -		set_git_dir(make_absolute_path(git_dir));
> > +		set_git_dir(make_relative_path(make_absolute_path(git_dir),
> > +					       work_tree));
> >  	if (!work_tree || chdir(work_tree))
> >  		die("This operation must be run in a work tree");
> >  	initialized = 1;
> 
> All in all I am pretty surprised how easy it was.  I tried yesterday, for 
> half an hour, to come up with something sensible, and failed.

I was sure you'd come up with just this solution, because you'd just 
recently explained that make_absolute_path() means you can find when one 
path is in another path with a simple string compare. And, since we know 
what pwd is going to be...

	-Daniel
*This .sig left intentionally blank*
