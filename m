Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A68C433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830AF207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="M8+yVh6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBGSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBGR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:17:59 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42DBC061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:17:58 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f11so388576qvw.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwHyUezafLtE2AXnzr/cZDF+mCgHLxtf+oKcpVzOsn4=;
        b=M8+yVh6JnkOuQJDS+Ycc2FLsp3uZB8UqD3x1v5/7LKt8z6uV10z6v6jreYl7+Tz6y5
         Gc/xKTcXPYxevldsZspFSVKm/eEDNc3m4eDffrtImeLraDj+/dKcyZvjkKTl9umGtO4R
         ++vAV26PUzM9riA48OqkI+C4YYuK4Vjz1AMmi9GlZ5CzG+JoMWsW6qc8xgZz41so+dG4
         ZalFVxJI1THQJiC8o1OOA6qo2hp5ngOVP8z+mJTLPtAUfs5WFna5E0vtY6aPE9CG4oJq
         8pTRjTvV1Ican/xfoj6WVjlstQOeKriSo/t5pNLBVizGWoemmVXtpYgvotDMbigK/ZFi
         pXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwHyUezafLtE2AXnzr/cZDF+mCgHLxtf+oKcpVzOsn4=;
        b=fJnoK1y6bQ45XIOejGYNS25gtYl9pWFndKCdkDF6uEeQ9geD/UdThuzX91nufNlG/o
         uajLgwK0FEZBWE79XoCE5Q1amTVvBneDy550lfVqXKRaMB+XZ1PI2JCh5j8dyCNDzk7k
         wrWB08kOixyk+xYjSJqcqr+VV7WxblwF2LAIRsmNojHjN4v03H5x2UuLkHcRXoirvvL+
         nwXJCZ6ng3tNIUzAnjVeXnHnzDllm2OfNHE6UtwljthA671G4Vg7+Gyr7ufoi3o0og20
         z3q9f3rzysKkpBRd4aJNythxkhhfTSwvRcyax6j08gG6zC8TSAekpZqQpQJqnHaIfR1U
         CEbA==
X-Gm-Message-State: AOAM5334LUoPg4MazAEcbLHLvEs5gjq9skPtRhJ1X8MvsnUbriy5A/38
        JaF+krf+n76Je1rVFcyysmhFWb1brYWx/Q==
X-Google-Smtp-Source: ABdhPJwamy8SYmluQ9WlOVkg2MC+2tmf9nQ5W54FXaglM0RKFS8mdprc1anYrCjfrjyHPbt7yoaTLQ==
X-Received: by 2002:a05:6214:1108:: with SMTP id e8mr5622051qvs.237.1599027477668;
        Tue, 01 Sep 2020 23:17:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:17:56 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 1/8] doc: grep: unify info on configuration variables
Date:   Wed,  2 Sep 2020 03:17:30 -0300
Message-Id: <70c9a4e7415f532c2aa6fdd460a927b5e677cd97.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
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

