From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 00/11] Build in clone
Date: Sat, 8 Mar 2008 18:03:52 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081803250.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY85g-00087e-AT
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYCHXDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYCHXDy
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:03:54 -0500
Received: from iabervon.org ([66.92.72.58]:42217 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbYCHXDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:03:54 -0500
Received: (qmail 18545 invoked by uid 1000); 8 Mar 2008 23:03:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:03:52 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76601>

This series is getting closer to being ready, and I think a number of
the initial patches are ready. In particular, 1-3 are tests that work
unexceptionally with the current implementation, and point out
potential bugs in a C version (which I've fixed); 4-7 are changes and
additions that should be pretty uncontraversial, which later code will
need; 8 is a potentially more contraversial library feature.

9 gives API access to init-db, and may or may not be ready, although I
think it looks promising now; 10 builds in clone and probably needs
more work; and 11 adds support for figuring out what the user means
with a bundle and should probably get squashed into 10.

(Unrelated note: it might actually be good to use some sort of log
instead of shortlog in --cover-letter, at least as an option, in order
to list the contents of the series with the patch numbers and order
they have)

Daniel Barkalow (8):
      Test that --reference actually suppresses fetching referenced objects
      Mark the list of refs to fetch as const
      Add a library function to add an alternate to the alternates file
      Add a function to set a non-default work tree
      Have a constant extern refspec for "--tags"
      Allow for having for_each_ref() list some refs that aren't local
      Provide API access to init_db()
      Build in clone

Johan Herland (2):
      Add test for cloning with "--reference" repo being a subset of source repo
      Add a test for another combination of --reference

Johannes Schindelin (1):
      Support bundles in builtin-clone

 Makefile                      |    2 +-
 builtin-clone.c               |  553 +++++++++++++++++++++++++++++++++++++++++
 builtin-fetch.c               |   10 +-
 builtin-init-db.c             |  183 +++++++-------
 builtin.h                     |    1 +
 cache.h                       |    6 +
 contrib/examples/git-clone.sh |  518 ++++++++++++++++++++++++++++++++++++++
 environment.c                 |    6 +
 git-clone.sh                  |  518 --------------------------------------
 git.c                         |    1 +
 refs.c                        |   18 ++
 refs.h                        |    9 +
 remote.c                      |    9 +
 remote.h                      |    2 +
 sha1_file.c                   |   19 ++
 t/t5700-clone-reference.sh    |   35 +++-
 transport.c                   |   16 +-
 transport.h                   |    4 +-
 18 files changed, 1283 insertions(+), 627 deletions(-)
 create mode 100644 builtin-clone.c
 create mode 100755 contrib/examples/git-clone.sh
 delete mode 100755 git-clone.sh
