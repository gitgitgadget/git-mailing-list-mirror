From: Camille Moncelier <moncelier@devlife.org>
Subject: cherry-pick fail when a symbolic link has been changed into a file
 or directory
Date: Thu, 4 Nov 2010 12:56:41 +0100
Message-ID: <20101104125641.2ef90853@cortex>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 12:57:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDyRB-0002Vd-Mj
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 12:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab0KDL4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 07:56:55 -0400
Received: from lo.gmane.org ([80.91.229.12]:36757 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782Ab0KDL4y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 07:56:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PDyR3-0002Sd-A3
	for git@vger.kernel.org; Thu, 04 Nov 2010 12:56:53 +0100
Received: from arennes-258-1-39-42.w90-31.abo.wanadoo.fr ([90.31.190.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 12:56:53 +0100
Received: from moncelier by arennes-258-1-39-42.w90-31.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 12:56:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: arennes-258-1-39-42.w90-31.abo.wanadoo.fr
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160717>

I'm reposting this since I didn't get any responses and I think my
message didn't contained enought context.

I think I may have spotted a bug, or a unhandled case when doing a
cherry-pick

Consider a repository like this:

# Initialize a dummy repository
    mkdir -p repo1 ; cd repo1
    git init .

# Create a new directory `dir1' and a link to it `dir2'
    mkdir dir1
    echo file1 > dir1/file1
    ln -s dir1 dir2
    git add dir1 dir2
    git commit -m "Initial status: dir2 -> dir1"

# Create a branch named `test1' remove the `dir2' link and
# replace it by a new directory
    git checkout -b test1
    git rm dir2
    mkdir dir2
    touch file2 > dir2/file1
    git add dir2/file1
    git commit -m "Removing link: dir1/ and dir2/"

# Now create a new file in `test1' branch
    message="New file in test1"
    echo $message > new_file_test1
    git add new_file_test1
    git commit -m "$message"

# Now try to cherry-pick last commit from `test1' into master
    git co master
    git cherry-pick test1

The cherry-pick fails saying if failed to merge `dir2' despite the fact
that the commit doesn't affect `dir2' and 

git diff test1~..test1 | git apply

is working. Am I doing something wrong ?

-- 
Camille Moncelier
http://devlife.org
