From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 09/94] builtin/apply: move 'state' init into init_apply_state()
Date: Wed, 11 May 2016 15:16:20 +0200
Message-ID: <20160511131745.2914-10-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2R-0001rb-SM
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbcEKNSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35165 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbcEKNSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9399953wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hymo+Rd1KQ3knVTTHSqRu29B9HY+R6eOfYPNuVDJR2I=;
        b=kRfDCGcdxucr6FKBzw7jXG/6rrQ/1hNrkaP1PlkZntna1yrvLv6nORewmOySHPSxbV
         JSAP4uVOxPGaGqZeYewwFA9mv/ip6wGYSdN/SLDkkOYOx05GAQW8QqWNCGpB8p5l9gL7
         ZXF/cyLBJeCntpRwF70T1R9K2m3bcj+O1MIOVlbSIN2tl5e+DHL2CGsovqIZME6H+/9f
         CYUzJCGFxycZKwDT16Mq8llBX6yHcyBIUqLUhGzS5q/AOl/ZWFPicgTLaihTpp6gISGM
         ZLZV60gkhZeRfhRm8oOy5uaqJyUNnLSdJai0IsFqMi+4a9SbUB6mY7nZ7tUvmVTOD2fN
         Jn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hymo+Rd1KQ3knVTTHSqRu29B9HY+R6eOfYPNuVDJR2I=;
        b=ROm9uN3iVcPJRHBG/x8g7fMNJ7bbfxlZG5U0sIYWPPUsrZEtINeaTe9vWnEHdrLouV
         z1/XzktWaPPJlqz/RikjvYmCg8lxkQwHsdCEIOS/JZAspAjDvQtwG0sgfk7G5rCB03cd
         WJYd/sQ3uhPfAHbR0lLlCl1OctMzh1HN4/XH87yFb9NveWzfeFBUpkGROd7XgEtw+nji
         1LLP/SGLT/PrjJXS3qvyJfdik5cSIP5jk7X1mCee40atucbd02xQDxEOWbLsePZH4KZe
         tk7Bu/MxgO60HKjuFa7FxRE/FMfhT24n9cg98HPkMBi5oT7Yh+Jf76pbKmUcnxnmwO8/
         2RKQ==
X-Gm-Message-State: AOPr4FVYFZnIw5Bj28lfaxFz2Use4F6Pr8JlxcmyJjfabE9d3qGr7nZFo+OBlesmNKgWoA==
X-Received: by 10.28.150.142 with SMTP id y136mr79547wmd.28.1462972724427;
        Wed, 11 May 2016 06:18:44 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:43 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294257>

When the apply functionality will be libified, the 'struct apply_state'
will be used by different pieces of code.

To properly initialize a 'struct apply_state', let's provide a nice
and easy to use init_apply_state() function.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ae068e7..e133033 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4522,6 +4522,19 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
+static void init_apply_state(struct apply_state *state, const char *prefix)
+{
+	memset(state, 0, sizeof(*state));
+	state->prefix = prefix;
+	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+
+	git_apply_config();
+	if (apply_default_whitespace)
+		parse_whitespace_option(apply_default_whitespace);
+	if (apply_default_ignorewhitespace)
+		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
+}
+
 int cmd_apply(int argc, const char **argv, const char *prefix_)
 {
 	int i;
@@ -4603,15 +4616,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_END()
 	};
 
-	memset(&state, 0, sizeof(state));
-	state.prefix = prefix_;
-	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
-
-	git_apply_config();
-	if (apply_default_whitespace)
-		parse_whitespace_option(apply_default_whitespace);
-	if (apply_default_ignorewhitespace)
-		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
+	init_apply_state(&state, prefix_);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.2.490.g3dabe57
