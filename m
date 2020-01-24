Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE2C35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA34C21D7E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHYR7+KH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgAXDfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:48 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56162 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgAXDfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:46 -0500
Received: by mail-pl1-f202.google.com with SMTP id c12so426854pls.22
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VzoZ4FKhaorUGWAXnLUFgwc7FU1UKXLmaUOcwxG/PjU=;
        b=dHYR7+KHKv6w8p6ByZ34JG7/0gwW8AUtoJCa4djaRokQDgxJ6S9XyhDEU1QsbILuCe
         XGzMhh9mE0a1F/zr3g/NTZ0fBLhW/L/7oBaNx8HLPMh++O759WDD3RKBCXgcJgwNw97p
         dtSJePlYDMpEoWt5zccof9QYcrzLpSfJLQkXQpo7cIO6nwOZG3um+U63a08hfrLfTfYH
         rAbJwtqK0ZqzNudAFWlaGXIXBJR4ZFWWHikqAN6MLBcXew3Qsf+wfZXrL4ju1lmxZHMn
         ZlIMb04zc/KyJqmr1LvjwspRYJHVjXH5mvWaWYvHs93HRzTVBsG0em2Me0/wzomNhgm9
         XPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VzoZ4FKhaorUGWAXnLUFgwc7FU1UKXLmaUOcwxG/PjU=;
        b=KgG1rg+IQBctgKZR+qW5A3UKdxNSnP5khp7GCaOrYtprCFJLv3+fbRuvOPeEiHd4Ba
         TMTfEx0piduh9uccHjOtLc4VSx6B9UeSSf8Lqp8Hpk25uno5GwIU4RcnR1LyLPK6vLzu
         K5RkhabDRkwokngLi530eaoEmABjVaA8wCiUOVDZ5v5Qh0OfFS5vqzW8jbG/4rtbaRzX
         HLn3IY4OaKqX1OM1e2coxswpN7U9bpDPj6TSRsE/EYJ8MqNKxH3feaDSbbwbMwGaY3TS
         b1lqRWXdm7aQnO7ZMsp2a2Vp1bFmloxC17DMt1BsJovCGPTfyu1JTj+TgHAchOZTyGrT
         oiqg==
X-Gm-Message-State: APjAAAU358BBvGGqm8vtcgfaXdwQQ5nFwDhdj6fjPgI7jimQI7rxPdWv
        8B9izBCfKmGMEMNPNYDOjw1pDYuPPnhO2RqweVmqZRPNy+ReC91t2tf0pCv6JtTD67FUPby5cFI
        lAMN4GQugPP61c6QEeH6C9WflaA28S+R8Z5RkJ+gh4uKuyIXEsUO6sNNDcBYBYg4trOAcfXcNHg
        ==
X-Google-Smtp-Source: APXvYqwPUwcIb8F5W6r1tpOV6yEePdNkAvCQxdR4yBBvN4ZedFZldw55s3Hxu1yhYMW8ufjNXNTxOkUiGyjVP5YqTnw=
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr1868236pgt.208.1579836945908;
 Thu, 23 Jan 2020 19:35:45 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:36 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 15/15] bugreport: summarize contents of alternates file
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

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
 bugreport.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 12463ffdc7..2c540182dd 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -294,6 +294,42 @@ static void get_object_info_summary(struct strbuf *obj_info)
 	strbuf_release(&dirpath);
 }
 
+static void get_alternates_summary(struct strbuf *alternates_info)
+{
+	struct strbuf alternates_path = STRBUF_INIT;
+	struct strbuf alternate = STRBUF_INIT;
+	FILE *file;
+	size_t exists = 0, broken = 0;
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
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -378,6 +414,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Object Info Summary");
 	get_object_info_summary(&buffer);
 
+	get_header(&buffer, "Alternates");
+	get_alternates_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.25.0.341.g760bfbb309-goog

