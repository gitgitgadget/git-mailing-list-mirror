From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 15:53:07 +0000 (UTC)
Message-ID: <loom.20111013T171530-970@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org>  <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>  <20111013145924.2113c142@ashu.dyn.rarus.ru>  <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>  <loom.20111013T152144-60@post.gmane.org> <1318517194.4646.30.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 17:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RENb8-0001mH-F9
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 17:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab1JMPxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 11:53:25 -0400
Received: from lo.gmane.org ([80.91.229.12]:46644 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676Ab1JMPxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 11:53:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RENay-0001fr-S2
	for git@vger.kernel.org; Thu, 13 Oct 2011 17:53:20 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 17:53:20 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 17:53:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183491>

Carlos Mart=C3=ADn Nieto <cmn <at> elego.de> writes:
> I have not seen a revert command in any of your messages. If a revert=
 on
> one branch changes another one, that would be a bug, but you haven't
> shown this to happen.

Sorry, it was in prose in the original post (near the end)
"At this point, reverting the master with "checkout --" also wipes out =
the
changes on the other branch. It's like the merge symlinked the two bran=
ches
rather than, well, merging them."

Based on the explanations here, and the git *st* message, it wiping out=
 the
other branch is to be expected, because it's "the working directory", n=
ot
"the branch".

>git st
# On branch foo
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   file1.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

What makes this really interesting though is this: I tried to switch to
master to see if that gave the same warning, and NOW, I get the correct
error.

>git co master
error: Your local changes to the following files would be overwritten b=
y
checkout:
        file1.txt
Please, commit your changes or stash them before you can switch branche=
s.
Aborting

I'm sure if I thought about it enough (ie re-read Andreas's post a coup=
le
more times) I'd be able to understand why git gets it right sometimes b=
ut
not other times, but I'm too tired right now. Even when I *am* awake an=
d
grok it properly, I'm still going to be annoyed that it's so inconsiste=
nt,
but I can live with that if I have to.

> The reason this happens both in svn and git is that the most likely
> cause for someone to change a branch mid-edit is that they decide
> they're doing the changes on the wrong branch.

Lucky you. :P  The most likely reason for me is, I'm working on somethi=
ng
and I get interrupted and have to switch. Since the code may well not e=
ven
compile at this point, the last thing I want to do is commit it. git's
ability for that commit to be local is half the reason I'm trying to sw=
itch
to it. (I'm not particularly keen on having to commit broken code to ev=
en a
local repo, but that's still a hell of a lot better than having it push=
ed
upstream as well).

> svn doesn't tell you about the modifications being carried over
> (presumably you're meant to use status and diff to figure out what's
> going on). Therefore, the same workflow (with the only difference bei=
ng
> how to create and switch branches) works for svn and git in this case=
=2E

I expect part of my confusion comes from using different workdirs for s=
vn
branches, ie "clone" rather than "branch", because branching in svn is =
such
a PITA I just don't bother with it unless the branch is going to be
"heavyweight" enough to warrant a "proper" branch.
Good to be reminded of though, thanks.
