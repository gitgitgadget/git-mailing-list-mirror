From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: git gc == git garbage-create from removed branch
Date: Thu,  3 May 2012 20:38:42 +0200 (CEST)
Message-ID: <hbf.20120503q14w@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 21:01:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ1Hf-0007ZQ-SU
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 21:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621Ab2ECTBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 15:01:43 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:58402 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784Ab2ECTBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 15:01:42 -0400
X-Greylist: delayed 1377 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2012 15:01:42 EDT
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1SQ0vM-0002kr-Gw
	for git@vger.kernel.org; Thu, 03 May 2012 20:38:44 +0200
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx1.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1SQ0vM-0005ZJ-4F
	for git@vger.kernel.org; Thu, 03 May 2012 20:38:44 +0200
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 94DC5A59; Thu,  3 May 2012 20:38:42 +0200 (CEST)
X-UiO-Ratelimit-Test: rcpts/h 1 msgs/h 1 sum rcpts/h 10 sum msgs/h 2 total rcpts 2382 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 4A7E2F8AA74C13E71014CE2225666E4AAC9DA43A
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 1038 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196941>

After removing a branch, 'git gc' explodes all objects
which were only in that branch.  Git filled up my disk that
way when I had cherry-picked from a big remote repo and then
did git remote rm.  Tested with Git 1.7.10.1 and 1.7.1.

$ git clone --bare --branch linux-overhaul-20010122 \
	git://git.savannah.gnu.org/config.git
...
Receiving objects: 100% (3263/3263), 517.15 KiB | 295 KiB/s, done.
...
$ cd config.git/
$ git tag -d `git tag`
...
$ git branch -D master
$ git gc
Counting objects: 1183, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (751/751), done.
Writing objects: 100% (1183/1183), done.
Total 1183 (delta 457), reused 1113 (delta 393)

$ find objects/?? -type f -print | wc -l
2080

$ git reflog expire --expire=now; git gc --prune=now
Counting objects: 1183, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (687/687), done.
Writing objects: 100% (1183/1183), done.
Total 1183 (delta 457), reused 1183 (delta 457)

$ ls objects/
info/  pack/

3263 fetched objects == 2080 loose objects before prune +
HEAD's 1183 objects.

-- 
Hallvard
