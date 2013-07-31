From: worley@alum.mit.edu (Dale R. Worley)
Subject: Making a patch:  "git format-patch" does not produce the documented format
Date: Wed, 31 Jul 2013 17:31:47 -0400
Message-ID: <201307312131.r6VLVliK028321@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 23:39:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4e6m-0004tQ-Gy
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab3GaVi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 17:38:56 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:39457
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760634Ab3GaViz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Jul 2013 17:38:55 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2013 17:38:55 EDT
Received: from omta17.westchester.pa.mail.comcast.net ([76.96.62.89])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id 726y1m0041vXlb85C9Xo27; Wed, 31 Jul 2013 21:31:48 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta17.westchester.pa.mail.comcast.net with comcast
	id 79Xo1m00Z1KKtkw3d9XoQA; Wed, 31 Jul 2013 21:31:48 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.5/8.14.5) with ESMTP id r6VLVlN8028322;
	Wed, 31 Jul 2013 17:31:47 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.5/8.14.5/Submit) id r6VLVliK028321;
	Wed, 31 Jul 2013 17:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375306308;
	bh=M32CGvx0rNKbrLL64u866rJyS9TFQh4+DVwQRY2wMPY=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=WhVkJABZ7MBV3hljNBjDlOsFtlDpJtgh7sgYyk9qbJsbmF9jHB9YjW1eo+gmbt5kK
	 ujdgTSXx/2AjbMb0gLh+myn5aFmgXIVzdwbYoc5lGNByX1w82Qm4qOEvs33WFQ+ALv
	 of5DvlW4y8jyT2s2sUJJEhZVI7a8Em9AC9KY1Os1J2Eu1Q7hQ0ezcID5KcmMgX0QqM
	 NZa+HIZ1/HlA+zPk2+qP/NqvY8/eEZ4pvGncDopECmmEE22JHHYjbnIfuPVjeHrNCK
	 yUdxcK4k6PF6QfWHlOJ4ML0WveQ7tmlNm87uXF/5wHtqeggyKHc5Jl8GTN08tilAEs
	 Ltlvijc4W7Rtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231467>

I'm working on writing a patch, but I'm running into a problem.  The
patch itself is from this commit:

    $ git log -1
    commit 07a25537909dd277426818a39d9bc4235e755383
    Author: Dale Worley <worley@ariadne.com>
    Date:   Thu Jul 18 18:43:12 2013 -0400

	open() returns -1 on failure, and indeed 0 is a possible success value
	if the user closed stdin in our process.  Fix the test.
    $ 

But the output of "git format-patch" is:

    From 07a25537909dd277426818a39d9bc4235e755383 Mon Sep 17 00:00:00 2001
    From: Dale Worley <worley@ariadne.com>
    Date: Thu, 18 Jul 2013 18:43:12 -0400
    Subject: [PATCH] open() returns -1 on failure, and indeed 0 is a possible
     success value if the user closed stdin in our process.  Fix
     the test.

    ---
     t/t0070-fundamental.sh |    7 +++++++
     wrapper.c              |    2 +-
     2 files changed, 8 insertions(+), 1 deletions(-)

    diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
    index 986b2a8..d427f3a 100755
    --- a/t/t0070-fundamental.sh
    +++ b/t/t0070-fundamental.sh
    @@ -25,6 +25,13 @@ test_expect_success POSIXPERM,SANITY 'mktemp to unwritable directory prints file
	    grep "cannotwrite/test" err
    [...]

Notice that the whole commit message has been formatted as if it is
part of the Subject line, and the line breaks in the commit message
have been refilled.

The file Documentation/SubmittingPatches says that "git format-patch"
produces patches in the best format, but the manual page shows an
example more like this:

    From 8f72bad1baf19a53459661343e21d6491c3908d3 Mon Sep 17 00:00:00 2001
    From: Tony Luck <tony.luck@intel.com>
    Date: Tue, 13 Jul 2010 11:42:54 -0700
    Subject: [PATCH] Put ia64 config files on the
    MIME-Version: 1.0
    Content-Type: text/plain; charset=UTF-8
    Content-Transfer-Encoding: 8bit

    arch/arm config files were slimmed down using a python script
    (See commit c2330e286f68f1c408b4aa6515ba49d57f05beae comment)
    [...]

That is, the first line of the commit message is in the Subject and
the remaining lines are in the message body.  As far as I can tell,
that's what SubmittingPatches prescribes.  And that is what I see in
the Git mailing list on vger.

(This is with git 1.8.3.3.)

Exactly how should the commit message be inserted into the patch
e-mail?  What needs to be updated so the code is consistent with the
documentation?

Dale
