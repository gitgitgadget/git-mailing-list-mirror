From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 2/7] submodule-config: keep labels around
Date: Mon, 21 Mar 2016 19:06:07 -0700
Message-ID: <1458612372-10966-3-git-send-email-sbeller@google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiO-0000gs-2I
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196AbcCVCG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:28 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34204 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbcCVCG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:26 -0400
Received: by mail-pf0-f175.google.com with SMTP id x3so287819057pfb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODI35c3EGAXO+xweBuKJMzhVolJsPRMy2ON4rycgyt4=;
        b=k1TF0MiyzFa9EVD2skSEjz3IbB7NIjUu0hmfqgzmX+2gN4CVA7HAkhqxBh6eVHlsp0
         bM/9lppPPxpX1+/lmqNPBi31YKVA2e3dU418gLCeg/smK3UT1M+/LP2ntAhDcJd1RlbN
         vdV15caYpuVvzebhRqrDfzm7IeD1f/rho14OPzvxX17zc2S+P1hzKYrxf37de+EKgrQY
         hGnwD3aMBCyehF405l/w4+UkBjebVjURbnHZaLKaagShb0qd3ZAVEiNrGHadjhbN8BWN
         no9aLPfHNzVF/qKJ0RI1pzc43f+KjPkbBVWEopbYU7bvjABxQuMeidcXpqosif4hGdqS
         /jLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODI35c3EGAXO+xweBuKJMzhVolJsPRMy2ON4rycgyt4=;
        b=d0nr2t2rNfAEtBh+pB8cPnKjm2w4YBaI90uKCdwGK9fai6Ox+UF4UmXXob0KFfy4WJ
         dM2i99cAgUGAvTksovu6JAX34XylE8UGWC1cRDI+YXmr0UJzj+4aJAjZVgtLdWIRJXwF
         CyTegZvMlgMtyhSEoNGkI010l/WoNbtG1xXaUzN8JSpZbpi3AUsWndSP2Aq0+OXN4L0j
         nguV1b7tgnCx2uyxoKg5vHa0JAxU5tzLRSR1JNhAOfJOenp80DMQzLJoz2Jd01oJIw9O
         cLHmzLXs7IF6Z6wGi18ut4fWQCFWujsg+7zR9WjWvq6A5v+yumlj+Hc47KXSonloubUJ
         GiEQ==
X-Gm-Message-State: AD7BkJKl4CWkF4ahTHqbndbs39KntoDRjZR2pOGHYrOKYbrPpidduaf1Pa8Gsyj2lEfTQ8Am
X-Received: by 10.66.146.39 with SMTP id sz7mr50815402pab.76.1458612386113;
        Mon, 21 Mar 2016 19:06:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id x64sm43652671pfa.72.2016.03.21.19.06.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:25 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
In-Reply-To: <1458612372-10966-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289484>

We need the submodule labels in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 18 +++++++++++++++++-
 submodule-config.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 9fa2269..7b48e59 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -60,6 +60,10 @@ static void free_one_config(struct submodule_entry *entry)
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
 	free((void *) entry->config->update_strategy.command);
+	if (entry->config->labels) {
+		string_list_clear(entry->config->labels, 0);
+		free(entry->config->labels);
+	}
 	free(entry->config);
 }
 
@@ -199,6 +203,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->labels = NULL;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -324,7 +329,18 @@ static int parse_config(const char *var, const char *value, void *data)
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
-	}
+	} else if (!strcmp(item.buf, "label")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else {
+			if (!submodule->labels) {
+				submodule->labels =
+					xmalloc(sizeof(*submodule->labels));
+				string_list_init(submodule->labels, 1);
+			}
+			string_list_insert(submodule->labels, value);
+		}
+ 	}
 
 	strbuf_release(&name);
 	strbuf_release(&item);
diff --git a/submodule-config.h b/submodule-config.h
index 092ebfc..8d61df3 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -18,6 +18,8 @@ struct submodule {
 	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
+	/* sorted, not as on disk */
+	struct string_list *labels;
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
2.7.0.rc0.45.g6b4c145
