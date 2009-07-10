From: Esben Skovenborg <esskov@oncable.dk>
Subject: Re: git-svn is "Unable to determine upstream SVN information..."
Date: Fri, 10 Jul 2009 13:15:14 +0200
Message-ID: <5m5e55538tlnq40rup7rci61i2mg16q0dv@4ax.com>
References: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com> <20090710033133.GA23082@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 13:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPE4o-00062S-1b
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 13:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbZGJLPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 07:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbZGJLPP
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 07:15:15 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:39091 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751078AbZGJLPN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 07:15:13 -0400
Received: from 56344c10.rev.stofanet.dk ([86.52.76.16] helo=eclipse2)
	by mx04.stofanet.dk (envelope-from
	<esskov@oncable.dk>)
	with esmtpa id 1MPE4M-0000NZ-0h; Fri, 10 Jul 2009 13:15:10 +0200
In-Reply-To: <20090710033133.GA23082@dcvr.yhbt.net>
X-Mailer: Forte Agent 4.2/32.1118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123049>


Thanks for your quick reply! Let me go through your check-list...

On Thu, 9 Jul 2009 20:31:33 -0700, Eric Wong wrote:
>esskov@oncable.dk wrote:
>> I'm trying to clone the trunk of an svn repo, so that I can work on a set
>> of patches locally, and then occasionally push some of them back to svn.
>> 
>> The git-svn clone seems to go well, and the resulting git log looks
>> alright. However, git-svn info and git-svn rebase both say "Unable to
>> determine upstream SVN information from working tree history".
>> Also, git-svn log shows nothing.  I'm using the svn:// protocol btw, but I
>> guess the protocol shouldn't matter?
>
>Protocol shouldn't matter.  Do you have any non-linear history from
>merges in git?  git-svn (and SVN) doesn't play very nicely with
>non-linear history that git merges can generate.
>
>Does having a clean clone of that repo fix things?  You didn't use
>--no-metadata or blow away your .git/svn/* directories, did you?

I do get the problem with a clean clone, and I don't see any difference
between the structure of the .git/svn/* of the problematic repo and of the
working test-repo.

The problem can be reproduced as simple as this:
$ git svn init svn://svn.xxx.xxx/xxx/trunk
$ git svn fetch -r BASE:10
$ git branch -a
	* master
	  remotes/git-svn
$ git svn info 
	Unable to determine upstream SVN information from working tree
history
$ git log
	each commit shows line like: "a git-svn-id:
svn://svn.xxx.xxx/xxx/trunk@1-10 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

These 10 revisions only consist of file insertions and deletions in the
trunk.

>> To test if this was a general problem, I just tried to git-svn clone a
>> repo on some public svn server which was also using the svn protocol. I
>> used exactly the same syntax for the svn init and fetch commands. However,
>> the resulting git repo did NOT suffer from the problem, i.e., git-svn info
>> reported nicely etc.
>> 
>> At some point I suspected that there might be a problem with the
>> "git-svn-id ..." lines in the commits for the problematic repo, but they
>> look just like the ones for the working repo. The .git/config files of the
>> working and the non-working git-repos are similar as well. 
>> 
>> What could be causing this problem?
>
>Which version of git svn is this?  

I see the problem with both git version 1.6.3.2.1299.gee46c (msysgit) and
git version 1.6.3.3.412.gf581d (Ubuntu). The latter contains your fix for
that other problem I encountered :)

>Are there any weird characters in the URL?  

No. The only thing 'different' about this svn server is that it uses
authentication (i.e. asks for name+password). But I suppose that when the
git-svn fetch goes well, then this is not the problem?  Do the git-svn
info and git-svn rebase even need to access the svn server?

>Off the top of my head I can't think of anything else; I assume
>you're not allowed to share access to the repo (or to the clone) you're
>having problems with?

Right, at least it's something we should talk about off-list.

Is there any way of asking git-svn *why* it is "unable to determine
upstream SVN information from working tree history" ?


Cheers,

	Esben
