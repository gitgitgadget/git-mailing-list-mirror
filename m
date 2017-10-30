Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68E4202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932884AbdJ3TrF (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:47:05 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46553 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932876AbdJ3Tq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:46:57 -0400
Received: by mail-io0-f194.google.com with SMTP id 101so29873923ioj.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6sqHHdNjEqZnkFRvsl20hw0k1WTomyBLT1YwTNsR2JY=;
        b=MhLfVD5nRlo7L4pqCzDqcwonloS4EKvs4rPU1CFM5XF68ZGUisFLQ8I4Z/EAM1aNZ0
         NpfXjSE/4FJrBjBQNRJCjL+vO3zoqQxkHfDlMHdDRPl8IE5+ckQsN/utluVc5D9zlyAP
         qnvnB8JTndhraIKNhBdgGvprSS1rIH4hxXZSXGWjKPRit5Lr4y4paxDFitVAU8a4XNeB
         jmygC7RHWFdRY276BMQklAgR1i6P57Y2+4gDMnKcU3CuxWlsKcmuhP8kJaICbxQJQLn7
         sxtBWCC7j9R2aIEF6Xyd9ksFNOyXeLbK4CY3/WTkT+p/cvgNwVd5lScfkQXx0r9axf9I
         JGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6sqHHdNjEqZnkFRvsl20hw0k1WTomyBLT1YwTNsR2JY=;
        b=dMHlcAj3wlQYgSH+m84TNFzuTtQkMXzH4qTy16fT7ToPuRNj6zSN+JQE+tQlHpyJHr
         GL6eWxBJeRFYdczzoGSR4BAvvMt9nrSu+5MVmpZowb/5/lRyMBxyXNb3XqN9JSRjtWNR
         K6YlYz0aeEJiqNE2Hjs7rbvj2Ete1k2ahuKkDYorSJfHqsCOqHLz+fPw2A1TZNKOW4Im
         BKJ1F1HLGpqALKU24Guu+qXhbroCxRn3ifgLpNJppys5O6K8GRh5VAWydz52+3a7KO1y
         A9CKsHzMI0N5nZAJf0gihrptN+sJOSxMbxTIwXSU2eJAPRfug0IFwnoPVpVxE3bBRAku
         W7ig==
X-Gm-Message-State: AMCzsaWLW9/5asuwvEAw3If/DcQ4sdcIS4y3KTJe7WK5+3wtIamdN5AM
        cqaSG9XpEmvbYlELVAKo5Ot7srL5ia4=
X-Google-Smtp-Source: ABhQp+QvKDFjfOThRRuxsWnqyGXxvgC1YWGOqDez5vGJaFrUgnDp9avB5FS1pctITcpFy03HDly2DQ==
X-Received: by 10.107.200.197 with SMTP id y188mr11959147iof.170.1509392816518;
        Mon, 30 Oct 2017 12:46:56 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g195sm2372805itc.14.2017.10.30.12.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 12:46:55 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 3/4] diff: add flag to indicate textconv was set via cmdline
Date:   Mon, 30 Oct 2017 12:46:45 -0700
Message-Id: <20171030194646.27473-4-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171030194646.27473-1-bmwill@google.com>
References: <20171027222853.180981-1-bmwill@google.com>
 <20171030194646.27473-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-show is unique in that it wants to use textconv by default except
for when it is showing blobs.  When asked to show a blob, show doesn't
want to use textconv unless the user explicitly requested that it be
used by providing the command line flag '--textconv'.

Currently this is done by using a parallel set of 'touched' flags which
get set every time a particular flag is set or cleared.  In a future
patch we want to eliminate this parallel set of flags so instead of
relying on if the textconv flag has been touched, add a new flag
'TEXTCONV_SET_VIA_CMDLINE' which is only set if textconv is requested
via the command line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/log.c | 2 +-
 diff.c        | 8 +++++---
 diff.h        | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index dc28d43eb..82131751d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -485,7 +485,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	unsigned long size;
 
 	fflush(rev->diffopt.file);
-	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
+	if (!DIFF_OPT_TST(&rev->diffopt, TEXTCONV_SET_VIA_CMDLINE) ||
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
diff --git a/diff.c b/diff.c
index 3ad9c9b31..8b700b1bd 100644
--- a/diff.c
+++ b/diff.c
@@ -4762,11 +4762,13 @@ int diff_opt_parse(struct diff_options *options,
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
 		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
-	else if (!strcmp(arg, "--textconv"))
+	else if (!strcmp(arg, "--textconv")) {
 		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
-	else if (!strcmp(arg, "--no-textconv"))
+		DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
+	} else if (!strcmp(arg, "--no-textconv")) {
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
-	else if (!strcmp(arg, "--ignore-submodules")) {
+		DIFF_OPT_CLR(options, TEXTCONV_SET_VIA_CMDLINE);
+	} else if (!strcmp(arg, "--ignore-submodules")) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, "all");
 	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
diff --git a/diff.h b/diff.h
index 47e6d43cb..4eaf9b370 100644
--- a/diff.h
+++ b/diff.h
@@ -83,6 +83,7 @@ struct diff_flags {
 	unsigned DIRSTAT_CUMULATIVE:1;
 	unsigned DIRSTAT_BY_FILE:1;
 	unsigned ALLOW_TEXTCONV:1;
+	unsigned TEXTCONV_SET_VIA_CMDLINE:1;
 	unsigned DIFF_FROM_CONTENTS:1;
 	unsigned DIRTY_SUBMODULES:1;
 	unsigned IGNORE_UNTRACKED_IN_SUBMODULES:1;
-- 
2.15.0.403.gc27cc4dac6-goog

