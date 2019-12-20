Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C5C2D0C8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE26206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDeTahyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfLTRJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36892 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfLTRJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id cy15so8949046edb.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4c26c6uYaJlYKBbTrB6p4wqnGEGgHWMfnUoqaXCZzQ8=;
        b=gDeTahyf7D3FBajBN8aho/hsRiM1+FJknZb2lDq+P36UX1cP8VypbTOE+zx8JP1U3L
         JqXnyf+vQIVMLCHd0+JO1DRi/c37JAigKF//z7omWzJbsiXgOGH9IBiVk6cgOCfGWhH9
         vkB9UcisxOWWBpPI1M5DMWqr/n3gC85m9fK6gak38JnoxuRXqlBU3fKFkzJxxuKEoCWL
         ghH6hzuLgMD/XtTHSRyWDLvKUqye71VaxJPgZ3fzJ39TFG3Ys24riWaN1yW7Jd+JDT2g
         ACi5V8VpkOJKAkWjyqiU0JtDdrnyZNSXvii1xqhD8OhErsENn+zbGw9WRtoIbXSUBxDH
         WGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4c26c6uYaJlYKBbTrB6p4wqnGEGgHWMfnUoqaXCZzQ8=;
        b=CLn5Xxc7hNR5u/3257rneZfDBN6hxpd6A3X0gkuMv+hBPSjKM/UY+7FMwqeWOrGDOv
         h9ZroxRBI4TssjA/5p3MSfqO2zOWb8EP7h/uw17SIDCdSYqpFwIA7KlQri9Vb8pdr8PJ
         hw2R6khD3Xy2VIZV7OIPAzt+v5k4D4Cm7R2dAjO7he++OcD+gCsnRgyWbOQrOy+Mhv4W
         k+qq8DcRZNkseiwdPqySi8JtaxV2zUJjkC3uQKEZGVZoOwGAPDqzrVtyXs1KL716xq/M
         mEJd38k1FtbFVI4heV1YxXhg1TyZUT9ZEcW+A9t1O3yAcetzvzd57GV8X4CbE/fwAI87
         8RIQ==
X-Gm-Message-State: APjAAAXECgsivoRmnVi6x3iC81Ii5LTAPz4J43DIC/oaknjDqy3tT94N
        4I8SVvIru8WL2/AHEpy29at6w3SH
X-Google-Smtp-Source: APXvYqxMHQrLeLR0igHsdTz2aPq2HieXrNRQ+R3u19HEQw1Ud4pUAosfTyXFYn4iiZ70Cu4s4ofV4A==
X-Received: by 2002:a17:906:a3da:: with SMTP id ca26mr17411225ejb.332.1576861796761;
        Fri, 20 Dec 2019 09:09:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ck28sm1034882edb.45.2019.12.20.09.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:56 -0800 (PST)
Message-Id: <5c31d664f3b410cc165ec7757041a0a82ba2b8c0.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:42 +0000
Subject: [PATCH 09/15] rebase: move incompatibility checks between backend
 options a bit earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 67bccd876f..9e7e88b147 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1910,6 +1910,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
+	if (options.git_am_opts.argc) {
+		/* all am options except -q are compatible only with --am */
+		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
+			if (strcmp(options.git_am_opts.argv[i], "-q"))
+				break;
+
+		if (is_interactive(&options) && i >= 0)
+			die(_("cannot combine am options with either "
+			      "interactive or merge options"));
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1940,17 +1951,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (reschedule_failed_exec >= 0)
 		options.reschedule_failed_exec = reschedule_failed_exec;
 
-	if (options.git_am_opts.argc) {
-		/* all am options except -q are compatible only with --am */
-		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
-			if (strcmp(options.git_am_opts.argv[i], "-q"))
-				break;
-
-		if (is_interactive(&options) && i >= 0)
-			die(_("cannot combine am options with either "
-			      "interactive or merge options"));
-	}
-
 	if (options.signoff) {
 		if (options.type == REBASE_PRESERVE_MERGES)
 			die("cannot combine '--signoff' with "
-- 
gitgitgadget

