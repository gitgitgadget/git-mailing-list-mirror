From: Theodore Tso <tytso@mit.edu>
Subject: Re: mercurial to git
Date: Thu, 15 Mar 2007 10:12:27 -0400
Message-ID: <20070315141227.GA18416@thunk.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu> <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de> <20070315002505.GA31770@thunk.org> <20070315101913.GA9831@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 15:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRqha-0001Xe-91
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 15:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbXCOOMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 10:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbXCOOMt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 10:12:49 -0400
Received: from THUNK.ORG ([69.25.196.29]:55225 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422713AbXCOOMs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 10:12:48 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HRqmv-0006f3-9p; Thu, 15 Mar 2007 10:18:41 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HRqgt-0005WH-Ec; Thu, 15 Mar 2007 10:12:27 -0400
Content-Disposition: inline
In-Reply-To: <20070315101913.GA9831@peter.daprodeges.fqdn.th-h.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42282>

On Thu, Mar 15, 2007 at 10:19:13AM +0000, Rocco Rutte wrote:
> I failed to send a response to the list and it went Theodore privately 
> only, sorry. I merged hg2git into fast-export.git at repo.or.cz and 
> named it 'hg-fast-export' to match with the other importers there. It 
> now can parse Signed-off-by lines and supports author maps (as 
> git-cvsimport and git-svnimport do, same syntax).

BTW, there are a number of places where the old name (hg2git) is still
being used for filenames, et.al, because $PFX is still being set to
hg2git.  

> For which changesets exactly? The script only attempts to write out the 
> 'author' command if -s (for parsing signed-off-by) is given. But for 
> both commands the time information written out are identical and are 
> exactly what hg gives us. So the bug must be elsewhere.

All of them.  :-)

Upon doing more investigation, the failure case seems to be if -A is
specified but NOT -s.  Comare:

(Generated using: hg-fast-export.sh -A ../e2fsprogs.authors -r ../e2fsprogs)
commit b584b9c57ecbbeef91970ca2924d66662029ab29
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jan 1 00:00:00 1970 +0000  <=============

with

(Generated using: hg-fast-export.sh -s -A ../e2fsprogs.authors -r ../e2fsprogs)
commit 9e9a5867e4d4985bde6d6be072efb96e901e08cc
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed Mar 7 08:09:10 2007 -0500  <=============

The date seems to be correctly generated using

	hg-fast-export.sh -s -A ../e2fsprogs.authors -r ../e2fsprogs
	hg-fast-export.sh -s -r ../e2fsprogs
	hg-fast-export.sh -r ../e2fsprogs

It seems to be this combination of options:

	hg-fast-export.sh -A ../e2fsprogs.authors -r ../e2fsprogs

Where all of the dates end up being Jan 1, 1970.

Regards,

						- Ted
