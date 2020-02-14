Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED354C3B194
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8192168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 01:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZB+WRJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBNBy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:54:28 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46706 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgBNBy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 20:54:28 -0500
Received: by mail-pg1-f201.google.com with SMTP id f5so5025778pgn.13
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Euv/yjuzPZRAiWkQXN0/3dsS8sVF8EZnzt+OM2Lwltw=;
        b=DZB+WRJouJXKMnRljreTGuosbB7ew8kmEGT6s84sexEW9+44WArvSW9t4ILOPd4R54
         8leOdULj85nUCEB9k0aG1VgxjmHajouO02+9u8F+vSmYmB5ZR0AqfjpMywqElUjtuMH5
         5J10kT/WYEcsOWCWkiYmh1k/8YBr/YLI29uZLQg/kCWy+RBYZ+WEkDvlN1CAST3HeVZI
         p/y+Mj1JYfiYH2AutsKE3hx0H/Ton4m4soEEPfmihA0RTBFE/M0Ra/ALWcXjYK5trNmj
         nZ8/RXihxIvaLi5wCKRnvD8U3lHzfEBqa8Azm8MIkiLX2Nn6wF0pZePtKCwQ26PbUN4i
         iRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Euv/yjuzPZRAiWkQXN0/3dsS8sVF8EZnzt+OM2Lwltw=;
        b=TdwFiFd5Md3SpocFt2C1e9nojCSyAnFHzIsUh8YH1QDNLr/squfDnCEMDCMqdirmqy
         flwHCMVImBVqjWOTH4UtOsDQeYpVCzay3ylq0twV4vjB5S0FJBiEHeqJlseDpES56qT7
         hnkLU/7CzCykV/GdPP7VqrXH50v79xhNrCdAPXL2d63I5qWzuo6jxEUEDmEODFbcgQPJ
         6e7sEepDRzPHp/QLRgoDClg1HPbPzf2gn9Xpde+D9wZIrrI5F3HswNrr+ePUgz9sRrVt
         STMCAN39ApjjaSs8lR8cbXI8Osyhz5vMzawzVKqcLCvqjkqDMcfPl/JBIrP8NVgiR5RH
         v3Cg==
X-Gm-Message-State: APjAAAWNndsihn4BvJt6lXG54ehrAEGlSpaUccBBNR+2N1CsPNQfqbEf
        mHLPfTfX3Xe51QPhQY9h1pcoTLvPClU/jjFbG+VZg+PFiRNW/UdTc6ckuXmkjkIWkUOTE3aAg2d
        LJetFRrodwo8OdEMp1yTUcuzTdnG5BGtB6juLvmOuaTsNXl9Rv9OXiKCa/8hbz0Riyd2ryhw16g
        ==
X-Google-Smtp-Source: APXvYqwJbreNdSbzk6OyBNsgSauQCmwl9lxjqRjj3zECGx0PgqxlS0adMN8AWK7j2cXDKRezxEnG1XMPnqLKkusjapE=
X-Received: by 2002:a63:1e06:: with SMTP id e6mr941179pge.134.1581645267398;
 Thu, 13 Feb 2020 17:54:27 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:53:43 -0800
In-Reply-To: <20200214015343.201946-1-emilyshaffer@google.com>
Message-Id: <20200214015343.201946-16-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200214015343.201946-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 15/15] bugreport: summarize contents of alternates file
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
index 1c67b55598..3bc8cb3579 100644
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

