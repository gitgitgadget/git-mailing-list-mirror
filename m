From: Madhu <enometh@meer.net>
Subject: git-rebase --continue eats commits
Date: Sat, 31 Aug 2013 20:56:06 +0530 (IST)
Message-ID: <20130831.205606.373615550.enometh@meer.net>
References: <20100626125924.160F11F212@leonis4.robolove.meer.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 17:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFnXg-0004nX-T8
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 17:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab3HaP4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 11:56:49 -0400
Received: from vps4.hungerhost.com ([199.167.40.167]:59388 "EHLO
	vps4.hungerhost.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755812Ab3HaP4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 11:56:48 -0400
X-Greylist: delayed 1832 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2013 11:56:48 EDT
Received: from [59.92.79.28] (port=44315 helo=localhost)
	by vps4.hungerhost.com with esmtpsa (SSLv3:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <enometh@meer.net>)
	id 1VFn40-00069e-6g
	for git@vger.kernel.org; Sat, 31 Aug 2013 11:26:13 -0400
X-Mailer: Mew version 6.5 on Emacs 24.3.50 / Mule 6.0 (HANACHIRUSATO)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps4.hungerhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - meer.net
X-Get-Message-Sender-Via: vps4.hungerhost.com: authenticated_id: enometh@secure.meer.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233519>


Don't know if this has been resolved-by-debate here before, But if
`git-rebase' finds a hitherto untracked file in the worktree, which it
wants to create, it then aborts asking you to remove the file.  So if
you remove it and ask git to continue with `git-rebase --continue', it
then deletes the commit that was being applied from the branch. ---Madhu


(setenv "TDIR" "/dev/shm/foo/")

mkdir -pv $TDIR && cd $TDIR && git-init
(cd $TDIR && echo a > a && git add a && git commit -m "a")
(cd $TDIR && echo b > b && git add b && git commit -m "b")
(cd $TDIR && echo c > c && git add c && git commit -m "c")
(cd $TDIR && EDITOR="sed -i -e 's/^pick/edit/'" git rebase -i 'HEAD^^')
(cd $TDIR && echo fubar > c)
(cd $TDIR && git-rebase --continue)

    Rebasing (2/2)
error: The following untracked working tree files would be overwritten by merge:
	c
    Please move or remove them before you can merge.
    Aborting
    Could not apply ddd6f51...

(cd $TDIR && rm -fv c)
(cd $TDIR && git-rebase --continue)

    Rebasing (2/2)
Successfully rebased and updated refs/heads/master.

(cd $TDIR && git log)

;; commit `c' is gone
