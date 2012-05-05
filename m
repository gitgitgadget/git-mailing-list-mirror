From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: recipe to use git for deployment
Date: Fri, 04 May 2012 22:51:21 -0500
Message-ID: <jo283q$kna$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 05:52:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQW2J-0007DP-AL
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 05:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759239Ab2EEDvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 23:51:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:35863 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759209Ab2EEDvf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 23:51:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SQW1r-0006wQ-PX
	for git@vger.kernel.org; Sat, 05 May 2012 05:51:31 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2012 05:51:31 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 May 2012 05:51:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197088>

I'm trying to cook up automated mass deployment using git as the main 
ingredient.  Here's a recipe idea:

install git on deployed server under the home dir of the 'gittech' user 
and add that path only to the PATH of 'gittech'.

have the git repos on deployed server be under the 'gittech' home dir 
with worktree(s) assigned to deployment locations.  If people mess with 
the worktrees I will be able to tell with git status via 'gittech'.

I can ssh to deployed servers from a deployment server and do git fetch 
to get updates.

I can have a 'deployment manager' repo which contains script to apply 
patches from remote tracking branch to worktree.  It checks out commits 
at waypoints and at waypoint it executes needed file/data conversion 
programs, creates dir/file structures, etc.  If conversion validation 
program is successful it will continue to checkout next waypoint, etc, 
until worktree matches HEAD of remote tracking branch.

Data/files are commited to data tracking git repo at waypoints.  If 
waypoint validation fails then software version repo and data version 
repo are checked out to last good waypoint or back to startpoint.

Problem(1): cron patches.  The cron jobs portion I'm not sure of.  Need 
to learn more about cron.  Perhaps cron can run scripts that are 
symlinks to a worktree.  Cron worktree can have waypoints just like 
software and data worktrees.  The cron tabs, cron.daily, etc can be 
worktrees perhaps also.

Problem(2a): diskspace.  I think I will have to pull shallow clones to 
avoid growing history.  For deployment I only care about recent 
revisions.  Not sure if the above ideas will work with shallow clone.

Problem(2b): network latency.  Maybe I can have the git repo object 
store on the deployment server and the deployed git repo reference it to 
save diskpace on the deployed server.  That would probably be really slow.

I'm thinking the ingredients of this recipe could make a tasty git 
deployment.  Maybe different ways of mixing and cooking them and other 
ingredients can make a good dish.  Please let me know if you think this 
can be edible for security, palatable for reliability, and digestible by 
git.

v/r,
neal
