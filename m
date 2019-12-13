Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B26C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475D2173E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dl6ZJB5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfLMAoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:44:05 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:57273 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfLMAoE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:44:04 -0500
Received: by mail-pg1-f202.google.com with SMTP id a4so327887pgq.23
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CYTOmTIH021BCK/eU7Pf8plHGlQuQ0XxPruLIpG941U=;
        b=dl6ZJB5ZXkt/TaHh3eBGvbhHMtiWlrOcbY4HgWjt/O+sHGAaGuacQKJWamFToZ8zV7
         PmB6c48Y06WDsUG6IepJ9O3amnR7hKZusXdmrLxX+wf3JWD0oOJkarmxpJkCwblAA/O6
         c43vloY82j/SQ2xZOEK9/CG+EhDV6MPTIpzqS/hzU1jzBgvhGvG5zrAAIoo0JpsjhiIu
         PjpRdb+yjyXU9k+R5XvalMLTadkKXfJzyyuZaYlsZlkcNj2vxzMgQk5RRDGSdLVjRpNe
         1G94lvYnApFfzMDdkLue8wGofhV9D5Mpp4IEayIvoXbdmAtqV6Be5Z3IbL7ATJg9PtPm
         U5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CYTOmTIH021BCK/eU7Pf8plHGlQuQ0XxPruLIpG941U=;
        b=R3D+PZjV06zCxHCO2mVON0gB3xtnxMqJD+nRs4seEvIzixz97bW7rw82CBFfwDNkPA
         ZCcT/adXCrvQ4bFjipfeGGIJARE+66DHDIVLzE765PXdtqqZWdJSLX40X1gIukb5W8NH
         /stqMzZjxwSLTJZD3n2JtBWuKW8A/pKPc73SJF/t9yLKlyTFEmgVI80FsjcO0Xzb9V+f
         Jeiavdc7ODZv5zSq7GOWO6RGoIhQbldevyHrGl/ANR+EKV4nxFdF90QDYjm1+2roXs+5
         3pmWuBjTfTtf5nhqUVnFB2wAFwbVvyb9LUYPcBi3db3HmjOslcHebay2nGY/cF0rndEB
         O9Vg==
X-Gm-Message-State: APjAAAVVyNJbVoWGPj/Y5D8DfjxzdeOShSFguZ+w/VT6FJniMhpGS5ag
        YtJQgh31h0dEQ9IwverBVnWVfKfbvvH83kXqHsjcdZDjucWZACEtvPF3qtnkIKlUhM9qSVlv0u9
        TlEwj5mO0U1XNQT4NoxK5ePcYdCIp9thZ8r8P8FwZySG+yGuVAyUdEz0SBpXTzuvZhJ3weVGkIA
        ==
X-Google-Smtp-Source: APXvYqxIajV88D1EIVH1VJW/hd/AWet7t6g1MnjmO0rQFcuxb5p9ZenSg8ZvSdCeD+770EhmHC1XaubS6c5Rk6nZwHU=
X-Received: by 2002:a63:3f82:: with SMTP id m124mr13784206pga.431.1576197843654;
 Thu, 12 Dec 2019 16:44:03 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:12 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 15/15] bugreport: summarize contents of alternates file
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 5d300f1c5f..d2a3fb1f67 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -307,6 +307,42 @@ static void get_object_info_summary(struct strbuf *obj_info)
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
@@ -386,6 +422,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Object Info Summary");
 	get_object_info_summary(&buffer);
 
+	get_header(&buffer, "Alternates");
+	get_alternates_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.24.1.735.g03f4e72817-goog

