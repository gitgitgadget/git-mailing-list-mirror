From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Bug in "git diff --quiet" handling.
Date: Mon, 11 Apr 2011 17:07:33 -0400
Message-ID: <4DA36D95.6060108@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 11 23:08:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9OLi-0006UP-10
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1DKVI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:08:26 -0400
Received: from mail.windriver.com ([147.11.1.11]:56942 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab1DKVIX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:08:23 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p3BL8NpT027302
	for <git@vger.kernel.org>; Mon, 11 Apr 2011 14:08:23 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 11 Apr 2011 14:07:34 -0700
Received: from [128.224.146.65] ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 11 Apr 2011 14:07:34 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Thunderbird/3.1.9
X-OriginalArrivalTime: 11 Apr 2011 21:07:34.0539 (UTC) FILETIME=[7A8D6DB0:01CBF88C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171357>

I came across this when I was mistakenly thinking I could use "--quiet" to
stop the output of git format-patch giving the 0001-somecommit.patch names as
it generated them.

It was then when I read the man page and found it is passed into git diff and
is supposed to disable all output.  The interesting thing, is that it only
seems to do this on every other commit it format-patches, as shown
below.

I'm assuming this is a bug, since I can't imagine what use case would have
every alternate patch being output as useful.  If I get a chance, I'll take
a look at the code and see if I can figure out what is going on, but I
figured I'd mention it 1st in case it triggered an "Oh yeah it is XYZ"
in someones memory.

Paul.

---

Script started on Mon 11 Apr 2011 04:50:22 PM EDT
paul@dv2000:~/git/git$ git --version
git version 1.7.4.4
paul@dv2000:~/git/git$ git format-patch --quiet -o foo HEAD~10..HEAD
paul@dv2000:~/git/git$ ls -l foo
total 60
-rw-r--r-- 1 paul paul 2960 2011-04-11 16:50 0001-fetch-pull-recurse-into-submodules-when-necessary.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0002-fetch-pull-Add-the-on-demand-value-to-the-recurse-su.patch
-rw-r--r-- 1 paul paul 1514 2011-04-11 16:50 0003-config-teach-the-fetch.recurseSubmodules-option-the-.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0004-Submodules-Add-on-demand-value-for-the-fetchRecurseS.patch
-rw-r--r-- 1 paul paul 1391 2011-04-11 16:50 0005-fetch-pull-Don-t-recurse-into-a-submodule-when-commi.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0006-submodule-update-Don-t-fetch-when-the-submodule-comm.patch
-rw-r--r-- 1 paul paul 1381 2011-04-11 16:50 0007-fetch-pull-Describe-recurse-submodule-restrictions-i.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0008-remote-disallow-some-nonsensical-option-combinations.patch
-rw-r--r-- 1 paul paul 3801 2011-04-11 16:50 0009-remote-separate-the-concept-of-push-and-fetch-mirror.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0010-remote-deprecate-mirror.patch
-rw-r--r-- 1 paul paul 3172 2011-04-11 16:50 0011-submodule-process-conflicting-submodules-only-once.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0012-revisions.txt-consistent-use-of-quotes.patch
-rw-r--r-- 1 paul paul 9679 2011-04-11 16:50 0013-revisions.txt-structure-with-a-labelled-list.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0014-log-cherry-pick-documentation-regression-fix.patch
-rw-r--r-- 1 paul paul 1826 2011-04-11 16:50 0015-compat-add-missing-include-sys-resource.h.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0016-pull-do-not-clobber-untracked-files-on-initial-pull.patch
-rw-r--r-- 1 paul paul 1743 2011-04-11 16:50 0017-Start-preparing-for-1.7.4.4.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0018-gitweb-Fix-parsing-of-negative-fractional-timezones-.patch
-rw-r--r-- 1 paul paul 1089 2011-04-11 16:50 0019-Documentation-trivial-grammar-fix-in-core.worktree-d.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0020-revisions.txt-language-improvements.patch
-rw-r--r-- 1 paul paul 1114 2011-04-11 16:50 0021-Git-1.7.4.4.patch
-rw-r--r-- 1 paul paul    0 2011-04-11 16:50 0022-Git-1.7.5-rc1.patch
-rw-r--r-- 1 paul paul 4996 2011-04-11 16:50 0023-git-p4-replace-each-tab-with-8-spaces-for-consistenc.patch
paul@dv2000:~/git/git$ exit
exit
Script done on Mon 11 Apr 2011 04:51:34 PM EDT
