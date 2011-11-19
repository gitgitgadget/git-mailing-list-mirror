From: Gerd Knops <gerti@bitart.com>
Subject: Possible bug with branch names and case sensitivity
Date: Sat, 19 Nov 2011 14:08:58 -0600
Message-ID: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 21:19:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRrNe-0005lw-MZ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab1KSUTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:19:14 -0500
Received: from mail.bitart.com ([75.146.45.42]:36410 "EHLO
	mail.summitsite.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab1KSUTO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2011 15:19:14 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Nov 2011 15:19:13 EST
Received: from localhost (localhost [127.0.0.1])
	by mail.summitsite.info (Postfix) with ESMTP id 45E6D22202CB
	for <git@vger.kernel.org>; Sat, 19 Nov 2011 14:08:27 -0600 (CST)
X-Virus-Scanned: Debian amavisd-new at localhost
Received: from mail.summitsite.info ([127.0.0.1])
	by localhost (summitsite.summitsite.info [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EgiVWye-CBS4 for <git@vger.kernel.org>;
	Sat, 19 Nov 2011 14:08:22 -0600 (CST)
Received: from [192.168.42.8] (75-146-45-44-Minnesota.hfc.comcastbusiness.net [75.146.45.44])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.summitsite.info (Postfix) with ESMTPSA id BA65422202B8
	for <git@vger.kernel.org>; Sat, 19 Nov 2011 14:08:22 -0600 (CST)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185706>

Hi All,

On Mac OS X with a case-insensitive file system (not sure if that matters) git get's confused with branch names that differ only in case. Here is what happened as far as I can reconstruct:

While in a branch named "foundry" I accidentally

	git checkout Crucible

instead of "crucible". This appears to have made a local branch "Crucible" of the remote tracking "crucible" branch (had I done this on purpose, I would have expected "Crucible" to be a branch of "foundry" instead of a branch of "crucible").

I made some changes, committed, and pushed, only to be puzzled that no changes were pushed upstream.

At this point "git branch -a" showed:

	* Crucible
	  foundry
	  master
	  remotes/origin/DAExceptions
	  remotes/origin/HEAD -> origin/master
	  remotes/origin/centerSectionOptimizer
	  remotes/origin/crucible
	  remotes/origin/foundry
	  remotes/origin/ipad
	  remotes/origin/master

So naturally I proceeded with

	git checkout crucible
	git merge Crucible

only to see "Already up-to-date."

Not sure if any of this is expected behavior, but to me it didn't feel like it.

Thanks

Gerd

PS: here is how I "fixed" this:

	git checkout Crucible
	git reset --soft HEAD^
	git stash
	git stash apply
	
added, committed, pushed. BTW now "git branch -a" shows:

	* crucible
	  foundry
	  master
	  remotes/origin/DAExceptions
	  remotes/origin/HEAD -> origin/master
	  remotes/origin/centerSectionOptimizer
	  remotes/origin/crucible
	  remotes/origin/foundry
	  remotes/origin/ipad
	  remotes/origin/master

No trace of the "Crucible" branch.
