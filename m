From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 58/83] builtin/apply: libify parse_ignorewhitespace_option()
Date: Sun, 24 Apr 2016 15:33:58 +0200
Message-ID: <1461504863-15946-59-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCv-0008Jg-HO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbcDXNgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:10 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36866 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbcDXNgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:08 -0400
Received: by mail-wm0-f53.google.com with SMTP id n3so90222362wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jz3DQ479OWjwT7hb/9OyWwoHr/l1VoKndzqjjVVUjIY=;
        b=p2hFzB5NaJJcBu+1UD2NrJAKmxru/ZVdSlYhkW7HF39F+MnVlhdhTwCg3+7QDJRICg
         nxzAED3FDM28XP64riECg/dauOklaJh+mTQNdxpSVEVSz1NLNXd53f3vP4mhbJwiIO4Z
         1l6wyyo1MIekhdoOQVW4U++nhyHRWQwgPiuoQAEJcTO3NwuiOPurCJGJY2Ite8lLNcqN
         tc2SILV4Gx5FfGDVSJTQ0ZKzBa4O+kGqpKEr4vKZS8rqPCLjPU06Pie31t4sr8FlfPyd
         soWvB+DN7122LBRwOy/OUXnleJ0IM7R4R++aVEIHDenVbBNR+SBt9mMgOloRtiGgcnkr
         M/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jz3DQ479OWjwT7hb/9OyWwoHr/l1VoKndzqjjVVUjIY=;
        b=bIJSiOx3QHo3vRScngUqSuQMRbYESteKHj2JmkL11qz7lS+2OBLewXozOpXENZQI05
         wDi4NlZ/OMd5EDyKVMwQZl/xdOG3IFxF0H1WVYm2qFkD8ZF7UB+DkJVhu0fbRhhmJdRb
         Imz8leI6EtrpflWQ48NUWJJ6uH2x9zyrkDuMkNJpjlwGNDfF+eyJbb64PPl3h2OPk26K
         Gf+mVyrbPiBgRzADuL16a1UtVLGZ0o24TiC6TmJEI7LJk/rjlWyXRvy4uCfZSItLWbfQ
         32w+u/rEFW98sOyPL/ThzJXegEV4Dfvdex/2iShzZO5E83GaXj3raBVPJbzAIMkJtP8u
         EBDg==
X-Gm-Message-State: AOPr4FW+Hgxv45461Xni/2K3Mj0es+cLJ6ZT0AKBd5mqryaNgr+0rvsYRdncWn15RkKZGw==
X-Received: by 10.195.17.166 with SMTP id gf6mr29139025wjd.124.1461504967445;
        Sun, 24 Apr 2016 06:36:07 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:06 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292355>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8d96f70..2f89922 100644
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
@@ -4605,8 +4605,8 @@ static void init_apply_state(struct apply_state *state, const char *prefix)
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
2.8.1.300.g5fed0c0
