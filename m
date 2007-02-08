From: Bill Lear <rael@zopyra.com>
Subject: Question on git fetch to bare repo
Date: Thu, 8 Feb 2007 16:28:29 -0600
Message-ID: <17867.41997.561756.679778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 23:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHla-0004bH-Dk
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423493AbXBHW3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423494AbXBHW3T
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:29:19 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61717 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423493AbXBHW3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:29:18 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l18MTIM29170;
	Thu, 8 Feb 2007 16:29:18 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39109>

If I have not yet made myself unwelcome, I now have another problem
using git 1.4.4.1.

I have a public bare repo I created yesterday:

% mkdir project && cd project
% git --bare init-db --shared
% git --bare fetch git://source/project
[All seems well]

I have a private repo:

% mkdir project && cd project
% git clone /repos/git/project
[All is well]

A co-worker checks something in to our company repo, so I go to my
public repo to fetch the changes:

% cd /repos/git/project
% git --bare fetch -v git://source/project
remote: Generating pack...
remote: Done counting 230 objects.
remote: Result has 152 objects.
remote: Deltifying 152 objects.
remote:  100% (152/152) done
Unpacking 152 objects
remote: Total 152, written 152 (delta 109), reused 90 (delta 51)
 100% (152/152) done
* fetched git://source/project
  commit: 5c2d43d

I then go to my private repo to pull from my public one:

% cd ~/project
% git branch
  topic
* master
% git pull
Already up-to-date.
% cat .git/remotes/origin
URL: /repos/git/project
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/topic:refs/heads/topic
[All seems well with this repo ??]

I try to push from my private to my public:

% git push /repos/git/project
Everything up-to-date

I go back to my public repo, and poking around, can't see what is wrong.

The commit that the fetch says it pulled is there, if I do:

% cd /repos/git/project
% git --bare show -t 5c2d43d

the patch comes out exactly as it did in my email notification, so I
know it's there.

I tried then to be more forceful, and did another fetch like this,
which I sort of expected to fail:

% git --bare fetch -v git://source/project master:master
remote: Generating pack...
remote: Done counting 230 objects.
remote: Result has 152 objects.
remote: Deltifying 152 objects.
remote:  100% (152/152) done
Unpacking 152 objects
remote: Total 152, written 152 (delta 109), reused 90 (delta 51)
 100% (152/152) done
* refs/heads/master: fast forward to branch 'master' of git://source/project
  old..new: 37e2298..5c2d43d
Cannot fetch into the current branch.

Having enabled the logs, I can investigate a bit:

% cat logs/refs/heads/master
37e229835103a11365b1e081f9b9987a88437e62 5c2d43dc819fc1bc37ebae1696c3fbfd6a4401db Bill Lear <rael@zopyra.com> 1170973321 -0600     fetch git://source/project: fast-forward
5c2d43dc819fc1bc37ebae1696c3fbfd6a4401db 37e229835103a11365b1e081f9b9987a88437e62 Bill Lear <rael@zopyra.com> 1170973321 -0600     fetch git://source/project: Undoing incorrectly fetched HEAD.

And, my branches seem to be there, properly:

% git --bare branch
  topic
* master

So, I'm confused.  Why does my fetch seem to fetch things the first
time, yet I cannot pull these into my private repo?  I could swear I
just did this same sequence of operations on Monday and it worked.

Perhaps I just need a vacation ...


Bill
