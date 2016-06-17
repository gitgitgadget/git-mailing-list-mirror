Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7376D1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbcFQUYJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:09 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35319 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932065AbcFQUYI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:08 -0400
Received: (qmail 2103 invoked from network); 17 Jun 2016 20:24:06 -0000
Received: (qmail 1864 invoked from network); 17 Jun 2016 20:24:06 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:04 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 05/38] i18n: sequencer: mark entire sentences for translation
Date:	Fri, 17 Jun 2016 20:20:54 +0000
Message-Id: <1466194887-18236-6-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

