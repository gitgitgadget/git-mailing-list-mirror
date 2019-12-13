Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE5BC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6532253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTOz1Rlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfLMAn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:57 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:44513 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731763AbfLMAn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:57 -0500
Received: by mail-vk1-f201.google.com with SMTP id k16so303872vko.11
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ab2bcDVKAZvq03F1lRiy63B2enXZnHSY50w8FqRsyTM=;
        b=CTOz1Rlky5utrtsaS4yS/mh453m4jgOkVxx6QV6zrDlIKo8pfxQaAol8P2fniVjwTO
         1BEd98aSsNlMfVC4aaTV+Mv2Ybt7Hp2n6IBD3xWtSk4S7tAVD2oEf6oSoHnsjtt/vlZj
         DHioMcMdBGsvzKHCdT1+ft+tvuAfSi0KNhm95hlbbYUEq+fvoFwCYFooWdPyPVal3yOV
         MbCV6tT1TaClta3+8l9245czqe1uJHCcZI2RaGRIKYiEHFDF1JRz2hBvHXCQ035bd59X
         ghSQfXrBVu+oQ3dz7GmcwfKO7YoLtlgvlzZf6HxtB9FgW+zHFPeQTPAW3ePJWEQ3eKsl
         nVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ab2bcDVKAZvq03F1lRiy63B2enXZnHSY50w8FqRsyTM=;
        b=lGzhc2YojBlpedFY7YMBdKPGwNgQBxlJkY5o5R38UW6kMynJkovngwy/1Pm+xOy0It
         a7McC1WGh0E8V9BJd/EYBBXqo7X7XPhfuW/wV5D2X+8x4yW/kSsZTxujFxkdP6dQn5m4
         Pz/xuyVHnikmhUvEBD/joDscYrBxtOhT7YfIRJ5Nyh/96AQCeLJZlJa1mgjbC2yW31Hg
         UgF95q52t2SDMxItlnXI6pe2ct5TMhgQ2peMlz+uanGevVBPs7F2Axe9gG1K4NRmGvl9
         If50AKFq7jvNP+ZXMU5iJSHyrbK93xGUSO+JmxCFfaOlp3wDh3Lw/xR/FzqCwIYGhTxd
         N2XQ==
X-Gm-Message-State: APjAAAXnN07b3rCdnJrwzxWxxzSvhBT2I81IG6g4XA5rpBZY6/CEA3gW
        +/ljkCoDbtLo10YicOH94SK/RpG0Kc2L5CKPAud3tgFj77kyQD85EAYf8RXbJu7wLea4GqoZ0Ne
        aDQ3M0oBjXKAccWYdmZX7htYbPRMCl9sr9WnN+tEktNDLN77hHSzwdES3XsC4ETIn47t++XgV5A
        ==
X-Google-Smtp-Source: APXvYqwfwqsmnorG2+KMxRpbV1u+1Zqg5NEvseH0btROuAZZaToyeEXFMvoowHsSGG0nkhIQ5CERmfy2WsVo8siJQ9w=
X-Received: by 2002:a1f:e3c6:: with SMTP id a189mr11599068vkh.82.1576197836471;
 Thu, 12 Dec 2019 16:43:56 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:09 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 12/15] bugreport: count loose objects
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The number of unpacked objects in a user's repository may help us
understand the root of the problem they're seeing, especially if a
command is running unusually slowly.

Rather than directly invoking 'git-count-objects', which may sometimes
fail unexpectedly on Git for Windows, manually count the contents of
.git/objects. Additionally, since we may wish to inspect other
directories' contents for bugreport in the future, put the directory
listing into a helper function.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index f89cb8d754..3abb83d77f 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -173,6 +173,67 @@ static void get_populated_hooks(struct strbuf *hook_info)
 	}
 }
 
+static int is_hex(const char *string, size_t count)
+{
+	for (; count; string++, count--) {
+		if (!isxdigit(*string))
+			return 0;
+	}
+	return 1;
+}
+
+static void get_loose_object_summary(struct strbuf *obj_info) {
+	struct dirent *d = NULL;
+	DIR *dir, *subdir = NULL;
+	size_t dir_len;
+	struct strbuf dirpath = STRBUF_INIT;
+
+	strbuf_addstr(&dirpath, get_object_directory());
+	strbuf_complete(&dirpath, '/');
+
+	dir = opendir(dirpath.buf);
+	if (!dir) {
+		strbuf_addf(obj_info, "could not open object directory '%s'\n",
+			    dirpath.buf);
+		strbuf_release(&dirpath);
+		return;
+	}
+
+	dir_len = dirpath.len;
+
+	while ((d = readdir(dir))) {
+		int object_count = 0;
+		char subdir_name[3];
+
+		if (d->d_type != DT_DIR)
+			continue;
+
+		if ((strlen(d->d_name) != 2) || (!is_hex(d->d_name, 2)))
+			continue;
+
+		/* copy directory name + \0 */
+		memcpy(subdir_name, d->d_name, 3);
+
+		strbuf_setlen(&dirpath, dir_len);
+		strbuf_addstr(&dirpath, d->d_name);
+
+		subdir = opendir(dirpath.buf);
+		if (!subdir)
+			continue;
+		while ((d = readdir(subdir)))
+			if (d->d_type == DT_REG)
+				object_count++;
+
+		closedir(subdir);
+
+		strbuf_addf(obj_info, "%s: %d\n", subdir_name, object_count);
+	}
+
+
+	closedir(dir);
+	strbuf_release(&dirpath);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -243,6 +304,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Configured Hooks");
 	get_populated_hooks(&buffer);
 
+	get_header(&buffer, "Loose Object Counts");
+	get_loose_object_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.24.1.735.g03f4e72817-goog

