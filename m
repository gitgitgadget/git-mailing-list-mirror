From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 12:27:44 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804291204160.19665@iabervon.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no>  <alpine.LNX.1.00.0804281515480.19665@iabervon.org> <7f9d599f0804290834v23da6dfbv47b3ca9058934228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:28:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqsh7-0004YR-Tf
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYD2Q1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYD2Q1x
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:27:53 -0400
Received: from iabervon.org ([66.92.72.58]:34935 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbYD2Q1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:27:52 -0400
Received: (qmail 307 invoked by uid 1000); 29 Apr 2008 16:27:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2008 16:27:44 -0000
In-Reply-To: <7f9d599f0804290834v23da6dfbv47b3ca9058934228@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80701>

On Tue, 29 Apr 2008, Geoffrey Irving wrote:

> On Mon, Apr 28, 2008 at 12:34 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Mon, 28 Apr 2008, Henrik Austad wrote:
> >
> >  > Hi list!
> >  >
> >  > As far as I have gathered, the SHA-1-sum is used as a identifier for commits,
> >  > and that is the primary reason for using sha1.  However, several places
> >  > (including the google tech-talk featuring Linus himself) states that the id's
> >  > are cryptographically secure.
> >  >
> >  > As discussed in [1], SHA-1 is not as secure as it once was (and this was in
> >  > 2005), and I'm wondering - are there any plans for migrating to another
> >  > hash-algorithm? I.e. SHA-2, whirlpool..
> >
> >  No. The cryptographic security we care about is that it's impractical to
> >  come up with another set of content that hashes to the same value as a
> >  given set of content. The known attacks on SHA-1 (and more broken earlier
> >  hashes in the same general class) only allow the attacker to produce two
> >  files that will collide. Now, it's true that this would allow somebody to
> >  produce a commit where some people see the "good" blob and some people see
> >  the "evil" blob, but (a) the "good" blob contains some large chunk of
> >  random data, which is a major red flag by itself, and (b) all of these
> >  people have to be taking data from the attacker.
> >
> >  If somebody gives you some source, and it's got some large random chunk in
> >  it, and the behavior of the object depends on the content of this chunk,
> >  and it's unspecified where this chunk comes from, you should be aware
> >  that they might be able to swap this chunk for a different chunk. But such
> >  a file is pretty blatantly malicious anyway.
> 
> This argument is invalid, since the use of git is not limited to
> source code.  People
> can and do store unreadable binary data in git, and unless you are completely
> sure that no one would ever care about the security of that data in a
> way that can
> be attacked with a single collision, git should be secure about those as well.
>
> For example, I just converted a 20 GB repository to git which, among
> other things,
> contains pdf files of my tax returns.  I have looked them over, but I
> have not opened
> them in a hex editor and looked them over at the binary level, and I
> don't think git
> should expect me to.

If you haven't looked over your PDFs with a hex editor, you're depending 
on the security of the software generating the PDFs and on what you did in 
generating them. (Looking at the resulting image alone may be unwise if, 
for example, you redacted anything.) In any case, on the basis of your 
actions, you may this commit. Now, anyone receiving the repository can, 
due to the lack of second preimage attacks, be sure that (a) the document 
is as you committed it; or (b) the document is different from what you 
committed, but you made the substitution; or (c) the document is different 
from what you committed, and you were tricked into committing a document 
carefully designed by somebody else to be weak. Additionally, it's 
infeasible to create a document such that forensics after the fact can't 
turn up both the content as originally shown and the content as swapped 
from either document.

I'm also not confident that PDFs are, in general, not vulnerable to an 
attack where they rasterize entirely differently depending on 
environmental factors (e.g., the document you're signing says something 
entirely different when printed on A4 paper than what it says printed on 
Letter); if so, it doesn't matter much that the document could be 
replaced, since an attacker could just control the environment and get the 
same effect.

In any case, an attacker can't come along later and make a replacement of 
a file that originated in your commit. Also, you know that any sets of 
interchangable documents had already been created when you get a commit 
that contains one of them.

	-Daniel
*This .sig left intentionally blank*
