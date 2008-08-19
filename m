From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 15:22:30 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808191143040.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vbpzph3fx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWoT-000133-6g
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946AbYHSTWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757931AbYHSTWj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:22:39 -0400
Received: from iabervon.org ([66.92.72.58]:33993 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757946AbYHSTWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:22:37 -0400
Received: (qmail 4647 invoked by uid 1000); 19 Aug 2008 19:22:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2008 19:22:30 -0000
In-Reply-To: <7vbpzph3fx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92911>

On Tue, 19 Aug 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > .... For most systems, "diff" without options is a preview of 
> > what would be in the patch if you were to commit; "git diff", on the other 
> > hand, shows what would be left out of the patch.
> 
> That is true, but I also think that is because (1) on other systems, you
> cannot even choose to select changes to "leave out of the patch", so they
> have no option other than showing "what could be committed", and (2) by
> definition active use of index means that you are staging incrementally,
> and it is natural to expect you to want to view "changes since the last
> staging" much more often than "what would be committed" when you are
> staging incrementally, so the current default is the _right_ one.

Wow, that's a completely different idea of how to use the index than I 
think of. When I think of staging things incrementally, I'm taking a 
working tree with a ton of changes, and triaging them into: (a) things 
that go into this commit; (b) things that I want to hang onto but not put 
in yet; and (c) things I want to get rid of. This is after I've got a 
working version of the change, and I'm just cleaning it up and debugging. 
This, of course, is essentially the same as using the index for merging, 
where you start using the index when you've got all the content available 
(including stuff you don't want), and you finish with the state you'll 
want to commit.

When I want to do what you're doing, I just do a commit and then use 
--amend when I've done more work (or I work on a temporary branch). I 
think the real benefit of the index is that it doesn't have to match a 
complete-working-tree state you've actually had, so you can use it to 
commit the correct version of API A without user B when you really wrote a 
buggy version of A, then wrote B, then fixed A.

> So I'd say the below is a faulty argument:
> 
> > ...  So, even given that 
> > people understand the meaning of the index, they can fail to understand 
> > what "diff" will tell them.
> 
> If they understand "the meaning of the index", not just as literal reading
> of the manual page "it is a staging area to prepare for the next commit",
> but including the reason why there is a "staging area" and how it is to be
> used, they would reach the conclusion that "diff by default will show the
> leftover from incremental staging and it is the right thing".

I think you may be overly limited in "how the index is to be used". One of 
the major advantages, in my view, of git over other systems is that you 
can incrementally decide what of the changes persent in your working tree 
will be included in the next commit, and the index stores what you've 
decided to include. That is, you can not only checkpoint your work on 
changing the content, you can even checkpoint your work on forming the 
content change into commits, and you can checkpoint your work on resolving 
merge conflicts.

Simply checkpointing content changes is, IMHO, better done in ways other 
than the index (git stash, throw-away development branches) that allow you 
to recover to earlier checkpoints; having private commits satisfies this 
need admirably, while the index allows incremental work on preparing a 
commit out of changes you've written, which is an area where nothing but 
the index works nearly so well.

> > ... And diff is a bit unhelpful in that it 
> > generates headers as for "diff -r a b", regardless of what the things are.
> 
> We have a separate thread on this now ;-)

Right.

> >> (2) Some concepts in git are different from what they are used to, without
> >>     any good reason.  IOW, the concepts have room for improvement, and our
> >>     UI is based on these faulty concepts.
> >> 
> >> (3) Some concepts in git may be exactly the same with other systems, yet
> >>     our UI may operate differently from them without any good reason.
> >> 
> >> I'd be surprised if there is _no_ UI element that falls into the latter
> >> two categories, but obviously I would not be able to list examples.  If I
> >> could, they instead would have long been fixed already.
> >
> > You've got to include the class of "The concepts in git are exactly the 
> > same as with other systems (although git also has additional concepts), 
> > and commands from other systems do not do the same thing in git (with or 
> > without good reason)."
> 
> Isn't it the same as (3)?

Well there may be a good reason, which (3) excludes. 

> > E.g., git has a working directory, and git has a committed state, and CVS 
> > has both of these, and "cvs diff" compares the working directory with the 
> > committed state, but "git diff" does a different operation.
> 
> Ah, Ok, that is not the same as (3), but "although git has more" makes it
> totally different.
> 
> Your example sounds like comparing a car and a motorcycle.  Yes they both
> share two tyres, but the former having two more tyres makes the driving
> technique of the whole thing quite different, doesn't it?

Ah, but a motorcycle has handlebars and a car has a steering wheel. That 
is, they somewhat arbitrarily have different user interfaces, 
corresponding to the difference in driving technique. That would be like 
having "git diff" not exist, but "git cmp" serve the same goal as "cvs 
diff", because git can do a different and more useful operation than cvs 
can do, but we'd name it differently because it's not the same operation.

	-Daniel
*This .sig left intentionally blank*
