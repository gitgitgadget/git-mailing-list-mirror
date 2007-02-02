From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 02 Feb 2007 12:19:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702021114480.3021@xanadu.home>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <200702021302.10567.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702020955540.3021@xanadu.home>
 <200702021611.06029.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 18:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD24D-0001DF-8l
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 18:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965393AbXBBRTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 12:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965384AbXBBRTO
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 12:19:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47672 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965381AbXBBRTN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 12:19:13 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCU0096KIRZE4I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Feb 2007 12:19:12 -0500 (EST)
In-reply-to: <200702021611.06029.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38518>

On Fri, 2 Feb 2007, Andy Parkins wrote:

> On Friday 2007 February 02 15:13, Nicolas Pitre wrote:
> > On Fri, 2 Feb 2007, Andy Parkins wrote:
> > > Forgetting about detached heads for the moment,
> >
> > That is not the way to go about it.  You cannot start forgetting about
> > detached heads and come back to it afterwards like an afterthought.
> 
> I don't agree.  To avoid confusing people the key thing should be 
> consistency.

I'm sorry but I can't help the fact that I think it's your argument that 
is inconsistent.

> What holds true for HEAD in the non-detached case should hold true for the 
> detached case.  Otherwise it's just another variable for the user to 
> remember.

I completely agree with that.

> > The exact same argument could be said if you did 1300 operations on a
> > single branch, say master.  What would master@{yesterday} tell you?
> > What will it tell you one minute from now?  Now suppose that you have
> 
> It doesn't matter - it will be on the same head, as time ticks by I will at 
> least find that master@{yesterday} ticks by linearly too.  That is not the 
> case if HEAD@{yesterday} means "whatever HEAD pointed to yesterday".  How am 
> I supposed to remember what it pointed to?  Therefore what use is 
> HEAD@{yesterday}?

It is there precisely to tell you what it pointed to yesterday, and how 
you happened to get there if you care.

If you want a particular branch reflog you just name it explicitly.

If you want the current branch's reflog you use @{...}.

Why would you use HEAD@{...} in that case?

> > only one branch and therefore HEAD reflog would be a duplicate of master
> > reflog.
> 
> You misunderstand, I'm suggesting that reflogging HEAD is not the right thing 
> to do. 

Then I understand that we won't agree on that point.

> Asking for HEAD's reflog should be the same as asking for the 
> pointed-to-branch's reflog.

That just has no logic.  HEAD is a pointer that can move inside 
branches, across branches, and even outside of any branches.  Remember 
that reflog is a "log", so the most obvious thing to do is simply that: 
logging operations affecting the HEAD pointer, _including_ the switching 
between branches, should be logged.

Having HEAD@{} named explicitly but changing meaning 
entirely depending on an implicit state (the current branch) when the 
explicit name doesn't change _is_ inconsistent in my book.  This is why 
there is now @{...} (no explicit name) that means the current branch 
reflog with no potential for confusion what so ever.

> Instead, the reflog should be kept for the "unnamed branch", which would jump 
> around each time you detached HEAD.
> 
> > Answer: it would carry the same kind of confusion as your example above.
> 
> I don't agree.  HEAD is always "the branch I'm on now", even when it's 
> detached it's pointing at the branch I'm working on. It just happens 
> that that branch has no name.

Whatever.  But you must admit that, with that same logic, the HEAD 
reflog should always be a log of "the branch you were on" at the time it 
has been recorded.

But because @{...} carries no name information, it has no _explicit_ 
meaning and therefore can refer to whatever reflog your current branch 
is at the moment.  It may change universe when you change branch just 
fine.

> > anyway since HEAD is the likely default in most cases.  So you may even
> > forget that the HEAD entity exists and be just fine.
> 
> Yep; in my scenario that's true.  One could completely forget about HEAD.  In 
> your scenario that isn't the case, because I need to remember that when I'm 
> detached HEAD suddenly gets special powers to tell me about the detached 
> movements.

No.  HEAD is never special.  HEAD@{} is a log of all values HEAD had in 
the past.  So HEAD@{5} will _always_ give you the fifth last position 
your checked out tree was at, regardless if it happened to be  on branch 
x or branch y or detached.  The same logic goes for master@{} which will 
_always_ return the previous values master might have had.

And because people want a shortcut to mean the reflog of the current 
branch then we use @{} without any explicit name.  This way the reflog 
for @{} being annonymous can change at will depending on the current 
branch without semantic confusion.

> > But HEAD is still a moving pointer and we might want to know that it
> > switched from one branch to another at some point.  And the only way for
> > that to be sensible is by having a separate reflog for HEAD that is the
> > exact log of every operations you perform regardless of the actual
> > branch you might be on.
> 
> I agree.  I am arguing about nomenclature.  There is no dispute that /that/ 
> reflog (or equivalent) should exist.  However, I don't believe it should 
> be "the log of HEAD" it should be "the log of the unnamed branch".

OK...  If what you want is an explicit "detached head" reflog then let's 
just create one!  But that doesn't eliminate the need for a separate 
HEAD reflog that includes all moves the HEAD pointer makes.

But IMHO I don't think the detached head should have a reflog of its 
own.  It is meant to be a volatile thing and since the HEAD reflog 
already contains moves made when HEAD is detached should be plenty 
enough for the detached head intended use.

> > HEAD _does_ get detached.  It becomes loose in the air.  It doesn't drag
> 
> Well, we're talking semantics now.  HEAD becomes detached from a branch, but 
> it certainly isn't floating.  It points at a particular point in the 
> repository.

So? Every ref always point to somewhere.  Don't be silly please.

> HEAD is always a symref (despite what you say); it's just that when HEAD is 
> detached from all branches, there is no ref for it to point at, so we store 
> the ref in the file called HEAD.

Please have a look at the git-symbolic-ref documentation.  When the ref 
is stored in the file called HEAD, then HEAD is _not_ a symbolic ref 
anymore.

> I disagree that there is no virtual branch.  That is what HEAD is when it is 
> in detached mode.  It looks just like a ref - HEAD holds a hash, refs hold a 
> hash - how is that not a virtual branch?  I used the word "virtual" only 
> because it is not stored in refs/ and vanishes when you move back to a real 
> branch.  Just because the virtual branch is stored in HEAD, I think it is 
> dangerous to thing of HEAD as being the thing that is logged - it is this 
> virtual branch that should be logged because that branch is always there and 
> can be tracked through time as a discrete entity.  If you track HEAD itself, 
> then sometimes it will hold the same as a branch reflog, sometimes it will 
> hold unique data.

Please consider the HEAD reflog as a _log_ of all operation the HEAD 
_pointer_ has seen.  Because that is all there is about it.  Forget that 
HEAD is a branch.  It is not a branch IT is a pointer.  "master" is a 
branch, "origin/next" is a (remote) branch.  But HEAD is not a branch it 
is a pointer.

OK branches are pointers too, but they are _branch_ pointer.  HEAD is 
_not_ a branch pointer.  It is only the current checked-out state 
pointer.  The HEAD pointer is a totally volatile thing.  Branch pointers 
are not volatile pointers.

This is why you should have a mental model for a detached head as the 
HEAD pointer being totally up in the air.  Sure it points to something, 
but it keeps its volatile nature.  When HEAD is not detached, it drags 
the current branch pointer along so the branch state is updated.  But 
that doesn't make HEAD more a branch pointer even though it might be 
pointing to a branch.


Nicolas
