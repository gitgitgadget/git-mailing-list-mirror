From: Greg Price <price@MIT.EDU>
Subject: [PATCH] rebase -i: Simplify handling of invalid commands.
Date: Sat, 14 Nov 2009 03:11:15 -0500
Message-ID: <20091114081115.GM30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 09:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Dk9-0008NS-Sj
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 09:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109AbZKNIMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 03:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbZKNIMD
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 03:12:03 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:36180 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752954AbZKNIMC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 03:12:02 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id nAE8B1o4001210;
	Sat, 14 Nov 2009 03:11:01 -0500 (EST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id nAE8BMjZ019077;
	Sat, 14 Nov 2009 03:11:22 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132861>

A few weeks ago there was a bug report that some invalid commands
produced confusing error messages.  The fix could have made things
simpler.  There's no need for die_with_patch in this case, because its
purpose is to tell rerere and a future rebase --continue about a
commit that we just attempted, and we didn't attempt any commit.  So
just use a plain "die" unconditionally.

Signed-off-by: Greg Price <price@mit.edu>
---
 git-rebase--interactive.sh |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 53ad248..6d0ca7b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -416,12 +416,7 @@ do_next () {
 		;;
 	*)
 		warn "Unknown command: $command $sha1 $rest"
-		if git rev-parse --verify -q "$sha1" >/dev/null
-		then
-			die_with_patch $sha1 "Please fix this in the file $TODO."
-		else
-			die "Please fix this in the file $TODO."
-		fi
+		die "Please fix this in the file $TODO."
 		;;
 	esac
 	test -s "$TODO" && return
-- 
1.6.5.2.27.g906c6.dirty
