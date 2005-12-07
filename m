From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-object-id: cleanup id verifying
Date: Wed, 7 Dec 2005 22:39:29 +0100
Message-ID: <20051207213929.GB25890@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 22:41:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek70r-0004sM-7x
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 22:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVLGVjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 16:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVLGVjb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 16:39:31 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:9927 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030361AbVLGVja (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 16:39:30 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 7DEB76DFE17; Wed,  7 Dec 2005 22:38:35 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 432DA6DFDD7; Wed,  7 Dec 2005 22:38:35 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A0AA861556; Wed,  7 Dec 2005 22:39:29 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13344>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 36c0d9fae209ab7fa889333e8eebef22e7f0f55c
tree 364122ed83e2b920b0f0f5fe18c608a22aea6d07
parent 964e5ec2dd0ff3b073fbb9f3ad6f11c640a96a04
author Jonas Fonseca <fonseca@diku.dk> Wed, 07 Dec 2005 08:11:43 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Wed, 07 Dec 2005 08:11:43 +0100

 cg-object-id |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cg-object-id b/cg-object-id
index c7efa8a..56d9f91 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -50,6 +50,7 @@ normalize_id()
 	revid="$(git-rev-parse --verify "$id^0" 2>/dev/null)"
 	if [ "$revid" ]; then
 		id="$revid"
+		valid=1
 
 	# Short id's must be lower case and at least 4 digits.
 	elif [[ "$id" == [0-9a-f][0-9a-f][0-9a-f][0-9a-f]* ]]; then
@@ -60,8 +61,8 @@ normalize_id()
 		idmatch=($_git_objects/$idpref/$idpost*)
 
 		if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
-			exid=$idpref${idmatch#$_git_objects/$idpref/}
-			[ ${#exid} -eq 40 ] && [ "$(git-rev-parse --revs-only "$exid")" ] && id="$exid"
+			id=$idpref${idmatch#$_git_objects/$idpref/}
+			[ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
 		elif [ ${#idmatch[*]} -gt 1 ]; then
 			echo "Ambiguous id: $id" >&2
 			echo "${idmatch[@]}" >&2
@@ -69,13 +70,12 @@ normalize_id()
 		fi
 	fi
 
-	valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
-	if ([ "$id" ] && [ "$id" != " " ]) && [ ! "$valid" ]; then
+	if [ "$id" != " " ] && [ ! "$valid" ]; then
 		reqsecs=$(date --date="$id" +'%s' 2>/dev/null)
 
 		if [ "$reqsecs" ]; then
 			id=$(git-rev-list --min-age=$reqsecs --max-count=1 HEAD)
-			valid=; [ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
+			[ ${#id} -eq 40 ] && [ "$(git-rev-parse --revs-only "$id")" ] && valid=1
 		fi
 	fi
 

-- 
Jonas Fonseca
