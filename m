From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 1/7] submodule-config: keep update strategy around
Date: Thu, 18 Feb 2016 14:19:18 -0800
Message-ID: <1455833964-3629-2-git-send-email-sbeller@google.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 18 23:19:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWvF-0005Zk-F3
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946937AbcBRWTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:19:34 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34456 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965549AbcBRWT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:19:29 -0500
Received: by mail-pf0-f173.google.com with SMTP id x65so38849141pfb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 14:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TEtjIDlCHq+IAYepSg8FP3yfg2yMV36eQd1BS3ZifYE=;
        b=VJtxgDBc+74T0xZtnu41cJXk06y7Wt7RiCIox97nlqReeiJMcn06LdYuwlTVigLLUJ
         UwL7EqLZ+F9sNK8QBdvrPlZXATxGHE6oqau4sWEWNibtJtj+jVfIJ5VqC+qA/UcGCGzx
         NByrnms6p0tjglEkVth+DXXxL7Q0pc+gYS7ZdmqSFTpqfdEsJgtBYdl1iSo7t3kVmxtB
         WGxLF8xUUTWzngE583E8JHk1UgmVtAMFsP9nGkIhMokAkqKf4TSEWlZ0m8q9Rum3wy0a
         UDxVMb3estRovuJUVSAiO+meYo+RT+ZLYJUzSSbslkRRyGaw699S3cxMdd9Qr3uTwHZ1
         1+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TEtjIDlCHq+IAYepSg8FP3yfg2yMV36eQd1BS3ZifYE=;
        b=U3aV697ayzKbqIJK+TS9Lw522qlSLAY+ifOcopsf/q1FyQkwj1VOP3YjoJ2jNMgTpl
         C2iQeupWlDO3g0ZsH00JkFtAyF1saB1Hois0nA5uTSpYMk3wWQBNbfAz1rgeoBHDRwOQ
         //Vgpx9Qo2JDLM2p2gRNUEUBbOMLTy8z7+hv+1+c1Z3cUNkur9Ab+zyowshznWU6mqaC
         eOsMa9iLs1/cz868jDdt2XEJNsz5RKtHvF4d8uravDIgc1nV24RMKoJtyc8EMW+Ou/RE
         Y8Wf/EewpZRnxxK0qynTK47Qi9p9n6ha6lhIryzavRFIusVix0GEgaI51cMJrNP1UNCa
         DrfQ==
X-Gm-Message-State: AG10YOSA0z8GdP36W7EvIlrmxXa6P4wB15iLp1QM6ctvRpQr05bOikhyGSa31aN6n/gx5sko
X-Received: by 10.98.12.29 with SMTP id u29mr13531034pfi.116.1455833969148;
        Thu, 18 Feb 2016 14:19:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id dg12sm12501573pac.47.2016.02.18.14.19.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 14:19:28 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455833964-3629-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286626>

Currently submodule.<name>.update is only handled by git-submodule.sh.
C code will start to need to make use of that value as more of the
functionality of git-submodule.sh moves into library code in C.

Add the update field to 'struct submodule' and populate it so it can
be read as sm->update or from sm->update_command.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 12 ++++++++++++
 submodule-config.h |  2 ++
 submodule.c        | 23 +++++++++++++++++++++++
 submodule.h        | 16 ++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..f8d1be9 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update_strategy.type = SM_UPDATE_UNSPECIFIED;
+	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -311,6 +313,16 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite &&
+			 submodule->update_strategy.type != SM_UPDATE_UNSPECIFIED)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else if (parse_submodule_update_strategy(value,
+			 &submodule->update_strategy) < 0)
+				die(_("invalid value for %s"), var);
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..092ebfc 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -2,6 +2,7 @@
 #define SUBMODULE_CONFIG_CACHE_H
 
 #include "hashmap.h"
+#include "submodule.h"
 #include "strbuf.h"
 
 /*
@@ -14,6 +15,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	struct submodule_update_strategy update_strategy;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
diff --git a/submodule.c b/submodule.c
index b83939c..1de465f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -210,6 +210,29 @@ void gitmodules_config(void)
 	}
 }
 
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst)
+{
+	const char *com;
+
+	free((void*)dst->command);
+	dst->command = NULL;
+	if (!strcmp(value, "none"))
+		dst->type = SM_UPDATE_NONE;
+	else if (!strcmp(value, "checkout"))
+		dst->type = SM_UPDATE_CHECKOUT;
+	else if (!strcmp(value, "rebase"))
+		dst->type = SM_UPDATE_REBASE;
+	else if (!strcmp(value, "merge"))
+		dst->type = SM_UPDATE_MERGE;
+	else if (skip_prefix(value, "!", &com)) {
+		dst->type = SM_UPDATE_COMMAND;
+		dst->command = xstrdup(com);
+	} else
+		return -1;
+	return 0;
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
diff --git a/submodule.h b/submodule.h
index cbc0003..3464500 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,6 +13,20 @@ enum {
 	RECURSE_SUBMODULES_ON = 2
 };
 
+enum submodule_update_type {
+	SM_UPDATE_UNSPECIFIED = 0,
+	SM_UPDATE_CHECKOUT,
+	SM_UPDATE_REBASE,
+	SM_UPDATE_MERGE,
+	SM_UPDATE_NONE,
+	SM_UPDATE_COMMAND
+};
+
+struct submodule_update_strategy {
+	enum submodule_update_type type;
+	const char *command;
+};
+
 int is_staging_gitmodules_ok(void);
 int update_path_in_gitmodules(const char *oldpath, const char *newpath);
 int remove_path_from_gitmodules(const char *path);
@@ -21,6 +35,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-- 
2.7.0.rc0.34.g65aed89
