From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 39/48] builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:49:07 +0100
Message-ID: <1457545756-20616-40-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJE-0000Is-PY
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933775AbcCIRyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:54:01 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35918 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933638AbcCIRxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:46 -0500
Received: by mail-wm0-f46.google.com with SMTP id n186so190630305wmn.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zHG3oivj7QiLGuca06S5896Tc9zxB2BsL0a6jjuTv+g=;
        b=tXte2/j7sr8AsJRF/+8pKirw+vIU6SDsifLKiZRmC+clcvQmQ53HbVhIYuujjewSEe
         L3oJcQcJgFf671W6oDbz3DKIwz0BBan6rakkOXszf2ZK2Pq0rrCgEJZWwWi0YsmhDQFa
         zQtGcdQ9yuA9PPF/XvOsYhhru/EZd3+UVfMsiXRODzIzx/tr+p/Lj4TJ1r76gPJxfBC2
         chypjSvv4PIKWsYOVYaqhGhx+qvGF+p9YUW/kcvSI0I/zPInMEAG8x3efMbTqa8wivju
         6qQqdLh5seroobYCQcl9JIytZo2vC4apnunPgREKkkCbV+NrTYwRU9gd8oVwuqSXAPub
         VViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zHG3oivj7QiLGuca06S5896Tc9zxB2BsL0a6jjuTv+g=;
        b=A2iVVJJ4GoHebCCVlHC5dU4v5AitLpJCcpggc0iKRGDicGA7J+4sRp5ET8L/af58b3
         W7VNZWfChj4siojNfQlJsVdkyqtrckr1MDYu/vObrO+zeQA9raCXEbD2KICbMeVvQFVZ
         sLROGUZdLSMUo3kfKlKg8qrcBLQH7PWcwRq6q/qFzeaU1Ghd4xeh+5EwGPLSTFG6KBKA
         agGKk+/SpnnSpeN451Hp0i0fJQwWHdEkXPHhKCQOJMMf9DiPZL7Xg3MrwgfQRCRn43g+
         OIMa/KwI60Hpl/fHxrCPk116/SGLEDcdJVG9D3tINU8M3uZxlRPhYCGixQHSzEvfoG/S
         PHPg==
X-Gm-Message-State: AD7BkJLVhzwdxkA0A7E/xsyaRG0J+hMeYrVH1dldX8bSyzB8RHTlrmxQmTLbEje5oyI/mA==
X-Received: by 10.28.107.216 with SMTP id a85mr374923wmi.96.1457546025281;
        Wed, 09 Mar 2016 09:53:45 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:44 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288528>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a2e1e51..9a2b8af 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -82,6 +82,7 @@ struct apply_state {
 	const char *whitespace_option;
 	int whitespace_error;
 	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
 };
 
 static const char * const apply_usage[] = {
@@ -95,7 +96,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int applied_after_fixing_ws;
 
 static enum ws_ignore {
 	ignore_ws_none,
@@ -2881,7 +2881,7 @@ static int apply_one_fragment(struct apply_state *state,
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
-				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &applied_after_fixing_ws);
+				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &state->applied_after_fixing_ws);
 			}
 			add_line_info(&postimage, newlines.buf + start, newlines.len - start,
 				      (first == '+' ? 0 : LINE_COMMON));
@@ -4809,11 +4809,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			       "%d lines add whitespace errors.",
 			       state.whitespace_error),
 			    state.whitespace_error);
-		if (applied_after_fixing_ws && state.apply)
+		if (state.applied_after_fixing_ws && state.apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
-				applied_after_fixing_ws,
-				applied_after_fixing_ws == 1 ? "" : "s");
+				state.applied_after_fixing_ws,
+				state.applied_after_fixing_ws == 1 ? "" : "s");
 		else if (state.whitespace_error)
 			warning(Q_("%d line adds whitespace errors.",
 				   "%d lines add whitespace errors.",
-- 
2.8.0.rc1.49.gca61272
