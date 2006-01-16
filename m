From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 00:06:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601152248030.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> 
 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de> 
 <43C537C9.4090206@hogyros.de>  <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
  <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
  <43C951B6.5030607@gmail.com>  <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
  <43C95F69.7090200@gmail.com> <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net>
 <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, gitzilla@gmail.com,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 06:04:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyMXm-0002k7-Jm
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 06:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWAPFE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 00:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWAPFE3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 00:04:29 -0500
Received: from iabervon.org ([66.92.72.58]:55819 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932182AbWAPFE2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 00:04:28 -0500
Received: (qmail 5229 invoked by uid 1000); 16 Jan 2006 00:06:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2006 00:06:18 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14721>

On Sun, 15 Jan 2006, Martin Langhoff wrote:

> On 1/15/06, Junio C Hamano <junkio@cox.net> wrote:
> > > The "get" rule for each sub-project could be something like:
> > >
> > >       git_sub-project:
> > >               mkdir sub-project
> > >               cd sub-project
> > >               git-init-db
> > >               git-fetch <fetch-options> <repository> <refspec>
> > >               git-checkout <branch>
> > >               $(MAKE) get_sub_components
> >
> > There lies a drake here --- <repository> is not the same for
> > everybody.  It is not a big showstopper dragon, though.
> 
> Well, that /little complication/ applies to doing it in git too ;-)
> There's no way to tell how the dev doing the top level checkout has
> access to the subproject repos.
> 
> I am with gitzilla on this one. Let the projects have their own
> bootstraping mechanisms, using make, ant or whatever catches their
> fancy. One of the great things about git is that it doesn't assume
> that it's being used by all the projects in the world -- thanks to
> Linus' disregard for arbitrary metadata and to your git-cherry
> implementation, it's all about the content -- and so it interoperates
> great with Arch, SVN, CVS, etc.

But most of the content of the project that started this thread is the 
revisions of the subprojects. Sure, it could all be done in the build 
system, but then it becomes impractical to manage. Git could refuse to 
support tracking the executable bit on files, or what directories things 
are in, and we could tell people to use their build systems to set these 
things, but it would make the tool impractical to use. We want to track 
some metadata, because it's actually important; what we don't want to 
track is the metadata that is local to the particular working tree. That's 
why we track only one executable bit, not a full set of permissions; it's 
a matter of local policy who can interact with the files in a working 
tree, but it's part of the content whether a file is executable.

So the problem with handling subprojects with the build system is that it 
is too tempting to use the revision control system directly on the 
subproject, at which point the thing you're developing and testing isn't 
at all what other people will get if they check out your commit. You want 
"git status" to report it as an uncommitted change if you have a different 
revision of the subproject than your previous commit had, and it can't 
tell if this information is buried in the build system.

I like Linus's proposal: which revision of which project goes where is 
part of the content, while how you manipulate data for that project is a 
matter of local policy, and is not tracked, although it might be a good 
idea to let project provide overridable defaults (so that, if you're a 
random member of the general public and don't have a special method for 
accessing the repository, you don't have to track it down yourself).

The tricky question is whether we should permit the "subproject" objects 
to specify a revision that isn't a hash, for use in identifying revisions 
of subprojects in other systems.

	-Daniel
*This .sig left intentionally blank*
