From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Coming clean, after being stupid and ugly (or: globs and filtering
 with git-svn)
Date: Mon, 23 Jun 2008 15:17:47 +0200
Message-ID: <g3o7ps$32h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 15:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAlwe-0004Y6-W4
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 15:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYFWNR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 09:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYFWNR7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 09:17:59 -0400
Received: from main.gmane.org ([80.91.229.2]:39058 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbYFWNR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 09:17:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KAlvg-0003bY-9P
	for git@vger.kernel.org; Mon, 23 Jun 2008 13:17:56 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 13:17:56 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 13:17:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85861>

Hi there,

I've been a sinner regarding good repo structures: I lumped a lot of 
stuff into one SVN repo. I blame SVN's clumsy admin commands and URLs 
for that, of course... Along with my transition to git I want to change 
this structure.

At the root of my SVN repo I have directories trunk/A, trunk/B and 
trunk/C, say; similarly for branches/*/A etc.

I know how to "git-svn clone -s" the tree under A so that it becomes an 
independent git repository (using "branches = 
branches/*/A:refs/remotes/*" etc., i.e: git-svn init, edit config, 
git-svn fetch).

But I want the trees under B and C to end up in the same git repository 
(under B and C, of course). I could convert the whole SVN repo and 
remove A afterwards using git-filter-branch, but this changes commit IDs 
and leaves spurious branches, tags and commits which touch the tree 
below A only, and would need to be removed also.

Is there any way to tell git-svn to do the filtering? It does some sort 
of filtering already (evaluating the fetch, branches and tags glob 
patterns). I would need something like

branches/*/{B,C}:refs/remotes/*

or

branches/*/{B,C}:refs/remotes/*/\1

to mean: treat only the trees below branches/something/B and 
branches/something/C and put them into subdirs B resp. C of the same git 
repo in branch something, for each something there is.

Alternatively: Where in git-svn should I look if I wanted to implement 
something like that?

Cheers,
Michael

P.S.: Actually, the tree below A will end up in a tree of smaller repos, 
and in my case I have more than just B and C which should end up in the 
same repo. The description above is a minimal case.
