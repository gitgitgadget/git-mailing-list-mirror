From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Idea for git-fast-import
Date: Fri, 20 Jul 2007 08:59:23 +0200
Message-ID: <46A05D4B.1050208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Jul 20 08:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBmSe-0006b8-5L
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 08:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756103AbXGTG7d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 02:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756666AbXGTG7d
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 02:59:33 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:48304 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbXGTG7d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 02:59:33 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l6K6xOVY021543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2007 08:59:25 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53062>

I'm working on a git backend for cvs2svn and had an idea for
git-fast-import that would make life a tiny bit easier:

Currently, git-fast-import marks are positive integers.  But they are
used for two things: marking single-file blobs, and marking commits.

This is a tiny bit awkward, because cvs2svn assigns small integer IDs to
these things too, but uses distinct (overlapping) integer series for the
two concepts.  If it would be trivial to split the marks into two
"namespaces" (one for single-file blobs and one for commits), that would
make things a little bit more natural.  I don't think commit marks can
be used interchangeably with blob marks anyway, so it wouldn't be a
backwards incompatibility.

Without this feature, I will have to assign a new "mark" integer series
that is unrelated to cvs2svn's IDs, which is no big deal at all but will
make debugging a little bit harder.  So only add this feature if it is
really easy for you.

Also, is there a big cost to using "not-quite-consecutive" integers as
marks?  cvs2svn's CVSRevision IDs are intermingled with IDs for
CVSBranches and CVSTags, so the CVSRevisions alone probably only pack
the ID space 5%-50% full.

In fact, if there is a big cost to "not-quite-consecutive" integers,
then I withdraw my request for separate mark namespaces, since I would
have to reallocate mark numbers anyway :-)

Another thing that might help with debugging would be a "comment"
command, which git-fast-import should ignore.  One could put text about
the source of a chunk of git-fast-import stream to relate it back to the
front-end concepts when debugging the stream contents by hand.

[I will be out of town until Monday, so don't be surprised that I don't
respond right away :-) ]

Thanks,
Michael
