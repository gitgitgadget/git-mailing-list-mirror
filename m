Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E381FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbcFQUYo (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:44 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:52175 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964930AbcFQUYl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:41 -0400
Received: (qmail 23873 invoked from network); 17 Jun 2016 20:24:40 -0000
Received: (qmail 10171 invoked from network); 17 Jun 2016 20:24:40 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:39 -0000
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
Subject: [PATCH v5 33/38] i18n: remote: allow translations to reorder message
Date:	Fri, 17 Jun 2016 20:21:22 +0000
Message-Id: <1466194887-18236-34-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

