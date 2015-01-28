From: Dick <dick@mrns.nl>
Subject: git loses commits on git pull --rebase with Dictator and Lieutenants Workflow
Date: Wed, 28 Jan 2015 19:49:02 +0000 (UTC)
Message-ID: <loom.20150128T203924-608@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 23:08:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGamo-0005sd-6n
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 23:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbbA1WI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 17:08:29 -0500
Received: from plane.gmane.org ([80.91.229.3]:51087 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328AbbA1UUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:20:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YGYcl-0007B9-GG
	for git@vger.kernel.org; Wed, 28 Jan 2015 20:50:03 +0100
Received: from 095-096-100-038.static.chello.nl ([95.96.100.38])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 20:50:03 +0100
Received: from dick by 095-096-100-038.static.chello.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 20:50:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.96.100.38 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.93 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263121>

Hi all,

I've encountered a problem with the Dictator and Lieutenants Workflow. I've 
configured remote origin so it pulls from the "blessed repository" and 
pushes to the "developer public" repository.

When the "blessed repository" has the same branch name as the "developer 
public" repository git pull seems to drop commits.

I've create a test script to demonstrate, left is the blessed repository, 
right.git is the developer public and right is the developer private 
repository.

rm -rf left/ right/ right.git/
git init left
cd left/
echo "hello world" > test.txt
git add test.txt 
git commit -m .
cd ..
git clone --bare left right.git
git clone right.git/ right
cd right
git remote set-url origin ../left
git remote set-url origin --push ../right.git
echo "bye world" >> test.txt 
git commit -a -m .
git push
git log
echo "start: two commits, ok"
git fetch
git rebase origin/master
git log
echo "manual fetch/rebase: two commits, still ok"
git pull --rebase
git log
echo "pull: one commits, oops?"

Am I using git wrong or is this a git bug?

Thanks for having a look!

Dick
