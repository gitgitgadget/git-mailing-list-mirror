From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/7] Use 'printf %s $x' notation in t5401
Date: Wed, 30 Jan 2008 01:21:56 -0500
Message-ID: <20080130062156.GA15838@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:22:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6LO-0001Rm-3j
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbYA3GWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbYA3GWE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:22:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58694 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbYA3GWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:22:02 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK6Kc-0000Ad-Is; Wed, 30 Jan 2008 01:21:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 452F120FBAE; Wed, 30 Jan 2008 01:21:56 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72030>

We only care about getting what should be an empty string and
sending it to a file, without a trailing LF, so the empty string
translates into a 0 byte file.  Earlier when I originally wrote
these lines Mac OS X allowed the format string of printf to be
the empty string, but more recent versions appear to have been
'improved' with error messages if the format is not given.

This may cause problems if we ever wind up with changes to the hook
tests.  A minor cleanup makes the test more safe on all systems,
by conforming to accepted printf conventions.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5401-update-hooks.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 3eea306..9734fc5 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 
 cat >victim/.git/hooks/pre-receive <<'EOF'
 #!/bin/sh
-printf "$@" >>$GIT_DIR/pre-receive.args
+printf %s "$@" >>$GIT_DIR/pre-receive.args
 cat - >$GIT_DIR/pre-receive.stdin
 echo STDOUT pre-receive
 echo STDERR pre-receive >&2
@@ -35,7 +35,7 @@ chmod u+x victim/.git/hooks/pre-receive
 cat >victim/.git/hooks/update <<'EOF'
 #!/bin/sh
 echo "$@" >>$GIT_DIR/update.args
-read x; printf "$x" >$GIT_DIR/update.stdin
+read x; printf %s "$x" >$GIT_DIR/update.stdin
 echo STDOUT update $1
 echo STDERR update $1 >&2
 test "$1" = refs/heads/master || exit
@@ -44,7 +44,7 @@ chmod u+x victim/.git/hooks/update
 
 cat >victim/.git/hooks/post-receive <<'EOF'
 #!/bin/sh
-printf "$@" >>$GIT_DIR/post-receive.args
+printf %s "$@" >>$GIT_DIR/post-receive.args
 cat - >$GIT_DIR/post-receive.stdin
 echo STDOUT post-receive
 echo STDERR post-receive >&2
@@ -54,7 +54,7 @@ chmod u+x victim/.git/hooks/post-receive
 cat >victim/.git/hooks/post-update <<'EOF'
 #!/bin/sh
 echo "$@" >>$GIT_DIR/post-update.args
-read x; printf "$x" >$GIT_DIR/post-update.stdin
+read x; printf %s "$x" >$GIT_DIR/post-update.stdin
 echo STDOUT post-update
 echo STDERR post-update >&2
 EOF
-- 
1.5.4.rc5.1126.g6ba14
