From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 14/40] builtin/apply: make parse_traditional_patch() return -1 on error
Date: Mon, 13 Jun 2016 18:09:16 +0200
Message-ID: <20160613160942.1806-15-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:11:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCUSw-0004no-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425006AbcFMQLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:11:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35889 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424850AbcFMQKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id m124so15998361wme.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wR6+Cnwgxj0g59AdBs4OhBTGRnxJzHZTXAG/A0WC77I=;
        b=LNCUUt8ttujG4H6tgUONZqYpfqerQyCJAMcxOFf7HkbFeL3yNez3+fnjkzY9kiEY39
         f8X1IQO5ctBTumX9Scb/0r3NdrLX0r3oQjD8n0ICcDnlX2+FPi0U6YejVR1jnE/FP3Rv
         nZwhRJDwpQZwBik/Nb4xLWMrDlJay98meCff8Xx6cDAHhgHksHAWbwvTySY6VIHE688v
         A06wjwg5sLcgSuyAtz0WzPgUwiHwPCNjs2biLU6UecTuvEO5/b8Ihdio5sHVvMRslN0C
         3YDYqOHLD9y9ctmemYQE4YYbOjC3DYwaa8gn7IsumcQ2llazL8yOLK1WArH/+hfDu/UM
         ODkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wR6+Cnwgxj0g59AdBs4OhBTGRnxJzHZTXAG/A0WC77I=;
        b=aFADHEbxdl7LeaG+y12gIGfLIuzS9pda2r4wB66Tdfudm0P8AR2kIS1NedMR9hkgJW
         kwzsp8iJ9wkyy1V6UYLi+/rDQCQgPCKuAuO05j2JmGmu+ep+y4SumVni0epBkc6cVNMf
         NRAdgzaaRIz0F2luKzXpT+GqDFaEVbspKDLy1LpYlDuFYdjilecrK5Byq7vB5VD+rg6r
         Wofefsc/enm+msRMmJDPceqCQyHxjgqLl+VCj3Ne0fUL3qPd4R+7p+MQtftST305osRm
         0CVCGUf+lz1QJX4LeW/d9sMXCHhFUPQfkIHHy8m3uxcH+23FgzdhZwXnEN4QbRL3F5On
         rjMw==
X-Gm-Message-State: ALyK8tKp2WLBxp6Pg4ApCXbORuHj7QF9ofczDF9Zz5IDo7vssS9dRPJ40CC0hzdj71PMqg==
X-Received: by 10.194.242.163 with SMTP id wr3mr1877957wjc.1.1465834216170;
        Mon, 13 Jun 2016 09:10:16 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:15 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297227>

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", parse_traditional_patch() should return -1
instead of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c27be35..eb98116 100644
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
2.9.0.rc2.411.g3e2ca28
