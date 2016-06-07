From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 11/38] i18n: bisect: simplify error message for i18n
Date: Tue,  7 Jun 2016 11:52:10 +0000
Message-ID: <1465300357-7557-12-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:54:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFaZ-0007Nz-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbcFGLyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:54:18 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:57899 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752732AbcFGLyP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:54:15 -0400
Received: (qmail 752 invoked from network); 7 Jun 2016 11:54:14 -0000
Received: (qmail 14182 invoked from network); 7 Jun 2016 11:54:14 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:54:08 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296640>

The message was not being extracted by xgettext, although it was marked
for translation, seemingly because it contained a command substitution.
Moreover, eval_gettext should be used instead of gettext for strings
with substitution.

See step 4. of section 15.5.2.1 Preparing Shell Scripts for
Internationalization from gettext manual [1]:
"Simplify translatable strings so that they don't contain command
substitution ("`...`" or "$(...)") [...]"

[1] http://www.gnu.org/software/gettext/manual/html_node/Preparing-Shell-Scripts.html

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-bisect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..737bf05 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -277,8 +277,9 @@ bisect_state() {
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
 	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
-		rev=$(git rev-parse --verify $(bisect_head)) ||
-			die "$(gettext "Bad rev input: $(bisect_head)")"
+		bisected_head=$(bisect_head)
+		rev=$(git rev-parse --verify "$bisected_head") ||
+			die "$(eval_gettext "Bad rev input: \$bisected_head")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
-- 
2.7.3
