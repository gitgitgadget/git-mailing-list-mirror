From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 17:31:21 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Trans <transfire@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 23:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVCKy-00070b-PF
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 23:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYHRVbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 17:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbYHRVbY
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 17:31:24 -0400
Received: from iabervon.org ([66.92.72.58]:43320 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281AbYHRVbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 17:31:23 -0400
Received: (qmail 23318 invoked by uid 1000); 18 Aug 2008 21:31:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Aug 2008 21:31:21 -0000
In-Reply-To: <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92743>

On Mon, 18 Aug 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Sun, 17 Aug 2008, Trans wrote:
> >
> >> Well, after a few days of using git, I've decide Linus is too smart to
> >> be designing end-user interfaces.
> >
> > This is true, but hardly relevant. Git's end-user interface was almost 
> > entirely designed by other people, using Linus's excellent 
> > script-developer API.
> 
> I'd agree that you cannot judge Linus's ability to design end-user
> interfaces by observing the UI of git.
> 
> I am pleased to see that almost everybody who responded in this thread has
> refrained from saying meaningless things (aka feeding the troll) to waste
> people's mental bandwidth.
> 
> I think there are three majorly different reasons that new people can get
> confused.
> 
> (1) Some concepts in git are different from what people from other systems
>     are used to.  For example, A new person may be puzzled by the
>     distinction among "git diff", "git diff HEAD" and "git diff --cached"
>     and say "why do you have these three?"
> 
>     Complaining that we have these three instead of two, claiming that
>     such complexity is a source of UI clunkiness, is an invalid argument
>     made by a new person who does not understand the index.  People who do
>     take advantage of the index need the distinction among these three.
>     We shouldn't be doing anything but educate them against that kind of
>     complaints.
> 
>     However, I think it is valid to say, for a person who does not use
>     index very actively (i.e. one who does not incrementally stage), what
>     "git diff" does is confusing.  It does not say anything about new
>     files (until it is modified since added) while showing changes for
>     existing files.  CVS does the same thing ("file foo is a newly added
>     file, no comparison available"), but that may not be a good excuse.

There's another issue here, I think. It's not clear from an understanding 
of the index, working tree, and commits that the default for "git diff" is 
between the working tree and the index, as opposed to one of the other 
possibilities. For most systems, "diff" without options is a preview of 
what would be in the patch if you were to commit; "git diff", on the other 
hand, shows what would be left out of the patch. So, even given that 
people understand the meaning of the index, they can fail to understand 
what "diff" will tell them. And diff is a bit unhelpful in that it 
generates headers as for "diff -r a b", regardless of what the things are; 
if you'd get:

--- (index)/foo/bar
+++ ./foo/bar

people would at least be clear on what information they were getting, even 
if they didn't know why they were getting that as opposed to a different 
combination.

>     If we had a configuration for "index-free" people, that changes the
>     semantics of "git add" to register object name of an empty blob when a
>     new path is added, makes "git add" for existing blobs a no-op, but
>     keeps "git commit -a" and "git commit <paths>" to operate as they
>     currently do, then people with such configuration could:
> 
> 	$ >new-file
>         $ git add new-file
>         $ edit old-file
>         $ edit new-file
>         $ git diff
> 
>     to always see what's the difference from the HEAD is with "git diff",
>     and any of these three:
> 
> 	$ git commit -a
>         $ git commit old-file
>         $ git commit old-file new-file
> 
>     would work as expected by them.  We still need to support the three
>     diff variants for normal git people, but people who do not use index
>     do not have to know the two variants ("git diff" vs "git diff HEAD");
>     such a change could be argued as a "UI improvement" [*1*].

I think that having the possibility of adding an empty blob (or maybe a 
magical "nothing currently here but git-ls-files includes it") would be 
preferrable to a no-index mode. That is, the operation that corresponds 
most directly to "cvs add <filename>" is "git update-index --cacheinfo 
100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 <filename>", which is not 
exactly easy to do, and just because a user wants to do this doesn't mean 
the user doesn't want to use the index; a user that makes extensive use of 
the index is actually more likely to want the state where a file is 
tracked but all of the content has not yet been staged.

But we've argued this before.

> (2) Some concepts in git are different from what they are used to, without
>     any good reason.  IOW, the concepts have room for improvement, and our
>     UI is based on these faulty concepts.
> 
> (3) Some concepts in git may be exactly the same with other systems, yet
>     our UI may operate differently from them without any good reason.
> 
> I'd be surprised if there is _no_ UI element that falls into the latter
> two categories, but obviously I would not be able to list examples.  If I
> could, they instead would have long been fixed already.

You've got to include the class of "The concepts in git are exactly the 
same as with other systems (although git also has additional concepts), 
and commands from other systems do not do the same thing in git (with or 
without good reason)."

E.g., git has a working directory, and git has a committed state, and CVS 
has both of these, and "cvs diff" compares the working directory with the 
committed state, but "git diff" does a different operation.

	-Daniel
*This .sig left intentionally blank*
