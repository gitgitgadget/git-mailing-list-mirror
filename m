From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Keeping unreachable objects in a separate pack instead of loose?
Date: Sun, 10 Jun 2012 08:31:51 -0400
Message-ID: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 14:32:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdhJr-0003HH-1E
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 14:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab2FJMby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 08:31:54 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:48861 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981Ab2FJMbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 08:31:53 -0400
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SdhJ8-00079Y-SU; Sun, 10 Jun 2012 12:31:50 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1SdhJ9-0006B1-6p; Sun, 10 Jun 2012 08:31:51 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199594>

I recently noticed that after a git gc, I had a huge number of loose
objects that were unreachable.  In fact, about 4.5 megabytes worth of
objects.

When I packed them, via:

   cd .git/objects ; find [0-9a-f][0-9a-f] -type f | git pack-objects pack

the resulting pack file was 244k.

Which got me thinking.... the whole point of leaving the objects loose
is to make it easier to expire them, right?   But given how expensive it
is to have loose objects lying around, why not:

a)  Have git-pack-objects have an option which writes the unreachable
    objects into a separate pack file, instead of kicking them loose?

b)  Have git-prune delete a pack only if *all* of the objects in the
    pack meet the expiry deadline?

What would be the downsides of pursueing such a strategy?  Is it worth
trying to implement as proof-of-concept?

						- Ted
