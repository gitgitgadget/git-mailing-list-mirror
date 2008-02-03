From: Wink Saville <wink@saville.com>
Subject: Re: git-svn segmetation fault
Date: Sun, 03 Feb 2008 13:42:31 -0800
Message-ID: <47A63547.9080801@saville.com>
References: <47A39DFD.9020905@saville.com> <47A3BE6F.6080304@saville.com> <20080202034258.GA27814@dervierte> <47A3E9A8.1060102@saville.com> <20080202160332.GA25945@dervierte> <47A4BCE8.5030308@saville.com> <20080202210348.GA11722@dervierte> <47A51737.7050905@saville.com> <20080203024225.GA23647@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 22:43:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLmcI-0007CY-6f
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 22:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbYBCVmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 16:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYBCVmh
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 16:42:37 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:1533 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYBCVmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 16:42:35 -0500
Received: by an-out-0708.google.com with SMTP id d31so458202and.103
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 13:42:34 -0800 (PST)
Received: by 10.100.123.4 with SMTP id v4mr13454945anc.14.1202074953961;
        Sun, 03 Feb 2008 13:42:33 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id q26sm13553684ele.6.2008.02.03.13.42.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Feb 2008 13:42:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080203024225.GA23647@dervierte>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72406>

Steven Walter wrote:
> On Sat, Feb 02, 2008 at 05:21:59PM -0800, Wink Saville wrote:
>   
>> What steps would be needed to recreate a "local git repo" from the
>> "git repo on srvr" that I could use against the svn repo?
>>
>> I tried a little test, I cloned my git repo on srvr locally to amc-xx
>> and added the [svn-remote "svn"] section to amc-xx/.git/config
>> and then did a git-svn fetch. From what happened it looks like I
>> just did a git svn clone and didn't save any time.
>>     
>
> After adding the svn-remote section, you'll want to copy
> .git/refs/remotes/origin/master to .git/refs/remotes/git-svn.  After
> doing that, "git svn fetch" should see that you have all the needed
> commits and do a quick rebuild of its metadata.
>
>   
>> Also, a follow up can I create an svn repo from a git repo.
>>     
>
> I've not done it, but it should be possible.  You would create the new
> svn repository with a single empty commit (as empty as SVN would allow).
> Import that revision into your git repository with git-svn.  Then you
> would either rebase or use grafts to make all of your git commits a
> descendent of that single svn commit.  In that way, the next time you
> run "git svn dcommit" it will see all your local git commits as new
> commits to send to subversion.
>
> No guarantees though, as I've not tried it.
>   
Steve,

That worked thanks, I did make some minor adjustments as when
I recloned I used the "-s" switch because my svn repo was in standard
format so rather than copying master to .git/refs/remotes/git-svn I copied
it to .git/refs/remotes/trunk. I also used git svn init to create the 
remotes
section instead of editing .git/config directly. So the following worked
for me:

lcl ~/ $ git clone git://srv/amc.git amc
lcl ~/ $ cd amc
lcl ~/amc $ git svn init -s http://async-msgcomp.googlecode.com/svn
lcl ~/amc $ rm -rf .git/svn
lcl ~/amc $ cp .git/refs/remotes/origin/master .git/refs/remotes/trunk
lcl ~/amc $ git svn fetch


It would seem creating a "git svn connect" command which did the above
might be nice. I took a quick look at git-svn and decided that since I 
don't know
perl and git-svn was almost 5000 LOC it would be dangerous for me to try
to make the change:)

Thanks for all of your help.

Wink
