From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 34/39] i18n: remote: allow translations to reorder message
Date: Wed,  1 Jun 2016 18:12:58 +0000
Message-ID: <1464804783-10195-5-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 20:14:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Aej-0006c3-1f
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161288AbcFASNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 14:13:39 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:34633 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754961AbcFASNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 14:13:38 -0400
Received: (qmail 9669 invoked from network); 1 Jun 2016 18:13:30 -0000
Received: (qmail 18559 invoked from network); 1 Jun 2016 18:13:30 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 18:13:24 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296139>

Before this patch, translations couldn't place the branch name
where it was better fit in the message "and with remote <branch_name>".
Allow translations that, instead of forcing the branch name to display
right of the message.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/remote.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9f934cb..7f0f78b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -952,7 +952,7 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	struct show_info *show_info = cb_data;
 	struct branch_info *branch_info = item->util;
 	struct string_list *merge = &branch_info->merge;
-	const char *also;
+	int width = show_info->width + 4;
 	int i;
 
 	if (branch_info->rebase && branch_info->merge.nr > 1) {
@@ -969,13 +969,12 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 		return 0;
 	} else if (show_info->any_rebase) {
 		printf_ln(_(" merges with remote %s"), merge->items[0].string);
-		also = _("    and with remote");
+		width++;
 	} else {
 		printf_ln(_("merges with remote %s"), merge->items[0].string);
-		also = _("   and with remote");
 	}
 	for (i = 1; i < merge->nr; i++)
-		printf("    %-*s %s %s\n", show_info->width, "", also,
+		printf(_("%-*s    and with remote %s\n"), width, "",
 		       merge->items[i].string);
 
 	return 0;
-- 
2.7.3
