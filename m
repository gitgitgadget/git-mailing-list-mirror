Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6482C35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969D021835
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 03:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4VqcqBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgAXDfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 22:35:45 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:40585 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbgAXDfo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 22:35:44 -0500
Received: by mail-pj1-f73.google.com with SMTP id g12so545857pje.5
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 19:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7UBci21ScjkBeEf9VgxewN7XfaxUl4B2fpgA6V29wVk=;
        b=r4VqcqBO0rSOT1SgNDcHrq0npB1hwS5jIfSN6qHu3HZjRePggeBZ+Rn2d+V8RWGorr
         Xu+9UpsR4ziGwklnzXB+YzgFDG8qfvViYO6pLjZV4FUxl2svZxGfAx84xrRmUiQnIgoo
         90Kn5eP81jFjF4Jkb7A3oBpQ4E+T3agvlbxCRo2u9lUPjMw1vmRmsxGui/qtrak/qQcX
         AQskFCLKZUrISZUVOIJt6uUbyCav/qUNfp+EusJCJ09mGz6LNVbNfKMg8EJZoXbfsNLe
         8ohOnonhE94LxBUgfAzJTvuY3cZdkVrvSF/5Vw0a6FT718ggmHgtGx6WnCiUeGMWMBEg
         e0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7UBci21ScjkBeEf9VgxewN7XfaxUl4B2fpgA6V29wVk=;
        b=HSmwJf5k78KBSdoGwBONSRqJzNRGeqsUy6syk4NXHxWe/X28fSXQEB02exRJJA/vWZ
         /tZ3rZFfHx+3h1DS75Sa9Z61fDSalry1GcAr23GUAV8WFx2TKzPjVYBXtnFxI94bpWSy
         HKG6dFbgtRLM75eKtT1hRI4PF0+5oPfokY2a36t23CAe+88jqrsgLWXk8zexF885AhCa
         SZ0fdgA826nCPMHxdmx+8mqU+zl2fL+8/Xsm6QsCPFKcGQGmjYPsJajoL805EE8iAKwX
         0GgcRmvANWcWJ66MEOWdMRfFoOhHuEOZUVH/f3W0i8/7YqLWw/tNlkhKGwWZkdLc4E+o
         yDuA==
X-Gm-Message-State: APjAAAWvPDd6OHeCdz/tEzYlTN2ba6Fjp4MBsNQ9tdju49GkeD3uKfFM
        uL09RI9wKZ3jWiEMexztoC9UfIDE9LCVLvSW0BrL2CZd4Pp/rrvPmoRqPnwq8dl55dH5+vzmNs6
        AOw45NBIvbSXbFswt8Y22ek5EAL4LkjdruXqnoti5E1IoYG27Px246w+Xp3iVFDVn0daVvducZg
        ==
X-Google-Smtp-Source: APXvYqwX1Vh8gRuAqJFLxdO1FbIEzGCw9TKHtMHw89QWMkg6JC0LztB99mnNtnO31pF7Yv2vCv011b4VsBhQJalLctQ=
X-Received: by 2002:a63:ce4b:: with SMTP id r11mr1823909pgi.419.1579836943635;
 Thu, 23 Jan 2020 19:35:43 -0800 (PST)
Date:   Thu, 23 Jan 2020 19:34:35 -0800
In-Reply-To: <20200124033436.81097-1-emilyshaffer@google.com>
Message-Id: <20200124033436.81097-15-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v5 14/15] bugreport: list contents of $OBJDIR/info
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

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
index 45cc1764e0..12463ffdc7 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -249,6 +249,51 @@ static void get_packed_object_summary(struct strbuf *obj_info)
 		    cb_data.pack_count, cb_data.object_count);
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
@@ -330,6 +375,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Packed Object Summary");
 	get_packed_object_summary(&buffer);
 
+	get_header(&buffer, "Object Info Summary");
+	get_object_info_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.25.0.341.g760bfbb309-goog

