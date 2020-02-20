Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A42C11D40
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E230224656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPtSAl7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBTB7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:44 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:52090 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBTB7n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:43 -0500
Received: by mail-pg1-f201.google.com with SMTP id m18so1299453pgn.18
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bXqNk8D8gZgU3IlplvuXY/GcpAoadbhrrvLlMeGwTUs=;
        b=dPtSAl7sIGuHnF9+7mH22yd/UsyKU+c+GEFuSU4dBagLY+Uu2eKYGVIm/NvjyD5QLA
         Ri9KADoPk2hJM+vKnT74q583FIExFeOmhM8it0c2bimZY+l2mgYfkbqI5Iul8X8dCt6T
         U7OlrqiSJjyMfQoFYZE3wWqMPQk/EP53AwrX6yGnwD+v401VvZo0M6vPZ3YJJHaW19r+
         wjUXvhml+vQeFY8YoldDdrZDntnJXUTPo0UHMZpMfcLRLzGmlYnOOvi7mnghAoViKA+g
         iWMxQqs6AUlRaFsBpMmWbhV8z3QdlYBI/zhplKq9SnpYgfpXdXMPKlN4cDRz8tp+waxC
         FLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bXqNk8D8gZgU3IlplvuXY/GcpAoadbhrrvLlMeGwTUs=;
        b=aSKSHLSoLfSRUqxbyjNhq17fgC96JBS6y04ufn5HzyfNW0eC93GJl8b+ynOIWrq8Gw
         t4YgWXJrPf2wpRXI+UYROf1n8x3NAZNGJOoGgLpUXdJT8PEZ8WxrSmgYX8g5TWUstLGN
         rrvZ7bQ4DduUJhGR1BFF31wzbJgwykmHyF43xrKM/gmcOrVC+bwuU7jqv6iTUQc7KqTV
         q50ptLQu1S/w/5uqePcynx4BhOZeLrWsDAcy7JTHK0fAwvxh8sXkZ3MuTqXzPxiVZNKO
         G8mBp6HLfe1mRrZ7R6p2goj8t7yBB700D+bYEeVXc7FFc5GIxN69iO5OJLSSAHRkDncH
         jUow==
X-Gm-Message-State: APjAAAUmijwUoNkTKHQYI0isTwkI6kYyXXC0vrWPCBEQJ5v2mCIEmonu
        LzHGZSd9KW/y0enOXDN6DQ4HvDW2OZN9Kd8FKN60jEpblSZs6qJZkRfNJrZkNkdDkamzd6a+Oll
        d2sstAGGE/wB1RH9eFWIamSiivqg7UQO3OmNfXBEShnFe+wGwqVyEs5omcsxASnz25gmWJX5svQ
        ==
X-Google-Smtp-Source: APXvYqyChv3wxYlhQYboFImgQUTHyLYYXWleLM6O8UZQZg9hq3IOAVCUeDJCUf2bpx9rEGIaCERFx24xxSwB6cXPJR4=
X-Received: by 2002:a63:8f59:: with SMTP id r25mr31921729pgn.280.1582163981393;
 Wed, 19 Feb 2020 17:59:41 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:58 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 15/15] bugreport: summarize contents of alternates file
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, it could be that the user is having a problem with an
object which isn't present in their normal object directory. We can get
a hint that that might be the case by examining the list of alternates
where their object may be stored instead. Since paths to alternates may
be sensitive, we'll instead count how many alternates have been
specified and note how many of them exist or are broken.

While object-cache.h describes a function "foreach_alt_odb()", this
function does not provide information on broken alternates, which are
skipped over in "link_alt_odb_entry()". Since the goal is to identify
missing alternates, we can gather the contents of
.git/objects/info/alternates manually.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index a7ef3360d2..1f60fb9456 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -35,6 +35,7 @@ The following information is captured automatically:
  - The number of loose objects in the repository
  - The number of packs and packed objects in the repository
  - A list of the contents of .git/objects/info (or equivalent)
+ - The number of valid and invalid alternates
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 1d61e0f642..1640a71086 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -255,6 +255,48 @@ static void get_object_info_summary(struct strbuf *obj_info, int nongit)
 	strbuf_release(&dirpath);
 }
 
+static void get_alternates_summary(struct strbuf *alternates_info, int nongit)
+{
+	struct strbuf alternates_path = STRBUF_INIT;
+	struct strbuf alternate = STRBUF_INIT;
+	FILE *file;
+	size_t exists = 0, broken = 0;
+
+	if (nongit) {
+		strbuf_addstr(alternates_info,
+			"not run from a git repository - alternates unavailable\n");
+		return;
+	}
+
+	strbuf_addstr(&alternates_path, get_object_directory());
+	strbuf_complete(&alternates_path, '/');
+	strbuf_addstr(&alternates_path, "info/alternates");
+
+	file = fopen(alternates_path.buf, "r");
+	if (!file) {
+		strbuf_addstr(alternates_info, "No alternates file found.\n");
+		strbuf_release(&alternates_path);
+		return;
+	}
+
+	while (strbuf_getline(&alternate, file) != EOF) {
+		if (!access(alternate.buf, F_OK))
+			exists++;
+		else
+			broken++;
+	}
+
+	strbuf_addf(alternates_info,
+		    "%zd alternates found (%zd working, %zd broken)\n",
+		    exists + broken,
+		    exists,
+		    broken);
+
+	fclose(file);
+	strbuf_release(&alternate);
+	strbuf_release(&alternates_path);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -355,6 +397,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Object Info Summary");
 	get_object_info_summary(&buffer, nongit_ok);
 
+	get_header(&buffer, "Alternates");
+	get_alternates_summary(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.265.gbab2e86ba0-goog

