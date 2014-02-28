From: Stephen Leake <stephen_leake@stephe-leake.org>
Subject: git reset <path> returns unwanted failure status
Date: Fri, 28 Feb 2014 10:40:15 -0600
Message-ID: <85wqgfxkb4.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 17:40:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJQU5-00041s-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 17:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbaB1QkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 11:40:20 -0500
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:20207 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752959AbaB1QkT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 11:40:19 -0500
Received: from [75.87.81.6] ([75.87.81.6:54045] helo=TAKVER)
	by cdptpa-oedge01 (envelope-from <stephen_leake@stephe-leake.org>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id 39/64-10928-1FBB0135; Fri, 28 Feb 2014 16:40:18 +0000
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (windows-nt)
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242986>

The use case:

I'm doing a 'git stash pop'; it had conflicts. At this point, 'git status' shows:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   Target.java
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#	both modified:      DriveByInches.java
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   CommandBasedAutonomous.java
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	AerialAssist2014/src/org/usfirst/frc1939/AerialAssist2014/Autonomous/

As part of the conflict resolution, I decide to unstage Target.java:

stephe@takver$ git reset Target.java
Unstaged changes after reset:
M	CommandBasedAutonomous.java
U	DriveByInches.java
M	Target.java
stephe@takver$ echo $?
1


The issue is the error status and the messages about other files.

If I had not specified a path to 'git reset', the error status would
make sense; those files were not reset. However, since the file I
specified was reset, there should be no error.

Similarly, if I specify no path to a git command, I expect warning
messages about files in the workspace that might need attention.
However, if I do specify a path, I expect warning messages about files
in that path only.

This can be stated more concisely if the default path is considered to be
"*" (and recursive); don't error if the operation succeeded for all
files in the path; don't warn about files not in the path.

-- 
-- Stephe
