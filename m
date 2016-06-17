Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5847F1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbcFQUY0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:26 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52103 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964878AbcFQUYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:24 -0400
Received: (qmail 23645 invoked from network); 17 Jun 2016 20:24:18 -0000
Received: (qmail 4864 invoked from network); 17 Jun 2016 20:24:18 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:17 -0000
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
Subject: [PATCH v5 11/38] i18n: bisect: simplify error message for i18n
Date:	Fri, 17 Jun 2016 20:21:00 +0000
Message-Id: <1466194887-18236-12-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

