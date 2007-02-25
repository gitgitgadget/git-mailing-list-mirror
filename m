From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [RFC/PATCH] Fix git-diff --cached to not error out if HEAD points to a nonexistant branch
Date: Sun, 25 Feb 2007 10:13:02 +0100
Message-ID: <20070225091302.GB3897@xp.machine.xx>
References: <20070224172037.GA31963@xp.machine.xx> <7vvehrw9mz.fsf@assigned-by-dhcp.cox.net> <20070224221622.GA3897@xp.machine.xx> <7vvehqtzns.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 10:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLFP4-0000uI-OE
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 10:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933693AbXBYJKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 04:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933696AbXBYJKg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 04:10:36 -0500
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:47265 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S933693AbXBYJJy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Feb 2007 04:09:54 -0500
Received: (qmail 27575 invoked by uid 0); 25 Feb 2007 09:09:52 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 25 Feb 2007 09:09:52 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvehqtzns.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40546>

On Sun, Feb 25, 2007 at 12:22:15AM -0800, Junio C Hamano wrote:
> Peter Baumann <waste.manager@gmx.de> writes:
> 
> > I tend to agree, but I'd like to also have somethin in the spirit of
> > "log.showroot = true" which handles the diff of the first commit like
> > diffing against an empty tree. Why should diff --cached differ from
> > this? At least it is easier to explain, just mention that diff --cached
> > shows everything which would become the next commit.
> 
> I think it is _actively wrong_ to explain that "diff --cached
> shows everything which would become the next commit".  It
> instills an incorrect mental model to new users.  What would
> become the next commit is "git tar-tree $(git-write-tree)".  A
> commit records the tree state, not difference from _the_
> previous _single_ commit.
> 

Ok. You are obviously right here. Not the difference but the actual tree
state would become the next commit. What I meant to say that everything
which is shown in git-diff --cached would be applied to the previous
commit to get to the new tree state. And quoting from the manpage of

 git-diff [--options] --cached [<commit>] [--] [<path>...]
          This form is to view the changes you staged for the next commit
          relative to the named <commit>. Typically you would want comparison
          with the latest commit, so if you do not give <commit>, it defaults
          to HEAD.

I interpreted this to mean that it would show me the diff from an empty
commit (= empty tree state) to the index if I am in a new git repo without
a previous commit.

> Having said that, showing an "add everything" patch when the
> user says "git diff --cached" or even "git diff --cached HEAD"
> on a yet-to-be-born branch might actually make sense, although I
> am a bit afraid that the added inconsistency makes the command
> more confusing and harder to explain at the end.
> 
> The output would become indistinguishable from the case where
> your previous commit indeed was with an empty tree.  In essense,
> this is about making the state before the first commit less
> special.  That may or may not be a good thing, and I agree that
> the preference on this may be related to what log.showroot
> controls.
> 

Yes, I find the special case before the first commit really annoying for
the _porcelain_commands_. You have to explain to someone that a command
does this and that, but in the same sentence you have to say
"Oh, did I mention that it doesn't work until you have made a first commit?"

People new to git are often confused about this, because they read
the manpage and then tried it in an empty repository (or after adding
some files to it but just before the very first commit) to see how it
works. At least thats the way I was getting familiar with git. And it is in
_no_way_ obvious that git diff --cached only operates on
commits <-> index. Ok, I reallized very quickly that I have to do a commit
first, but if I hadn't glanced over the mailinglist since the very beginning
of git, it would have taken me _much_ longer to reallize this, especially with
the .. uhm .. "meaningful" error messages. Thank god (or better all you
people; you are doing a great job) that this has become much better in 1.5.0.

The plumbing commands are a diffrent story. They shouldn't do this, but
if you stay on the level of the porcelain commands, as most people and
especially newbies do, a little more onsistency would be nice.

-Peter
