From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-stash: improve synopsis in help and manual page
Date: Sat, 16 Aug 2008 05:27:31 +0200
Message-ID: <1218857251-2971-1-git-send-email-s-beyer@gmx.net>
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 05:28:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUCTD-0005CB-QL
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 05:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYHPD1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 23:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYHPD1i
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 23:27:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:45473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751307AbYHPD1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 23:27:37 -0400
Received: (qmail invoked by alias); 16 Aug 2008 03:27:35 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 16 Aug 2008 05:27:35 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19Z/hJEcoRZWnMeK4MxrisyThtjCIi/UpO0qp9Mzt
	Jz5L9cRr0syIrH
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KUCRv-0000mJ-GQ; Sat, 16 Aug 2008 05:27:31 +0200
X-Mailer: git-send-email 1.6.0.rc3.10.g5a13c.dirty
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92531>

"git stash -h" showed some incomplete and ugly usage information.
For example, the useful "--keep-index" option for "save" or the "--index"
option for  "apply" were not shown. Also in the documentation synopsis they
were not shown, so that there is no incentive to scroll down and even see
that such options exist.

This patch improves the git-stash synopsis in the documentation by
mentioning that further options to the stash commands and then copies
this synopsis to the usage information string of git-stash.sh.

For the latter, the dashless git command string has to be inserted on the
second and the following usage lines. The code of this is taken from
git-sh-setup so that all lines will show the command string.

Note that the "create" command is not advertised at all now, because
it was not mentioned in git-stash.txt.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
   Hi,

   btw, should the "create" command be used directly at all?
   Then a line for this should perhaps be added.

   Regards,
     Stephan

   PS: This or something like this is meant to go into 1.6.0,
       so I hope this is not too late :-)

 Documentation/git-stash.txt |    7 ++++---
 git-stash.sh                |    8 +++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7d50d74..4dd42b4 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,10 +8,11 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git stash' list
-'git stash' (show | apply | drop | pop ) [<stash>]
+'git stash' list [<options>]
+'git stash' (show | drop | pop ) [<stash>]
+'git stash' [--index] apply [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [<message>]]
+'git stash' [--keep-index] [save [<message>]]
 'git stash' clear
 
 DESCRIPTION
diff --git a/git-stash.sh b/git-stash.sh
index 5ad2c4b..d790676 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,13 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi
 
-USAGE='[  | save | list | show | apply | clear | drop | pop | create | branch ]'
+dashless=$(basename "$0" | sed -e 's/-/ /')
+USAGE="list [<options>]
+   or: $dashless (show | drop | pop ) [<stash>]
+   or: $dashless [--index] apply [<stash>]
+   or: $dashless branch <branchname> [<stash>]
+   or: $dashless [--keep-index] [save [<message>]]
+   or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
-- 
1.6.0.rc3.10.g5a13c.dirty
