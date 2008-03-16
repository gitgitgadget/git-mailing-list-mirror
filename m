From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: Re: git-svn clone on a central server
Date: Sun, 16 Mar 2008 14:47:11 +0000
Message-ID: <frjbtf$rd0$1@ger.gmane.org>
References: <frh8k1$lc8$1@ger.gmane.org> <eaa105840803151645j5e8ec443v991b9117df343b8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 15:48:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JauAB-00079E-FC
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 15:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbYCPOrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 10:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbYCPOrd
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 10:47:33 -0400
Received: from main.gmane.org ([80.91.229.2]:58260 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbYCPOrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 10:47:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jau8w-0007Ns-M0
	for git@vger.kernel.org; Sun, 16 Mar 2008 14:47:22 +0000
Received: from 87-194-245-197.bethere.co.uk ([87.194.245.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Mar 2008 14:47:22 +0000
Received: from Bruno.Harbulot by 87-194-245-197.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Mar 2008 14:47:22 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87-194-245-197.bethere.co.uk
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <eaa105840803151645j5e8ec443v991b9117df343b8f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77364>

Peter Harris wrote:
> On Sat, Mar 15, 2008 at 3:38 PM, Bruno Harbulot
> <Bruno.Harbulot@manchester.ac.uk> wrote:
>>  I'm trying to follow example 3 of the git-svn manpage, since I'd like to
>>  keep a "central" clone of a subversion repository (and rebase it
>>  regularly) on a server and work on local git repositories based on that
>>  server's git repository.
> ...
>>  I get this error:
>>
>>  $ git-svn rebase
>>  fatal: ambiguous argument 'HEAD': unknown revision or path not in the
>>  working tree.
> 
> You have to git reset --hard <branch> to create 'master' based on a
> particular svn branch, or git-svn won't know what to rebase.
> 
> I sent a documentation patch to this list back in February, but it
> appears to have been dropped. I should probably re-send it...
> 
> http://article.gmane.org/gmane.comp.version-control.git/72954

Thank you. This works. 'git reset --hard' was the key.

I've also managed to get it to work without '-s' (for just a 
sub-directory of the trunk) this way:
   ssh server "cd /pub && git svn clone -s 
http://svn.foo.org/project/trunk/subproject"
   mkdir subproject
   cd subproject
   git init
   git remote add origin server:/pub/subproject
   git config --add remote.origin.fetch +refs/remotes/*:refs/remotes/*
   git fetch
   git svn init http://svn.foo.org/project/trunk/subproject
# The following line creates a master branch
   git reset --hard origin/master
   git svn rebase


The way I'm planning to use this is to create a "central" bare 
repository on the server (by moving the '.git' directory and setting 
bare=true in the config file) that I would like to keep in sync with the 
original SVN repository (and also push by own branches).
I'd like then to pull these changes to my working copies of that central 
repository. I'm not quite sure how to update this central bare git 
repository (and then its clones) with the changes in the SVN repository 
upstream. (By the way, I'm not planning to 'dcommit' anything directly, 
just reading from this SVN.) Are there any recommendation on how to 
achieve this?


Best wishes,


Bruno.
