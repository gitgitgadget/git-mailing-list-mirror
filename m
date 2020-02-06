Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C159C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205BE2166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4+T/EL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBFAlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:53 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:50181 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgBFAlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:53 -0500
Received: by mail-pj1-f74.google.com with SMTP id z12so2204438pju.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HXAJ+iFjamq+8uYEpgJHgUKO9+FVivh727MB+qeHfTA=;
        b=s4+T/EL/FS4DplPZdX6e/zRcETF1KeYoN+qKNpm3+76iheo9rVhXZmK81wjX384ppm
         clhGNSY1L8/UTTFQJEJSFdmRxBVlxDKvwDNwNxOya6cjzhBqZWs2mxh64qdG4IqElDBh
         X6/4JRZgGWsoykK28gBYqLo7uXUxlzOEdX8PRbGXCK8BfF3+2soNbKud/DZlHKkhExW4
         NgRSqRjPdJc/A7qcYb+3xEhED66KTdA/CciCtH1xh8Ks8RM6hOWq3tB9wBR++UxHUZ/2
         cSIcnDLoQj6R1dEOdbSR2G4hyhIQuNAqLGTtkdnB4mKMzwv+llVGf10Lt/KlWfj48UIX
         cqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HXAJ+iFjamq+8uYEpgJHgUKO9+FVivh727MB+qeHfTA=;
        b=omlwbHW0iKMjtf+6OoA63WIZmrpfPUJ6B0Yv+9LTNXrh1IOr1+y8IEn6eugs71WOh/
         LUcECD5U4rGLAinVHh/9fDO22HMPGCDfsUDoIBc6PW8437WPwcJ/enhaHWWYSgi4XGKJ
         RIAUbQPXzx/D8wUAQWHZwnYu2nyZM3pyZizE7DMrCOQYNFFHKpdQcxtpHT0bmjTYYeQJ
         g14KVluqbgf9OH3QeG/8sB67N8iziSgTr1eB50xVSQ8uVlNgNNzQYz5ZXtqmaLQJpuWV
         TgW/YRd57JAzc93+tYD3HEBehSeIvz+o0b1ftsQWsLUY3b2MpyZvuabbLcgmVZ28LqfC
         DjXA==
X-Gm-Message-State: APjAAAWEUFmyjY3YizCbmgWpIAkT4beaizDJJp51Nm+CnsUKCGBufSGO
        Hx8W4qrS/SxlbhDaxRMyei56qBJfTAbLklbu1jys3xnCCglMMJ+A4UvbqIvAVlApKu+kYDvdBzK
        VCDwHqDdEyU0zBZ2ULv9OscUcAVCZ+MDkjjKxg0JHokn74n7hkNd/EsHd/V+nEXcWvadlVyWlAA
        ==
X-Google-Smtp-Source: APXvYqyfEIdWycxit6MIuxcNE62TLpfxx/vp0vV8JCMjUvwJ4rVZzEIMwH9qfkF2PGapHOjjKvIvny3M+CNmsBAsMfk=
X-Received: by 2002:a63:d406:: with SMTP id a6mr684882pgh.264.1580949710924;
 Wed, 05 Feb 2020 16:41:50 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:05 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 12/15] bugreport: count loose objects
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
index 3b0a2b12cc..9552e2922e 100644
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
@@ -210,6 +259,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Enabled Hooks");
 	get_populated_hooks(&buffer, nongit_ok);
 
+	get_header(&buffer, "Loose Object Counts");
+	get_loose_object_summary(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.341.g760bfbb309-goog

