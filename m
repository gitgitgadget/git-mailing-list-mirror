Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F3C11D40
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3393C24656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwMYwpZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBTB7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:38 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:33561 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBTB7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:37 -0500
Received: by mail-pj1-f73.google.com with SMTP id d22so852858pjz.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EsGnCNMpS+5Wytfo1sX1NIfMdMPivlv2CW66I/6jj6g=;
        b=uwMYwpZHfSrNYE6t8Dhv8jRrejwBafZRQd7Q2XIE1AXnQK3UK8+sQG49GbTLvZ2DU8
         1e2YPsCrKPEeJrwkpJ+cidHhTGWSO6LN74lxb2yMuo/GQzK3UYfJOgJQGsnroQdhOtOT
         qo4CjZGnQkCctK+XAIpO9id8Sq4V/GDfOoWrtwKw5RMogu4Zs3rxDLX87HJngA5wfydu
         peDnY4LCtt6AS4CDSOKSp9fNjgve4Nm0DOYFJdbUIC0D5PhfBJ5pWLmQ+iYAFyi1R+5K
         RbMC+shO7CFlbUNNsZnD7Mo623E46Q8/1ip2tBvdwCFNSJh0OUBzWEFFr0yP0BZhfGum
         pkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EsGnCNMpS+5Wytfo1sX1NIfMdMPivlv2CW66I/6jj6g=;
        b=YgegBzHTwyPv5F2HctXFDil+yG/XYQuXB3BwrGd4FY6gWXxO/2qgD8p1oieAeASkJO
         kNWlESXYyvmB0RYeWpKxIx2gbIPVMreg1BPNCtvXs+z5r4qIKbmppADYrOnFRfmPyuOx
         pti3Enud84dcFKrMzEunaStzIE7TaSfzzqS6f2hT4cKI15JXUk0plU0C2t08FKUSuuzD
         gtfOgkCu7iTML5lKapk2DXfWvx/j17G53XhW6zLcC5+NyrSY3yC68cmPYiASY7ZsA/cK
         XbOL+3m+eGVM9cSc5nSWoSsw8dX95N8j9AyK2qssPITFzHBNnPAQ/jV051gdyuGoW2nh
         F3xQ==
X-Gm-Message-State: APjAAAWG6eCNClJs6xWzc0lLFgof4C/dtuBCVqGgiX55xUuqQom8d2+J
        gKQrhLgVajzaYHo0tk/VjJi/Q66nERcRnthagunm3EQXoxbZXgBkWDV0Lp9flOaAdVpOXTjilML
        wArdihbknb44AbVwbDCwr2RQHixmVUMe2nZHAcmq+pjS4RAZytbwtujZMJyKI6E9oMC/MR/tPYA
        ==
X-Google-Smtp-Source: APXvYqwV2cSI1RKNyFuy/P7aKWhohBn3AkdnMaKFO3CguNuZ3lzq2RtPTmvDXoYEI6nwEfCJgJ1hEjkT/sr2EbC6qCw=
X-Received: by 2002:a63:f648:: with SMTP id u8mr31074131pgj.148.1582163976920;
 Wed, 19 Feb 2020 17:59:36 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:56 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 13/15] bugreport: add packed object summary
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alongside the loose object counts, it can be useful to show the number
of packs and packed objects. This way we can check whether the repo has
an appropriate ratio of packed to loose objects to help determine
whether it's behaving correctly.

Add a utility to easily traverse all packfiles in a given repository.
Use it in packfile.c and remove a redundant call to
prepare_packed_git(), which is already called in get_all_packs().

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 30 ++++++++++++++++++++++++++++++
 object-store.h                  |  6 ++++++
 packfile.c                      |  3 +--
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 4fe1c60506..eb41f0677f 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -33,6 +33,7 @@ The following information is captured automatically:
  - Selected config values
  - A list of enabled hooks
  - The number of loose objects in the repository
+ - The number of packs and packed objects in the repository
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index fb7bc72723..71191f1331 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -177,6 +177,33 @@ static void get_loose_object_summary(struct strbuf *obj_info, int nongit) {
 		    total_count_questionable ? " (problem during count)" : "");
 }
 
+static void get_packed_object_summary(struct strbuf *obj_info, int nongit)
+{
+	struct packed_git *pack = NULL;
+	int pack_count = 0;
+	int object_count = 0;
+
+	if (nongit) {
+		strbuf_addstr(obj_info,
+			"not run from a git repository - no objects to show\n");
+		return;
+	}
+
+	for_each_pack(the_repository, pack) {
+		pack_count++;
+		/*
+		 * To accurately count how many objects are packed, look inside
+		 * the packfile's index.
+		 */
+		open_pack_index(pack);
+		object_count += pack->num_objects;
+	}
+
+	strbuf_addf(obj_info, "%d total packs (%d objects)\n", pack_count,
+		    object_count);
+
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -271,6 +298,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Loose Object Counts");
 	get_loose_object_summary(&buffer, nongit_ok);
 
+	get_header(&buffer, "Packed Object Summary");
+	get_packed_object_summary(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
diff --git a/object-store.h b/object-store.h
index 5b047637e3..f881a1756e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -7,6 +7,7 @@
 #include "sha1-array.h"
 #include "strbuf.h"
 #include "thread-utils.h"
+#include "packfile.h"
 
 struct object_directory {
 	struct object_directory *next;
@@ -447,4 +448,9 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+#define for_each_pack(repo, pack) 		\
+		for (pack = get_all_packs(repo);\
+		     pack;			\
+		     pack = pack->next)
+
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 99dd1a7d09..95afcc1187 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2095,8 +2095,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git(the_repository);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for_each_pack(the_repository, p) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-- 
2.25.0.265.gbab2e86ba0-goog

