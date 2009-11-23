From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] mergetool--lib: simplify guess_merge_tool()
Date: Tue, 24 Nov 2009 00:29:17 +0100
Message-ID: <4B0B1ACD.6000008@lsrfire.ath.cx>
References: <1258560919-28054-1-git-send-email-bert.wesarg@googlemail.com> <7v1vjvebem.fsf@alter.siamese.dyndns.org> <4B095F91.8030305@lsrfire.ath.cx> <20091123112221.GA7175@sajinet.com.pe> <7vtywlyu43.fsf@alter.siamese.dyndns.org> <4B0B185B.4090305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 00:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCiLZ-0005rT-3c
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 00:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbZKWX3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 18:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756356AbZKWX3R
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 18:29:17 -0500
Received: from india601.server4you.de ([85.25.151.105]:47342 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbZKWX3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 18:29:17 -0500
Received: from [10.0.1.101] (p57B7BDDD.dip.t-dialin.net [87.183.189.221])
	by india601.server4you.de (Postfix) with ESMTPSA id 4637B2F8051;
	Tue, 24 Nov 2009 00:29:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B0B185B.4090305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133542>

Use a case statement instead of calling grep to find out if the editor's
name contains the string "vim".  Remove the check for emacs, as this
branch did the same as the default one anyway.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This removes all grep calls from this script.

 git-mergetool--lib.sh |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f7c571e..5b62785 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -338,15 +338,14 @@ guess_merge_tool () {
 		fi
 		tools="$tools gvimdiff diffuse ecmerge p4merge araxis"
 	fi
-	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
-		# $EDITOR is emacs so add emerge as a candidate
-		tools="$tools emerge vimdiff"
-	elif echo "${VISUAL:-$EDITOR}" | grep vim > /dev/null 2>&1; then
-		# $EDITOR is vim so add vimdiff as a candidate
+	case "${VISUAL:-$EDITOR}" in
+	*vim*)
 		tools="$tools vimdiff emerge"
-	else
+		;;
+	*)
 		tools="$tools emerge vimdiff"
-	fi
+		;;
+	esac
 	echo >&2 "merge tool candidates: $tools"
 
 	# Loop over each candidate and stop when a valid merge tool is found.
-- 
1.6.5
