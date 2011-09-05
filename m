From: Hannu Koivisto <azure@iki.fi>
Subject: "Your local changes ... would be overwritten" bug
Date: Mon, 05 Sep 2011 19:25:53 +0300
Organization: NOYB
Message-ID: <8362l73qi6.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 18:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0bzz-0005Px-56
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 18:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab1IEQ0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 12:26:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:57594 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab1IEQ0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 12:26:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R0bzp-0005M9-Ez
	for git@vger.kernel.org; Mon, 05 Sep 2011 18:26:05 +0200
Received: from s2.org ([80.83.7.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 18:26:05 +0200
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 18:26:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:N8ZofrnGiZNddZl9MwepZump/ek=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180747>

Greetings,

I have a problem where "git checkout origin/another-branch" in master
should remove a set of files but instead I get:

error: Your local changes to the following files would be overwritten by checkout:
        file1
        file2
        ...
Please, commit your changes or stash them before you can switch branches.
Aborting

(where the files listed are those that should be removed)

The problem occurs only if the checkout is not run in the top level
directory of the repository and the files in question have execute
bit set.  Before checkout, git status says

# On branch master
nothing to commit (working directory clean)

The following script can be used to reproduce the problem:

-------------------------------------------
mkdir temp
cd temp
git init
echo foo > testfile
git add testfile
git commit -m "test1"
echo foo > testfile2
chmod +x testfile2
git add testfile2
git commit -m "test2"
mkdir foo
cd foo
git co master~1
--------------------------------------------

The problem disappears if one removes either the "chmod +x
testfile2" line or the "cd foo" line.

I'm running Cygwin git 1.7.5.1 in Windows XP.

-- 
Hannu
