From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Fri, 20 Feb 2009 09:27:08 +0100 (CET)
Message-ID: <56112.77.61.241.211.1235118428.squirrel@hupie.xs4all.nl>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQkV-0004Ac-LK
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbZBTI1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbZBTI1P
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:27:15 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:38118 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751746AbZBTI1O (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 03:27:14 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 19AFC58BDCE; Fri, 20 Feb 2009 09:27:09 +0100 (CET)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Fri, 20 Feb 2009 09:27:08 +0100 (CET)
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110815>

        Hi,

 I'm actually working on coming up with a patch for a bug I hit that has to to do with safecrlf=true. Maybe now I should coordinate with you?

 See this thread
 http://article.gmane.org/gmane.comp.version-control.git/110152

 Ferry

 Michael Haggerty wrote:    The test suite for "git cvsimport" is pretty limited, and I would like to improve the situation.  This patch series contains the first of what I hope will eventually be
several additions to the "git cvsimport" test suite.  I am the maintainer of cvs2svn/cvs2git.  Most of the new tests will probably use fragments from the cvs2svn test suite.  I should admit that
part of my motivation for adding tests to the "git cvsimport" test suite is to document its weaknesses, which do not seem to be especially well known.  Patch 1 splits out some code into a library
usable by multiple CVS-related tests.  Patch 2 changes the library to add the -f option when invoking cvs (to make it ignore the user's ~/.cvsrc file).  Patch 3 adds a new test to t9600, namely to
compare the entire module as checked out by CVS vs. git.  Patch 4 adds a new test script t9601 that tests "git cvsimport"'s handling of CVS vendor branches.  One of these tests fails due to an
actual bug.  These ideas in the patches are logically independent of each other, but each patch assumes that the previous patches have been applied.  I would like to point out a few things about
these patches that seem a little bit unprecedented in the git test suite.  If other approaches would be preferred, please let me know.  The first is that I would like to introduce a library that can
be used by the "git cvsimport" tests in the t96xx series, simply to avoid code duplication.  I put this library in t/t96xx/cvs-lib.sh, to hopefully make its role clear.  The library has to be
sourced from the main test directory.  (It sources test-lib.sh indirectly.)  The second is that the new test script uses a small CVS repository that is part of the test suite (i.e., the *,v files
are committed directly into the git source tree).  This is different than the approach of t9600, which creates its own test CVS repository using CVS commands.  The reasons for this are:  - t9600
wants to test incremental import, so it *has to* create the   repository dynamically.  That is not the case for t9601, which only   tests a one-shot import.  - The repository for t9601 is derived
from one that already exists as   part of the cvs2svn test suite.  Reverse-engineering it into CVS   commands would be extra work.  - The code to create CVS repositories via CVS commands is not very
  illuminating, and runs slowly, as CVS throttles commits to 1 per   second (to ensure unique timestamps).  - Future tests may require even more complicated CVS repositories that   are even more
cumbersome to create, so it's good to set a precedent   now :-)  Finally, the *,v files comprising the CVS repository have blank trailing lines, triggering a warning from "git diff --check".  I
don't think that CVS strictly requires the blank lines, but they are always generated by CVS, so I left them in.  But if the "git diff --check" warnings are considered a serious problem, the blank
lines could probably be removed.  Cheers, Michael -- To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at 
http://vger.kernel.org/majordomo-info.html
