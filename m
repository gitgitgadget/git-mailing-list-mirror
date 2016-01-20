From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] submodule-config: keep groups around
Date: Tue, 19 Jan 2016 19:34:38 -0800
Message-ID: <1453260880-628-3-git-send-email-sbeller@google.com>
References: <1453260880-628-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 04:34:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLjXq-0004dV-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 04:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935040AbcATDev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 22:34:51 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34134 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935033AbcATDer (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 22:34:47 -0500
Received: by mail-pf0-f177.google.com with SMTP id q63so192074964pfb.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 19:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kzLTmE8KHv+PmR+pIJ/EzvabmUFEFdmaGeVjv1NEgLw=;
        b=UIGPmfOUHs7DBFYhIUL/SH4ERGiuogenfYl0uYVWAw3o9aJ81NW86cA/QI+ZR8tnbs
         IIYi8BJTa69O7ydSslecn7mfcBSuomQP7QIAO8sqxpWPUJ7wGRMJO1nWH33gxWWclW3+
         re/ETdIyv2tctuSUFK2YInEWTlCwSH/mNO3Z2kuojG1j3dglp/26DNyUt0zLLFofcmNJ
         Fl9qL7OMPAyLVkgduFEohtUlW/kv8gS5PG4k7Jhaq3a4eFByD/GJQgry4LU5Vq0onuSm
         JUDj241lW0TzFGHyr7MbTkbvhjg5tueOKjeblCXo0f0QR6xNegfRh/uklKyUyPPT+F2b
         PUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kzLTmE8KHv+PmR+pIJ/EzvabmUFEFdmaGeVjv1NEgLw=;
        b=bj8scxiGYTojvBClBF6DReWCjKyU8wcWsT3FHXv9KeY4wlLRBTwTfHOgTG8k9nefrg
         vNi2VHWMavg2HGot97z9I3wfsVe22Pl04igvG7GpVayhGLA//qPeCDRM498K7rXAaNMA
         7U7dROF/SpR+W5XEqVU6aC91i1bhf2DtC2nv7/o93iolppj61vlcs0d6e8gkcN4R+PAz
         jdekzGvnnlxacuvKbWN4UZVcJqRaGeOafk+OezOgXbVDf2oFvX9zyFk80uLEyyojhdbf
         vJP28epEWXsABAYgNgjGkCbqi0QD4iBobPpTgEJEpNSy6mFPuxnx0ukzdvoR/E/Fl6hF
         vB2w==
X-Gm-Message-State: ALoCoQk/VnzGQY558HeVISbXIWfFcpKZx86+Qqg6SaJUEPvrkiKHz1e/UAaxS/qc2+5ifO3ZjBTKyehksniwI6TmpZnjQS+9Ug==
X-Received: by 10.98.13.68 with SMTP id v65mr48903643pfi.54.1453260886627;
        Tue, 19 Jan 2016 19:34:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id ss5sm12622594pab.15.2016.01.19.19.34.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 19:34:45 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.g89994f2.dirty
In-Reply-To: <1453260880-628-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284421>

We need the submodule groups in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 13 +++++++++++++
 submodule-config.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index a32259e..b5453d0 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -60,6 +60,8 @@ static void free_one_config(struct submodule_entry *entry)
 {
 	free((void *) entry->config->path);
 	free((void *) entry->config->name);
+	if (entry->config->groups)
+		string_list_clear(entry->config->groups, 0);
 	free(entry->config);
 }
 
@@ -184,6 +186,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
+	submodule->groups = NULL;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -324,6 +327,16 @@ static int parse_specific_submodule_config(const char *subsection, int subsectio
 			free((void *) submodule->update);
 			submodule->update = xstrdup(value);
 		}
+	} else if (!strcmp(key, "group")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else {
+			if (!submodule->groups) {
+				submodule->groups = xmalloc(sizeof(*submodule->groups));
+				string_list_init(submodule->groups, 1);
+			}
+			string_list_insert(submodule->groups, value);
+		}
 	}
 
 	return ret;
diff --git a/submodule-config.h b/submodule-config.h
index d9bbf9a..332f5be 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -17,6 +17,7 @@ struct submodule {
 	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
+	struct string_list *groups;
 };
 
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-- 
2.7.0.rc0.41.g89994f2.dirty
