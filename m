Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52BCC3B18F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F932168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVgDfXH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgBNByW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:22 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51980 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgBNByW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:22 -0500
Received: by mail-pg1-f202.google.com with SMTP id m18so5028788pgn.18
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vp2GGgOSFO7of4FYxfU0AD8iRUDIAoiHfZJeEqu5n48=;
        b=sVgDfXH9n1v1cl2YTxHGEfoibToTyPOiGz95+YKM+53mZJzoSW5H4MibxDY+PJop9v
         2/5hVd3zhJEZIvza3OMNLCLsjxBXcgO4w3SL0UozRnS8eD0DuzDqJR0vHkuDTT8fpEFd
         l4gpbDY21GHJ6HSYUt7wg5Mgz86XoxhW1drf9ARD9HyiLpjGCoJCz4iCjbQdWmL0UdrD
         ZBp0Imh3KKYcn5KY0tVJlqSy4jI0ElINpdVlvkR7QA2XQfQsddVD13Gr96jVPYDgl38R
         iGc5QhrHlzJ92CVtffKZpzywqTzDTf/P/8Qsie2Pr4hz8MhGH0erynVcCpAzZe2rhuCA
         PvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vp2GGgOSFO7of4FYxfU0AD8iRUDIAoiHfZJeEqu5n48=;
        b=bn1iV1BVGlNnqLTqMrRtTxmYVgPtPLW8P7Mp3XFUfkazDpK0f7HACSAhMuUM/tFS5T
         yk+siQwHCBdwogJ4xDoIq5cBUYk1E/vY5NqNxKt8m8aT0DoEIDEilxnexB4wZg7Mstma
         38aIyG5C5lfqcHzG0NkxAQwrFj1T902jEJWzhE7TjlBo3q7eDlw/iLYGFD+umgugOy23
         3/hZmxZiBo7s9S35y4NyxsjgP3XsyzPtEYO7MKGyspJfUb2O26vUmAM3VKSEAZyxpO2N
         7wv99uT+0Ofh9FbDCijDwA1fQI0i4CvW9QeYJMPXWal5D0xgh3SikcsLEj34uQro3Bb4
         u0hQ==
X-Gm-Message-State: APjAAAWFeN9F16pxLT/1JQkghEN7tePsY8L48AfxxnElDq+sEw/h5gLk
        7bM660j8rIC6bopRhNLD6+GHcObS20ttClx2G1idYqXfTH9niTp16C8XKgmbG3Al7wLc1Cas4J3
        LLdBIGxpXsk0oL2j2VmZlFR4ZXauTvL4njwM88KXkpUt3Quy5hUc0oVbmuNBo8etwpfxm2Hz2wg
        ==
X-Google-Smtp-Source: APXvYqyNHRG/QHELDJ59IzlEe61gwWXSm+VN/azb01nOhqxRF1xJPTa7UC8a0d4/l/DAcJ/oDUy7drIUWhNli9sopQU=
X-Received: by 2002:a63:504f:: with SMTP id q15mr922418pgl.8.1581645260119;
 Thu, 13 Feb 2020 17:54:20 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:40 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 12/15] bugreport: count loose objects
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
index 779c9c7fd9..7e1ed44cb4 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -32,6 +32,7 @@ The following information is captured automatically:
  - $SHELL
  - Selected config values
  - A list of enabled hooks
+ - The number of loose objects in the repository
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index 7e6147a935..f5201ce416 100644
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

