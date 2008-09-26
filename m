From: "Craig Tataryn" <craiger@tataryn.net>
Subject: Help with merge and git-svn
Date: Fri, 26 Sep 2008 11:36:48 -0500
Message-ID: <8384c2b90809260936m21c14e0dve5b08b021da4a342@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 18:45:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjGRR-0006zO-E5
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 18:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYIZQgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 12:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbYIZQgu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 12:36:50 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54928 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbYIZQgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 12:36:49 -0400
Received: by gxk9 with SMTP id 9so8510586gxk.13
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 09:36:48 -0700 (PDT)
Received: by 10.100.210.9 with SMTP id i9mr1445811ang.9.1222447008183;
        Fri, 26 Sep 2008 09:36:48 -0700 (PDT)
Received: by 10.100.209.12 with HTTP; Fri, 26 Sep 2008 09:36:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96877>

Hi, first time poster to kernel.org mailing lists, so if I commit a
taboo, please be kind to me :)

I have the following scenario:

[remote deveoper]<===>[shared git repo]<===>[me]<===>[client's svn repo]

So my remote developer and I push and pull to/from the shared git
repo, and then I sync changes to and from the client's svn repo using
git-svn.

My problem is, when I am ready to merge changes from my local master
branch to trunk-local, if I do a "git merge master" and then try to
issue any git-svn commands I get the following errors:
======================
$ git merge master
Updating d88106e..77b86ae
Fast forward
 community/pom.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

$ git svn dcommit
Can't call method "full_url" on an undefined value at
/usr/local/git/libexec/git-core/git-svn line 425.

$ git svn rebase
Unable to determine upstream SVN information from working tree history
======================

The only way I've seem to be able to remedy this is if I add the
"subtree" merge strategy to the merge command:

git merge -s subtree master

Then git-svn doesn't get confused about it's repo, but when you look
at the repo using gitk, you see something like:

[trunk-local]--[remotes/trunk]  Merge branch 'master' into trunk-local
| \
|  \
|    [master]--[remotes/origin/master]  "Some commit message from the
last master commit"
|    |
|    |
|  /
/

When I use the normal merge strategy then gitk shows all branches at
the same level, but git-svn is of course b0rked.

So I guess my question is, am I stuck using "-s subtree", is this the
right course of action??  Or can I get this to work with the default
strategy?  Is this symptomatic of a messed up or disjoint history
(i.e. early on I did some --squash merges).

I have full control over the shared repo and I don't mind blowing it
away and rebuilding it based on what's in SVN if that's what it takes.

Thanks!

Craig.

-- 
Craig Tataryn
site: http://www.basementcoders.com/
podcast:http://feeds.feedburner.com/TheBasementCoders
irc: ThaDon on freenode #basementcoders, ##wicket, #papernapkin
im: craiger316@hotmail.com, skype: craig.tataryn
