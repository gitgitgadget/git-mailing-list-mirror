Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E18C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC7321655
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Al8ure62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbfLMAoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:44:02 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:42916 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfLMAoC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:44:02 -0500
Received: by mail-vk1-f201.google.com with SMTP id 198so307801vkz.9
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z2PBOeiNceafL9gMLCWLSaOgNOOycaLR48iAI36O43Y=;
        b=Al8ure62NMogREvEhNCXRVyIxUX1a/0AdBXAevMIN4KUv9vU3AvLNFtyHYJ11HL4vm
         q7yBl4LrpmZVa0AFTb/KJG91PMjXs8IEm9dmtdya1w0E/YjESDh7k11snsvlAr2ekWkp
         BBPsMvoUkynNoT43VRghGbNJU4hpOJvM66FJ6vHqvMcKl0knn9ldUr6eO5497+XhG9d/
         csEGycoiZNz3xhQay7YLtmceES5RoUyugkFBqdrDAY/7wkJxvlN2QibTrLpU95r/O2VM
         2cZCq9xaQzPp/K715cH9MHyPzbIoMpX0VnDRop0Wcbgzhj5AtY/0zznJaxJeYNpjkrLN
         vi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z2PBOeiNceafL9gMLCWLSaOgNOOycaLR48iAI36O43Y=;
        b=EtWGNfM46Xkuz0GiuUumz7icWLXT3ybA6/1gmDSRevR+4P/c8bA+kS1a7guNkzsS5p
         sjNN2PGP0rL2XGGF7W9uxqJGYb1mED3TMfIDOjcY69ioFcIsQUkvzLueYCUzasNUwXsX
         tmE+66oq/Yi5lTBibv36EpQhsniZ0fRA+QagMCw8D6KMP2yuOHi80IDOH/jkE8bmy293
         lrdco0ylh8N0lpuTP0Ikik7wVkwguGQrlpG1ahmOIx1L3+NyygbW4KknthE1t0Q7Tth0
         4ifR5dC65np1/Mqyi5gFAA/J95Ghi37TPpHj7BkoACxvsvDQ792zR9jqhyFBkw5Z6h/Y
         9y4w==
X-Gm-Message-State: APjAAAWXUT/rX8BQYU1hPTo8EENcFhdGQzDixdqHEPXNec9+DsTfx1u3
        J7Nyy+soYyVZwv7njAF+/zyR28kcLgz+JCbbbhRirRIvsTTXcRddHrnSmG9OV1DIhFyBcDK0stT
        3+wP+5PjYgzP4Grkh9wosI2NOLXUB8SFFgzSbl6s6pfCs5KTsIdV40BJvie2UIrj1JXMGUha7mQ
        ==
X-Google-Smtp-Source: APXvYqwieCdt40Y7nx1Vbjsph++DR6bo91c988leJbx7g1+KP6QTwFdyz/MN1pN0F6DPj3/VbQVo3trjEUkI6a4+0Ew=
X-Received: by 2002:a67:e8d1:: with SMTP id y17mr9076322vsn.91.1576197841286;
 Thu, 12 Dec 2019 16:44:01 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:11 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-15-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 14/15] bugreport: list contents of $OBJDIR/info
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
 bugreport.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 992d8f9de7..5d300f1c5f 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -262,6 +262,51 @@ static void get_packed_object_summary(struct strbuf *obj_info)
 	strbuf_release(&dirpath);
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
+static void get_object_info_summary(struct strbuf *obj_info)
+{
+	struct strbuf dirpath = STRBUF_INIT;
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
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -338,6 +383,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Packed Object Summary");
 	get_packed_object_summary(&buffer);
 
+	get_header(&buffer, "Object Info Summary");
+	get_object_info_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.24.1.735.g03f4e72817-goog

