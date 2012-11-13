From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Fwd: [PATCH] Add tcsh-completion support to contrib by using
 git-completion.bash
Date: Wed, 14 Nov 2012 00:46:36 +0100
Message-ID: <20121113234636.GS12052@goldbirke>
References: <CAFj1UpE6OtJEojaED1_DZJD0kU=nVsFE_w8xa0oJE-6auCU2rw@mail.gmail.com>
 <CAFj1UpFd9X8Jq5o7B4m35i=merBDvOo4NOtwth=UnG2S5X_rGw@mail.gmail.com>
 <20121113111448.GA3817@goldbirke>
 <CAFj1UpGxx_9GHSnJRpe8hDGB6OTio1mcN71LKcR0pxhSVx2xDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, felipe.contreras@gmail.com
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYQBw-00073a-F0
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 00:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab2KMXqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 18:46:39 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:62374 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab2KMXqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 18:46:38 -0500
Received: from localhost6.localdomain6 (p5B13079E.dip0.t-ipconnect.de [91.19.7.158])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0M83Dl-1TLGur3v4D-00w3La; Wed, 14 Nov 2012 00:46:37 +0100
Content-Disposition: inline
In-Reply-To: <CAFj1UpGxx_9GHSnJRpe8hDGB6OTio1mcN71LKcR0pxhSVx2xDw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:JMQCO9/u8yRMyF/Rmn4B9XBYEqvBFKHczzSxDK66sab
 WRZbDCgdNTerlYA/b7OAZdEGzISco54yE0s2/CmVpwaMZjbxbM
 RguKPGMB3dU+s0BsVncmp/Cq6ZCZeeRahUdUDh+4Mez8agQyC5
 YnX3NUNkjcgQqJjwdIFOe1Nq3h2gDrKklsQXr/vxrrSIU9b4DI
 H7nRGZTlsYlzjOSc7LIw7EJBmhQKFRtkf3Y5iHY4mSk2ckB+6n
 utjfyhckQJXtxkN9DaYIw9aRAxqSX70IH1PsMv8w0ov83bkIOV
 xMRiS524gldaYalsXbM+UBnAr+o9ObakXCEFwSuRnJNY5h71lD
 CvMgDFdTtti7l/BpbzXUh56riicvSJ8cHvrzP5IXk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209686>

Hi,

On Tue, Nov 13, 2012 at 03:12:44PM -0500, Marc Khouzam wrote:
> >> +if [ -n "$1" ] ; then
> >> +  # If there is an argument, we know the script is being executed
> >> +  # so go ahead and run the _git_complete_with_output function
> >> +  _git_complete_with_output "$1" "$2"
> >
> > Where does the second argument come from?  Below you run this script
> > as '${__git_tcsh_completion_script} "${COMMAND_LINE}"', i.e. $2 is
> > never set.  Am I missing something?
> 
> This second argument is optional and, if present, will be put in
> $COMP_CWORD.  If not present, $COMP_CWORD must be computed
> from $1.  Also see comment above _git_complete_with_output ().
> tcsh does not provide me with this information, so I cannot make use of it.
> However, I thought it would be more future-proof to allow it for other shells
> which may have that information.
> 
> It is not necessary for tcsh, so I can remove if you prefer?

I see.  I read those comments and understood what it is about.  I was
just surprised that the code is there to make use of it, yet it's not
specified when invoking that function.

Since it's a trivial piece of code, I would say let's keep it.  Could
you please add a sentence about it (that it's for possible future
users and it's not used at the moment) to the commit message for
future reference?

> >> +complete git  'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}"
> >> | sort | uniq`/'
> >> +complete gitk 'p/*/`${__git_tcsh_completion_script} "${COMMAND_LINE}"
> >> | sort | uniq`/'
> >
> > Is the 'sort | uniq' really necessary?  After the completion function
> > returns Bash automatically sorts the elements in COMPREPLY and removes
> > any duplicates.  Doesn't tcsh do the same?  I have no idea about tcsh
> > completion.
> 
> On my machine, tcsh does not remove duplicates.  It does sort the results
> but that is done after I've run 'uniq', which is too late.  I'm not
> happy about this
> either, but the other option is to improve git-completion.bash to
> avoid duplicates,
> which seemed less justified.

Ok.  Then keep it for the time being, and we'll see what we can do to
avoid those duplicates.

> > Does the git completion script returns any duplicates at all?
> 
> It does.  'help' is returned twice for example.

Right.  Now that you mentioned it, I remember I noticed it a while
ago, too.  I even wrote a patch to fix it, but not sure what became of
it.  Will try to dig it up.

> Also, when completing 'git checkout ' in the git repo, I can see multiple
> 'todo' branches, as well as 'master', 'pu', 'next', etc.
> 
> You can actually try it without tcsh by running my proposed version of
> git-completion.bash like this:
> 
> cd git/contrib/completion
> bash git-completion.bash "git checkout " | sort | uniq --repeated

Interesting, I can't reproduce.  Are the duplicates also there, if you
start a bash, source git-completion.bash, and run __git_refs ?
