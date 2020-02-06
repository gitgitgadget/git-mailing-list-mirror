Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4736C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF242166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tkmb7wmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgBFAlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:55 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:33680 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgBFAlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:55 -0500
Received: by mail-vs1-f74.google.com with SMTP id y15so279169vso.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AVYYQp3rUELKcwibZIXczAtH5lQZZgoIvNRRLEVVSbs=;
        b=Tkmb7wmK3SLkywHgPorGoZN/EA2o0SXNvPNvkTZNsY6YA3cH28M2d3w0xjhzXKom/u
         Xp6jnimDhFDMh+6aEWukI/tFrbNVp6ySNkNjeOpv3dV0omBuW0rloqz98ZuhFUvHV3lI
         6LWn1igcdCQPckmzMgA+rqlbtxTltw4PRJdEn8XZGp/yuMH5RbfNc1i2DF4pm2hGXH3J
         mqNL3wvGKjlwnbZu6Yi5C5rAv/STajGZom8FlPhKnu07PfkhlvFkO/klRzetvvdOtCQ2
         6Q0u3HePfOLk+NWaPD1lvX9hvLqQus3BafXqDiMnqLvXUkuzWcfIGaEljKjW/D1Bs7hW
         XtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AVYYQp3rUELKcwibZIXczAtH5lQZZgoIvNRRLEVVSbs=;
        b=O3Y/r8yjDqi+P3jyT4r3N1W/w3Nc9aLSz2qAB0jRTO45ykp18Urk0Wc4hbNKnUacqk
         jsVZLZu6w0EMoHiAlLtK++9Rr0p+X1ZEolSZcx2HFD/Gr+SiMbT0NM+okZmH6ibjJphA
         KzqOF3wL5AgBjz6mmv70zJIvjdlAx94JCaN7Imxjj3kduJEfsxDU43m2xPRU15TtbjVr
         Gujk5dVALPBEEodrdw+Km1a/Gq3kQ3Muf86jVC+THbrwOud1wdxo3M/pm+Y/jptxAno7
         tsbXo9ZXPYYuRckiMam0NRVReKfM1K6ozRsKlA5zCbjWWAdTHyl4Va82o1dF28m0JNfA
         YIDQ==
X-Gm-Message-State: APjAAAWQ/KJw7vJqfA74+KVTxJsGmMAxYWYCXYv4C7hUQUh9AWmcdNlE
        74KSSK8x1d0qMnULOdLxHY3MTVlB8zTi7wiK7dmlJckYLVTax2tBbRNZmROLCSQvl0g8f6+LXm+
        8TZPMFW6tTehJEYz6hFG784F2VcNV2OK4tguamm+O5azPWVGckY4W3TjCmiRREyD0aoDTad3zmg
        ==
X-Google-Smtp-Source: APXvYqy8ofNv6/teoDd9AILK7xRbgVZlYZAMXgRk73pBdvj8rl0zX9pGik11CGLdQ5W41CgxZ6L3zpyaIMiVjWKvLe0=
X-Received: by 2002:ab0:48cf:: with SMTP id y15mr245874uac.26.1580949713427;
 Wed, 05 Feb 2020 16:41:53 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:06 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 13/15] bugreport: add packed object summary
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
Perhaps the macro should be in another patch? I didn't spend a lot of
time looking for anybody who could conceivably be iterating packs; if I
were to do so, I'd break this change out separately.

I considered following the pattern in the rest of the file, where the
foreach takes a callback and data pointer, but found it would be
cumbersome to use with for_each_packed_object() - I'd have to add a new
callback just to handle the pack, and bundle that function's callback
data along with the callback pointer. It seemed like overkill.

 - Emily

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
index 9552e2922e..d554488f3e 100644
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
@@ -262,6 +289,9 @@ int cmd_main(int argc, const char **argv)
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
2.25.0.341.g760bfbb309-goog

