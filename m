From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 39/94] builtin/apply: move 'applied_after_fixing_ws' into 'struct apply_state'
Date: Wed, 11 May 2016 15:16:50 +0200
Message-ID: <20160511131745.2914-40-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:23:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U6y-0007Dw-AS
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbcEKNT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34931 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbcEKNTx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9406323wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lCtKF//emGtgX+jbS9JFzHjWOg2pVZkNt+ZecqtJnhk=;
        b=tO8dZ5VQ5QA1hhba92mLrRov6rLh5qa3eVYM3lj/zAQjvYeopiXNKp/obNel9VzTdK
         p/pNi8me9L6w1kgZqbtwnSDivqOZ6BY+r1lPKjrbqzujv9I6v3oq97RDvtr+aAxM4+Z4
         8FFGX/2ftI9LQe/55SDnYe/5hORwclFP3brVWWHIpGjYNXi2DmlqDMz4noohVLX7KQzo
         k04ErmBirxiZIKYkkXjp8lZda5apKhK50QoH0uF6gOWgsDLWraX9+e7WuhcE5ebtSL+D
         +Hbni1sjMIbyZknbi7Q5D5tlBkfLafwBtIiJNk1CYd0HjH5DIRfaiKkjY/sru1WtpPNH
         zLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lCtKF//emGtgX+jbS9JFzHjWOg2pVZkNt+ZecqtJnhk=;
        b=ZY40Wh6VAHCjN1J9Cfn8rTgjUSI+3T004zw2JhbL0ohu13MePCdoEu51xZ+o7cRzr8
         AZYC8uKBTk9dNx1idrBZ8bPWOzwauYIs7JQDBxkkHGkq8kK0rCSM5R2HnZwpWq44BxQc
         whGMKDyM6X9CNzLlesJvCW39jCmIVYrcGF8xB36ItvDhBOwDGDL9gknrXQZEhivaRN7f
         3O2y9X5IdjCMxp/sdmPid6mszAxIXY9ZAKLFy91gBNwY8KEUSCaH7iaTa3I9GfOUm3vs
         S1YB9TywF1GfBooY0GN12eY0FPf/dTw8aBR2abCS5BdV/NixaIkP0yjy5kLZ77QC2kl5
         q7lA==
X-Gm-Message-State: AOPr4FVgyMcrpWh0Ze+vQ+yRpmuU1rXYJ/xPZ3kv+6Idmgfu7M1ZY3BioaCNKuKIOWwwBw==
X-Received: by 10.28.189.138 with SMTP id n132mr4469821wmf.34.1462972787408;
        Wed, 11 May 2016 06:19:47 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:46 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294325>

To libify the apply functionality the 'applied_after_fixing_ws' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f84e301..e68fd2c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -70,6 +70,7 @@ struct apply_state {
 	const char *whitespace_option;
 	int whitespace_error;
 	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
 };
 
 static int newfd = -1;
@@ -85,7 +86,6 @@ static enum ws_error_action {
 	die_on_ws_error,
 	correct_ws_error
 } ws_error_action = warn_on_ws_error;
-static int applied_after_fixing_ws;
 
 static enum ws_ignore {
 	ignore_ws_none,
@@ -2868,7 +2868,7 @@ static int apply_one_fragment(struct apply_state *state,
 				strbuf_add(&newlines, patch + 1, plen);
 			}
 			else {
-				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &applied_after_fixing_ws);
+				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &state->applied_after_fixing_ws);
 			}
 			add_line_info(&postimage, newlines.buf + start, newlines.len - start,
 				      (first == '+' ? 0 : LINE_COMMON));
@@ -4806,11 +4806,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.2.490.g3dabe57
