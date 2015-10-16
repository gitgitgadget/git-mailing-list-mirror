From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v2 4/4] git rebase -i: Use newly added --count-lines option for stripspace
Date: Fri, 16 Oct 2015 17:16:45 +0200
Message-ID: <1445008605-16534-5-git-send-email-tklauser@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 17:17:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn6ki-000388-5T
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 17:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbbJPPQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 11:16:50 -0400
Received: from mail.zhinst.com ([212.126.164.98]:36619 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbbJPPQt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 11:16:49 -0400
Received: from ziws06.zhinst.com ([10.42.0.71])
	by mail.zhinst.com (Kerio Connect 8.5.2);
	Fri, 16 Oct 2015 17:16:45 +0200
X-Mailer: git-send-email 2.6.1.148.g7927db1
In-Reply-To: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279745>

Use the newly added --count-lines option for 'git stripspace' to count
lines instead of piping the entire output to 'wc -l'.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---

Implements the small project idea from
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#implement_.27--count-lines.27_in_.27git_stripspace.27

 git-rebase--interactive.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d65c06e..f80da30 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -120,9 +120,9 @@ mark_action_done () {
 	sed -e 1q < "$todo" >> "$done"
 	sed -e 1d < "$todo" >> "$todo".new
 	mv -f "$todo".new "$todo"
-	new_count=$(git stripspace --strip-comments <"$done" | wc -l)
+	new_count=$(git stripspace --strip-comments --count-lines <"$done")
 	echo $new_count >"$msgnum"
-	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
+	total=$(($new_count + $(git stripspace --strip-comments --count-lines <"$todo")))
 	echo $total >"$end"
 	if test "$last_count" != "$new_count"
 	then
@@ -1243,7 +1243,7 @@ test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"
 
-todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+todocount=$(git stripspace --strip-comments --count-lines <"$todo")
 todocount=${todocount##* }
 
 cat >>"$todo" <<EOF
-- 
2.6.1.148.g7927db1
