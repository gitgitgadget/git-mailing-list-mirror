From: Johan Herland <johan@herland.net>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Thu, 10 Feb 2011 23:16:23 +0100
Message-ID: <201102102316.23628.johan@herland.net>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: John Wiegley <johnw@boostpro.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 23:16:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PneoT-0008DS-CI
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 23:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab1BJWQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 17:16:28 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56378 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab1BJWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 17:16:27 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGF008CI9VC3C40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Feb 2011 23:16:24 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 520D11EA5525_D5463B8B	for <git@vger.kernel.org>; Thu,
 10 Feb 2011 22:16:24 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3A32F1EA3424_D5463B8F	for <git@vger.kernel.org>; Thu,
 10 Feb 2011 22:16:24 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LGF00BY59VB6810@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Feb 2011 23:16:24 +0100 (MET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-reply-to: <m21v3fvbix.fsf@hermes.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166505>

On Thursday 10 February 2011, John Wiegley wrote:
> Is it allowable to add new metadata fields to a commit, and would this
> require bumping the repository version number?  Or should this be
> implemented by appending a Header-style textual field at the end of the
> commit message?

Many have tried before you to add such fields to the commit objects 
(including, literally, storing the origin of cherry-picks to help with 
rebases; search the archives for several examples). They have not succeeded. 
With good reason. This information does not belong in the commit object 
header section (see earlier discussions for a more complete rationale). 
Putting them at the end of the commit message is your best bet. Or even 
better: as a note object stored in a special-purpose notes ref (e.g. 
refs/notes/cherry-picks). The note approach also allows you to retroactively 
add this field to previous cherry-picks. AND it allows you to remove Origin-
IDs that refer to no-longer-existing commits. AND it pretty much solves the 
"git log should show this info" for you as well. In short, this is exactly 
the thing that notes were created to do.

Also, don't forget that the existing -x option to cherry-pick pretty much 
does exactly what you want to add to the commit object.

As for making use of this information in other git commands (e.g. rebase, 
log, etc.), you should show the list that the feature works well and solves 
Real Problems(tm) in the real world. If you can do so (with patches), and 
are willing to work with the list to address issues raised, and improve your 
patches, I'll guess you have a pretty good shot at getting this accepted.

AFAIK, nobody else is working in this area right now, although I don't read 
the mailing list religuously, so I may have missed things. As I said, others 
have previously proposed similar features, so you'll want to search the 
archive for those discussions to make sure you don't repeat the same 
mistakes.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
