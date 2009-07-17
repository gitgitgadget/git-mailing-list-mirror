From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: pushing specific branches to a public mirror repos
Date: Fri, 17 Jul 2009 10:30:26 +0200
Message-ID: <h3pcrg$ekk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 10:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRiqN-00032A-ME
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 10:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934230AbZGQIa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 04:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934219AbZGQIa4
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 04:30:56 -0400
Received: from main.gmane.org ([80.91.229.2]:39005 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934179AbZGQIaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 04:30:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MRiqE-0003HN-FE
	for git@vger.kernel.org; Fri, 17 Jul 2009 08:30:54 +0000
Received: from 41.177.101.200 ([41.177.101.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 08:30:54 +0000
Received: from graemeg by 41.177.101.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 08:30:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.101.200
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123449>

Hi,

I cloned a SubVersion repository and am maintaining a Git mirror of it 
on GitHub. Here is an example of some of the SubVersion branches that 
got cloned.

refs/remotes/cleanroom
refs/remotes/fixes_2_0
refs/remotes/fixes_2_2
refs/remotes/fixes_2_2_0_dos
refs/remotes/florian
refs/remotes/fpc_2_3
refs/remotes/generics
refs/remotes/genfunc
refs/remotes/trunk
...

By default 'git svn' created a "master" branch which tracks 
"remotes/trunk". This is currently the only branch available on GitHub 
mirror repository and I push it as follows:

On our server which manages the subversion -> local git repos -> github 
sync process.

  $ cd /path/to/repository/
  $ git svn fetch
  $ git push github master

This works fine. Now I don't have any other local branches or any local 
modifications (I used to have, but reverted all of them) so now a 'git 
svn fetch' does clean fast-forward merges without problems.

I currently have the following git config setting for the remote github 
repository:

[remote "github"]
	url = git@github.com:graemeg/freepascal.git
	push = +refs/remotes/*:refs/heads/*

As far as I understand, if I do 'git push github', it is going to push 
all the SubVersion branches (as listed above) as heads to GitHub - but 
this is not what I want. Many of those branches in SubVersion are old, 
outdated or private development areas.

I only want to push the "trunk" and "fixes_2_2" SubVersion branches to 
GitHub as heads. How must I change by remote.github.push config setting, 
or must I do a manual push as I do with the local tracking "master" branch.

In summary:
  * Can I change remote.github.push so that if I run 'git push github'
    that it will ONLY push remotes/trunk and remotes/fixes_2_2 to
    GitHub mirror

  * or must I manually push those two to GitHub mirror as follows
     once off create a tracking branch:
       $ git branch --track fixes_2_2 remotes/fixes_2_2

     then hourly do the following:
       $ cd /path/to/repository/
       $ git svn fetch
       $ git push github master
       $ git push github fixes_2_2



Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
