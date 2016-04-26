From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/15] submodule-config: keep labels around
Date: Tue, 26 Apr 2016 13:50:22 -0700
Message-ID: <1461703833-10350-5-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wl-0006WI-Nd
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbcDZUu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:59 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35149 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbcDZUuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:55 -0400
Received: by mail-pa0-f45.google.com with SMTP id iv1so10921028pac.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7enzsJ+Px8NnnOZo/j6FsyqAus2kOqcVFgSmFNCigwQ=;
        b=mSaDMDmfaV1W3qznaQ4uckGWkMZ+o0RyRvhtTwO8QybHxp78k3c1m3K/UOKVm5xNxx
         c7sD3lmc6CxE29Dns9BLESvNf6vAnknErnfXux65L06EssLrJU+c6Py87kCnyvwV2/bb
         yFHwpabb3Zk4PRqLBO9ZLiZ7tGXOS9Dv5RBv9d636juudUB4LquetvF8hRymCp2dYynX
         vG+woluXeAF3REHV8+fUTz/Al0b6FAbwlo/xmPJjozvqjjDGHqXvYXcb7bFZbxx8i9SB
         YpAqH1O6PkOk053Ev9DZO80YHZiIVbWzxw8S13U4ON6/V6Uk8F5gSjJARaY0kStegLK3
         zK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7enzsJ+Px8NnnOZo/j6FsyqAus2kOqcVFgSmFNCigwQ=;
        b=Bh73sOELmHthUZ/XUWbKt8AsUUpuZQhS40phOOITu0fkbjJiELDWJFzqFDCPlbJtSl
         2r9Vb0OGLXcSJFxqznrNxYSUCdVvJmy3eta8TD9ED6dTdGZ/lNQl7YQ2/qGski9KMlAA
         VRTE44MF1FRKjnlGTPmpBzYt+Qw8Rmvp4ivwTk6Q2FUZq2LrbxHvUAZBpTHtscibYbzr
         3e3tR0Yf5BrVYjzLZ8/td0lLY0TDsABFfVdmD+pyMHQNjcOXEJf8mhhsj5LfjQdIPcFo
         UfjF7z1CYBe2v1ZEnWK/gLTFlhJNbzfbd2XuB7gfFTmrlga4SrsmO3rkSG+z8/2/nL1Q
         1Haw==
X-Gm-Message-State: AOPr4FU4xldKPTytnzs986U5p3hfJ6aEo7YB9rF//xtw2i4hQny/lN8f/MRIOQu3Azk+Lc8M
X-Received: by 10.66.253.68 with SMTP id zy4mr6505983pac.81.1461703849278;
        Tue, 26 Apr 2016 13:50:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id q26sm469339pfi.57.2016.04.26.13.50.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:48 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292670>

We need the submodule labels in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 16 ++++++++++++++++
 submodule-config.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index b82d1fb..0cdb47e 100644
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
 
@@ -353,6 +358,17 @@ static int parse_config(const char *var, const char *value, void *data)
 		else if (parse_submodule_update_strategy(value,
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
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
 	}
 
 	strbuf_release(&name);
diff --git a/submodule-config.h b/submodule-config.h
index e4857f5..d57da59 100644
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
2.8.0.41.g8d9aeb3
