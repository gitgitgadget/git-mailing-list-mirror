From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Fri, 14 Oct 2011 11:54:47 +0200
Message-ID: <20111014095447.GC2856@victor.terreactive.ch>
References: <4E96D819.20905@op5.se>
 <loom.20111013T152144-60@post.gmane.org>
 <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
 <loom.20111013T171530-970@post.gmane.org>
 <1318525486.4646.53.camel@centaur.lab.cmartin.tk>
 <loom.20111013T193054-868@post.gmane.org>
 <7vzkh44ug1.fsf@alter.siamese.dyndns.org>
 <loom.20111013T203610-130@post.gmane.org>
 <20111014013830.GA7258@sigill.intra.peff.net>
 <4E980093.6040704@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, arQon <arqon@gmx.com>,
	git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Oct 14 11:55:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REeTn-0000XJ-Lg
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 11:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660Ab1JNJy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 05:54:57 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:50007 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab1JNJy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 05:54:56 -0400
Mail-Followup-To: Holger Hellmuth <hellmuth@ira.uka.de>,
	Jeff King <peff@peff.net>, arQon <arqon@gmx.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4E980093.6040704@ira.uka.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183562>

On Fri, Oct 14, 2011 at 11:27:47AM +0200, Holger Hellmuth wrote:
> On 14.10.2011 03:38, Jeff King wrote:
> >On Thu, Oct 13, 2011 at 06:56:14PM +0000, arQon wrote:
> >
> >>I'll give a shot, though I don't know how good it'll be. Off the top of my
> >>head, I don't see any good way to explain the inconsistency with LOCAL CHANGES
> >>sometimes preventing switches and sometimes not, based on what is to the user
> >>an arbitrary set of rules that has nothing to do with the *current state* of
> >>the worktree, but rather the state of those files in prior commits.
> >
> >The rules are fairly straightforward.
> 
> They are. But what arQon is getting at is that the normal
> switchability depends on something that is often a game of chance:
> Did I change a file that is different between the two branches? That
> is only known by the user for branches not far removed.
> 
> Now the obvious answer is: It doesn't matter because git tells you.
> At the right time to act upon it. But git says "M file" instead of
> what 'git status' would say: "#  modified:   file". Is there a
> reason for that? On one hand it should be familiar to svn users, on
> the other hand it is an inconsistency. And personally I always hated
> those cryptic status flags of svn
> 
> Another good point arQon made is that the case that you switched
> with forgotten local changes is more common than the case that you
> switched because you made changes in the wrong branch. If that were
> the case the warning that you have local changes should be more
> visible than that small "M file", at best something that looks
> similar to 'git status' output.

Very good point. How about by default just running `git status` after a
successful checkout, and only printing the result if there are any
changes? That way:
1) If no changes are pending, nothing is displayed.
2) The user sees a *familiar* style output if anything changed.
3) If there's an alias for "status", it would be used.

Example:

$ mkdir /tmp/test
$ cd /tmp/test
$ git init
Initialized empty Git repository in /tmp/test/.git/
$ echo foo > foo
$ echo bar > bar
$ git add foo bar
$ git commit -m "Initial commit"
[master (root-commit) 55246c6] Initial commit
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 bar
 create mode 100644 foo
$ echo foobar > bar
$ git branch --track test
Branch test set up to track local branch master.
$ git checkout test
M   bar
Switched to branch 'test'

After `git checkout test`, we should instead see:
# On branch test
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#   modified:   bar
#
no changes added to commit (use "git add" and/or "git commit -a")

2c,
V

-- 
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
