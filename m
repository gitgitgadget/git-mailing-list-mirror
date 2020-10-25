Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7BC4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06111222EC
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420280AbgJYWl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420274AbgJYWlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:55 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977DC061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:55 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-Rg; Sun, 25 Oct 2020 22:27:17 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 09/21] trailer: refactor print_tok_val into taking item
Date:   Sun, 25 Oct 2020 22:26:40 +0100
Message-Id: <20201025212652.3003036-10-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on st.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXp-0007u5-Rg; Sun, 25 Oct 2020 22:27:17 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

No functional change intended.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 trailer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index 0986d4267e..71921e70ce 100644
--- a/trailer.c
+++ b/trailer.c
@@ -147,22 +147,22 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(FILE *outfile, const char *tok, const char *val)
+static void print_item(FILE *outfile, const struct trailer_item *item)
 {
 	char c;
 
-	if (!tok) {
-		fprintf(outfile, "%s\n", val);
+	if (!item->token) {
+		fprintf(outfile, "%s\n", item->value);
 		return;
 	}
 
-	c = last_non_space_char(tok);
+	c = last_non_space_char(item->token);
 	if (!c)
 		return;
 	if (strchr(separators, c))
-		fprintf(outfile, "%s%s\n", tok, val);
+		fprintf(outfile, "%s%s\n", item->token, item->value);
 	else
-		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
+		fprintf(outfile, "%s%c %s\n", item->token, separators[0], item->value);
 }
 
 static void print_all(FILE *outfile, struct list_head *head,
@@ -174,7 +174,7 @@ static void print_all(FILE *outfile, struct list_head *head,
 		item = list_entry(pos, struct trailer_item, list);
 		if ((!opts->trim_empty || strlen(item->value) > 0) &&
 		    (!opts->only_trailers || item->token))
-			print_tok_val(outfile, item->token, item->value);
+			print_item(outfile, item);
 	}
 }
 
-- 
2.25.1

