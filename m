Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C7FC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB8D2166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5jRzJwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBFAmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:42:01 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46463 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBFAmA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:42:00 -0500
Received: by mail-pf1-f202.google.com with SMTP id c185so2665453pfb.13
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+SEt9cIEjZWJQuaMOwoMeoDn/4LSCl52Nai+V0nkf20=;
        b=g5jRzJwhexYOABCaMOSRTbpKq3B3M8QloSn7+WvtN3JtZHJwD3+xfSK2AYuh4wyHqD
         X3UzEv0UPx6PqMQ6zAC4PnFm8gSBpIMnHAEDEzjHz0M5EafaAGFLN0Eyc3RS3Wuamy98
         mQovZwzG5dy99mM/gxaI34g6vCkroAYh9D+QkmT1EU7+jBeyDB+L3fks9oDurQVl4Un1
         KEyEd8xFmROJx7jpDLORSRPGaLmrV23j8NufqVKVFi9qjkx190QTMuh8wrg1M0IAjip1
         CUghNxbe3Cy3ecZQojl6eTj0nQ+GjBq4Y/iVDfENm7tKKscPprEqKx8iREsiyjV5yK6O
         xexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+SEt9cIEjZWJQuaMOwoMeoDn/4LSCl52Nai+V0nkf20=;
        b=SZOJUaayK2iBT/nHOHWdtYvUtmbArMzbGzQM9NyiNK732UHHadwW5gKAwBJwYeLVnv
         oIJ9RmAQVCZi5yv8msAmszJ735ltG8xKCzReNwvrf5NQkpiIHlLnzHolQaHSVODTuuaH
         52YNiQZ9nEz6Wa/E43q4XLN6uaVhnaCXcfBcGAyRnbTLQQXZXT9C+N7YPQpz6dyemGh1
         y2sP53OXT/DC4laKof7QZeIgqWB/MGmxPzkbTZv90pE1/fyGMpckXgqC/jVZ0hOhh7tW
         6FXA0Jp4l6Rm4aONK4r8IJERLff/8RPoXE5wY3aiiGygo18+DIGiP243mmBBnvWEQiGD
         X4Og==
X-Gm-Message-State: APjAAAWO5plaVSxqkfgYJ4xOoYx/QzEHbeJ3n48yP4Sj0x8Ty10fhc/b
        0D7PjZjypEREHYYMmGSy2ziOkIkLJ7nccO/gF50F1exQmGOkorfTvJ1WwmGxrKcXCLGChh4HtBP
        niEG37BJXK8epNsWg52Ug2B2CyuoRQNlYmLFM5WPwF7TGZP0z96+mLH3cbe2ndb81U5nOLLUcqg
        ==
X-Google-Smtp-Source: APXvYqzqLKY8WGtiZ8L1vtX28etY/4GBC+U4H5VZZKEHymYQ2veajrIHycL2KbYbP/Kynuhe+exe/NSbJLlMblcMSyM=
X-Received: by 2002:a63:ba05:: with SMTP id k5mr653594pgf.158.1580949718327;
 Wed, 05 Feb 2020 16:41:58 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:08 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 15/15] bugreport: summarize contents of alternates file
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
index a21d081616..e870900c80 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -35,6 +35,7 @@ The following information is captured automatically:
  - The number of loose objects in the repository
  - The number of packs and packed objects in the repository
  - A list of the contents of .git/objects/info (or equivalent)
+ - The number of valid and invalid alternates
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index 3a3d33f680..9d4d5c8e6f 100644
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
@@ -346,6 +388,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Object Info Summary");
 	get_object_info_summary(&buffer, nongit_ok);
 
+	get_header(&buffer, "Alternates");
+	get_alternates_summary(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.341.g760bfbb309-goog

