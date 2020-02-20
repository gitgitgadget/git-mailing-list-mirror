Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7832CC11D41
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD5E21D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pT/+aId0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBTB7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:40 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:33562 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBTB7k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:40 -0500
Received: by mail-pj1-f74.google.com with SMTP id d22so852902pjz.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mpqrT5Qze+Us8UpdFpAGMe7m+uwP4gL7uh1F2yOvy9Q=;
        b=pT/+aId0VitvzAcbFUIrSNj6tynk+EQb0WvJZECaWj1icc/4n3rp+sGEudba0Akwao
         mOEHU42C8cZ9iR6wtJPzn3+vJtfTEpWWwN3hVSrF4zwXUKLwxNwuHKw3wNm72sMIy06Q
         oCi3xPdeYDpmuPISVA3mz8cJk+trCUT0T0DcAFy7rudwzq0PviMvQXrUTtvtn/S9pnmN
         ++z5rE33Ud4gya4ENIeLq/fPiFX6I0HjPLVNK9jtJoTv4QZGJwgHEBDCVKy8twrcwcJz
         EN8wroY50NAKdFipoFd5vSEocMJgCmfwF96RgRBsEGNRUlSc3+tZXeW5HhEI4gBO4IG0
         T39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mpqrT5Qze+Us8UpdFpAGMe7m+uwP4gL7uh1F2yOvy9Q=;
        b=DN+w2tRcNKg0589db4mCbLeAe++BK61VezcQWSMsWD9DR4NrFOH29Q3W4POiiPyRKA
         IIx8wlAL/Mum47e72SOEQlKFgrQQmH5c4ZeELLcu0/NgwOJagd9vHxFARB4XkTvTB+Sl
         rzWA26OIvO91LhqUU+r5aUqMhc5P6XXNz3zZXOywc4UC3nwsVXG7vA+HSmW6isSl+gq9
         VHMxlc1HnFUb1re6LX3l4kx++wBohhJ2JEeo5fkpL0Yckxkm2cmJ91ORiDtmwELujCX4
         +wdK0Mm5SDq3rVuArHi57lOWkqEG+kZVbhfo6IeJmfA4YkYXFbz7K6LFf9vLLJbyq9VH
         1xOg==
X-Gm-Message-State: APjAAAXxRp6epT0hSmhpNlhPvfRA1yquVr3wH8QlkPcv9u+lO1CjrYcd
        tfIdyhvrwpdinuWiusPJd9BEOMrz+yOtnCuxkL5+X1pshvPoMYMvt5+75DYBSxjU22rHVslQb+d
        Q9YmRj6PUTj9r8Wj/Bh8su7aMWBzT7+1Tio7tStXi9ZUYPFg5GivZppsnfIdBuJaE5X0n0vQLgg
        ==
X-Google-Smtp-Source: APXvYqxMr6OZ9K2Qq/170Z41TwUSi4HncLpN7dZwOlwT5fIUb4g7JMJZmzizKDSr/faLw6O9JnWql9KXjwSLzNExy8s=
X-Received: by 2002:a63:c401:: with SMTP id h1mr32026555pgd.262.1582163979125;
 Wed, 19 Feb 2020 17:59:39 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:57 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-15-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 14/15] bugreport: list contents of $OBJDIR/info
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miscellaneous information used about the object store can end up in
.git/objects/info; this can help us understand what may be going on with
the object store when the user is reporting a bug. Otherwise, it could
be difficult to track down what is going wrong with an object which
isn't kept locally to .git/objects/ or .git/objects/pack. Having some
understanding of where the user's objects may be kept can save us some
hops during the bug reporting process.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 bugreport.c                     | 54 +++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index eb41f0677f..a7ef3360d2 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -34,6 +34,7 @@ The following information is captured automatically:
  - A list of enabled hooks
  - The number of loose objects in the repository
  - The number of packs and packed objects in the repository
+ - A list of the contents of .git/objects/info (or equivalent)
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/bugreport.c b/bugreport.c
index 71191f1331..1d61e0f642 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -204,6 +204,57 @@ static void get_packed_object_summary(struct strbuf *obj_info, int nongit)
 
 }
 
+static void list_contents_of_dir_recursively(struct strbuf *contents,
+					     struct strbuf *dirpath)
+{
+	struct dirent *d;
+	DIR *dir;
+	size_t path_len;
+
+	dir = opendir(dirpath->buf);
+	if (!dir)
+		return;
+
+	strbuf_complete(dirpath, '/');
+	path_len = dirpath->len;
+
+	while ((d = readdir(dir))) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+
+		strbuf_addbuf(contents, dirpath);
+		strbuf_addstr(contents, d->d_name);
+		strbuf_complete_line(contents);
+
+		if (d->d_type == DT_DIR) {
+			strbuf_addstr(dirpath, d->d_name);
+			list_contents_of_dir_recursively(contents, dirpath);
+		}
+		strbuf_setlen(dirpath, path_len);
+	}
+
+	closedir(dir);
+}
+
+static void get_object_info_summary(struct strbuf *obj_info, int nongit)
+{
+	struct strbuf dirpath = STRBUF_INIT;
+
+	if (nongit) {
+		strbuf_addstr(obj_info,
+			"not run from a git repository - object info unavailable\n");
+		return;
+	}
+
+	strbuf_addstr(&dirpath, get_object_directory());
+	strbuf_complete(&dirpath, '/');
+	strbuf_addstr(&dirpath, "info/");
+
+	list_contents_of_dir_recursively(obj_info, &dirpath);
+
+	strbuf_release(&dirpath);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -301,6 +352,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Packed Object Summary");
 	get_packed_object_summary(&buffer, nongit_ok);
 
+	get_header(&buffer, "Object Info Summary");
+	get_object_info_summary(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.265.gbab2e86ba0-goog

