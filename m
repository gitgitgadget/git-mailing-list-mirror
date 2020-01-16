Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD58C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468A922522
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="BneqqHwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgAPClS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36753 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgAPClS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:41:18 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so17835164qkc.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MsP18VBLZ4HVFOQH1C5hC9OtjZ0nQJJXAQFrg9JGArk=;
        b=BneqqHwKEJluO3rUEtWgHpqVbZGwrbCM2SiF/e9EpdSUoYfsPWOixalrwH6Kl8J+j1
         a4cLXK5lwLYZa7YPzc79071dP55b2r/SNmFewzJXSZIH1owHPj+4HqZY6U0Hr+UlzMbp
         VqKuTt/mwqppKPze9fEOYIE+fIRWO+iLh7QaSsw8qMsvX0osL4SuLv2PA696hUJhGsyO
         v1PIm5utazA5MAXGEgUb4nwuckQFHhF56+djGu0w1Nrf2JQ/QScx/GMD6YdTCZhi3ur/
         H307SJH/9Mhoi4N5H/akoHjU3QFgnwQYk3Dn2RPyJaPDzSa3Dlmfph4BRFFciuRSWv4S
         2WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MsP18VBLZ4HVFOQH1C5hC9OtjZ0nQJJXAQFrg9JGArk=;
        b=t6oUm5shD5wFkCuDxD2il5rdUtUcaChrsrgAZ/edIeEP8MoKX8mXUYdnF5kru/KVpD
         C+SL5btQFPRrvfmvkSZwMNVpEt+Xt9FARRVnTZWg1ZgpSevZ0KHanGabYL9nRahqRGL1
         gBrtUO6h8oPTswxC9MrcB1RjTs6c8wzR0fGw1BL+KN1aQAMKGC5wPkXmMX+HX5CYfUEn
         bfwky06PQTC5Tm8ZqroAC14zWZA1TaEVLem/68gsstYDGeB3bFetwvYghxGVBOnH9R+l
         3lu/oCHa8Vvs5zo/iI+Q9cvzK9UCl0PIU1Vwjj4PoRYcHMa7XdMtc8zrYBXPYsK+o36n
         hBBw==
X-Gm-Message-State: APjAAAUrQxSIHQcPhTDuwfbkBh3sLH0DR7fjFH/G/bRMva30O6og1zhK
        U8SDiCklV2zjEZwvU1KNXSnJotI4+K4=
X-Google-Smtp-Source: APXvYqxc6EWmOLj0uT0+rgASHxIXAfxz/xdiIk7k9wWtNjE0ffadERaPQLm15Yys/F911PrX4gtBvw==
X-Received: by 2002:a05:620a:137a:: with SMTP id d26mr26290927qkl.173.1579142476011;
        Wed, 15 Jan 2020 18:41:16 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:41:15 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Eric Wong <e@80x24.org>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Manav Rathi <mnvrth@gmail.com>
Subject: [PATCH v3 10/12] grep: re-enable threads in non-worktree case
Date:   Wed, 15 Jan 2020 23:39:58 -0300
Message-Id: <6c09e9169dfb21fc2cd3f69700316d3a87e72019.1579141989.git.matheus.bernardino@usp.br>
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

They were disabled at 53b8d93 ("grep: disable threading in non-worktree
case", 12-12-2011), due to observable performance drops (to the point
that using a single thread would be faster than multiple threads). But
now that zlib inflation can be performed in parallel we can regain the
speedup, so let's re-enable threads in non-worktree grep.

Grepping 'abcd[02]' ("Regex 1") and '(static|extern) (int|double) \*'
("Regex 2") at chromium's repository[1] I got:

 Threads |   Regex 1  |  Regex 2
---------|------------|-----------
    1    |  17.2920s  |  20.9624s
    2    |   9.6512s  |  11.3184s
    4    |   6.7723s  |   7.6268s
    8**  |   6.2886s  |   6.9843s

These are all means of 30 executions after 2 warmup runs. All tests were
executed on an i7-7700HQ (quad-core w/ hyper-threading), 16GB of RAM and
SSD, running Manjaro Linux. But to make sure the optimization also
performs well on HDD, the tests were repeated on another machine with an
i5-4210U (dual-core w/ hyper-threading), 8GB of RAM and HDD (SATA III,
5400 rpm), also running Manjaro Linux:

 Threads |   Regex 1  |  Regex 2
---------|------------|-----------
    1    |  18.4035s  |  22.5368s
    2    |  12.5063s  |  14.6409s
    4**  |  10.9136s  |  12.7106s

** Note that in these cases we relied on hyper-threading, and that's
   probably why we don't see a big difference in time.

Unfortunately, multithreaded git-grep might be slow in the non-worktree
case when --textconv is used and there're too many text conversions.
Probably the reason for this is that the object read lock is used to
protect fill_textconv() and therefore there is a mutual exclusion
between textconv execution and object reading. Because both are
time-consuming operations, not being able to perform them in parallel
can cause performance drops. To inform the users about this (and other
threading details), let's also add a "NOTES ON THREADS" section to
Documentation/git-grep.txt.

[1]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
     04-06-2019), after a 'git gc' execution.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/git-grep.txt | 11 +++++++++++
 builtin/grep.c             |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index c89fb569e3..de628741fa 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -347,6 +347,17 @@ EXAMPLES
 `git grep solution -- :^Documentation`::
 	Looks for `solution`, excluding files in `Documentation`.
 
+NOTES ON THREADS
+----------------
+
+The `--threads` option (and the grep.threads configuration) will be ignored when
+`--open-files-in-pager` is used, forcing a single-threaded execution.
+
+When grepping the object store (with `--cached` or giving tree objects), running
+with multiple threads might perform slower than single threaded if `--textconv`
+is given and there're too many text conversions. So if you experience low
+performance in this case, it might be desirable to use `--threads=1`.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/grep.c b/builtin/grep.c
index 1535fd50f8..6aaa8d4406 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1054,7 +1054,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (recurse_submodules && (!use_index || untracked))
 		die(_("option not supported with --recurse-submodules"));
 
-	if (list.nr || cached || show_in_pager) {
+	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
 		num_threads = 1;
-- 
2.24.1

