From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 01:42:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705070127180.4167@racer.site>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705061851411.4015@racer.site>
 <vpqk5vlamav.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 07 01:42:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkqMa-0004gU-C1
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbXEFXl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbXEFXl5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:41:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:55861 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752274AbXEFXl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:41:56 -0400
Received: (qmail invoked by alias); 06 May 2007 23:41:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 07 May 2007 01:41:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Pj7pjCfwPzzfadyBTehNtSaIZztatU+aKXRCT3W
	5FogiZ4O1HRrAY
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqk5vlamav.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46398>

Hi Matthieu,

On Sun, 6 May 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 6 May 2007, Matthieu Moy wrote:
> >
> >> [...]
> >>
> >> % git satus -a
> >> % git commit -a -m "..."
> >> 
> >> In the former case, I have more commands to type, and in the second
> >> case, I loose part of the stat-cache benefit: If I run "git status -a"
> >> twice, the second run will actually diff all the files touched since
> >> the last run, since "git status -a" actually updated a temporary
> >> index, and discarded it afterwards, so it doesn't update the stat
> >> information in the index (while "git status" would have).
> >
> > Have you tried "git status" _without_ "-a"?
> 
> Reading my message (including the last 5 words of the sentence you're 
> quoting) would have told you that ;-).

Okay, I rephrase the (badly worded) question:

Why did you use "-a" with "git status" to begin with? It's useless.

> >> In both cases, I can't really see the benefit.
> >
> > The benefit is a clear distinguishing between DWIM and low level. The 
> > index contains _exactly_ what you told it to contain.
> 
> In other systems, commit commits _exactly_ the content of files on
> disk. And most people seem happy with that.

Because they do not realize that the file _names_ are actually only a key, 
not the value.

With Git, it is possible to stage changes, but also to have a dirty stage.

Think, for example, about debugging a program. Many programs have 
Makefiles, which define CFLAGS without "-g". Now you want to debug. Since 
gdb acquired the bad habit of not working properly at all without that 
flag (which is especially apparent when single stepping jumps around 
wildly in the source code), you _have_ to change the Makefile to include 
"-g" with the CFLAGS.

But you don't want to commit _that_. It is no useful change for the 
project. Submitting such a patch makes you look foolish. So, you leave it 
out of the commit.

And to make you _aware_ that it is a real possibility, and often a 
desirable one, git-commit makes you specify "-a" when you are _sure_ that 
you want to commit _all_ of your changes to the tracked files.

With CVS (which has been bashed on a lot on this list, and rightfully so), 
after a mistaken "cvs commit" _with_ irrelevant changes, like the change 
to the Makefile I illustrated above), you have two options:

	- leave it as it is (possibly undoing the change in a subsequent 
	  commit), or

	- edit the files, which often leads to an inconsistent repository. 
	  Yeah, sure, you can checkout the newest state, but you cannot 
	  reproduce known older states.

> > By forcing users to use "-a" with "git commit",
> 
> Does this mean that the normal way to use "commit" is to use "-a"?

Well, I use it quite a lot. But 30% of the time, I prefer to commit with 
specific filenames, so I can be sure _what_ I commit. FWIW, I picked up on 
that practice when using CVS...

There are even about 20% of the time, when I use "git commit" _without_ 
any parameters, because I used "git add" to tell Git that I resolved some 
conflicts, or that I want this file to be committed, while other files 
should not be committed.

> > you make it clear that a separate update steo is involved,
> 
> Well, with those kind of arguments, I could have my web browser not do
> DNS resolution for me, because it would make it clear that a separate
> step from HTTP request is involved.

No. _You_ never need to tell the browser _not_ to resolve via DNS.

But _you_ sometimes _need_ to commit with _different_ parameters than 
"-a". You might not realize that _now_. But at least specifying "-a" 
everytime you do your thing gives you a _chance_ to realize it.

> > and if you made an error (which you see from the file list), you can
> > abort, and start over with the original index.
> 
> You don't necessarily see your error from the file list:
> 
> % vi foo.c
> % git add foo.c
> % vi foo.c
> % git commit -m foo

As others have commented, "-m" is a _bad_ option. Yes, for ease of use, it 
is provided.

But how useful is a commit message which consists of less than five words?

It does _not_ tell you,

	- what the _conceptual_ change was,
	- _why_ it was done,
	- _how_ it was done, and
	- what the rationale of the committer was, for the case that 
	  people try to come up with a cleverer patch, to prevent 
	  unnecessary rethinking.

Ciao,
Dscho
