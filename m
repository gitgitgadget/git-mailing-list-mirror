Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE4C3B18F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5976E2168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHUw6zsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBNBy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:26 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:44146 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgBNBy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:26 -0500
Received: by mail-yb1-f201.google.com with SMTP id n13so6538209ybd.11
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DTdoVnwl3Doo1Jag89MvQKMjslSAxopi0LZVHXddsrc=;
        b=dHUw6zsmCUttx3cdKq51lZEwwEG+hd5Zc16lIMLYp2E++yBqSc48kLDvcYH33ClTu8
         YVbEEFVj3Q7dLjsRt8zTR5O81275pKaJ24h9wAajM4k8FNNKmqDoPAtfxcBHeyYbgtVk
         4UBt+A03kJtlvhY8vHDR+t0BZThSQ/VlQywYC+O6lu9wM1jaTetatkLv0zh2IvlUyWXZ
         QR6eLC5rDkscNA1Ts6RFzpqOR8wC+e3r0M9/Flvfnh9FIyWZMkI5QPXxZHC21I1qLfVg
         C8bX1uxFvcTmMMcMeItOQBQ5D8KqkoJoTPqYijAbgwFDci1GHXoihm4K7awVVzTH1raT
         3PVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DTdoVnwl3Doo1Jag89MvQKMjslSAxopi0LZVHXddsrc=;
        b=Unx0uIf8uQAo5+ETywYnpEk77+D80MVft0GtjGBbO9yATKj41ZCv/0kmZLL321GMce
         vD83L993YFJhEup7Umau9SjfLgEhMI/nwywnIrGEqSZfvh+zq3wgKzCnf/8s7OBe9oxJ
         yVG2yKTC3mmPQaESYPatA69D1FS/3b2VEoLN5XKeLqD44dSpqn+FOwLtNgah+xxeShuH
         Rt/WMxpVvZFtgPOdeRX2k3CmnqIoNL0YjyFa1bu5jVXwkr7eHYYkOoim4V8qRrrNaJxn
         0vaLZf0mk7ezOXZ1swZacqJnFgKw9VnxSr9R1oOa0r3vEw9v28PM067TMe7GSJNFNg0N
         u/MQ==
X-Gm-Message-State: APjAAAXDs3udBtqorjkZeq3uWTnLGuue/qM+sZzGlwOt2KfyOTq/+oAW
        5mtwedJBlyVOQ8nj4YO+0zjNWDgZz/PtXNRF2bG5Rm8LvxW0SEuKb+UPwmKgfV8cr6M8CrtRgjk
        nsl6e3fQLqDjqJvWoroNuIUqUFzU6Gk6SU71RC5Lhtj+JBVNp6mhdFMEKzuSD9F19xpoj7QFDqQ
        ==
X-Google-Smtp-Source: APXvYqyarlwOS6nSfLwsjMv+jNiAOMiNf3UU9XGtCjeptMS64Gz6n2l1USf2PpyAklug3Q35vjKA3T6jBwQvpfENJ1I=
X-Received: by 2002:a0d:f245:: with SMTP id b66mr567233ywf.102.1581645265022;
 Thu, 13 Feb 2020 17:54:25 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:42 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-15-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 14/15] bugreport: list contents of $OBJDIR/info
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
index 580de13ddc..1c67b55598 100644
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

