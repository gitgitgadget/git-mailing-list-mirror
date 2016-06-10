From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 08/44] builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
Date: Fri, 10 Jun 2016 22:10:42 +0200
Message-ID: <20160610201118.13813-9-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSoR-0004b4-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbcFJUNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:13:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33263 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbcFJULw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:11:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so1067459wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=drUSlGetF8oZGaijeR7r/El0q3eCDzfQfOjPRT3xnd0=;
        b=mJvJvY+Y1O26tr5otfV7X2QijG7c2S6VIiCVKJiCjBkZA2aqWFqgIUS6/VV53cneOc
         hkB1S6HPD2++bqg7jXF6g7Mx8hfPGm6lJfr1z74f6JYfe4zhEst4xB5O1GeAvufdW0UH
         M3cYhriavWDB79v/PHJBwrKXJ8PzywAPGIBG2k9EhQxTSRW8wJAkT3JpEZKG4qYdRUrX
         7TonIl4nj7vWkiSMsoTnrDe4lH24G3SxZ0jTGNsmff8NogDrZUNV5qePFcA5cofbkT1S
         3ZczN8Gy5nxlSkmMSgMSVar/KQTWD5RTRf7LG46+bjwhFDBEPFZ3a1iSBJCaVOlZqzBZ
         I2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=drUSlGetF8oZGaijeR7r/El0q3eCDzfQfOjPRT3xnd0=;
        b=DNpCKdg35L0xoWi7odxJ1Ah6os8tNWi0VX9xDdOoMwGHsCzaIBtG/rLa/ryeuDUrse
         kudvHeEmAaq3vcs49iPOWS9zdPp/KVyqb+80vFpjYjhRPo4tJUxNnHiw48f3k8W08i+O
         letgm+ALJ8AegQabj66/qhuU8hMkfIeXrPYLV4Qpt8rtMZvWo/QGJTY7+9Ju4JjnNXJ3
         d+96SySVZk3R3JGFk3NcauWCndJJeW5SCA53bzeGjfnAicNMCl+PcrG/b1eYuQkLtqJM
         LXely06IPgw218i+svzmAJHO/UfXPbnnNcQAzzCqN4owiMUSbd+WHcO6M5K5ceL9Dtq6
         qiNw==
X-Gm-Message-State: ALyK8tKH114i6MbNrCTuuRPC1o/Sy3pghI3KAYhZGhkfiby09/s5GeuEBtPsLy8TmYyRlw==
X-Received: by 10.194.133.161 with SMTP id pd1mr3803683wjb.16.1465589510716;
        Fri, 10 Jun 2016 13:11:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:11:50 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297065>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_ignorewhitespace_option() should return
-1 instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index e56e754..e2f970d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -57,20 +57,20 @@ static int parse_whitespace_option(struct apply_state *state, const char *option
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-static void parse_ignorewhitespace_option(struct apply_state *state,
-					  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
 	    !strcmp(option, "none")) {
 		state->ws_ignore_action = ignore_ws_none;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "change")) {
 		state->ws_ignore_action = ignore_ws_change;
-		return;
+		return 0;
 	}
-	die(_("unrecognized whitespace ignore option '%s'"), option);
+	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
 static void set_default_whitespace_mode(struct apply_state *state)
@@ -4616,8 +4616,8 @@ static void init_apply_state(struct apply_state *state,
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
 		exit(1);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
+	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
+		exit(1);
 }
 
 static void clear_apply_state(struct apply_state *state)
-- 
2.9.0.rc2.362.g3cd93d0
