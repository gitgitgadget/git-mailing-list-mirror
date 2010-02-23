From: Daniele Segato <daniele.bilug@gmail.com>
Subject: [Git-SVN] Manage merges bewteen remote branches. git-svn or svn?
Date: Tue, 23 Feb 2010 12:58:31 +0100
Message-ID: <9accb4401002230358k669937fai400890658b14c4fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:00:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjtRQ-0007d6-Ni
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 13:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab0BWL6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 06:58:34 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:32942 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0BWL6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 06:58:33 -0500
Received: by bwz1 with SMTP id 1so860529bwz.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 03:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=TF0Uc+WTuU14hwDMm+uWwFvBazB6/TOs58CzW0ylEL0=;
        b=qO7c1N9A+6awWAMvoAhvL5rZ/20tzrROTHglzCl+G83/hSHlae6nDE+pnL3jDXfi6B
         4lejCj2wS8oilGz51vCkPOyjI463zCZKP3Cd9PcKTOHqadgix+Zj7fJ8RV8Huh3Go2Ft
         WxQsRnY1ZO0Z0nVVyV6ax+4cyqwsGNXrD3ukc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=EISixZyMkOZsR2hj1o0dwTfMVqDZ/otlCtmxWxYYd8nTxJgSOEExKGwXTr2wGsBV9G
         mCXfdBMvlumhBj5vjS5K2Y3jPVZDd3TdXjG6lhzTG66seOv5D+0KjzJZgnWQmSCsFCi7
         9F1/6NTjGb30DVgDDI4bDQc4JVZgQlIwvCywc=
Received: by 10.204.133.27 with SMTP id d27mr2832838bkt.51.1266926311605; Tue, 
	23 Feb 2010 03:58:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140789>

I'm trying to understand the best way to deal with remote branches
merging in git-svn.

This is the situation (more or less) that I had to manage:

master: tracking remote svn trunk
v1.x: tracking remote svn branches/v1.x

at the moment v1.x just branched from trunk

master
    |
    |
    |
    |   v1.x
    |  /
    | /
    |/
branch point


now i should start to merge into v1.x the work from trunk/master.
some of the last commit on master will be left there for later merging.

so i branched from master~10 (example) and cherry-picket the commit i
want to put into


I see three root from now on and no one i really like:
1.
git checkout v1.x
git merge --squash myTemporaryBranch

this way it's ok the first time but i'll have a lot of conflict later
when i will do (again):
git merge --squash master


2.
git checkout v1.x
# this will not work because of the svnid:
#git rebase myTemporaryBranch

so I did:
for commit in `git rev-list --reverse --cherry-pick
v1.x..myTemporaryBranch`; do
    git cherry-pick-svn $commit;
done;

the cherry-pick-svn is an alias i defined myself like this:
cherry-pick-svn =  !GIT_EDITOR='sed -i /^git-svn-id:/d' git cherry-pick -e

it just strip out the git-svn-id line from the commit comment.

this way i have all the history but i think i'll have conflict any
way, can you confirm?
furthermore it will take a lot of space into the SVN server.

3.
use svn directly.
never did an svn merge with svn so I still don't know exactly how it work
may be someone of you can tell me if this could work or not. this way
I should always do my mergings with subversion directly



What would you do?
thanks and regards,
Daniele Segato
