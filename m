From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] submodule-config: keep labels around
Date: Fri, 22 Jan 2016 16:31:41 -0800
Message-ID: <1453509103-16470-4-git-send-email-sbeller@google.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 23 01:32:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMm7U-0006fU-WC
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbcAWAb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:31:57 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34207 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666AbcAWAbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:31:52 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so51548890pfb.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cZdntBsXfplbodKadVQ0Flt9NGH3spt7nGFK6xD3cIY=;
        b=VD3N7NJpyuhhE0sf3wVxL3RcucggqXbAmjRByrV0WPIUPe71qxzD4a5EPOFqX8tVNO
         tS5B+6stLKFUVCgpfJVaWwRYBTnvZEBIGcLqPndVdFHgS6+Uwwkq3zHwC8gi4IF9L5ji
         2oGVqwGOQAALS+wdxk+jj0NXmQtUcehpTdU15K0jKNYT7P/8cNG17tOet1igxeXh8wzq
         CgTKEhDTPZpB+iA44GMxOf8ugXXQxYfKLKb9I78GCLCsTzykSFYnLTKBN62OxH2lwAcC
         ka/WAM2vOHUN9aj6C9Dh5dF6PZJq/uvuaDZI/nxI1GxniAINLnIC9giT/ZwIt4iHglAN
         Sq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cZdntBsXfplbodKadVQ0Flt9NGH3spt7nGFK6xD3cIY=;
        b=iWwzyFajj2x9RViu/Zyzf3hag9r/Oh9NGJz12+mhvir6KWT9u+KedQVO8ObhqD3Uus
         3acubL8sfe/+BitLYF9gGPFIekKWuo7Lrym1jg+mH+Ui8j90/iVEah3+WXMyMPA1Tp9J
         h2QCSMofH12zt3d6SlbYvmH4Uofx4K5slPduKEA5vzClQ0OeckyITZlNNUmvcRUWG6Cn
         mXNycfZDrkS4DsNEyVKydyHV2tNp5hxyvzOIWUgZwwXvTzg7o239KanXgg2uYM5kwTna
         AZRKuI3vAoc4rziUR0upmQYXh7FDgv4TZlthqO5uCpp72HEcZJ7lkDrzFpONH0HB1Ocu
         EPWw==
X-Gm-Message-State: AG10YOSPyTszWMpLp2UHWEAe56bK85vt6PmNqKbhzfqtzvCgXV3ZrlUwLUHECv/YOhbFAH6L
X-Received: by 10.98.68.152 with SMTP id m24mr8500808pfi.78.1453509111445;
        Fri, 22 Jan 2016 16:31:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id p66sm12218225pfi.34.2016.01.22.16.31.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 16:31:50 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.g77a36b9.dirty
In-Reply-To: <1453509103-16470-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284613>

We need the submodule groups in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 15 +++++++++++++++
 submodule-config.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index a32259e..245a0f6 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -60,6 +60,10 @@ static void free_one_config(struct submodule_entry *entry)
 {
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
+	if (entry->config->labels) {
+		string_list_clear(entry->config->labels, 0);
+		free(entry->config->labels);
+	}
 	free(entry->config);
 }
 
@@ -184,6 +188,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->labels = NULL;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -324,6 +329,16 @@ static int parse_specific_submodule_config(const char *subsection, int subsectio
 			free((void *) submodule->update);
 			submodule->update = xstrdup(value);
 		}
+	} else if (!strcmp(key, "label")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else {
+			if (!submodule->labels) {
+				submodule->labels = xmalloc(sizeof(*submodule->labels));
+				string_list_init(submodule->labels, 1);
+			}
+			string_list_insert(submodule->labels, value);
+		}
 	}
 
 	return ret;
diff --git a/submodule-config.h b/submodule-config.h
index d9bbf9a..df73fd7 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -17,6 +17,8 @@ struct submodule {
 	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
+	/* sorted, not as on disk */
+	struct string_list *labels;
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
2.7.0.rc0.42.g77a36b9.dirty
