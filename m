From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] rebase-i: style fix
Date: Mon,  5 Jul 2010 23:27:10 -0700
Message-ID: <1278397631-20658-2-git-send-email-gitster@pobox.com>
References: <1278397631-20658-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 08:27:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW1co-0003GP-VK
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 08:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab0GFG1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 02:27:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0GFG1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 02:27:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AECF9C0273
	for <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AqML
	hLzx01JxBvI86ayqsPxSuK4=; b=VMXdU0+Jn94lVqQ7Y9/ItrjRj++RD1pISqio
	pMilwaeAuW78uMXIoyfO9GVzzB9oz//A5+V67ClH2sssh3PaCLm+7PJnF4XyFNXw
	UbxTAto4/QG34FsEC93dzq83++mU16y5bdBp8X3p6pYmI4ZalKogszyy6SVmFmg9
	bGBPngw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fy5ftD
	VVM6Njno8LJCJiK9oGMEBL0M7PsqggRUOIurkFvUdAExmLTMuo7vqFL8sthAaW6K
	ELsoRMOjiNnkOtogmC4qGU+MA24BXeNNKu6aBt7E2VJvUf5Ux+71gn3N0Aft35Qo
	IphZydCs//qaBPMWHNHHcEcdqEipAOiwpj4T4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9648C0272
	for <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:15 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D44EC0270 for
 <git@vger.kernel.org>; Tue,  6 Jul 2010 02:27:14 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.209.g3868f
In-Reply-To: <1278397631-20658-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 850AED1A-88C7-11DF-B6FB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150327>

Case arms should align with "case" and "esac".

Do not cat a file into a pipeline; just make the downstream command
read from the file.

Having a while statement as a downstream of a pipe is fine, but
the loop should begin on its own line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6b86abc..ed57552 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -263,10 +263,10 @@ pick_one_preserving_merges () {
 	then
 		if test "$fast_forward" = t
 		then
-			cat "$DOTEST"/current-commit | while read current_commit
+			while read current_commit
 			do
 				git rev-parse HEAD > "$REWRITTEN"/$current_commit
-			done
+			done <"$DOTEST"/current-commit
 			rm "$DOTEST"/current-commit ||
 			die "Cannot write current commit's replacement sha1"
 		fi
@@ -440,9 +440,9 @@ record_in_rewritten() {
 	echo "$oldsha1" >> "$REWRITTEN_PENDING"
 
 	case "$(peek_next_command)" in
-	    squash|s|fixup|f)
+	squash|s|fixup|f)
 		;;
-	    *)
+	*)
 		flush_rewritten_pending
 		;;
 	esac
@@ -890,7 +890,8 @@ first and then run 'git rebase --continue' again."
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
 			$REVISIONS | \
-			sed -n "s/^>//p" | while read shortsha1 rest
+			sed -n "s/^>//p" |
+		while read shortsha1 rest
 		do
 			if test t != "$PRESERVE_MERGES"
 			then
-- 
1.7.2.rc1.209.g3868f
