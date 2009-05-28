From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Bug in git-cvsexportcommit: can't commit files which have been removed
 from CVS
Date: Thu, 28 May 2009 17:53:24 +0100
Message-ID: <4A1EC184.50107@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 19:24:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9jL8-0005rx-Ic
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 19:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZE1RYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 13:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZE1RYR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 13:24:17 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:58516 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZE1RYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 13:24:17 -0400
X-Greylist: delayed 1853 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2009 13:24:17 EDT
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.101])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1M9ir7-0000uT-71
	for git@vger.kernel.org; Thu, 28 May 2009 17:53:25 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120201>

Hi,

I think I've discovered a bug in git-cvsexportcommit: where a file has been
removed from a CVS repository, it linger in the Attic and CVS perversely reports
them as 'no file X' with status 'Up-to-date'.  git-cvsexportcommit then
prevents files from being added with the same name.

I have a patch against the current version of git's repository which seems to
fix the problem.  This is actually three commits:
 - the fix,
 - an extension to t9200-git-cvsexportcommit.sh to test the fix
 - EOL whitespace-removal

I'm hesitant to send all three as separate emails, even though the
SubmittingPatches document seems to imply I should - should I squash them into
one commit?


Anyway - to replicate the issue, create a CVS repository, add a file "x", then
remove it.

Then create a git repository tracking this CVS repository using git-cvsimport.
Pull the changes from CVS, then try adding a file "x", and exporting it back to
CVS.  When I do that I get this error:

  File x is already known in your CVS checkout -- perhaps it has
  been added by another user. Or this may indicate that it exists on a
  different branch. If this is the case, use -f to force the merge.
  Status was: Up-to-date
  Exiting: your CVS tree is not clean for this merge. at
  /usr/lib/git-core/git-cvsexportcommit line 275.

When comitting, I also sometimes get warnings like this:

  Huh? Status reported for unexpected file 'no file y'

These seem to be ignorable, but I think they also result from the above issue.


Cheers,

Nick
