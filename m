From: Jon Loeliger <jdl@freescale.com>
Subject: Notes for CVS Converts
Date: Wed, 31 Aug 2005 14:08:36 -0500
Message-ID: <1125515315.13577.53.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 31 21:10:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAXwv-0001rb-BL
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 21:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVHaTIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 15:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVHaTIi
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 15:08:38 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:15582 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932522AbVHaTIi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 15:08:38 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id j7VJHjWa012304
	for <git@vger.kernel.org>; Wed, 31 Aug 2005 12:17:45 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j7VJCkZB013744
	for <git@vger.kernel.org>; Wed, 31 Aug 2005 14:12:46 -0500 (CDT)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7983>

Guys,

I was recently bitten by a cg-rm behavior where
it silently Did The Wrong Thing, IMO.  I think
that other CVS Converts might stumble across the
same pitfall, so it might warrant a comment in
the documentation, perhaps in the "Notes For CVS
Users" section.

I am in the process of doing some file merging,
resulting in some files being eliminated from my
source tree.  But I wasn't prepared to just out-right
delete my original files until some testing had
been completed first.  So I moved my files out of
the way so the build would proceed without them.

Later, when I was satisfied the build was good, I
executed a "cg-rm floof/somefile.h" and then cg-commit'ed
them.  However, I realized, they were not actually
removed from the cache.

Reading through "cg-rm", I figured out that it expected
to actually rm the files from the filesystem after first
proving they existed with a "find".  That in turn also
drove the "git-cache-update --force-remove".

However, in my case I had already moved/removed the
original files.  The "find" didn't find them and the
cache update didn't happen.  And no output was generated
either.  But I thought nothing of it; after all, "rm"
doesn't produce output when it works successfully.

So two possible suggestions here:

First, perhaps cg-rm should issue a warning if the
generated temporary file results in an empty list of
files to be removed (and then maybe with a --silent
option subsequently?),

Secondly, maybe the documentation needs a section with
"Notes for CVS Converts" section that clearly states
that cg-rm _expects_ to actually remove the file from
the filesystem, directly opposite the normal CVS behavior.

Thanks,
jdl
