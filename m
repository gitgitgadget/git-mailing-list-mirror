From: Maaartin <grajcar1@seznam.cz>
Subject: Commiting automatically (2)
Date: Sun, 19 Dec 2010 08:29:50 +0000 (UTC)
Message-ID: <loom.20101219T090500-396@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 19 09:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUEew-0002Aa-5i
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 09:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab0LSIaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 03:30:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:55851 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab0LSIaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 03:30:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PUEeX-0001zW-QT
	for git@vger.kernel.org; Sun, 19 Dec 2010 09:30:02 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 09:30:01 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 09:30:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163953>

Some time ago I asked how to make a commit of the working tree in a way 
influencing neither the current branch nor the index:
http://comments.gmane.org/gmane.comp.version-control.git/157056
I'm going to use it for taking a snapshot of the current working tree without 
disturbing my work. It seem to work except for one thing:

There are files tracked by git and later added to .gitignore. AFAIK listing 
them in .gitignore is a no-op, since I haven't removed them from the index. 
Until now I haven't known about them at all, I'm currently undecided what to do 
to them.

However, when I use my git-autocom script, those files get marked as deleted. 
This is quite strange, especially because of them still existing. I'd strongly 
prefer git-autocom to behave just like git commit (i.e., tracking the files).

The relevant part of my script follows:

export GIT_INDEX_FILE=.git/autocom.tmp
git add -A &&
tree=$(git write-tree) &&
commit=$(echo "$message" | git commit-tree $tree $parent1 $parent2) &&
git update-ref -m "$message" refs/heads/autocom $commit

I'd say using another index is the reason for this behavior. The index gets 
created on the first use, which is probably why those files look like being 
deleted. Should I always
/bin/cp .git/index $GIT_INDEX_FILE
or is there a better way?

There's one more problem. My script doesn't recognize deleted files, since
git add -A
does nothing to them. I'm quite sure I saw a solution to this, but can't find 
it now...
