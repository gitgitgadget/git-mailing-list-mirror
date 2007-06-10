From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn set-tree bug
Date: Sun, 10 Jun 2007 16:37:25 -0700
Message-ID: <466C8B35.3020207@midwinter.com>
References: <002a01c7abb6$de2b3680$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'Eric Wong' <normalperson@yhbt.net>, 'git' <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Mon Jun 11 01:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxWya-0006FA-2P
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 01:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbXFJXha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 19:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756644AbXFJXha
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 19:37:30 -0400
Received: from tater.midwinter.com ([216.32.86.90]:41564 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755335AbXFJXh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 19:37:29 -0400
Received: (qmail 23948 invoked from network); 10 Jun 2007 23:37:29 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=a3LUP7BtqyksEGzn+8dG2B6xK1Mnxg/67JOEDALusdx4+Tb+fnl3Buo18ZWcBjM1  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 10 Jun 2007 23:37:29 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <002a01c7abb6$de2b3680$0e67a8c0@Jocke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49793>

Joakim Tjernlund wrote:
> Is there a way to tell set-tree to commit the whole "merge" branch
> as one svn commit?
> If I merge the latest kernel into my tree there will
> be a lot of commits that I don't want in svn.
>   

You want a "squash" merge. Something like this:

git checkout -b tempbranch origin/svn-branch-to-commit-merge-to
git merge --squash branch-with-commits-you-want-to-merge
git commit
git svn dcommit

The "merge" command will merge in the changes but will not commit 
anything; when you do the explicit "commit" command afterwards, you get 
the contents of the merge but from git's point of view it's just a 
regular commit so git-svn doesn't get confused.

After you do git svn dcommit, you may want to edit .git/info/grafts to 
tell git after the fact that this commit was a merge. It won't hurt 
git-svn at that point and it will mean you can do another merge later 
without git getting confused about what has already been merged.

Take a look at the script I posted a while back, which does something 
similar:

http://www.spinics.net/lists/git/msg29119.html

-Steve
