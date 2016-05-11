From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 58/94] builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
Date: Wed, 11 May 2016 15:17:09 +0200
Message-ID: <20160511131745.2914-59-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U42-0003kW-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbcEKNU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36444 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbcEKNU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so9352151wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z5M9JpRkO8wl+5753/8BKn4/+rPgOlEujw5E9c4XCUo=;
        b=JkI8X5y7PnWrMuoBl3yRK9HiN6QK6tBDtXZ77t+ru+cH+uV8k8le6LGVfLFzJ8T37u
         fYq9Dsujmt1pkxcuhmdTBx0nBLBF6VQMOIZAClt4xziOQpWM3fJ4PoEXLFKcaJ3catmY
         1xn3GVO252ThfJq+e5IXdBtnntg4Oc28agSuc1aQrALy0cxW5cWehY1jv3JHvRVXEJ0e
         qpG3flEk3VAEQhaf3Yc/jiYcIpQWhVX5ILDQyShxmOnCo/XuLtBnBUrF8gurDMneWvni
         PJZOqxTx6JMCdLdugpw/1H3dwqi9gYhMPcX9UgWoIa7DB8CB8Y4VKMgwln2tp60KIsk+
         wjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z5M9JpRkO8wl+5753/8BKn4/+rPgOlEujw5E9c4XCUo=;
        b=jpHXIuRxc1zlqe2VmlyPf2iPNvOr/xGFzgTMahjFiT0ZGiEXIDDiW0AXTZ6IfAvw/k
         tZkDEKUPnbXaW8pMsdzxjQ3sy4xhdjbO0viehmvVjomu3tBB0VPERwnS9D+cKoaTx4kb
         TJjmL+oSEXqaciwIXPpbFwA90CzGShiar5Dlk6/ufXCN46cYE7IfRBeO4vS1kpRjZ+8v
         8xSS4kv3j9p8ww6h/FyfWteIRrK1QeXYsm7Pp55nMc85ZweIEYgomOa3TTmhFJy3muUx
         UtK5D7IHv2rRVEarGJ1Z6/pUCz/cY/EU1Y46Lte2xGdSLr23iFlNC2KOnZ56beqe8OSs
         /y5Q==
X-Gm-Message-State: AOPr4FURDxGYCK4B+oh0W+1FWb5JRzT24eEL0ZBGzfXke0ElpQlDwJ51Q7XtGntOEbIFiQ==
X-Received: by 10.28.35.201 with SMTP id j192mr96020wmj.18.1462972825736;
        Wed, 11 May 2016 06:20:25 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:24 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294282>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_ignorewhitespace_option() should return
-1 using error() instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 657e986..a7ebbbb 100644
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
@@ -4615,8 +4615,8 @@ static void init_apply_state(struct apply_state *state,
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
 		exit(1);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
+	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
+		exit(1);
 }
 
 static void check_apply_state(struct apply_state *state, int force_apply)
-- 
2.8.2.490.g3dabe57
