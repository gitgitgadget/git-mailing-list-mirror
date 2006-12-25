From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/5] git-add/git-rm updates
Date: Mon, 25 Dec 2006 03:09:22 -0800
Message-ID: <7vr6uomdul.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 25 12:09:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gyni8-0003R3-HB
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 12:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbWLYLJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 06:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754408AbWLYLJY
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 06:09:24 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49234 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbWLYLJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 06:09:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225110923.RIOK2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 06:09:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2z9c1W00f1kojtg0000000; Mon, 25 Dec 2006 06:09:36 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35381>

This series futzes with a pair of functions in dir.c machinery
and enhances git-add and git-rm command.

[PATCH 1/5] match_pathspec() -- return how well the spec matched

The function match_pathspec() takes the pathspec given from the
command line and tells if a given name matches it.  This
enhances its return value so that the command can tell how well
the name matches.  Earlier, the caller could not tell if matched
pathspec was exactly the same as the name, was a fileglob that
matched the name, or was a leading directory.

[PATCH 2/5] git-rm: update to saner semantics
[PATCH 3/5] t3600: update the test for updated git rm

This updates git-rm to saner semantics Linus suggested on the
list earlier, and updates the tests.  When a path is removed, it
is removed both from the working tree and from the index.  As a
safety measure, the path is required to be cache-clean, and also
must match the HEAD (unless it is before the initial commit on
the branch).

[PATCH 4/5] read_directory: show_both option.

The function read_directory() is the workhorse to traverse
working tree while taking '.gitignore' into account.  This
updates the function to allow callers that are interested in
both ignored and non-ignored paths to get both paths so that it
can do its own filtering on the result.

[PATCH 5/5] git-add: add ignored files when asked explicitly.

One thing many people found confusing about git-add was that a
file whose name matches an ignored pattern could not be added.
This is an RFC fix for the problem.
