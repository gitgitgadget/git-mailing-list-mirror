From: Greg Hewgill <greg@hewgill.com>
Subject: Proposal for git stash rename
Date: Sun, 20 Jun 2010 09:31:42 +0000
Message-ID: <20100620093142.GF24805@occam.hewgill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 20 11:49:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQHA0-0005DD-CR
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 11:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464Ab0FTJtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 05:49:43 -0400
Received: from occam.hewgill.net ([69.41.174.196]:50499 "EHLO
	occam.hewgill.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429Ab0FTJtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 05:49:42 -0400
X-Greylist: delayed 1078 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Jun 2010 05:49:42 EDT
Received: by occam.hewgill.net (Postfix, from userid 1001)
	id 8924D22823; Sun, 20 Jun 2010 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hewgill.com;
 i=@hewgill.com; q=dns/txt; s=greg; t=1277026303; h=Date : From : To :
 Subject : Message-ID : MIME-Version : Content-Type :
 Content-Disposition : X-PGP-Fingerprint : User-Agent;
 bh=I56wIyoCqlITe6cyXYTrjjrj9q3FI80Eh6oAimpyEsk=; b=oJ+ssxQEO5DiGNLdQU1QDgmLEeMXwTLByefZfsNIwmRSpSvFw2fpok29yPWR6TvdbD91zkQSG3i9YGKXbW0tP2dr8ZUF7y6sv8Emw2LpxfkQKfgEyZkOOAWxl1L2BI10O0OOHhiddxpM4iD43eqCqg4MpRI77YBpYFk69EWfpl4=
Content-Disposition: inline
X-PGP-Fingerprint: 862C 894D 4908 0240 FEEE  6D1F FA34 8460 74E0 2115
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149392>

I'd like to teach git-stash to rename stashes. Sometimes I'll create a
stash and then later think of a better or more descriptive name for it.
Or, I'll create a stash with "git stash -p" and forget to give it a
useful name, and there's no easy way to undo and redo that without
doing the interactive part again.

I noticed that although the stash message is used as the commit
description for the stash commit(s), it is the message in the reflog
that is actually displayed on "git stash list". So to rename a stash,
changing the message in the reflog is sufficient (this can be
demonstrated with a text editor).

My general idea is:

1. Implement a new "git reflog update" command that updates the message
associated with a specific reflog entry. To do this, a new
update_reflog_ent() function (in reflog.c) would change the message
associated with the specific reflog entry to update. An update_reflog()
function would use for_each_reflog_ent() with update_reflog_ent to
actually do the change.

2. A "git stash rename" command would then only need to call "git
reflog update" with the appropriate ref and new message.

Since this is my first time modifying the Git source, I thought I'd
solicit some feedback on this idea.

- Is this an appropriate approach to implementing this?
- Is there a better way to do it?
- I have a mostly working patch now, but it needs cleanup. What's the
  next step?

Greg Hewgill
http://hewgill.com
