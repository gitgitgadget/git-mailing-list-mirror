From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 70/94] builtin/apply: make add_conflicted_stages_file() return -1 on error
Date: Wed, 11 May 2016 15:17:21 +0200
Message-ID: <20160511131745.2914-71-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:22:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U5q-0005jz-P4
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbcEKNWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:22:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35618 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbcEKNUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so9412062wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2OJPjiDpfCNoyjIttDak5tmuEk6HsXA6DP+6zvbRp24=;
        b=MpMuBjWkqYWQ0hcCyZwwWGxS3w+Z5zq8F9UiBOIZ7oCsFUnCPrV9iTRiFWzVpbUwoM
         0JBUekbXJmvzmD2GZfVnvvAGj6mM22cCB9XJaLlyYPOdrfzRbcSEJFWlpGyLox70ijq6
         tVun4tZ3ciJ9A4YASJui0b6qXGW4u24eocNpViRSKhS9BkvwV8tRAWT+P2DxRJbVl5GV
         /UV/nWku4iUWRtcSpzgsBKd0yzdn9bXpTpkUwTl/LdN2FktUaYkNf1on8qaXtDqO1IVO
         WGn96kjRShORPYnck9gfoi6R13LbHnOPUuyosVJldnEzl9xw8k37NoVjoBhey8dNLubK
         KUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2OJPjiDpfCNoyjIttDak5tmuEk6HsXA6DP+6zvbRp24=;
        b=QWdB/5X2w8ZjCc3/azlx6KGJrcz9IS05lpaRHkg3oIZVsV4C7y7QlfCxIcLa/gsKKf
         ELYvG3shew+ZhUB8HrAc9XJclnXdWTIQ9BiISkxdKI48lth4yj0cc5zcbFCSh5xEztzJ
         aFNwjuH77HShpq+5R1z5YGHXKkWJkArcXSOF05Uky43HgqT6/XtUoO7kGRIpbR17K8L5
         8f0HqYZ6nr9zy7HXpcEaauEN4jPh1u1ke9iWqBkrouF/wDIeskkxNav/ofp85P1vKApT
         zio1d5wQZSHIXqWF0knRKF31t1ZFRSxznPhjNMyN5mq5H9S34mW0EgK3cTULrRnAR0mS
         wVLg==
X-Gm-Message-State: AOPr4FUsfwnBJdQBrGSinTWRaS9tY623JAsB18zRy44XefktsX4nqu7+PW+NOgzYkZvn7Q==
X-Received: by 10.194.153.65 with SMTP id ve1mr3824952wjb.106.1462972850777;
        Wed, 11 May 2016 06:20:50 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:49 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294314>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", add_conflicted_stages_file() should return -1
using error() instead of calling die().

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 52f36c2..ca3502f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4214,7 +4214,7 @@ static void create_one_file(struct apply_state *state,
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
-static void add_conflicted_stages_file(struct apply_state *state,
+static int add_conflicted_stages_file(struct apply_state *state,
 				       struct patch *patch)
 {
 	int stage, namelen;
@@ -4222,7 +4222,7 @@ static void add_conflicted_stages_file(struct apply_state *state,
 	struct cache_entry *ce;
 
 	if (!state->update_index)
-		return;
+		return 0;
 	namelen = strlen(patch->new_name);
 	ce_size = cache_entry_size(namelen);
 	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
@@ -4237,9 +4237,14 @@ static void add_conflicted_stages_file(struct apply_state *state,
 		ce->ce_flags = create_ce_flags(stage);
 		ce->ce_namelen = namelen;
 		hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
-		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
-			die(_("unable to add cache entry for %s"), patch->new_name);
+		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0) {
+			free(ce);
+			return error(_("unable to add cache entry for %s"),
+				     patch->new_name);
+		}
 	}
+
+	return 0;
 }
 
 static void create_file(struct apply_state *state, struct patch *patch)
@@ -4253,9 +4258,10 @@ static void create_file(struct apply_state *state, struct patch *patch)
 		mode = S_IFREG | 0644;
 	create_one_file(state, path, mode, buf, size);
 
-	if (patch->conflicted_threeway)
-		add_conflicted_stages_file(state, patch);
-	else
+	if (patch->conflicted_threeway) {
+		if (add_conflicted_stages_file(state, patch))
+			exit(1);
+	} else
 		add_index_file(state, path, mode, buf, size);
 }
 
-- 
2.8.2.490.g3dabe57
