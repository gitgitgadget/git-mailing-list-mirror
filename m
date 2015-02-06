From: Sergey Organov <sorganov@gmail.com>
Subject: 'git rebase' silently drops changes?
Date: Sat, 07 Feb 2015 00:28:00 +0300
Message-ID: <87386ispb3.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 22:36:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJqZH-0004FD-7F
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 22:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbbBFVf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 16:35:59 -0500
Received: from mail.javad.com ([54.86.164.124]:53839 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbbBFVf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 16:35:58 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Feb 2015 16:35:58 EST
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id A440E618A2
	for <git@vger.kernel.org>; Fri,  6 Feb 2015 21:28:02 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1YJqRU-0006Hw-Se
	for git@vger.kernel.org; Sat, 07 Feb 2015 00:28:00 +0300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263428>

Hello,

I recently ran into an annoying problem: 'git rebase' apparently
silently drops changes in non-conflicting paths of merge commits
(git version 1.9.3). 

Is it a bug or feature? Is there a way to flatten history using rebase,
yet preserve manual changes found in merge commits?

Here is simplified reproduction of what I've encountered:

<SCRIPT>
git init t
cd t
git config rerere.enabled true

echo "I" > a; git add a
echo "I" > b; git add b
git commit -am "I"

git checkout -b test

echo "B" >> b; git commit -m "B" -a

git checkout master

echo "A" >> a
git commit -am "A"

git merge --no-edit test

# Clean merge, but result didn't compile, so I fixed it and
# amended the merge:
echo "Precious!" >> a # [!] This is modification that gets lost
git commit --amend --no-edit -a
cat a

# Now rebase my work.
git rebase -f HEAD~1

# What? Where is my "Precious" change in "a"???
cat a
</SCRIPT>

I.e., the modification marked [!] was silently lost during rebase!

-- 
Sergey.
