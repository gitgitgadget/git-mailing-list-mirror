From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv13 1/7] submodule-config: keep update strategy around
Date: Thu, 18 Feb 2016 15:33:12 -0800
Message-ID: <1455838398-12379-2-git-send-email-sbeller@google.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 00:33:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWY4e-0003rg-J1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948682AbcBRXdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:33:25 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32823 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946440AbcBRXdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:33:24 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so39818158pfb.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2dzmIGODAsRhT+wH8lmCQYf0c05qc0VS2NSBxkZJc0I=;
        b=n7bYIH6iS9EGLCS0DRihaSwq7uVRpYznmXnWsUOlHuNge5EgGCl5rhnot1lIm4Hm2u
         dI2EFBBEsND7jEwj//gvxvOH3OtxUG6LbBSDy9hD5SMjL3EEzb9PH4/+7Lb1lXxPW74w
         MSo0Z77Gn1tJpAQmDAu885/8lrVwfO6zDMRvKVASLu0gpU8Ltrmw1iQxoxsEj2TawJo4
         +iyz9tsXsOY6UjKRSpIFQ2cOkIGa/T8H+5ZpDxYLaNH43aRQwbtWcB+NsS4rLQb9qlM4
         SD+DWfnL0bhCw942WUaU48E3/IC4GBzOPmOSbJc2VexnB5agrTNt8/Ta+qkM4SP/aDxU
         ooYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2dzmIGODAsRhT+wH8lmCQYf0c05qc0VS2NSBxkZJc0I=;
        b=iPR+6jLIVULjGplPlAh08SdYgutAsVLKlQazaLnUTm6oGs65keJQw4yk4MvWXOirmg
         JWwu8CinIaB3NpS8fmJEw4+UkkrgSC4Z+5SrJB+kk+swaHDo9nW5xZnXoblimQonBxmO
         +WDGcgxlb7EcvnUc8Igc9qi7kqg5RJDrFSanklYy2lBfUnmLVxoA+tbinAoh0hOOiUkp
         3NLcKFiUMZuEIgvPZ2X+pmy7x9Clmh8RGXWsWqDf9laBhLMJopFTaYdWxJUfd2hPU+tO
         kNb/cLUhaIOVMSzoA0if0m+rOvpdZTxhbHXgsZcXKgAaYkVFVOZcw7Lov/6u0sljrlo4
         C1iw==
X-Gm-Message-State: AG10YORKf3ijbjPKBxgrt9jCuq/ExjMna92inAj2NC4UrZXC8Ya0kg8AnQfctETpHsFgSt2d
X-Received: by 10.98.65.11 with SMTP id o11mr13931548pfa.115.1455838403491;
        Thu, 18 Feb 2016 15:33:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id r77sm12812992pfa.47.2016.02.18.15.33.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 15:33:22 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455838398-12379-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286643>

Currently submodule.<name>.update is only handled by git-submodule.sh.
C code will start to need to make use of that value as more of the
functionality of git-submodule.sh moves into library code in C.

Add the update field to 'struct submodule' and populate it so it can
be read as sm->update or from sm->update_command.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 13 +++++++++++++
 submodule-config.h |  2 ++
 submodule.c        | 21 +++++++++++++++++++++
 submodule.h        | 16 ++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index afe0ea8..a5cd2ee 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -59,6 +59,7 @@ static void free_one_config(struct submodule_entry *entry)
 {
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
+	free((void *) entry->config->update_strategy.command);
 	free(entry->config);
 }
 
@@ -194,6 +195,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update_strategy.type = SM_UPDATE_UNSPECIFIED;
+	submodule->update_strategy.command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -311,6 +314,16 @@ static int parse_config(const char *var, const char *value, void *data)
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
index b83939c..2891aad 100644
--- a/submodule.c
+++ b/submodule.c
@@ -210,6 +210,27 @@ void gitmodules_config(void)
 	}
 }
 
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst)
+{
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
+	else if (value[0] == '!') {
+		dst->type = SM_UPDATE_COMMAND;
+		dst->command = xstrdup(value + 1);
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
