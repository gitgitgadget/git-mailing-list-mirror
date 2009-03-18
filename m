From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] cvsimport: add test illustrating a bug in cvsps
Date: Wed, 18 Mar 2009 11:22:43 -0700
Message-ID: <7vfxhag07g.fsf@gitster.siamese.dyndns.org>
References: <49A2EFC6.5000104@hvoigt.net> <49A37ED1.5090506@alum.mit.edu>
 <49AC1E88.1010709@hvoigt.net> <49B4FCDA.4030106@hvoigt.net>
 <49B52F74.1090006@alum.mit.edu> <49C13062.4020400@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, ydirson@altern.org,
	git@vger.kernel.org
To: Heiko Voigt <git-list@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk0RE-0003A4-MW
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396AbZCRSWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbZCRSWz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:22:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbZCRSWy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:22:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EEF7A2784;
	Wed, 18 Mar 2009 14:22:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 809C1A2781; Wed,
 18 Mar 2009 14:22:45 -0400 (EDT)
In-Reply-To: <49C13062.4020400@hvoigt.net> (Heiko Voigt's message of "Wed, 18
 Mar 2009 18:33:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA7A1244-13E9-11DE-B41F-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113646>

Heiko Voigt <git-list@hvoigt.net> writes:

> This is an updated version of the first patch and an addition to ensure
> correct handling of branches in fixes. 

I've already merged the first one to 'next' so this needs to be turned
into an incremental update if we were to continue building on top in the
git project.

I however have a bigger issue with this, perhaps because I do not have the
feeling that I fully understand where these patches are going.

Your approach seems to me to:

 - add tests to git test suite that expose issues the current cvsimport
   that runs on an unpatched cvsps has;

 - diagnose and fix

   - the issues in cvsimport, if the problem is because cvsimport is
     mishandling correct output from cvsps; or

   - the issues in cvsps (and adjust cvsimport to patched cvsps if
     necessary), if the problem is because output from cvsps is incorrect.

That all feels sane, and having the tests to verify the end result would
help the people who collaborate on these tasks.

But how much of the actual fix will be made to cvsps, and how much to
cvsimport?  If the majority of the changes are to happen on cvsps (which
is not unexpected, given that many people who tried and wrote various cvs
importers put blame on the shortcomings of its output), I am afraid that
it would not help majority of git users until the fixes to cvsps that come
out of this effort hit their distros for me to keep these tests in the
git.git repository.  I do not build and install custom cvsps (because I
haven't had to work with complex history in CVS that your improvements to
cvsps are need to deal with correctly), and I suspect many others are in
the same boat.  In addition, if your tests are in the git.git repository,
they need to say test_expect_success for people with patched cvsps and
test_expect_failure for people without, and because I suspect that the
majority of git developers do not run bleeding edge cvsps, it does not do
anything but slowing down the test suite.

It feels as if you are scratching my feet through my shoes while I still
am wearing them.  I wonder if it would be more direct and simpler approach
to add tests to cvsps and handle these improvements as part of the cvsps
maintenance/development effort, not as part of cvsimport fixes, at least
initially.

I think it is great that you started actively working on identifying and
fixing issues with cvsps, that many others have gave up and gone to
different avenues, and I certainly do not mind keeping the new tests in
'pu' for wider exposure, in order to make it easier for other people who
use cvsimport and want to collaborate with you improving it through
improving cvsps.

But I am starting to think that it was a mistake on my part to have merged
the initial set of tests to 'next'.

Thoughts?
