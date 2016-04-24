From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 38/83] builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
Date: Sun, 24 Apr 2016 15:33:38 +0200
Message-ID: <1461504863-15946-39-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:38:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEb-0000nx-M5
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbcDXNh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:58 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37741 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbcDXNfl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:41 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so90212625wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BniEsbmWX4gXKaPicIa6N8/hM4DykRYcY9V918IxVOE=;
        b=WNm/QXu/Jp/h0JCOHPQNHRpMKd876d8hCrg1xGv0Fuaol/xVMxDeSyPLgT8cNyqzEH
         dKm3jQXi6khwV57neOF76MxPlxNLm+moFCzQxi7zQboK0WST8hHFzOJMMelVzDUopuFq
         HvYMQn79vlylUt7qJvO1PxOowD3NQ60HayEXa13ru9TG+4tyR5xcbAdzwy6vXiCN/UVX
         c+narVxsjvlCZNDhDvAaPRMgK3TMj1t25arItZxGMbnQNlaXrXXFmkHyJrV7smmal9bo
         StM3mR02Qu7NhKzFVwo6QzHp6+t8DnifBNrOYqI7qLDxPPGRFlxva1xbmQ+fqMygQRVL
         kz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BniEsbmWX4gXKaPicIa6N8/hM4DykRYcY9V918IxVOE=;
        b=mL1uvN43KvAdwbB7I13wUIp8IaHGAsraYF4n30CRAtUrC+2y6G9X8+yTr8/XJ6VORD
         SoFOOMEw+HxMMdG47hsNmGTh4igDI77kyvgqnW10aJdCES+kyujI2vzgQL4ybSQ2cOJ8
         OWQ3bo1EcGaOLdm0q/V5Jf4cS9gAnep8D0n3mC9Ux0DGTLUyfZl9dJy+UR09g4viriCh
         Xcu3cBqXfQmv5UbDoRBHEcnsIGsEjuPNrnAXYfHH0RGLpsIWqL5Y0x+RDEjXNnBjdMJ2
         72R8YflLIDnOWR/waCIpUBk6l33f6MDOcjAehNXcE9jjJrZYuNm9sdmLvWbE7LoH89ma
         1iRw==
X-Gm-Message-State: AOPr4FUazK+ifPMrhZDuN3MzrrJNlUbDwjf8/4MjaZaAtkiJkHLOwG2HPWV7QFKjCUU4hA==
X-Received: by 10.28.0.78 with SMTP id 75mr6782198wma.20.1461504939899;
        Sun, 24 Apr 2016 06:35:39 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:38 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292383>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 259f256..52602af 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -79,6 +79,7 @@ struct apply_state {
 	const char *whitespace_option;
 	int whitespace_error;
 	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
 };
 
 static int newfd = -1;
@@ -94,7 +95,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int applied_after_fixing_ws;
 
 static enum ws_ignore {
 	ignore_ws_none,
@@ -2878,7 +2878,7 @@ static int apply_one_fragment(struct apply_state *state,
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
-				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &applied_after_fixing_ws);
+				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &state->applied_after_fixing_ws);
 			}
 			add_line_info(&postimage, newlines.buf + start, newlines.len - start,
 				      (first == '+' ? 0 : LINE_COMMON));
@@ -4811,11 +4811,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.1.300.g5fed0c0
