From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [RFC/PATCH] git push usability improvements and default change
Date: Mon,  9 Mar 2009 23:35:44 +0100
Message-ID: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:22:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgonP-0003Hb-Fu
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZCIXUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbZCIXUi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:20:38 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:36501 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbZCIXUh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:20:37 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo4y-0002Lo-OD
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:14 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112757>

Usability improvements:

"-" is now an alias for the current remote (the remote of the current
branch or "origin" as a fallback). This works both for push, fetch,
pull, remote (and possibly some others), creating a lot of nice
shortcuts I think:
git remote prune - : prune the current remote
git push - HEAD : push the current branch to a branch of the same name
git fetch - next : fetch the next branch from the current remote

git push has learned two new command line options --matching and
--current, which override any configuration.  'matching' pushes all
branches that already exist at the remote, while 'current' pushes the
current branch to whatever it is tracking

I chose this behaviour for 'current', since it is the one that I find
most useful, and there seems to be no good way of expressing it from
the command line.  Pushing a branch to an identically named branch on
a remote can now easily be done by "git push - HEAD".

Also added a new configuration option push.default, which can have values
"nothing", "matching" and "current". This variable will only be used if
you have not specificed any refspecs at all, no command line options imply
any refspecs, and the current branch has no push configuration.

This is implemented in 1-3


git push default change:

git push will by default push "nothing" instead of "matching".

This is implemented in 4-7. 4-5 are for immediate consumption, 6 is for
next major release (or later), and 7 is even later.

4 Adds a warning if you have not configured push.default
5 Changes the wording to say that the default will change. 4 and 5 can
  be applied immediately.
6 changes the deault to "nothing", but keeps the warning.
7 removes the warning entirely

Finn Arne Gangstad (7):
      remote: Make "-" an alias for the current remote
      New config option push.default
      git push: New options --matching and --current
      git push: Display warning on unconfigured default push
      git push: Document that "nothing" is the future push default
      git push: Change default for "git push" to nothing.
      git push: Remove warning for "git push" default change

 Documentation/RelNotes-1.6.3.txt |    7 +++
 Documentation/config.txt         |   18 ++++++++
 Documentation/git-push.txt       |   14 +++++--
 builtin-push.c                   |   84 +++++++++++++++++++++++++++++--------
 cache.h                          |    7 +++
 config.c                         |   23 ++++++++++
 environment.c                    |    1 +
 remote.c                         |    2 +-
 transport.h                      |    9 ++++
 9 files changed, 142 insertions(+), 23 deletions(-)

- Finn Arne
