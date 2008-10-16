From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git and tagging hook
Date: Thu, 16 Oct 2008 22:15:02 +0200
Message-ID: <20081016201502.GA6362@efreet.light.src>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se> <1223399613.20250.1.camel@localhost> <gcg67d$4o2$1@ger.gmane.org> <1223484445.4055.8.camel@localhost> <48ECF072.3000506@op5.se> <20081014172227.GB6931@efreet.light.src> <1224007401.4073.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: Kristis Makris <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZGi-0004Qi-Hj
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbYJPUPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbYJPUPL
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:15:11 -0400
Received: from mail4customers.bluetone.cz ([212.158.128.5]:36749 "EHLO
	mail.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbYJPUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:15:09 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id 9FFBE3557; Thu, 16 Oct 2008 22:15:02 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id JwkBYoA7Txab1SjN; Thu, 16 Oct 2008 22:15:02 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KqZFO-0001nS-7L; Thu, 16 Oct 2008 22:15:02 +0200
Content-Disposition: inline
In-Reply-To: <1224007401.4073.40.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98409>

On Tue, Oct 14, 2008 at 11:03:21 -0700, Kristis Makris wrote:
> I have two use cases:
> 
> (1) A developer maintains besides his local copy a local bug-tracking
> system in which he tracks his changes. We would like to apply various
> verification policies when he commits or tags. For example, for tagging
> we wants to ensure that he tags giving consistent labels to his
> intermediate builds. e.g. as in:
> 
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-CONVENTION-BASED-LABELING

That already requires using additional interface to git alone. Using an alias
for creating tags that are synchronized with that local bug-tracker is not
that much more complex than IMHO. Besides you will sometimes want to use git
tags, branches, commits and other things *without* synchronizing them to the
local bug-tracker even if you usually synchronize -- they are often very
useful for manipulating changes.

> Or he may want to have Git force him to also supply a log message along
> with a tag, so that he can remember later more accurately why a tag was
> created and what it really captures. Even if Git (or other SCM systems)
> don't natively support log messages on tags. Scmbug plans to implement
> this.
> 
> http://bugzilla.mkgnu.net/show_bug.cgi?id=219

Git does support log messages on tags. It has unannotated tags (which are
just refs) and annotated tags which have a special tag object with the log
message (and optionally PGP signature).

> (2) I would like to apply various verification policies when work from a
> local repository is finally merged with the central repository. I assume
> there can/will be a central repository, and there is one "software
> product" that is being released somewhere among the many copies.
> 
> When its time to merge local changes to a central repository, the
> verification policies may deem that changes are not acceptable to be
> merged with the mainline. e.g. because log messages are too short,
> commits during the merge are issued against bugs in "a central"
> bugtracker that are either closed, assigned to someone else, or just
> plain wrong bug-numbers that belong to other products:
> 
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-LOG-MESSAGE-SIZE
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-OPEN-BUG-STATE
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-BUG-OWNER
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-PRODUCT-NAME
> 
> (I'm not very clear whether this is how Git works)
> 
> Does someone get to write-up a brand new log comment during the merge
> and the merge totally disregards older log comments? My understanding
> is that log comments on the local copy are preserved (and will need to
> be mapped to bug-numbers in the central bug-tracker. 

Indeed, the locally made commits are transfered to the upstream repository as
they are. In fact, because the commit id is a SHA1 checksum of all it's
content, including the message and the parent ids (and therefore complete
history), when the commit message is changed, it is no longer the same
commit.

However, git provides many tools (commit --amend, rebase -i, filter-branch)
and has additional extensions (stgit, topgit), that make it easy to create
a new commit based on another one with some change. This is extremely useful
and many people use it really often.

Such new commit will not replace the previous one -- it has different
checksum -- so it's not good thing to do when other people already based
further changes on your commit. But it's very useful for handling work in
progress, quickly diverting to different tasks, making experiments and such.

Therefore it's the push that casts things in stone, but before that you can
easily take back and redo both commits and tags. Additionally it's very
useful to sometimes do commits and tags that you intend to replace later just
to temporarily record some interesting state eg. to divert to other bug that
suddenly got higher priority or to try out different approach.

Thus you only want to run the checks as warnings locally and probably want to
have an option to avoid them in a particular case for performance reasons
(all this stuff is so useful because it's fast). And since the tags that are
ment for publication you will usually pull shortly after making them and
because creating a tag is rather simple, I would say that running the check
on push is sufficient there and the alias helps if you'd really want to run
the check earlier. For commits you can of course use the pre-commit and
post-commit hooks.

> [...]
> The local tag is useful to the local user and his local bug-tracker. He
> can have tag operations intercepted so that the tag names show up as
> versions in his bug-tracker. In this way he can keep track of which bugs
> still exist or have recently been introduced/discovered to his local
> copy, before he decides to publish his polished, final version:
> 
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#TAGS
> 
> And his "local bug-tracker" may be reachable on the web and useful by
> others that take a peek at the users progress (even fetching it with
> Git).

I would rather recommend having per-developer branches (you can actually have
branch hierarchies, so it's rather per-developer branch directories) on the
central repo, where the users would push their work they consider final
enough to show to anybody. Than you can have a "pending" (or "for review" or
both or whatever) state in the central bug-tracker for issues with fixes on
such developer branches. That saves the hassle of installing per-developer
trackers and gives developer more freedom to create temporary stuff locally.

That is not to say that your use case makes no sense. I am just trying to
suggest a workflow, that might fit better with the existing practices used
with git and maybe requiring less work to implement.

As for people replacing their local commits, this is common especially in
Linux (and Git) development model. For Linux patches need to be sent split
into logical steps to make it easier to review them, which is quite important
for a critical piece of code like kernel. But everybody will inevitably make
mistakes when implementing the changes; these mistakes must not appear in the
final submission though, because they would interfere with review. When
developing in Git, each commit will produce one patch in the submission, so
people go and redo their commits multiple times to make them as much readable
as possible and fix bugs they made earlier.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
