From: arQon <arqon@gmx.com>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 12:42:42 +0000 (UTC)
Message-ID: <loom.20111013T141239-151@post.gmane.org>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 14:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REKcq-0006t7-IX
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 14:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab1JMMm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 08:42:58 -0400
Received: from lo.gmane.org ([80.91.229.12]:50779 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab1JMMm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 08:42:58 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REKci-0006pJ-58
	for git@vger.kernel.org; Thu, 13 Oct 2011 14:42:56 +0200
Received: from 24-180-45-63.dhcp.crcy.nv.charter.com ([24.180.45.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 14:42:56 +0200
Received: from arqon by 24-180-45-63.dhcp.crcy.nv.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 14:42:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.180.45.63 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Ubuntu/10.04 (lucid) Firefox/3.6.23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183474>

Simple testcase:

>git init
Initialized empty Git repository in C:/git-test/.git/
>notepad file1
>notepad file2
>git st
 # On branch master
 # Initial commit
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #       file1.txt
 #       file2.txt
 nothing added to commit but untracked files present (use "git add" to track)

>git add .
>git st
 # On branch master
 # Initial commit
 # Changes to be committed:
 #       new file:   file1.txt
 #       new file:   file2.txt

>git commit -am "init"
  2 files changed, 2 insertions(+), 0 deletions(-)
  create mode 100644 file1.txt
  create mode 100644 file2.txt

>git co -b foo
 Switched to a new branch 'foo'
>notepad file1
(edit stuff)
>git st
 # On branch foo
 # Changes not staged for commit:
 #       modified:   file1.txt

>git co master
 M       file1.txt

file1 now has the wrong data in it for "master" branch.

If I go back to "foo" branch and commit the file before doing anything else,
it recovers, and changing branches works correctly again.

--

"If you have local modifications to one or more files that are different
between the current branch and the branch to which you are switching, the
command refuses to switch branches in order to preserve your modifications
in context."

Maybe I'm just missing something obvious, but at the time that last "git
co master" was issued:

The file is locally modified.
The file is different on the current branch (foo) than on the branch to which
I am switching (master).
The command fails to refuse to switch branches.

So I guess the problem is that since the file wasn't re-added after the edit,
git is ignoring it when trying to see if it's safe to branch or not?
