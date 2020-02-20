Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E6C11D41
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA26721D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9w/0btB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBTB7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:37 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51418 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBTB7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:36 -0500
Received: by mail-pf1-f202.google.com with SMTP id z19so1459007pfn.18
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VPfeplWG4b67E5JkrJSB8q2+yySZBw43O4RsqMDXlh0=;
        b=Y9w/0btBtWS2qgTSdCH9GPDf3aAbZKchcaxo7p7NRbKfJIVhYPjEA6NnzQ2sKTdqEQ
         FhO49zCyxqxRfexrSjHMwBBj0rHLOp5ZgXgsedsHV2ultSw7P+kjx1ObGjqVglD4rxkY
         GMz1PTdDsuwEo3UwUZhjqDzus1WYpYxAPe0nIoYR1oW66n/ZaDK4vmISoOiiTcOFq6a2
         ZW9rF/MjBD2ACXbwndTJYwKdR639lzfwCaq2ozLRoqWbCHJfJsXDU1sTXhb60gzHtuvB
         mlxvUsDMcCjGgMOaj6r9lWp5RsYtPhhjI6SYKL4uCbZY8N39RBb8Jz1ng26GvjMEtM9B
         Qu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VPfeplWG4b67E5JkrJSB8q2+yySZBw43O4RsqMDXlh0=;
        b=A2fYQeh0+l4udDNt8CggJ13fXkIDUGYHGFFBcdRCuyaemroo3vcLNW4aPVMCsigrtQ
         zYHjTfU8HlqhNTn1Ef1UYNg7BdcJWLwOQ9PvVfjIgusFAU8eCV0yU/Yq/W+aePMrZAk3
         9nYwa0fWcDc5Oynb+biXKKRB+uaGXfQU9zmG5lVL1lPaExdOz3OOovcB0xd+1XYxt3N8
         KLieS/SPA/dtSBjAJhjHmw125zSjejLDSaQdcciHnZrhu0tp+Iu8VMOC4cuVWm/4MMD7
         chXCdM1Z183Rzon3ysZjo8TNtV0Zg6vP7qR0ruib7oGQ44DoYWzXeetdhOAPnXzjju0N
         G1Og==
X-Gm-Message-State: APjAAAUcy5psiM1dExzR1XgrLNUHEASzjx4Td8s12vLx/rUNeofbOsyx
        AfnAAYSU8fG903flGAYt3jvfSF8UZc/+YL5M0XdarxPHwJ7yWbOFSvsbSq2iHWn5bgpG3c8QnDk
        F0VZXypSZ6OvYYo88Y0FZ+bBcnAA8dSGQgFxu8kvs060yga/cehSIU+4WmO6cGCvBC0/TZ1TrNg
        ==
X-Google-Smtp-Source: APXvYqyUwQMYBMk3/iOWanD5wecriLIeOoG15pB0gygpeWesTdUcwMGhOjZ9VTEwop43hb8TBSbU3s8N84kYpk4Qj0Q=
X-Received: by 2002:a63:f80a:: with SMTP id n10mr31019942pgh.76.1582163974344;
 Wed, 19 Feb 2020 17:59:34 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:55 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 12/15] bugreport: count loose objects
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The number of unpacked objects in a user's repository may help us
understand the root of the problem they're seeing, especially if a
command is running unusually slowly.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 4d01528540..4fe1c60506 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -32,6 +32,7 @@ The following information is captured automatically:
  - $SHELL
  - Selected config values
  - A list of enabled hooks
+ - The number of loose objects in the repository
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index b5a0714a7f..fb7bc72723 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -10,6 +10,7 @@
 #include "bugreport-config-safelist.h"
 #include "khash.h"
 #include "run-command.h"
+#include "object-store.h"
 
 static void get_git_remote_https_version_info(struct strbuf *version_info)
 {
@@ -128,6 +129,54 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	}
 }
 
+static int loose_object_cb(const struct object_id *oid, const char *path,
+			   void *data) {
+	int *loose_object_count = data;
+
+	if (loose_object_count) {
+		(*loose_object_count)++;
+		return 0;
+	}
+
+	return 1;
+}
+
+static void get_loose_object_summary(struct strbuf *obj_info, int nongit) {
+
+	int local_loose_object_count = 0, total_loose_object_count = 0;
+	int local_count_questionable = 0, total_count_questionable = 0;
+
+	if (nongit) {
+		strbuf_addstr(obj_info,
+			"not run from a git repository - no objects to show\n");
+		return;
+	}
+
+	local_count_questionable = for_each_loose_object(
+					loose_object_cb,
+					&local_loose_object_count,
+					FOR_EACH_OBJECT_LOCAL_ONLY);
+
+	total_count_questionable = for_each_loose_object(
+					loose_object_cb,
+					&total_loose_object_count,
+					0);
+
+	strbuf_addf(obj_info, "%d local loose objects%s\n",
+		    local_loose_object_count,
+		    local_count_questionable ? " (problem during count)" : "");
+
+	strbuf_addf(obj_info, "%d alternate loose objects%s\n",
+		    total_loose_object_count - local_loose_object_count,
+		    (local_count_questionable || total_count_questionable)
+			? " (problem during count)"
+			: "");
+
+	strbuf_addf(obj_info, "%d total loose objects%s\n",
+		    total_loose_object_count,
+		    total_count_questionable ? " (problem during count)" : "");
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -219,6 +268,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Enabled Hooks");
 	get_populated_hooks(&buffer, nongit_ok);
 
+	get_header(&buffer, "Loose Object Counts");
+	get_loose_object_summary(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.265.gbab2e86ba0-goog

