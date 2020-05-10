Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DAC47257
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E7221775
	for <git@archiver.kernel.org>; Sun, 10 May 2020 00:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ClQTdxnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgEJAmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 20:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgEJAmA (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 May 2020 20:42:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B966C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 17:42:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so4931128qkh.11
        for <git@vger.kernel.org>; Sat, 09 May 2020 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUU3kG2njJdwu6kxo7ucxWl6Z9P+M9pcu/vz3EAnCTc=;
        b=ClQTdxnliutVXQ4Glow/loeGohDv8BhX816LxUjBabh9J1gMq1YR3E5TNCrutG4QCN
         YE3EttmQGYn89WrC6kZ+rMB5GC4m+4QNxqH6kjqteeOa5zjuu+A7QGQuVdcKwxMOLwo/
         3p6T9gFUQ9D4Lqfm1qy6Iqcn9MNRdpmJ4JZ3/ZxGraAc73H0SyGGrTE0cqj1V8Tpsh/O
         fYUFYB703T5A1qcZ+UB89kJmKCl3CbDr4Cjg8YAbJQk5X9XCgY8UVtuw429J5tiRcCyn
         w0CgeRGOyPxxXVuXooADSsiWsubkvJ7+XzaTlZSga4aK7cFLO8fc+7K6rYmaUmyCXq7r
         ZzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUU3kG2njJdwu6kxo7ucxWl6Z9P+M9pcu/vz3EAnCTc=;
        b=PIT4d1lEj0eusw0oPCj0Wnx7QIw0zrw6psa9dyGtXA9ipqBXaEKSmgbmLxjh6cC9NX
         4bfxdoIkotLadqt/Lr6Gvoc+oKd7jO3gkZ1iTPsAT92WJA5ZlLvrqfa6elVLI8kKwmRF
         IOvg0EKr0XsX/2drIn5bndaZu+TiYRVYxUPVQxZQgu3xp8L7xTlTHoyiP18ar+ydjcsD
         NKaH+IOX5ZYhkSlXeYDKL7n6RHaWqkFb63iDqY9/y3YKIcC7pjEFXdANW9b9QR46nwfr
         92450zG8WjSy8ihvCY5JavgImb0T56y7eje87zZ96wQZFote0Kd39LP475Nco/YXKHVF
         mI+A==
X-Gm-Message-State: AGi0PuZcpg4Dvd15IUu8dHrsy2DmEfSrAHoVSHa/E3lGF2AfZkCFzxLS
        DuqW//LbU2FOYQ+kqcm0i8llu803WP8=
X-Google-Smtp-Source: APiQypLv6fmrwXv5qvLgo9kjNPxDrXCu2yVq9Hw2+88zrpuanxu6tP/C82bmRx1ol5uZ23g+4WCCbg==
X-Received: by 2002:a37:9d4f:: with SMTP id g76mr264872qke.235.1589071319389;
        Sat, 09 May 2020 17:41:59 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::1])
        by smtp.gmail.com with ESMTPSA id s8sm5615974qtb.0.2020.05.09.17.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 17:41:58 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: [RFC PATCH v2 1/4] doc: grep: unify info on configuration variables
Date:   Sat,  9 May 2020 21:41:27 -0300
Message-Id: <c344d22313265709fc6b5ab67621122390f33d14.1589058209.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589058209.git.matheus.bernardino@usp.br>
References: <cover.1589058209.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explanations about the configuration variables for git-grep are
duplicated in "Documentation/git-grep.txt" and
"Documentation/config/grep.txt", which can make maintenance difficult.
The first also contains a definition not present in the latter
(grep.fullName). To avoid problems like this, let's unify the
information in the second file and include it in the first.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/grep.txt | 10 ++++++++--
 Documentation/git-grep.txt    | 36 ++++++-----------------------------
 2 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 44abe45a7c..dd51db38e1 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -16,8 +16,14 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. See `--threads`
+ifndef::git-grep[]
+	in linkgit:git-grep[1]
+endif::git-grep[]
+	for more information.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a7f9bc99ea..9bdf807584 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,34 +41,8 @@ characters.  An empty string as search expression matches all lines.
 CONFIGURATION
 -------------
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
-
+:git-grep: 1
+include::config/grep.txt[]
 
 OPTIONS
 -------
@@ -269,8 +243,10 @@ providing this option will cause it to die.
 	found.
 
 --threads <num>::
-	Number of grep worker threads to use.
-	See `grep.threads` in 'CONFIGURATION' for more information.
+	Number of grep worker threads to use. If not provided (or set to
+	0), Git will use as many worker threads as the number of logical
+	cores available. The default value can also be set with the
+	`grep.threads` configuration.
 
 -f <file>::
 	Read patterns from <file>, one per line.
-- 
2.26.2

