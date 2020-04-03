Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89823C2BA1E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB312076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbInpUdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgDCUsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:30 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:54597 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgDCUs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:26 -0400
Received: by mail-wm1-f43.google.com with SMTP id h2so534461wmb.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Lg6FMrvQt2h/bhEcmVzJ1CdOTVDyBTPkDk1R39EF40=;
        b=GbInpUdqR1aIaIIwYtHhpI9OQrWsiaCo4whAjYk6+opAh/RcF/ohmYLcUkDkhkKIxV
         yvb7ucmz4yvO1bRCR+rJ9YRHjbe79z1ieqzL1Rm7yAipyZb+m2POK//lJRLUQsM4/wW0
         wnMt8mUNXWiXjwzc3FiErBv8HXzHbD5jpxKZ17W3v4rlU8tGvp2gSw1dFGmp5Iuc6LaA
         BUP5mL3E8R6NL86JzrhPz0aj1ioKBpqQkU+pHrIZaIreKTlpMLPkWrrW3ULrAyVTGL65
         1HsohKOXYb/p+pKtgIua/Ra/R/Og27IvNBvURKs3usxkZb7/8xz6MeBE+9G99rYZFxQ9
         CRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Lg6FMrvQt2h/bhEcmVzJ1CdOTVDyBTPkDk1R39EF40=;
        b=bwfq24EEEeBD76YrNzKoF+nih0oTKPmkx9BBfrouQfPbZEyJZejAf3cwL6ZAjQBzO0
         QCLQthsKZ4WNF+IskuuHuNbgJt5mFfgRLpW7wu1Vfc3yOJKOIzq/ZmllKLZYFIDZzA6S
         8gRCrp4uzdXNJtcBpnaEJogD2GeaAiPSO00qtDYPn60k13MAP92bJImlBz2Etneabne4
         99g9jUMK/5K1019KmQRZUPUAI41HM/oRu5CyjMWUwgoK8V5pX5BmcpJSk7yqRpuqpO0w
         S046FComGwXO/2f4mDSDHQlyBa8730D21J6di6m/vPGA6lOYWu1xP6it+lGMjedF9hZo
         YZjA==
X-Gm-Message-State: AGi0PuZ+B9JmuDX1UEt/PvQRwaO0e81yBvG+tss/ONt7cap31PBdxFZA
        ZFLtVvVk1oEDD7AmOB3Czj8/wk8G
X-Google-Smtp-Source: APiQypKwZbctOQRBCN8liCI3jmFt6YWTeTh3EoLY7iZghmYcAN01veX8QBrCKsZ+TH8t4hPff8ELyQ==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr10387170wmk.158.1585946905153;
        Fri, 03 Apr 2020 13:48:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm13393309wrp.13.2020.04.03.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:24 -0700 (PDT)
Message-Id: <ac7d624dc51823965482e6e8f0ef166767bafb78.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:11 +0000
Subject: [PATCH 12/15] job-runner: add --interval=<span> option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change used the job.loopInterval config option to
adjust the default sleep between iterations of the job loop in
'git job-runner'. Now, add a command-line option so a user can
override the configured value with an explicit value.

The value specified by this command-line option cannot be
changed without restarting the job-runner process.

RFC QUESTION: Are things like this useful, or should we only
use config options for this customization?

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-job-runner.txt | 6 ++++++
 builtin/job-runner.c             | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/git-job-runner.txt b/Documentation/git-job-runner.txt
index 010b2d05f9b..0719113a008 100644
--- a/Documentation/git-job-runner.txt
+++ b/Documentation/git-job-runner.txt
@@ -33,6 +33,12 @@ OPTIONS
 	attempts running jobs on repositories located at the provided
 	`<dir>` values. This option can be specified multiple times.
 
+--interval=<span>::
+	The job runner pauses between each attempt to run jobs. Use the
+	specified `<span>` as a number of seconds between each attempt.
+	If this is not specified, then the default will be found from
+	`jobs.loopInterval` or the default value of 30 minutes.
+
 
 CONFIGURATION
 -------------
diff --git a/builtin/job-runner.c b/builtin/job-runner.c
index 7e37b122d99..d1fca2c97b8 100644
--- a/builtin/job-runner.c
+++ b/builtin/job-runner.c
@@ -258,11 +258,16 @@ static int run_job_loop_step(struct string_list *list)
 	return result;
 }
 
+static unsigned int arg_interval = 0;
+
 static unsigned int get_loop_interval(void)
 {
 	/* Default: 30 minutes */
 	timestamp_t interval = 30 * 60;
 
+	if (arg_interval)
+		return arg_interval;
+
 	try_get_timestamp(NULL, ".", "loopinterval", &interval);
 
 	return interval;
@@ -287,6 +292,8 @@ int cmd_job_runner(int argc, const char **argv, const char *prefix)
 			       N_("<path>"),
 			       N_("run jobs on the repository at <path>"),
 			       PARSE_OPT_NONEG, arg_repos_append),
+		OPT_INTEGER(0, "interval", &arg_interval,
+			    N_("seconds to pause between running any jobs")),
 		OPT_END(),
 	};
 
-- 
gitgitgadget

