From: kenneth johansson <ken@kenjo.org>
Subject: tracking repository
Date: Sat, 15 Mar 2008 19:35:12 +0000 (UTC)
Message-ID: <frh8dg$t9j$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 20:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JacAs-0003RY-Pd
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 20:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbYCOTf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 15:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYCOTf3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 15:35:29 -0400
Received: from main.gmane.org ([80.91.229.2]:53046 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbYCOTf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 15:35:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JacA6-0003dv-5k
	for git@vger.kernel.org; Sat, 15 Mar 2008 19:35:22 +0000
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 19:35:22 +0000
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Mar 2008 19:35:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77338>

I was trying to create a repository used only to track different linux git 
repositories. The goal with this was to maximize object sharing and having 
one local copy of the data. 

But I think I managed to paint myself into a corner. Here was my initial 
setup. 

create a directory 
"mkdir linux"

create a git data base
"cd linux; git --bare init"

Add a few linux repositories with
"git --bare remote add [name] [url]"

then download the objects/branches with
"git remote update"

This works great and it will track all changes in the remote repositories 
without me having to worry about it aborting due to merge issues with my 
local branch or remote  doing rebase on some branch.

The problem is that it is useless :( I can't find any way to use a 
repository with only remotes in it. Is there a way to make a clone of a 
remote branch in a repository ??

Now it is not entirely useless since I can reuse the objects downloaded by 
setting GIT_OBJECT_DIRECTORY. This works quite well until "git gc --prune" 
is used. I leave it up to the reader to figure out what happens then :(

So I guess there should be some warning about using GIT_OBJECT_DIRECTORY 
that points to the same object store for different repositories. It's 
obvious but still a warning in the man page could be helpful.

GIT_ALTERNATE_OBJECT_DIRECTORIES works much better. The only potential 
problem I see is if I set this is set in my environment when I login and 
then do operation on my tracking repository's it will now point into it's 
own object directory. I have not tried that yet.

The downside of only using the objects is that I need to setup the remotes 
again in my clone. 

Now has anybody tried to do something similar? is there a better way?
