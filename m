From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Sat, 02 Apr 2011 01:27:41 +0200
Message-ID: <201104020127.41774.johan@herland.net>
References: <201103311246.25645.johan@herland.net>
 <AANLkTimMJxni=Vuja+iHyMp8ydm7ZBvWnkSe68g6+pyH@mail.gmail.com>
 <7vk4fdehps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 01:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5nky-0004N8-VA
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 01:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739Ab1DAX1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 19:27:48 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51822 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216Ab1DAX1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 19:27:47 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIZ00050YI8WO80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 02 Apr 2011 01:27:44 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id BE7871EA595F_D965F70B	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 23:27:44 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id A79071EA2BA0_D965F6EF	for <git@vger.kernel.org>; Fri,
 01 Apr 2011 23:27:42 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LIZ00H7QYI6KT00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 02 Apr 2011 01:27:42 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.1; x86_64; ; )
In-reply-to: <7vk4fdehps.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170635>

On Saturday 02 April 2011, Junio C Hamano wrote:
> I was responding to the motivation stated in the commit log message, the
> file-based "cp -r" copy or cpio clone, which are _not_ a safe thing to
> do.

Hmpf. I didn't know that clone --local --no-hardlinks was unsafe. If it's 
not safe, should it still be the default behavior for a cross-filesystem 
clone?

Furthermore, this lack of safety is not at all mentioned in the clone 
documentation...

> Because "leftover .keep" alone is a good justification, I was hinting to
> drop that other motivation from the description altogether.

Whatever works best for you. What about this commit message instead?


While pushing to a remote repo, Git transiently adds a .keep file for the
pack being pushed, to protect it from a concurrent "git gc". Sometimes, when 
the push fails or is aborted, the .keep file is left stale in the repo. This 
causes problems for other users of the same repo, since the permissions on 
the .keep file (0600) make it inaccessible even though the rest of the repo 
is accessible (0444 modulo shared_repository setting).

There is no reason why the permission mode of a .keep file should be any
different from the permission mode of the corresponding .pack/.idx files.
Therefore, adjust the permission of .keep files from 0600 to 0444 modulo
the shared_repository setting.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
