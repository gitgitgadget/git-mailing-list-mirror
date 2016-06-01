From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 05/39] i18n: sequencer: mark entire sentences for translation
Date: Wed,  1 Jun 2016 16:40:55 +0000
Message-ID: <1464799289-7639-6-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:43:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89En-0004Ip-Av
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbcFAQnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:43:03 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47312 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932803AbcFAQnA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:43:00 -0400
Received: (qmail 19411 invoked from network); 1 Jun 2016 16:42:54 -0000
Received: (qmail 6776 invoked from network); 1 Jun 2016 16:42:53 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:42:48 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296103>

Mark entire sentences of error message rather than assembling one using
placeholders (e.g. "Cannot %s during a %s").

That would facilitate translation work because it is easier to translate
a entire sentence than translating pieces. We would have better
translations at the expense of source code verbosity.

Moreover, translators can now 1) translate the terms "revert" and
"cherry-pick" if they please 2) have more leeway to adapt their
translations.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 sequencer.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4687ad4..88a7c78 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -697,9 +697,14 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	 * opts; we don't support arbitrary instructions
 	 */
 	if (action != opts->action) {
-		const char *action_str;
-		action_str = action == REPLAY_REVERT ? "revert" : "cherry-pick";
-		error(_("Cannot %s during a %s"), action_str, action_name(opts));
+		if (action == REPLAY_REVERT)
+		      error((opts->action == REPLAY_REVERT)
+			    ? _("Cannot revert during a another revert.")
+			    : _("Cannot revert during a cherry-pick."));
+		else
+		      error((opts->action == REPLAY_REVERT)
+			    ? _("Cannot cherry-pick during a revert.")
+			    : _("Cannot cherry-pick during another cherry-pick."));
 		return NULL;
 	}
 
-- 
2.7.3
