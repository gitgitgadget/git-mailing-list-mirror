From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 60/94] apply: make init_apply_state() return -1 instead of exit()ing
Date: Wed, 11 May 2016 15:17:11 +0200
Message-ID: <20160511131745.2914-61-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:20:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U47-0003qR-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbcEKNUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34563 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbcEKNUb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so9419596wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZbxuxVL23pLiWFvT1xYgS/RQAKQ0BFYrcmdFAICVFk4=;
        b=v4i89ZFUeK7xgb7raiLZZCORQq1dKfIGt63oZu5dtqEbTghSfnY3NoDk4jK5vRc5XD
         LCDvYzn9+Z0DTaigPZYF4UAJ/H18emc6f3pCt2fc0ZEPNDBXOCk10ZCQd1BHYbLt3HMX
         Xus5TIr7mQhKzeNrZiSkCIF5ae6lYTPJTknVjFU4dVetsmVlpvPz547swNJ+raCdutNs
         k00l/Wca9oXcmn8va2rf6XZHHj6zKiPo5C6BcJyRZuHMxmb9ROzy1/QsUyQ96s3Ykg5B
         8TM3ToqwoCe8LrqSOVsrmqNn7hApxAvyWS0Vv/cV03ieNC7iYWkQoDuBSxDrHu2H8J0W
         t2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZbxuxVL23pLiWFvT1xYgS/RQAKQ0BFYrcmdFAICVFk4=;
        b=Eg6aNxBdxWNkqYBrIhYLIV+yBc4icTUa/RhANx2i8FcsB9AqzZ417Nn83fgkiyFbBB
         wv6TMD6mye5O03h1WRg+FASX8hTDfrL36M9MgkAQfF4J1ghRh/1Q5x2sG42ZDfOaPbVk
         JAP0uDwqx6fqo5p8K+12BLRHRIPehY87LUChdCmBeirwxkEWUWYeiOPRudOGfMX1Z0s5
         kQ+pWFtsWEJrXW7iJWRFTux1v0/jeGDFHctkaozqJRVZQzO3M8OJej9YWA0sijR79PIW
         nnAyIuT6WjySlPKJSMZcNn3T3vC6PvVjjC/wpTDSfG4A4s4x/6vSzTk+79X1vfra87V+
         v1oQ==
X-Gm-Message-State: AOPr4FWRBLlxQMHqvsFzhIDRSdlrhDTH1ipygKb86BsfE/Pb2OwS6HtXMfeXydNqRbBt/A==
X-Received: by 10.194.3.84 with SMTP id a20mr3745474wja.77.1462972830408;
        Wed, 11 May 2016 06:20:30 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:29 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294281>

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", init_apply_state() should return -1 using
error() instead of calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 11 ++++++-----
 apply.h         |  6 +++---
 builtin/apply.c |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index 508ea64..1e2b802 100644
--- a/apply.c
+++ b/apply.c
@@ -55,9 +55,9 @@ int parse_ignorewhitespace_option(struct apply_state *state,
 	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-void init_apply_state(struct apply_state *state,
-		      const char *prefix,
-		      struct lock_file *lock_file)
+int init_apply_state(struct apply_state *state,
+		     const char *prefix,
+		     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
@@ -76,8 +76,9 @@ void init_apply_state(struct apply_state *state,
 
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
+		return -1;
 	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
+		return -1;
+	return 0;
 }
 
diff --git a/apply.h b/apply.h
index 0f77f4d..f3b2ae4 100644
--- a/apply.h
+++ b/apply.h
@@ -117,8 +117,8 @@ extern int parse_whitespace_option(struct apply_state *state,
 extern int parse_ignorewhitespace_option(struct apply_state *state,
 					 const char *option);
 
-extern void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file);
+extern int init_apply_state(struct apply_state *state,
+			    const char *prefix,
+			    struct lock_file *lock_file);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 805c707..b31f9eb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4724,7 +4724,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix, NULL);
+	if (init_apply_state(&state, prefix, NULL))
+		exit(1);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.2.490.g3dabe57
