From: "Alexey Feldgendler" <alexeyf@opera.com>
Subject: Directory replaced with a file confuses cherry-pick
Date: Fri, 18 Feb 2011 15:24:14 +0100
Organization: Opera Software ASA
Message-ID: <op.vq3rmo2b56e9f9@xman.eng.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 15:24:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqRFv-0004lH-EN
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 15:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab1BROYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 09:24:18 -0500
Received: from smtp.opera.com ([213.236.208.81]:54732 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757554Ab1BROYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 09:24:16 -0500
Received: from xman.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p1IEOEHw018999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 14:24:15 GMT
User-Agent: Opera Mail/11.01 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167213>


Hello!

I think I've found a bug. Here is how to reproduce.

1. Create an empty repo.
2. Add the following: file.txt containing "before" and directory problem/
with file problem/content containing "data". Commit this.
3. From here, create a branch and commit a change to file.txt: change it
to say "after".
4. Checkout master.
5. Remove directory problem/ and add a file with the same name (problem)
containing "newdata". Commit this.
6. Try to cherry-pick the commit you made on the side branch on step 3.

Here is what you see:

Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
and commit the result with:

           git commit -c 64f21a85fa3deb4d3952b0471f442a76e5147b05

And git-status says:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   file.txt
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add/rm <file>..." as appropriate to mark resolution)
#
#       added by us:        problem
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       problem~HEAD

Expected result: the cherry-pick goes smoothly. The change I'm
cherry-picking (modification of file.txt) has nothing to do with the
problem file/directory. Trying to cherry-pick anything from branches that
stem off from before the change of a directory to a file fails like this.

Known? Is replacing directories with files maybe a taboo?


-- 
Alexey Feldgendler
Software Developer, Desktop Team, Opera Software ASA
[ICQ: 115226275] http://my.opera.com/feldgendler/
