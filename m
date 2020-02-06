Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71636C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ACD2166E
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 00:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQpHJxBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgBFAl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 19:41:58 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:46902 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgBFAl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 19:41:58 -0500
Received: by mail-pl1-f202.google.com with SMTP id t17so2152686plr.13
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 16:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xlXdAkOdeNCyXnBIIbCTdCvrGPJlWzWwSA2EvqUHyXk=;
        b=tQpHJxBhPofIKnDL5e4w1OctNpnEuQhSgNWiXK6LFp8fl7j8Uz4bF1s5NCUPd0BkM6
         GURaiAzxzdIrvpugC8H3TI29LKKJcpwfWJ5RO87YowL4e6NIcccZv681Cf7Fq9jA3Y/W
         E8HMwjtlIervZID97aEeAwhxldidk8bbt8rRrz1g2qnF1lTXk9CBRkxYV/bylc+Dpf+T
         C5Qwzre1cVsGEptzuYiAGjmN7fHkL3Vcc02bPhDSfKuWUvGbhLIkMFTRpmMfav2jyVXv
         qT7wNcvaimdFIihvxFQ4kZtr2w8qxAxuMRqS41FQhy2Bgv2NXq0GlZE91WsjU7epsQDg
         gNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xlXdAkOdeNCyXnBIIbCTdCvrGPJlWzWwSA2EvqUHyXk=;
        b=OtnNY8ErUdPJCavNxXkaM7ElkJNOgq1QYKnfePKie8Lj4eVABkW0uwbi7M4WPFSohn
         c3KFl92I7wWvWxGgwWMv7nA3PCmKPRsJt5Gl5gviIsLKDnZy5Emi+HFjfaACmm6dGs6z
         hzOVhOAPfG+gwLqyOzNyoVmWP9zxM1xeNp2HbOewjnh1Hmv18MbVVx7M1oYVEiJWeRJx
         t6XdyM/f7GYa3mU43JoKVcmCdaJdt1spMEYsm62JuVA7Wcdd0vmTsugixwTAIgL+23id
         mvcdd9gquehR4r9Pi6dVxJZd/wsWrHp8sPFTOcvrJ7qyjrE33/B6rqStt1p1gjizMkd+
         BZUQ==
X-Gm-Message-State: APjAAAUq2Akz1R53UkbeFJHY1f/EJukT4wsknYw5bkgqBfU/XlNbcpJl
        t/5VnDBue5FwF0eF32jEEMtC21hvEN6GyC0Im4JFhYVOknZSQiQFxrawLH1W35qWZrDB7Z8Ad5d
        t7kCdk5SdxXAm0sWD7UglcbjyZNHeq1wIzbl97nQ13w4Lt5Oc6lb2xMoyh8UxiV5gJxlSz8J5Mg
        ==
X-Google-Smtp-Source: APXvYqwuBYO2l7N7rfeXS+H4W8J0mj0FsZXnOeLfrQJGt/kPsVu1Ea8qhSpq1/xPM/7R1zV7N68lOMzvOOtYN5c9GNI=
X-Received: by 2002:a63:7515:: with SMTP id q21mr668826pgc.63.1580949715950;
 Wed, 05 Feb 2020 16:41:55 -0800 (PST)
Date:   Wed,  5 Feb 2020 16:41:07 -0800
In-Reply-To: <20200206004108.261317-1-emilyshaffer@google.com>
Message-Id: <20200206004108.261317-15-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 14/15] bugreport: list contents of $OBJDIR/info
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
index 309b34fc42..a21d081616 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -34,6 +34,7 @@ The following information is captured automatically:
  - A list of enabled hooks
  - The number of loose objects in the repository
  - The number of packs and packed objects in the repository
+ - A list of the contents of .git/objects/info (or equivalent)
 
 OPTIONS
 -------
diff --git a/bugreport.c b/bugreport.c
index d554488f3e..3a3d33f680 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -204,6 +204,57 @@ static void get_packed_object_summary(struct strbuf *obj_info, int nongit)
 
 }
 
+static void list_contents_of_dir_recursively(struct strbuf *contents,
+				      	     struct strbuf *dirpath)
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
@@ -292,6 +343,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Packed Object Summary");
 	get_packed_object_summary(&buffer, nongit_ok);
 
+	get_header(&buffer, "Object Info Summary");
+	get_object_info_summary(&buffer, nongit_ok);
+
 	report = fopen_for_writing(report_path.buf);
 
 	if (report == NULL) {
-- 
2.25.0.341.g760bfbb309-goog

