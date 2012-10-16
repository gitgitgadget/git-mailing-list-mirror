From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: When Will We See Collisions for SHA-1? (An interesting analysis
 by Bruce Schneier)
Date: Tue, 16 Oct 2012 13:58:06 -0400
Message-ID: <20121016175806.GB26650@thunk.org>
References: <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>
 <CACBZZX65Kbp8N9X9UtBfJca7U1T0m-VtKZeKM5q9mhyCR7dwGg@mail.gmail.com>
 <20121015183438.GB31658@sigill.intra.peff.net>
 <507D4651.6080207@lsrfire.ath.cx>
 <20121016173254.GD27243@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOBPX-0002pw-So
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 19:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab2JPR6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 13:58:18 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:55810 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097Ab2JPR6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 13:58:17 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1TOBP3-00086V-Tu; Tue, 16 Oct 2012 17:58:05 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 242A4243E87; Tue, 16 Oct 2012 13:58:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20121016173254.GD27243@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207865>

I seem to recall that there was at least some discussion at one point
about adding some extra fields to the commit object in a backwards
compatible way by adding it after the trailing NUL.  We didn't end up
doing it, but I could see it being a useful thing nonetheless (for
example, we could potentially put the backup SHA-2/SHA-3 pointer there).

What if we explicitly allow a length plus SHA-2/3 hash of the commit
plus the fields after the SHA-2/3 hash as an extension?  This would
allow a secure way of adding an extension, including perhaps adding
backup SHA-2/3 parent pointers, which is something that would be
useful to do from a security perspective if we really are worried
about a catastrophic hash failure.

The one reason why we *might* want to use SHA-3, BTW, is that it is a
radically different design from SHA-1 and SHA-2.  And if there is a
crypto hash failure which is bad enough that the security of git would
be affected, there's a chance that the same attack could significantly
affect SHA-2 as well.  The fact that SHA-3 is fundamentally different
from a cryptographic design perspective means that an attack that
impacts SHA-1/SHA-2 will not likely impact SHA-3, and vice versa.

		    	     	    	   - Ted
