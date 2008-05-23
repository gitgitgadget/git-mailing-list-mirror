From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: Deleted files can't be checked back out?
Date: Fri, 23 May 2008 02:28:21 -0400
Message-ID: <20080523062821.GA24411@foursquare.net>
References: <fb3648c60805222128v1a425c60kc8e44f3a2fb41d54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: fREW <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 08:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzQmN-0008Pg-DE
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 08:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbYEWG2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 02:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbYEWG2g
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 02:28:36 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:45389 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbYEWG2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 02:28:35 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4N6SL61030127;
	Fri, 23 May 2008 02:28:21 -0400
Content-Disposition: inline
In-Reply-To: <fb3648c60805222128v1a425c60kc8e44f3a2fb41d54@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82685>

On Thu, May 22, 2008 at 11:28:57PM -0500, fREW wrote:
> I recently deleted a bunch of files and checked the change into git,
> and then changed my mind and wanted the files back.  I did a
> git-checkout <file> and got each file back individually.  Then I did

I believe you want to undo the change you made (deleting files), not
just view an old version of the file, which is what checkout does.

You can either add it back yourself, or you can undo the last commit, using
git-reset.

Here's an example of what you could have done before making further
changes that you wanted to push:

	git rm file
	git commit
	git log			# view your change
	git reset --hard HEAD^	# go back to the HEAD before your change

Think of the chain of commits as a long linked list of changes.  A branch
head is just a pointer to the top of that linked list.  git-reset allows
you to point that HEAD to anywhere in the list, even after going back
in history.  The commits are still there, even if HEAD doesn't explicitly
point to them.

For example, say git log shows commit 1a2b3c4 as HEAD, with commit 7abc983
as its parent.  You can move the HEAD back and forth, like this:

	git reset --hard 7abc983
	git log			# commit 1a2b3c4 is gone!
	git reset --hard 1a2b3c4
	git log			# now it's back!

But in your case, you now have a list of commits that is missing files:

        A -> B -> C
             |    |
             |    (made changes here)
             |
             (deleted files here)

So in this case you likely want to revert commit B, while keeping commit C.

	git log			# get the commit SHA1, let's say it's 04bcb93
	git revert 04bcb93


Take a look at "Git from the bottom up"
	http://www.newartisans.com/blog_files/git.from.bottom.up.php

- Chris
