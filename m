From: =?UTF-8?B?SmVucyBNw7xsbGVy?= <blog@tessarakt.de>
Subject: How to hierarchically merge from the root to the leaf of a branch
 tree? (Patch stack management)
Date: Thu, 01 Aug 2013 00:25:32 +0200
Message-ID: <ktc2sl$d4f$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 01 00:30:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4euK-0001Ft-Go
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 00:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757783Ab3GaWaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 18:30:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:42849 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079Ab3GaWaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 18:30:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V4euA-00019T-VG
	for git@vger.kernel.org; Thu, 01 Aug 2013 00:30:02 +0200
Received: from p5dc8fa44.dip0.t-ipconnect.de ([93.200.250.68])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 00:30:02 +0200
Received: from blog by p5dc8fa44.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 00:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p5dc8fa44.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231472>

Hi all!

I mainly use Git for version control, but have also tried out Mercurial.
While I don't really like Mercurial in general, the idea of maintaining
clearly separated patches with Mercurial Queues (MQ) is quite appealing.
Therefore, I am looking for something similar (but easier to use, more
"gitty" and maybe even more powerful) in Git.

So I will first explain what I have in mind:

As an example, let's say I am doing test-driven development. My master
branch follows the main repository of the software. Branched out from
that, I have a branch called "feature-test", and branched out from that,
"feature-implementation":

    master
    |_ feature-test
       |_ feature-implementation

For each branch, I remember the parent branch.

Implementation would then work like this: I checkout feature-test and
write some test. Then I checkout feature-implementation, rebase it to
the current status of feature-test and write the implemenation. And so on.

At some point, I update master, and then rebase both feature-test and
feature-implementation.

As a side note: Instead of rebasing the branches, an alternative would
be to merge the changes from the parent branch. This makes conflict
resolution easier. The cascading merge through the chain of branches is
like a rebase, anyway.

Of course, the process described above contains a lot of tedious manual
work. So I am looking for tooling for tasks like the following:

 * While on a branch, pull master from a remote branch it tracks and
merge the changes down the chain of branches. When a conflict is
encountered, switch to the branch where it occured, allow the user to
resolve the conflict, and then continue the cascading merge (similar to
what git rebase does when it encounters a conflict).
 * When checking out a branch, cascadingly merge from the ancestor
branches automatically. Conflict handling should work as in the previous
point.

The cascading merge should not check out master and the branches below
it (unless necessary to resolve conflicts), in order to avoid rebuilds
due to touched but unchanged files.

Do these requirements make sense? Is there some existing tool with a
similar workflow?

BR - Jens
