Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61EC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8073522522
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="OiwdH/oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgAPCl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:27 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47076 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgAPCl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:41:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id e25so6367627qtr.13
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cEzM8LDcgbrt1XmnakNIE2hNKqgH2uxVDzHusj+wluQ=;
        b=OiwdH/oAYTttlqu/BaRYqoC064KYtwYdJTHDVF2PmFOhoVhVAtFceIq37kiqZbkvd8
         c0CM5aslvQhyqa370lJnjiaAxDN/R38pr46owpXiTV7ah5Jl6wZIJzckv6w0DnxihkGf
         hds6VZUT0eEQRbjODBc8Kj2C7dZNMyhVRvZsTjQfeRTRb4Qp869E/MUwfzpUg0gzUGH/
         dYpg6fjwXoOTPDYnU2b2otPBRj9BQBcnY4dGQgDvvGSSYm1Huxaa5Etadh9MR3XivRkz
         B49OZmrA6qCU3xVzaVewN4NfS9FULVXTAsxqUbFfJMS7PPpoKvAmTC+zCBiy6zA7RaW7
         LfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEzM8LDcgbrt1XmnakNIE2hNKqgH2uxVDzHusj+wluQ=;
        b=HlDMtyzzlCEgYLbAJXevl4O2iaeKyNC2rgSheeJOaJ1c80KHpaGmYdos4efRH+R2Ki
         5ZYw5wEpthUjsZ0+2Yr46ke7MvGSlFmU2hYwCDqSVSNa4E3Mg83qrH6kWerqkcFJK56G
         /TpnPcWLfNf8ufgWIiG0bsKPpzEqsVdvfYFJwPOZYr8izhLyJf19yhE/7T2XEJPhWqHF
         t/Kb84jigGHgxOJrpD0ngm4cSm+lanNvI7jVKp57og2PrG4fbP+U4YamHTjkaGB4wk7w
         ZqFxGB3bnGktZAX+qDTwwvXIMPbgwWoHwLDJ5qz2wrVV9mUEilSr16SaI3kiBg0E5vbh
         J2KQ==
X-Gm-Message-State: APjAAAXmdkNWjLuaMkFZrbuKDb/VkHUJjhsZGn6kL7shHa3Myjyqozvs
        8ee5TQa1CM3NpOhjYv/elOFuirnrzTA=
X-Google-Smtp-Source: APXvYqzY1F3foTd9DT0w108Ypr3y8Hd7FJvALobjvgbCphsv3chkS7zRv9qgr9dIbIXKb7pAejuBGw==
X-Received: by 2002:aed:2ce4:: with SMTP id g91mr351809qtd.352.1579142485455;
        Wed, 15 Jan 2020 18:41:25 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:41:24 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Victor Leschuk <vleschuk@accesssoftek.com>,
        Eric Wong <e@80x24.org>, Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v3 12/12] grep: use no. of cores as the default no. of threads
Date:   Wed, 15 Jan 2020 23:40:00 -0300
Message-Id: <a5891176d7778b98ac35c756170dd334b8ee21c7.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When --threads is not specified, git-grep will use 8 threads by default.
This fixed number may be too many for machines with fewer cores and too
little for machines with more cores. So, instead, use the number of
logical cores available in the machine, which seems to result in the
best overall performance: The following measurements correspond to the
mean elapsed times for 30 git-grep executions in chromium's
repository[1] with a 95% confidence interval (each set of 30 were
performed after 2 warmup runs). Regex 1 is 'abcd[02]' and Regex 2 is
'(static|extern) (int|double) \*'.

      |          Working tree         |           Object Store
------|-------------------------------|--------------------------------
 #ths |  Regex 1      |  Regex 2      |   Regex 1      |   Regex 2
------|---------------|---------------|----------------|---------------
  32  |  2.92s ± 0.01 |  3.72s ± 0.21 |   5.36s ± 0.01 |   6.07s ± 0.01
  16  |  2.84s ± 0.01 |  3.57s ± 0.21 |   5.05s ± 0.01 |   5.71s ± 0.01
>  8  |  2.53s ± 0.00 |  3.24s ± 0.21 |   4.86s ± 0.01 |   5.48s ± 0.01
   4  |  2.43s ± 0.02 |  3.22s ± 0.20 |   5.22s ± 0.02 |   6.03s ± 0.02
   2  |  3.06s ± 0.20 |  4.52s ± 0.01 |   7.52s ± 0.01 |   9.06s ± 0.01
   1  |  6.16s ± 0.01 |  9.25s ± 0.02 |  14.10s ± 0.01 |  17.22s ± 0.01

The above tests were performed in a desktop running Debian 10.0 with
Intel(R) Xeon(R) CPU E3-1230 V2 (4 cores w/ hyper-threading), 32GB of
RAM and a 7200 rpm, SATA 3.1 HDD.

Bellow, the tests were repeated for a machine with SSD: a Manjaro laptop
with Intel(R) i7-7700HQ (4 cores w/ hyper-threading) and 16GB of RAM:

      |          Working tree          |           Object Store
------|--------------------------------|--------------------------------
 #ths |  Regex 1      |  Regex 2       |   Regex 1      |   Regex 2
------|---------------|----------------|----------------|---------------
  32  |  3.29s ± 0.21 |   4.30s ± 0.01 |   6.30s ± 0.01 |   7.30s ± 0.02
  16  |  3.19s ± 0.20 |   4.14s ± 0.02 |   5.91s ± 0.01 |   6.83s ± 0.01
>  8  |  2.90s ± 0.04 |   3.82s ± 0.20 |   5.70s ± 0.02 |   6.53s ± 0.01
   4  |  2.84s ± 0.02 |   3.77s ± 0.20 |   6.19s ± 0.02 |   7.18s ± 0.02
   2  |  3.73s ± 0.21 |   5.57s ± 0.02 |   9.28s ± 0.01 |  11.22s ± 0.01
   1  |  7.48s ± 0.02 |  11.36s ± 0.03 |  17.75s ± 0.01 |  21.87s ± 0.08

[1]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
     04-06-2019), after a 'git gc' execution.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/git-grep.txt | 4 ++--
 builtin/grep.c             | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index de628741fa..eb5412724f 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -59,8 +59,8 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.  If unset (or set to 0),
-	8 threads are used by default (for now).
+	Number of grep worker threads to use. If unset (or set to 0), Git will
+	use as many threads as the number of logical cores available.
 
 grep.fullName::
 	If set to true, enable `--full-name` option by default.
diff --git a/builtin/grep.c b/builtin/grep.c
index a85b710b48..629eaf5dbc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -33,7 +33,6 @@ static char const * const grep_usage[] = {
 
 static int recurse_submodules;
 
-#define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
 
 static pthread_t *threads;
@@ -1064,7 +1063,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	} else if (num_threads < 0)
 		die(_("invalid number of threads specified (%d)"), num_threads);
 	else if (num_threads == 0)
-		num_threads = HAVE_THREADS ? GREP_NUM_THREADS_DEFAULT : 1;
+		num_threads = HAVE_THREADS ? online_cpus() : 1;
 
 	if (num_threads > 1) {
 		if (!HAVE_THREADS)
-- 
2.24.1

