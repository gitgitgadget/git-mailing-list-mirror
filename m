From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv14 1/7] submodule-config: keep update strategy around
Date: Fri, 19 Feb 2016 10:17:07 -0800
Message-ID: <1455905833-7449-2-git-send-email-sbeller@google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 19:17:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWpcd-00015c-O6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 19:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992760AbcBSSRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 13:17:24 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34121 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992723AbcBSSRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 13:17:19 -0500
Received: by mail-pa0-f44.google.com with SMTP id fy10so54121038pac.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hWMUj+JuFgP7bK1ALczlObfzU3aCeT+50NM9SbqaDoE=;
        b=OBjKv8NK+F3CWVvkMPS4ySXrMEI7ej9OYrrOig1Ccr1EQMY634WDgSYJR9J7xh9wP9
         ThJl2VZ91mklyzumJIT/3NiSawLKU2E5ODcb4+VlllBM8sXPZ/TBd+ADF1FtEpvI0jLx
         uBFsFOMq1hppQiFhrXynYF2zdYWf3NF8t47cQxdXXckUATyqIU1wRnLYPLnvTpJhDV6L
         IjeN059CgqMgJJTPdmlzr2pNwC/5erhU7xK1gQO5/bdukNoqCoFJp4Gnd+A75lznOjrT
         ctuiz7YBTnhi3KmUIGYKRROaBbv+VS2gzAVR32/PCcU67PmXX8uBsZSaajlBIeJnCndR
         zWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hWMUj+JuFgP7bK1ALczlObfzU3aCeT+50NM9SbqaDoE=;
        b=i5YvKuIekygVrVqZqNNGSaBRDoxRkxyNaTxyM5QYaLpfwp1NaEdQNhM7aNWWtBOSQA
         jv15QUYz58UXTqrNgpHPuMMZitiqoyGoe/Ls1jfYh4DLnl5HVVdo1igzAHFmqClBFR5S
         Bh66TRA4VKjKmnk46AmDhQc+mJFMT32vxPjdsdHYoBQ3l88B/7kfUkJtk4isxtBMNXwP
         8hnBJJd1I0YsC8Ds8xYZlLvMxYDVW+hXgChD1Ey/wwqDjnd4+Ucaj3fvhnCIX2ygugcV
         rKyKZvUFhLRgINHWqJdSqhbWxW6hBDz3i6Hi0O/Vuz/sYVoMQYGReS/aTHWivlVf7hfM
         bbxA==
X-Gm-Message-State: AG10YOS4oV31AC6Obqq+vyz8Tyb0XcLPbPCSdBZ4r+bJ9DRDMsm1ij951MnQADZkq/VS+Csr
X-Received: by 10.66.102.40 with SMTP id fl8mr19526359pab.126.1455905838806;
        Fri, 19 Feb 2016 10:17:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id l24sm19258296pfb.73.2016.02.19.10.17.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Feb 2016 10:17:17 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1455905833-7449-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286728>

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
index b83939c..b38dd51 100644
--- a/submodule.c
+++ b/submodule.c
@@ -210,6 +210,27 @@ void gitmodules_config(void)
 	}
 }
 
+int parse_submodule_update_strategy(const char *value,
+		struct submodule_update_strategy *dst)
+{
+	free((void *)dst->command);
+	dst->command = NULL;
+	if (!strcmp(value, "none"))
+		dst->type = SM_UPDATE_NONE;
+	else if (!strcmp(value, "checkout"))
+		dst->type = SM_UPDATE_CHECKOUT;
+	else if (!strcmp(value, "rebase"))
+		dst->type = SM_UPDATE_REBASE;
+	else if (!strcmp(value, "merge"))
+		dst->type = SM_UPDATE_MERGE;
+	else if (skip_prefix(value, "!", &value)) {
+		dst->type = SM_UPDATE_COMMAND;
+		dst->command = xstrdup(value);
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
2.7.0.rc0.34.ga06e0b3.dirty
