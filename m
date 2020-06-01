Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F2C433E1
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D083207DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 18:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="cu3id5NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgFASBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgFASBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 14:01:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63451C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 11:01:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 131so3814353pfv.13
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N5oEVeOupZ4jCghLvlz0JRZfq4ZLEQWf8IBweMRhc+o=;
        b=cu3id5NCku8U1UIq1YLsb048AdWfY0C6nKeOEHbQD8qySpu/4/naS+PS7H5OCem0C2
         I23pAXbOfvWDrh1y54konVIpIeftFBYpuXcpXKv5DRw9fxOGJLAzjXbFdCyeiN3qjfeW
         wjt5k56+HOU0TArArdteXrdJgXZqFixsy5//kz+FDquB87yjS8rydURlKTIJObC5BlV8
         dwh7YgQni4KPoOGBKA/fUi7dxApg/FW0WqVvjfwxy9uXrh5Mlfy9eREYfwD8ctL8pxy/
         QBesM5O+7vGRHBNYFEty65IqcuqSyPDR6md9JTShEF7Izr/qlsBvWns7m3tlKYXn8lQR
         eUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N5oEVeOupZ4jCghLvlz0JRZfq4ZLEQWf8IBweMRhc+o=;
        b=LedW4NHym+2iGCTaVG8pBnlz9+4j7MpWEh2ObvgYgDYhKnf/5sgUlU/FriZNBENPz1
         EcDIu+2C+nZAtyX0IihB4X8gkvCu3SQqcr0xiOM8QsaojonWuLdztoXczYMOFcgGoogH
         wjnY3NOhrexZw5sSdRPmSLLnfcs6xeCnaNHSdEkR8uCvY/vZR6MZXKoEF47VDjtLGTGr
         1aUSxnXsmcxtJYkS0tWOm0nle61PWUxLYktcog7KV4h71bqAi1RKnc72H6Jfaj8E5rwS
         qTjPx+/cTWKPPEpP+gyaRTarqrMLs6zLA5N5gD/EZRHrRPLTRO6mAKab2hXHlxLmzo4j
         KzCw==
X-Gm-Message-State: AOAM531Tt5XDRIoAJM/TptTbSrankpWfdvcgqLr4h9INFEtNazEr6nLs
        b6mSJed6hS1lsUJxjb6k4qgMXDWP3UY=
X-Google-Smtp-Source: ABdhPJwEe7pnaQSHNp5TSpCzjn/Bv7M2jEMkVzM82qpan17FcrwjtkBQgtoQ5mKkvw1wsSgoMieSPA==
X-Received: by 2002:a62:aa0e:: with SMTP id e14mr6665914pff.128.1591034489592;
        Mon, 01 Jun 2020 11:01:29 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k14sm116081pjm.34.2020.06.01.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:01:28 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:01:27 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com
Subject: [PATCH 1/2] t5318: use 'test_must_be_empty'
Message-ID: <fddbe588147444fe2675224c94f50e24a1d12871.1591034353.git.me@ttaylorr.com>
References: <cover.1591034353.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1591034353.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A handful of tests in t5318 use 'test_line_count = 0 ...' to make sure
that some command does not write any output. While correct, it is more
helpful to use 'test_must_be_empty' instead, since the latter prints the
contents of the file if it is non-empty.

Since 'test_line_count' only prints the expected and actual line count,
not the contents, using 'test_must_be_empty' may be more helpful for
debugging if there is regression in any of these tests.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index a79c624875..d23986f603 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -147,7 +147,7 @@ test_expect_success 'Add more commits' '
 test_expect_success 'commit-graph write progress off for redirected stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph write force progress on for stderr' '
@@ -159,13 +159,13 @@ test_expect_success 'commit-graph write force progress on for stderr' '
 test_expect_success 'commit-graph write with the --no-progress option' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph write --no-progress 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph verify progress off for redirected stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph verify 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 test_expect_success 'commit-graph verify force progress on for stderr' '
@@ -177,7 +177,7 @@ test_expect_success 'commit-graph verify force progress on for stderr' '
 test_expect_success 'commit-graph verify with the --no-progress option' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git commit-graph verify --no-progress 2>err &&
-	test_line_count = 0 err
+	test_must_be_empty err
 '
 
 # Current graph structure:
-- 
2.26.2.1052.gcc6b3749ab

