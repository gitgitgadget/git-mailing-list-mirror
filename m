From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 46/48] builtin/apply: move 'state' init into init_apply_state()
Date: Wed,  9 Mar 2016 18:49:14 +0100
Message-ID: <1457545756-20616-47-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJX-0000Ta-UP
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933788AbcCIRyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:23 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33211 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933778AbcCIRyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:54:06 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so203717779wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHUM4CzIb1jMbQHeQzYLX5f5Rk+Hj5Gx10Eml/iSJvc=;
        b=OKgXNGzHQFzDhAhleACx1PqmnHtWa2GePzeSqDkcYU/WbF+ZzGq1X4HoQzUJNnPKFm
         qv6Hm3SJHSP8nx+TGfA96QEDpy0bggs5R49QQHoefIWI9uxEmRQmVFcoXTRZONDZZwNT
         Q3FBDFYuitV9NUxWvhUkZU0v+MGXppq+urEjxF86rIWZxD+Ff4H+xeM4vau6Vzb4Xi7Q
         hIQW0O6S0PhHk/qrWiC7/UH3zLpzEeEU24wN5RtpPNA6KDcofvFxjU1vUMegA/ri1BII
         EoBjNkKbP4zTjVUJ6p+Ufy9wUk6Geu4jl3n/iGzyFAiXypU/KinA7g6Hjz9vHT/jmbBM
         7adQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XHUM4CzIb1jMbQHeQzYLX5f5Rk+Hj5Gx10Eml/iSJvc=;
        b=EUURSntLF4X2BANN1vnj1xB9juwjYJcOA5FSmT5KfFeVyq7Es8VLeVPjA2oRGVoNid
         +oYY3983PGffoh3c7uF3/1hijVrrmmMX3Z0iww7I8ttSRZTso3ZRMXur9QPR9yKw/ri8
         nfv3dzLuRXuVp+wCU+UfaqAQleq0crTAGGiZkWfYRgzO+1cbmCtUSl+rHRZRJNAbkupg
         Uxj6crdMx6dxt8CQOU2tEAm9VGgLc7/SXFpR1eaHOSkH1bi8RHlhKoLOZ07ZvtQBS0wc
         4idk2KN+D3M3FqBsga+yZISW08dLznzh4xTBbDXH8qDlAl1CrnYXLblQa9QRRcBe8t31
         U6YQ==
X-Gm-Message-State: AD7BkJJEqj9cr+2Z5hY7kdG3Aexgmg91N2oCyS7KBOjl7uE8AP8sZO9Yv86I/llYYth1hw==
X-Received: by 10.28.172.194 with SMTP id v185mr26222563wme.21.1457546045094;
        Wed, 09 Mar 2016 09:54:05 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:54:04 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288533>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 66ebc9b..1676ce1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4667,6 +4667,29 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
+static void init_apply_state(struct apply_state *state, const char *prefix_)
+{
+	memset(state, 0, sizeof(*state));
+	state->prefix = prefix_;
+	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->apply = 1;
+	state->newfd = -1;
+	state->line_termination = '\n';
+	state->p_value = 1;
+	state->p_context = UINT_MAX;
+	state->squelch_whitespace_errors = 5;
+	state->ws_error_action = warn_on_ws_error;
+	state->ws_ignore_action = ignore_ws_none;
+	state->linenr = 1;
+	strbuf_init(&state->root, 0);
+
+	git_apply_config();
+	if (apply_default_whitespace)
+		parse_whitespace_option(state, apply_default_whitespace);
+	if (apply_default_ignorewhitespace)
+		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
+}
+
 int cmd_apply(int argc, const char **argv, const char *prefix_)
 {
 	int i;
@@ -4746,25 +4769,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_END()
 	};
 
-	memset(&state, 0, sizeof(state));
-	state.prefix = prefix_;
-	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
-	state.apply = 1;
-	state.newfd = -1;
-	state.line_termination = '\n';
-	state.p_value = 1;
-	state.p_context = UINT_MAX;
-	state.squelch_whitespace_errors = 5;
-	state.ws_error_action = warn_on_ws_error;
-	state.ws_ignore_action = ignore_ws_none;
-	state.linenr = 1;
-	strbuf_init(&state.root, 0);
-
-	git_apply_config();
-	if (apply_default_whitespace)
-		parse_whitespace_option(&state, apply_default_whitespace);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(&state, apply_default_ignorewhitespace);
+	init_apply_state(&state, prefix_);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.0.rc1.49.gca61272
