Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B5C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CB420795
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="P/hJDkS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIJRma (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgIJRVm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:21:42 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA1C061757
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cr8so3708280qvb.10
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwHyUezafLtE2AXnzr/cZDF+mCgHLxtf+oKcpVzOsn4=;
        b=P/hJDkS6HI5Mm5aCSsBxEIJmmCAKY0cBopXZmQefpv7Yaj/SVZy+D/Gf8vS0b4qpj4
         0+ITnL+9IQEZYoMfktqUbtnGAKF6k/BgKz/HyE1ybx2qx74Mpgv0cqYID4sBc1Nfzpjb
         ZvpkXAU0oNGIrHzxVVaBBQr4wokKJ+p8LxaMU2SfAUwNvZzltjAWwwPXGotKpNHAzOLL
         opbFLHrNQ5vprSQxkfTuH9+wkm/tlutk3PayGEknjLhduEvG/dB0eC67Urmn7UqTypAw
         WaK4lAW10Dp9cRubEmPrfGeO7jyIhMbldT8EH18pBE7jpc9PVitnVN2CZtIVBpp2SFEg
         K9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwHyUezafLtE2AXnzr/cZDF+mCgHLxtf+oKcpVzOsn4=;
        b=GZ//ZsmBXpPsSM8Q+dvdUoVrIJy+IcrRlaWFnB2Ew82c2RcsB/VPevi259O9cTOBMk
         tPjhZONJw2vjLstvsTs8mbn+QmZ1ip+jgO1zk/7KTAbD5mSwZtOGxu28A6XFg0zbZhTK
         mt50t4iY7X/swNSc4DKasKnpfvnMgIFwiVyaR9/RIrGBssXiS2dIy/RENwCDet6btyxK
         OO2j15WtBVaXJmxA9shfXL78/RcVrmyNwlD7shO/VMa0BYdp8dMof/kULz5CuMaOVGaC
         kHTY2jig/2PepN9AcfyfoqQZYwpJVzxvtrLHeHZ19NLAB9CBPTuqYKMGP6NT3Ju0UglQ
         ASQQ==
X-Gm-Message-State: AOAM532Rv28ntAkl/LTMuv6d2kYRPVsMW3khyZvuvSEyl7IEd1olZwH3
        8AdZ5zTdUZn2iNoPUEW6HZPJVDgszysWuQ==
X-Google-Smtp-Source: ABdhPJx/rZqEItH6AAc9S7VyZ5v22hdJ7NjXTmpvAzR2JdiLyHxk/QuxEsAUVpOnMvmfaOV7q3DhAg==
X-Received: by 2002:a0c:99c8:: with SMTP id y8mr9866105qve.53.1599758499838;
        Thu, 10 Sep 2020 10:21:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:21:39 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 1/9] doc: grep: unify info on configuration variables
Date:   Thu, 10 Sep 2020 14:21:20 -0300
Message-Id: <70c9a4e7415f532c2aa6fdd460a927b5e677cd97.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
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
2.28.0

