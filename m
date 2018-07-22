Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 654A41F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeGVKyH (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53773 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbeGVKyH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:07 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so20185313itw.3
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=advXH/72NC2SoznrTAneQ4J6g129E7qxJgZdod/b9hs=;
        b=dG1yPZVJgHqIjkB5+KP5d4JY/KTRZkGQrR6um6J3zZulIo7QQ8d04nIHnfPOl05oiy
         cedxI/H12X4vh0IAjDaUJvIjUsdoCS5zxn/Wg5Zgto8aJ6lJGBvzTSGtJjNr9YI4YogP
         2zgzflUIl90e3V/7goumV6lz+v4gPkVxENZ2F03hF86mlT2fANiSX2zdDFtQPF7MOs3q
         8x0TE8KA5TR49C3SOhEt32bRo2DPHhgN4CyM3zfxH5QI6y7JrVQf9w9BS4R7u4jnrK0x
         T5873mdCxCan5v98XmKqlQJTWURDR7B7qxFhvqVM/GJGsxWpzLlTryMGPNOZ61D2IekY
         3+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=advXH/72NC2SoznrTAneQ4J6g129E7qxJgZdod/b9hs=;
        b=OqTdZBi9RBBLF/YyyOtm8NGYz3UkO3Prg7vQt7yDnqk0B2ml/RBn3uAv3tcWgyyS8/
         5PwjgnB8FqEdcGPRlsyBdPXI0nDRonWNh5zS500ZA3udYIBgm/tHdgff8oh95w/qXxtK
         gznQT9M8l5SdbrsiPs5gLX07DdCs9dDTK5d8bY8eErkbirnfeWv1AsYOCyZPqjgLNamp
         568VvW6Gux9UJG0XaV0Ild556WnbB18PKbc30eqZlvobjhVoXigQbHO4CSGIhiIAE8XU
         1LelEGnGRvIPVr8BeNTV1U7AoEOhLzRoRXJ/liZmEZGBKK8/DhsscMOidsfGCBiK2ULv
         oG5Q==
X-Gm-Message-State: AOUpUlHUF+7pYL4rKBbNNuMIezYhZms0orLRgOQb6wIk/hEzxrl30ery
        KVQSzCZAxE+yXWN1E9rq0idDFrJE
X-Google-Smtp-Source: AAOMgpcT6ACef3RxW3dtOi4piP47U5UdcRVNN+7Wlzcq3Dhh1UqgWZwSVyZa2OQQs7x1O1ADhgKrTQ==
X-Received: by 2002:a24:5cc8:: with SMTP id q191-v6mr7236548itb.63.1532253477144;
        Sun, 22 Jul 2018 02:57:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.57.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:57:56 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 01/14] format-patch: allow additional generated content in make_cover_letter()
Date:   Sun, 22 Jul 2018 05:57:04 -0400
Message-Id: <20180722095717.17912-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

make_cover_letter() returns early when it lacks sufficient state to emit
a diffstat, which makes it difficult to extend the function to reliably
emit additional generated content. Work around this shortcoming by
factoring diffstat-printing logic out to its own function and calling it
as needed without otherwise inhibiting normal control flow.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/log.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 805f89d7e1..873aabcf40 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -997,6 +997,26 @@ static char *find_branch_name(struct rev_info *rev)
 	return branch;
 }
 
+static void show_diffstat(struct rev_info *rev,
+			  struct commit *origin, struct commit *head)
+{
+	struct diff_options opts;
+
+	memcpy(&opts, &rev->diffopt, sizeof(opts));
+	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
+	opts.stat_width = MAIL_DEFAULT_WRAP;
+
+	diff_setup_done(&opts);
+
+	diff_tree_oid(get_commit_tree_oid(origin),
+		      get_commit_tree_oid(head),
+		      "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+
+	fprintf(rev->diffopt.file, "\n");
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1010,7 +1030,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	struct strbuf sb = STRBUF_INIT;
 	int i;
 	const char *encoding = "UTF-8";
-	struct diff_options opts;
 	int need_8bit_cte = 0;
 	struct pretty_print_context pp = {0};
 	struct commit *head = list[0];
@@ -1060,25 +1079,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	shortlog_output(&log);
 
-	/*
-	 * We can only do diffstat with a unique reference point
-	 */
-	if (!origin)
-		return;
-
-	memcpy(&opts, &rev->diffopt, sizeof(opts));
-	opts.output_format = DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
-	opts.stat_width = MAIL_DEFAULT_WRAP;
-
-	diff_setup_done(&opts);
-
-	diff_tree_oid(get_commit_tree_oid(origin),
-		      get_commit_tree_oid(head),
-		      "", &opts);
-	diffcore_std(&opts);
-	diff_flush(&opts);
-
-	fprintf(rev->diffopt.file, "\n");
+	/* We can only do diffstat with a unique reference point */
+	if (origin)
+		show_diffstat(rev, origin, head);
 }
 
 static const char *clean_message_id(const char *msg_id)
-- 
2.18.0.345.g5c9ce644c3

