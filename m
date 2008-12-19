From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Git Notes idea.
Date: Fri, 19 Dec 2008 16:24:01 -0600
Message-ID: <5d46db230812191424m14e82c5fx1c1c12027db901ed@mail.gmail.com>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
	 <20081216085108.GA3031@coredump.intra.peff.net>
	 <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
	 <alpine.DEB.1.00.0812170003540.14632@racer>
	 <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com>
	 <alpine.DEB.1.00.0812170420560.14632@racer>
	 <20081217101110.GC18265@coredump.intra.peff.net>
	 <5d46db230812190918qf22b874n8d8aeea557083df8@mail.gmail.com>
	 <5d46db230812190938r4e8ff994gfcb616c750be0f22@mail.gmail.com>
	 <20081219212536.GA27168@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 23:25:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDnmn-0001ri-4x
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 23:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbYLSWYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYLSWYE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 17:24:04 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:38692 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYLSWYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 17:24:03 -0500
Received: by gxk6 with SMTP id 6so1140093gxk.13
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 14:24:01 -0800 (PST)
Received: by 10.150.12.10 with SMTP id 10mr1990310ybl.219.1229725441595;
        Fri, 19 Dec 2008 14:24:01 -0800 (PST)
Received: by 10.151.135.7 with HTTP; Fri, 19 Dec 2008 14:24:01 -0800 (PST)
In-Reply-To: <20081219212536.GA27168@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103590>

On Fri, Dec 19, 2008 at 3:25 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 19, 2008 at 11:38:55AM -0600, Govind Salinas wrote:
>
>> This is my concern with keeping a history of the notes pseudo-branch.  Let
>> me restate what you are saying with an example
>>
>> 1) on branch A commit a
>> 2) add note a`
>> 3) on branch B commit b
>> 4) add note b`
>> 5) on branch B commit c
>> 6) add note c`
>> 7) delete branch A
>> 8) gc after a time such that a is pruned
>>
>> Now either I will always have a note a` as an object forever even though
>> the only commit that points to it is gone or I have to re-write the history of
>> the notes branch from the point that it was added.
>
> Yes, that's correct.
>
>> Given this problem, is it really such a good idea to keep the history?
>
> I think so. Otherwise how will you push and pull notes? You won't even
> know which one is the more recent tree, let alone handle any merges
> caused by editing notes in two places.

Couldn't you simply merge your tree and theirs even if there is no
history.  You would have to find a way to handle merges in any event
since they could just as easily happen if you have a history.

>> On the other, other hand, pushing and pulling notes if a history is kept
>> will have to involve a lot of rebasing/merging.
>
> Depending on your workflow. It might just involve a lot of fast forwards
> if the note writer is in one place.
>
>> A possible solution is that notes are per-branch,
>>
>> refs/notes/heads/master
>> refs/notes/heads/foo/bar
>> refs/notes/remotes/baz/bang
>
> Sorry, I don't quite get it. You are asking for per-branch notes that
> keep history, or per-branch notes that don't keep history?

Both, at the end of my previous mail I said...

"So perhaps we could use the above layout with no history?"

But they are two separate fixes to 2 different problems.

> If the former, then you haven't solved the cruft accumulation problem.
> You can get obsolete notes in your note history by rebasing on a branch
> that is long-running (which is OK as long as you haven't published
> _those particular_ commits). Or are you proposing to rebase and cleanup
> the notes history every time you do a destructive operation?

Yes, it does not solve that problem.  But it does solve things like

Dev1 and Dev2 both have branches A and topic branch B. and they
are in refs/notes/public (or refs/notes or something not branch specific).

Dev1 adds 100 notes to topic B, lets say half of them are obsolete due
to rebases or whatever.  Dev2 pulls A and updates their notes
as well.  Now Dev2 has acquired all the notes from Dev1 including the
obsolete ones.  So you have 100 commits, 100 blobs and all the new
trees that go with them that the user was not interested in.

Run this across 1000 users and you have a lot of cruft.

Now, if instead we have a per-branch notes scheme, then you only get
the cruft from the branches you were interested in.  If you remove the
history you could end up with no cruft because gc should handle it.

> If the latter, then I don't see how you've solved the push-pull and
> merge problem (which you need history for).

What git-fetch would have to do is say.  This is a note.  The remote
sha is not the same as mine, i will treat this as a force and fetch the
objects without checking history and then run a merge on the 2
commits.  The notes merge could have its own strategy that checked
if an object exists before deciding to add a new item or delete a
removed one.  Then the user would only have to intervene if the
notes where edited.

> But in either case, I think the solution is non-intuitive. If I annotate
> a commit, and then merge the commit from one branch to another,
> shouldn't the annotation stay?

Sure, either the merge command could run 2 merges, one for the
real branch and one for the notes pseudo branch or the user
could be required to do that manually.  I would think that doing
it automatically would be good.  Especially if you use a special
merge strategy.

> Really, I am not sure this is worth getting too concerned about. Since
> we are talking about cruft in the _history_ of the notes branch, it
> won't impact actual notes usage (which will always just deal with the
> most recent tree). So really we are talking about some uninteresting
> objects in the db, which wastes some space. In practice, I suspect this
> won't be that large because notes themselves are going to be relatively
> short and in many cases, repetitive (i.e., many annotations may have the
> same blob hash for several commits). And if it is a space problem, then
> the right solution is to periodically truncate the notes history by
> rewriting.

You are correct of course that it will just be wasted space.  But I am
concerned that it could end up being a lot of wasted space.  I mean, what
if every person who contributed to the kernel contributed note cruft.  Users
have branches that they consider public, so they might go into the a public
note store if there is no per-branch store.  Or errant users could use the
public store without understanding how they are affecting the central repo,
including the obsolete ones.

If you *really* don't think its something to be worried about then I am OK
with that since you have a lot more experience with this, but it sounds hairy
to me.

Thanks,
Govind.
