From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Big Mess--How to use Git to resolve
Date: Sat, 17 Dec 2011 07:33:06 -0800
Message-ID: <86iplf2oy5.fsf@red.stonehenge.com>
References: <1324125130643-7103964.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hs_glw <greg@hra.net>
X-From: git-owner@vger.kernel.org Sat Dec 17 16:38:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbwLJ-00035V-1v
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 16:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab1LQPi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 10:38:29 -0500
Received: from lax-gw12.mailroute.net ([199.89.0.112]:44651 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752425Ab1LQPi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 10:38:27 -0500
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Dec 2011 10:38:27 EST
Received: from localhost (localhost [127.0.0.1])
	by lax-gw12.mroute.net (Postfix) with ESMTP id 2F06E32708A0;
	Sat, 17 Dec 2011 15:33:08 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw12.mroute.net (Postfix) with ESMTP id 00E62327089F;
	Sat, 17 Dec 2011 15:33:06 +0000 (UTC)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id DE57B1B09; Sat, 17 Dec 2011 07:33:06 -0800 (PST)
x-mayan-date: Long count = 12.19.18.17.10; tzolkin = 11 Oc; haab = 18 Mac
In-Reply-To: <1324125130643-7103964.post@n2.nabble.com> (hs glw's message of
	"Sat, 17 Dec 2011 04:32:10 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187385>

>>>>> "hs" == hs glw <greg@hra.net> writes:

hs> Some clients have customizations of the code, some have version 5 of the
hs> software others have 5.2, 5.5 etc.

Create an empty repo.

Unpack the oldest release (I presume you still have the tarballs) you
might have forked a customer from.  commit it, and tag it as v5.0 (or
whatever it is).

In the same dir, delete the files, and unpack the *next* release.  git
add . again, and commit that, effectively recording the changes from one
release to the next.  Tag it v5.1 or whatever.

Repeat for all releases.

git branch -m master release

That will remain your untouched release branch.

Now, take customer1.  Figure out which release is closest to their
modified code.  Let's say it's v5.2

git checkout -b customer1 v5.2

erase the files, copy their work in, and commit.  You'll now have a
customer1 branch that comes off the right release.

repeat for each customer.

So now you have tags for each release, and every customer's code checked
in somewhere.

If you feel brave, you can try to move a customer to a later release:

git checkout customer1
git rebase v5.5

That will try to apply the diff between v5.2 and customer1 directly to
the top of v5.5.  Might fail, might need some mopping up.  But at least
the hard work is done.

Hope this helps.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
