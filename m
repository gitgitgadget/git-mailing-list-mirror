Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0361DC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE46321655
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5+usTc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfLMAoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:44:00 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:46793 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbfLMAoA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:44:00 -0500
Received: by mail-qt1-f202.google.com with SMTP id d9so697849qtq.13
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C2sLBme3gm/qdTQaSfkdtC92BFNSfqgpRg1jGgOX4/w=;
        b=J5+usTc1iB85jPK9z2kZLsA2uOAjXKYfgzioytKr+eA1vPuVmT34/xOlNrrOWfB0Z1
         pmssEw2/iDcInnCdX41QhS8T5fdCmlcd5YS1C62DAmcGSRRd7mlhkkECPGnlR9+ONxwS
         TN26RVN2C16kxZOuJMi5LvOgKfg/I3sVqFSthUSAogPVAr9xMxerODE49nMrwHx7suew
         ouNWvNCkKBMXXXyZ2cIGg4odTwLEGCa9UMQn3KXL4DhmlPVDJn5XYNfMqWnnRT44QsLd
         DYeWOOc1iJ+JFEy73LZxsZde+A+UBTiLOW/6u2X54XMzx3Wb758DoX8XbBclKIhJAs5k
         DKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C2sLBme3gm/qdTQaSfkdtC92BFNSfqgpRg1jGgOX4/w=;
        b=bMDgmHg+rrsHWB33EDsjKpRSboPkhEFsrXoRbQYvmgYtiXUbcZOmAqRNzIzrOVia2+
         uwadVcGX/bdwBJ9LeG5D51QvWPh6k4G2DkliC0N/nTw34g1k2bdYb+izXCNSQJw6nEI6
         Y4NvKz2SIogKiMBsX3O92rNU+w3ExZhSX936ulLS9s4PioB8bxmZaeFhJ3W9BsDZv7V5
         iG/HWj83+GYA5sJF6ZE2S0Nk3JvxC2E0YJqcaL2a5r0onjXA/5X5jVJ/LKW/1umzry38
         SgNn8kuMtfOiBC4Pd6F5aZDE3T4/32SAK0mrjmRjhwpIgokGiti3XhffDrT5FrT6Rvdl
         mSEg==
X-Gm-Message-State: APjAAAUTEt4FO8BgZhBi08neC49xNQ5tHqPACs1Xvn8zVhG2JU+P6XRA
        0zgNjVnVGF+YmCR8SkJICsElR4wivCN3yImnQhrsvTf5yepOWJEQzkur8QOf73cAkbvTPt9hnms
        rK7JGUCgzr01ZYePaQ6gDur+3MhLX0wWGsbRYvcsk1B6eDX802cCtBx4NnCPMLvOqyHfR4rgnzA
        ==
X-Google-Smtp-Source: APXvYqxN8zVEy7ts7Z3Q0U50oWVzjln30myrv2RORHu5M2+DPJuilOvkWI7RxhvAZkPQgLYMam0FCN60MUDedqdRJaw=
X-Received: by 2002:ad4:4511:: with SMTP id k17mr10559420qvu.135.1576197838898;
 Thu, 12 Dec 2019 16:43:58 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:10 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 13/15] bugreport: add packed object summary
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alongside the list of loose objects, it's useful to see the list of
object packs as well. It can help us to examine what Git did and did not
pack.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/bugreport.c b/bugreport.c
index 3abb83d77f..992d8f9de7 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -234,6 +234,34 @@ static void get_loose_object_summary(struct strbuf *obj_info) {
 	strbuf_release(&dirpath);
 }
 
+static void get_packed_object_summary(struct strbuf *obj_info)
+{
+	struct strbuf dirpath = STRBUF_INIT;
+	struct dirent *d;
+	DIR *dir = NULL;
+
+	strbuf_addstr(&dirpath, get_object_directory());
+	strbuf_complete(&dirpath, '/');
+	strbuf_addstr(&dirpath, "pack/");
+
+	dir = opendir(dirpath.buf);
+	if (!dir) {
+		strbuf_addf(obj_info, "could not open packed object directory '%s'\n",
+			    dirpath.buf);
+		strbuf_release(&dirpath);
+		return;
+	}
+
+	while ((d = readdir(dir))) {
+		strbuf_addbuf(obj_info, &dirpath);
+		strbuf_addstr(obj_info, d->d_name);
+		strbuf_complete_line(obj_info);
+	}
+
+	closedir(dir);
+	strbuf_release(&dirpath);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -307,6 +335,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, "Loose Object Counts");
 	get_loose_object_summary(&buffer);
 
+	get_header(&buffer, "Packed Object Summary");
+	get_packed_object_summary(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.24.1.735.g03f4e72817-goog

