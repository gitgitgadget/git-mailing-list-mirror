From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 5/5] stash list: drop the default limit of 10 stashes
Date: Mon, 19 Oct 2009 17:48:12 +0200
Message-ID: <25199f42f705f14d58876777241e0d561e2e10d9.1255966426.git.trast@student.ethz.ch>
References: <cover.1255966426.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 17:49:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzuUF-0000tw-Q5
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 17:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbZJSPsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 11:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbZJSPsw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 11:48:52 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28915 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932109AbZJSPss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 11:48:48 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 19 Oct
 2009 17:48:50 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 19 Oct
 2009 17:48:48 +0200
X-Mailer: git-send-email 1.6.5.1.137.gefbc6
In-Reply-To: <cover.1255966426.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130711>

'git stash list' had an undocumented limit of 10 stashes, unless other
git-log arguments were specified.  This surprised at least one user,
but possibly served to cut the output below a screenful without using
a pager.

Since the last commit, 'git stash list' will fire up a pager according
to the same rules as the 'git log' it calls, so we can drop the limit.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-stash.txt |    3 +--
 git-stash.sh                |    5 -----
 2 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index fafe728..3f14b72 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -78,8 +78,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 ----------------------------------------------------------------
 +
 The command takes options applicable to the 'git-log'
-command to control what is shown and how. If no options are set, the
-default is `-n 10`. See linkgit:git-log[1].
+command to control what is shown and how. See linkgit:git-log[1].
 
 show [<stash>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index f8847c1..f796c2f 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -382,11 +382,6 @@ test -n "$seen_non_option" || set "save" "$@"
 case "$1" in
 list)
 	shift
-	if test $# = 0
-	then
-		set x -n 10
-		shift
-	fi
 	list_stash "$@"
 	;;
 show)
-- 
1.6.5.1.137.gefbc6
