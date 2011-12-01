From: "Catalin(ux) M. BOIE" <catab@embedromix.ro>
Subject: git merge strange result
Date: Thu, 1 Dec 2011 17:36:00 +0200 (EET)
Message-ID: <alpine.LFD.2.02.1112011733070.32682@mail.embedromix.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 17:24:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW9Qg-0000rc-JJ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 17:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab1LAQYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 11:24:05 -0500
Received: from mail.embedromix.ro ([80.96.69.110]:32869 "EHLO
	mail.embedromix.ro" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab1LAQYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 11:24:04 -0500
X-Greylist: delayed 2882 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2011 11:24:04 EST
Received: from mail.embedromix.ro (localhost.localdomain [127.0.0.1])
	by mail.embedromix.ro (8.14.5/8.14.3) with ESMTP id pB1Fa05A032721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 1 Dec 2011 17:36:00 +0200
Received: from localhost (catab@localhost)
	by mail.embedromix.ro (8.14.5/8.14.5/Submit) with ESMTP id pB1Fa0cO032718
	for <git@vger.kernel.org>; Thu, 1 Dec 2011 17:36:00 +0200
X-Authentication-Warning: mail.embedromix.ro: catab owned process doing -bs
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186176>

Hello!

Below is a script that reproduce what a coleague of mine found.
Seems that if in a branch we have a commit that is cherry-picked be 
master, than revert that commit in branch and merge branch in master, the 
revert is ignored. Is it normal?

Thank you very much!

#!/bin/bash

set -e

rm -rf buba1
mkdir buba1
cd buba1

git init
echo -e "aaa\nbbb\nccc" > file1
git add file1
git commit -m "c1"

echo "Create branch b1..."
git branch b1
echo

echo "Create a bad fix..."
sed --in-place -e 's/bbb/bad line/' file1
git add file1
git commit -m "bad commit"
cat file1
echo

echo "Cherry pick on b1..."
git checkout b1
git cherry-pick -x master
echo

echo "Reverting on b1"
git revert --no-edit b1
echo

echo "Switch to master"
git checkout master
echo

echo "merge-base is `git merge-base --all master b1 | git name-rev --stdin`"
echo

echo "diff between master and b1..."
git diff master b1
echo

echo "Merge b1 in master"
git merge --verbose --log b1

if [ "`grep bad file1`" = "" ]; then
 	echo "good!"
else
 	echo "bad!"
fi
# it should prind "good"

--
Catalin(ux) M. BOIE
http://kernel.embedromix.ro/
