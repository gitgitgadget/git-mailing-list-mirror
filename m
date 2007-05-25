From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 14:58:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251451530.4648@racer.site>
References: <11800866643203-git-send-email-hjemli@gmail.com> 
 <Pine.LNX.4.64.0705251157450.4648@racer.site>
 <8c5c35580705250646h12f4f30bt301f4c4bdc2ad530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 15:58:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HraJf-0006M2-4Q
	for gcvg-git@gmane.org; Fri, 25 May 2007 15:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXEYN6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 09:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758526AbXEYN6o
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 09:58:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:59219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751848AbXEYN6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 09:58:43 -0400
Received: (qmail invoked by alias); 25 May 2007 13:58:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 25 May 2007 15:58:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19E5eseZDFEvSLVt8qChiBqThXmFBaWy4xbHflDqm
	iftnyJi3d6kXns
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580705250646h12f4f30bt301f4c4bdc2ad530@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48376>

Hi,

On Fri, 25 May 2007, Lars Hjemli wrote:

> On 5/25/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Fri, 25 May 2007, Lars Hjemli wrote:
> > 
> > > +modules_init()
> > > +{
> > > +     git ls-files --stage -- $@ | grep -e '^160000 ' |
> > 
> > Any reason you read in the stage? It does not seem that you use it.
> 
> Are there any other way to get the mode info?

Ah, I missed that. Right.

> > > +             subsha1=$(cd "$path" && git-rev-parse --verify HEAD) ||
> > 
> > Maybe it would be a better idea to use "git --git-dir="$path" 
> > rev-parse ..."? Just in case somebody calls this with GIT_DIR 
> > overridden...
> > 
> > Or, unset GIT_DIR explicitely.
> 
> Hmm, that's annoying (overridden GIT_DIR). I guess 'git --git-dir 
> $path/.git' would be the easiest solution.

But you have to repeat it on every subsequent Git command. OTOH if you 
unset GIT_DIR, you can no longer be sure that you have the correct git dir 
for Git calls in the superproject...

> > > +             die "Unable to find current revision of submodule '$path'"
> > > +
> > > +             if test "$subsha1" != "$sha1"
> > > +             then
> > > +                     $(cd "$path" && git-fetch && git-checkout -q
> > "$sha1") ||
> > 
> > This will make a detached HEAD, right? Do you want that? (I am not 
> > really interested in submodules myself, so I haven't thought about it, 
> > and I haven't followed that monster discussion.)
> 
> Well, we might want to be smarter about this, but on the other hand: if 
> the user cares, he can always do 'cd $path && git checkout $branch', 
> since 'git submodule -u' will skip submodules with the correct commit 
> checked out.

Fair enough, I guess...

> > I'll let Junio comment on that command line parsing...
> 
> Heh, I'm a shell illiterate...

;-)

I guess Junio would like one of his famous

	case ,"$init","$update",[...] in
	*1*1) usage
	esac

to prevent running with two actions...

> > All in all, I like it: it is short, to the point, and it should do the 
> > job (maybe with a few enhancements like "--update" without arguments 
> > means _all_ submodules).
> 
> Well, it does (or should) update all initialized submodules, but maybe 
> that's not what you meant?

Oops. I meant "init". I mean, most people who want to clone a superproject 
want the submodules being initialized without hassles, probably. But maybe 
that should be another option: "--clone-superproject" or something. Dunno. 
There's time for that after the initial git-submodule.

Ciao,
Dscho
