From: John Keeping <john@metanate.com>
Subject: Interactive rebase with submodules
Date: Tue, 17 Jan 2012 18:47:08 +0000
Message-ID: <4F15C22C.3020902@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 20:17:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnEWt-0003Ip-He
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 20:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab2AQTRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 14:17:06 -0500
Received: from shrek.metanate.com ([193.123.6.120]:33310 "EHLO
	shrek.metanate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598Ab2AQTRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 14:17:05 -0500
X-Greylist: delayed 1792 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jan 2012 14:17:04 EST
Received: from farnsworth.metanate.com ([193.123.6.36])
	by shrek.metanate.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <john@metanate.com>)
	id 1RnE3o-00030b-4G
	for git@vger.kernel.org; Tue, 17 Jan 2012 18:47:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20120105 Thunderbird/9.0
X-DCC--Metrics: shrek; whitelist
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188713>

I've encountered a scenario where git rebase --interactive drops a 
commit which contains a modification to a submodule but no other changes.

This occurs when there is a conflict when applying the commit (for 
example if the submodule's history has been rewritten and you are 
rewriting the parent repository to match the new version of the submodule).

To clarify:

git rebase -i
# Edit a commit, switching submodule to an unrelated commit
git rebase --continue
# Conflict in submodule, checkout the correct submodule commit
git add path/to/submodule
# Only change in index is updated submodule
git rebase --continue
# No commit is created for the submodule change


This appears to be because the git-rebase--interactive script inspects 
whether there is anything to commit when `rebase --continue` is invoked 
by running:

     git diff-index --cached --quiet --ignore-submodules HEAD --

Is there a reason for the `--ignore-submodules` in this command? 
Removing that option results in the expected behaviour.


I can understand not updating submodules while running the rebase, but I 
expected that having resolved a conflict and added my change to the 
index it would be applied by `git rebase --continue`, as indeed it is if 
there happen to be other (non-submodule) changes in the same commit.


-- 
John
