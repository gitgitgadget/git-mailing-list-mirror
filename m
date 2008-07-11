From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git
 repository
Date: Fri, 11 Jul 2008 23:07:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112257450.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>  <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>  <alpine.DEB.1.00.0807112215050.8950@racer> <bd6139dc0807111452x778759d4jd6ac71338974018e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:08:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQmn-0005bS-N2
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbYGKWHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbYGKWHT
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:07:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:37877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753384AbYGKWHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:07:18 -0400
Received: (qmail invoked by alias); 11 Jul 2008 22:07:16 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp053) with SMTP; 12 Jul 2008 00:07:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NPKY8g63NJMPwn3GY3tGkh65CDB6f+SaM5NcX0R
	fYSj6hH8iUQUpf
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807111452x778759d4jd6ac71338974018e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88187>

Hi,

On Fri, 11 Jul 2008, Sverre Rabbelier wrote:

> On Fri, Jul 11, 2008 at 11:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 11 Jul 2008, Sverre Rabbelier wrote:
> >
> > I think quite a lot of our changes do code moves; this should be 
> > accounted for differently.
> 
> Yeah, I wish 'git log -C -C -M --numstat --sacrifice-chicken 
> --pretty=format:%ae --' would take care of that... That is, a git-blame 
> like mechanism that would detect such moves on a per-commit basis and 
> report them would be very useful to me.

Well, the chicken (or better, a goat) should be sacrificed by you...  The 
option I would call "--code-moves".

But the semantics of that need to be sorted out in a shell script first; 
maybe like I outlined (if that was not coherent, please say so).

> >> For some reason you people can't seem to make up your mind about a 
> >> file that's not even 1500 lines in size ;).
> >
> > Heh.  We might need to change it once or twice, in the future.
> 
> *chuckles*, I'm curious why the Makefile is such a hard file to get 
> right :).

Well, it is not a matter of getting it right, but it is a matter of 
changes.  For example, everytime we move code from one program into the 
library, and create a file for that, code changes.

Everytime we realize that we need to set some special settings for a 
platform, the Makefile needs to be changed.

Everytime a shell script is added, or converted to a builtin, the Makefile 
needs to be changed.

We are lucky that our maintainer is such a good shell hacker, otherwise 
every version number change, you guessed it, would need the Makefile to be 
changed.

> >> A note is in order here, this data was mined with "git log 
> >> --num-stat" so things like moving files and copying files are not 
> >> accounted for.
> >
> > In my opinion it would be even more interesting to see code moves 
> > (i.e. not whole files).  For example, we moved some stuff from 
> > builtins into the library.  The real change here is not in the lines 
> > added and deleted.
> 
> Very much so, but the former I figure can be easily done with 'git log
> -C -C -M' I discovered (I need to parse it's output though, and also
> determine what to do with moves statistics wise. Should changes made
> due to moves just be ignored?)

That is not very interesting, as we often move so small parts (think "one 
function") that -C -C -M does not trigger.

> >> I thought about using git-blame to gather this info before, but it is 
> >> not the right tool for the job. If anyone else has any idea's on what 
> >> would be better please let me know and I'll happily dig into it :).
> >
> > I think that you need to analyze the diff directly.  One possible (quick
> > 'n dirty) way would be to cut out long consecutive "+" parts of the hunks,
> > replace the "-" by "+", and use "git diff --no-index" to do the hard part
> > of searching for that code in the "-" part of the original diff.
> 
> That sounds interesting, I won't need to actually do that though, I
> already have a diff parser that gives me the lines added VS lines
> deleted on a hunk-by-hunk basis. If it is a true move (e.g., code
> removed in file X and added in file Y) it should be trivial to detect
> that.
> Something along the lines of:
> for hunk in added:
>   if hunk in deleted:
>     print("Over here!!")

I think that is not enough, as a code move can mean that part of a 
function was refactored into a function.  The consequence is often a 
reindent, and possibly rewrapping.

And it can mean that some lines have to be inserted here and there.  I 
still would count that as a code move "with touch-ups".

So I'd like to see something like

<number-of-commits>: <lines-added> <lines-removed> \
	<lines-moved-from> <lines-moved-to> <filename>

BTW I realized something else: your 
http://alturin.googlepages.com/full_activity.txt lists only 
"gitk-git/po/es.po" under git-git/po/.  And it has as many added as 
deleted lines.

So I suspect that "po/*" really lists both gitk's as well as git-gui's .po 
files, but merged together.

Ciao,
Dscho
