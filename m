Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AAFC3B194
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E32920848
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxZ1nj3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgBNByX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:23 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:49931 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgBNByX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:23 -0500
Received: by mail-pf1-f201.google.com with SMTP id c9so4955326pfo.16
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tAqmBpvv3JJsurmFduHZ0tAvK1YA3xnaG1czNXAmRro=;
        b=cxZ1nj3RKUBIwf7uoiJXwtwv7wAt/NVdPO58Pvmk8ca4/DeHE34DQP7X8bWja48X48
         OInPCQMx6ldvGdbWvSeBhlWoav9zpADbxCuRROUllxX5ycpdrOiTe3VM/LlXyu5KvBHL
         yFMXM34CtDLGSTNisgN7fn5Er9ibwOTVt++DbgKCKONz66ScIfy/qeUS6VG///hrksJg
         8Bnxepy689gauF8HP0J/c40f1bIHbANtCjF6qp7VGqYRI1s+UH6iU9pWDq1gU/Yl0ake
         YKPK4VJmt/ygLmS9rkdBRzyRayJbqP1KTEWd76NggnYFd3y4t+cPahyh8RlimYqNdbRF
         b9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tAqmBpvv3JJsurmFduHZ0tAvK1YA3xnaG1czNXAmRro=;
        b=NaDrDdewNacgG7Tgv9q9WvkO7rKRIyFgP3vADZjDQKXcg3zQd42O0WyQNuBvJrrMXI
         +v5IanwrK1yMG2UupatGKNqApmQUxFZeG1Bno4efqAv8nUU0RADfPUaLbJJ8UWO9wcrC
         amR9L6mlQaXQL43dgFMK/QXN30ZDnYWlfvAItybGH9YVGJ+SgS8ffo7N4CkX4lnklKrT
         /GLQ6U+0MOjNmdIwX5QMwYSTJ6C2l16kWWnVWFKuiV+gHH4DNLgdz+lmSoJ+d1tjg0YN
         B+F0WEndNgxQp1A40MV5nT6QBdctIrVOqCk8yuOPqsRHqPApDioDt8ftkTYOktgUqPE1
         K1fw==
X-Gm-Message-State: APjAAAUW7uQqNlDmpeXBwjbbU8tV17UpfSs3Art4DKPpqAOJtnkk8jbN
        Wfdly6zYEu3K8HztlJFSNVwmqsGHfbf4go3w39wRZTNKJ62kn6QayGZrpKPrUukbCK0ardFfeeD
        FWeMC96MY1FoT3pjtMcQ7maymsUrtTOUw8eV3Gd1EqkVZswMWsrJYSmFk3dn5MUNmMVkzWzfvTg
        ==
X-Google-Smtp-Source: APXvYqyEeMWXejox2wnDXofZa0EoOwcnVAGPWBp1JJ/YVdTy/hQ7KHJFpN5Z8JXUkei4oVzsRgPbRkw0a7EG0wmEyJ8=
X-Received: by 2002:a63:360a:: with SMTP id d10mr871281pga.366.1581645262612;
 Thu, 13 Feb 2020 17:54:22 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:41 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 13/15] bugreport: add packed object summary
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
index 7e1ed44cb4..309b34fc42 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -33,6 +33,7 @@ The following information is captured automatically:
  - Selected config values
  - A list of enabled hooks
  - The number of loose objects in the repository
+ - The number of packs and packed objects in the repository
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index f5201ce416..580de13ddc 100644
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
index 55ee639350..518c73469d 100644
--- a/object-store.h
+++ b/object-store.h
@@ -6,6 +6,7 @@
 #include "list.h"
 #include "sha1-array.h"
 #include "strbuf.h"
+#include "packfile.h"
 
 struct object_directory {
 	struct object_directory *next;
@@ -403,4 +404,9 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(each_packed_object_fn, void *,
 			   enum for_each_object_flags flags);
 
+#define for_each_pack(repo, pack) 		\
+		for (pack = get_all_packs(repo);\
+		     pack;			\
+		     pack = pack->next)
+
 #endif /* OBJECT_STORE_H */
diff --git a/packfile.c b/packfile.c
index 7e7c04e4d8..6873827fb5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2061,8 +2061,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
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

