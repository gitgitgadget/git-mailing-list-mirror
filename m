From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 64/83] builtin/apply: make parse_traditional_patch() return -1 on error
Date: Sun, 24 Apr 2016 15:34:04 +0200
Message-ID: <1461504863-15946-65-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKD1-0008PW-Vc
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbcDXNgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:19 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34618 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbcDXNgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id v200so10012298wmv.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NhPPux5BI4UIrLszFqAORxgfpe4bDH0BS0n5iRCzB4=;
        b=qh+osj6uMm6t4nTrm/vNo4Lf1jVaj9HCbaMWBmNec3fEpyScKIk6mwoe3A6pXjTqcf
         Mn/zb/Iox+2jyKZyO5TNW+LyKsf9RtD2rKL8MmbRS8gWClHxMr3/zRmzC1Ijx5qIfe9Z
         PGRlKiSGiq4ach7Dtqyo9r9G4OzLd7eZN9tPVGWgQx3z3wLzrzZ2ZLgwj6hSX65AhpMm
         276GlDD2allTbgRB5wzo6W5zW1lDV4QLjmJuc4rSgYKMpgEXCbwKydkI7D9Q0uqJUVbU
         v0Q2qmWodo3oPYVPgPPZkBPgyM2SaNM2vLiVofol1tU9toF9QoWvNRe/E/MXVRW2ByVa
         5n9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NhPPux5BI4UIrLszFqAORxgfpe4bDH0BS0n5iRCzB4=;
        b=NIxWBVvviGGC58fOfFbUPiUlnO38qLFhukJryviIoa9HyYI+ZoWz/QKuIAysREC9zR
         /fA2TQHDB2YzBymunNfaFyFbLacg07CYmDwnp1Dg7jKUvG7PYQoLgBgCPMSw+BqNltwG
         SaigzFswlVG9JP9eK/3YMCX9rQ3GIhuGbfxbdgsEefLyLQg5p+8Al/IqRlTjY4M3j7Fj
         yqMXvpENFIzYBwnd93bZR+7srBUqTcPkM/gX2CqOxiWZGtzkGlxmsYNNvv7vo+qMuUNk
         m/iL5ExEQ1WYnX4T9Tk0gP1P70Ff3dprOBVBNDu0036MD9tWEtLeAtRZUfkXLA4EvMsZ
         Zo1A==
X-Gm-Message-State: AOPr4FWADYMsvC3k3ZoO3+fXmXTzHZyHbqtB0oWLnW24EpAp+lOQwhfX/8ISZEd3IKliLA==
X-Received: by 10.28.17.211 with SMTP id 202mr6688834wmr.11.1461504975832;
        Sun, 24 Apr 2016 06:36:15 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:14 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292351>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 73247c7..6b8ba2a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -755,10 +755,10 @@ static int has_epoch_timestamp(const char *nameline)
  * files, we can happily check the index for a match, but for creating a
  * new file we should try to match whatever "patch" does. I have no idea.
  */
-static void parse_traditional_patch(struct apply_state *state,
-				    const char *first,
-				    const char *second,
-				    struct patch *patch)
+static int parse_traditional_patch(struct apply_state *state,
+				   const char *first,
+				   const char *second,
+				   struct patch *patch)
 {
 	char *name;
 
@@ -803,7 +803,9 @@ static void parse_traditional_patch(struct apply_state *state,
 		}
 	}
 	if (!name)
-		die(_("unable to find filename in patch at line %d"), state->linenr);
+		return error(_("unable to find filename in patch at line %d"), state->linenr);
+
+	return 0;
 }
 
 static int gitdiff_hdrend(struct apply_state *state,
@@ -1462,7 +1464,8 @@ static int find_header(struct apply_state *state,
 			continue;
 
 		/* Ok, we'll consider it a patch */
-		parse_traditional_patch(state, line, line+len, patch);
+		if (parse_traditional_patch(state, line, line+len, patch))
+			return -1;
 		*hdrsize = len + nextlen;
 		state->linenr += 2;
 		return offset;
-- 
2.8.1.300.g5fed0c0
