Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A613C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A22164ED7
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 18:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhBJSJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhBJSCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 13:02:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD1C061793
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 10:01:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id u14so2597860wmq.4
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 10:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8EPNwhCL+PbgQ7SvRHHk2O8mf+lDIOYt6IfBmTK04eM=;
        b=nRT56fquyu1D1xsi1gaC/cyy79/o+CLnhzwlatbmE0QP7kCLU4luSh7SIp6lD8zwXW
         xRy0K/JJh54hL56iiJBOsN8jmgQQ2aNtfyaoWZEbViY0fwfwlFvGNbbt8rPkPjJChQLo
         SG66TtW/76xU7gyUHCgQQ2Z859TYrl9nKNHr/E6IEPC9wv0duYdbnrUjCKRrdhCwZLLk
         WEVV/icgs4ksQr8y3aip4jPCzC65SQ85h74BFep9Y4R8Y1UNnneVki64R1DzjYkWEGds
         QsapuqjXlK2OYFq1Vq8WKUHiRplZN8ykatJhaDGnn9wq4SPgElpmt7LKguUWTtdss7ph
         tINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8EPNwhCL+PbgQ7SvRHHk2O8mf+lDIOYt6IfBmTK04eM=;
        b=VMj6ChyFqVdcU+TwF6vaEFkOcvArDuJRX/z9u4vKINRIvC/STN4gsAihYNoSmqavRn
         SD9+qrypEEMIQfaSsps1WIEyZjSaem8SiWRfq5SEMdGrXnzg+kmh3B3hf+4C2wWVz8dd
         C3R/bpBhIRZIRcEuK/zE7fJw40WeFPZeYgSyHOe99Wpuhng7UcQLzPgnQdUSzS2J2WuR
         jw03O2xiZXf4Vv6GzaGMsemtn6uS0TG+s/OwmXVfmOFWEHEAT7m9NR95THNzffhMdtI0
         ZRnXFWRFbL0GrAjsy7gUe88SyQbnpFlhqksm9rAcTYMHpLiUSQLsvvTM6QLd4F5ktfVt
         aS7A==
X-Gm-Message-State: AOAM531M2Lpe3s79N/87hj2BoVPpSB3C8ukh2qUuuLaIihPJgkCETBwT
        L2/uEKB7F13oiSa9UyKbG5C72ta1+q0=
X-Google-Smtp-Source: ABdhPJwgmYKKMQP68RNGRKallg3wCbG+x0wwQSMgIUaWdFoFcoDYUvEl8bUiJrU2zoCz9JbchXg9iQ==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr97195wml.118.1612980094607;
        Wed, 10 Feb 2021 10:01:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j71sm3315847wmj.31.2021.02.10.10.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:01:33 -0800 (PST)
Message-Id: <24d43d121162a9052f31c760a5fc929fdaad76b5.1612980090.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.874.git.1612980090.gitgitgadget@gmail.com>
References: <pull.874.git.1612980090.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 18:01:29 +0000
Subject: [PATCH 1/2] t1450: robustify `remove_object()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function can be simplified by using the `test_oid_to_path()`
helper, which incidentally also makes it more robust by not relying on
the exact file system layout of the loose object files.

While at it, do not define those functions in a test case, it buys us
nothing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1450-fsck.sh | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 02478bc4ece2..779f700ac4a0 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -41,17 +41,13 @@ test_expect_success 'HEAD is part of refs, valid objects appear valid' '
 # specific corruption you test afterwards, lest a later test trip over
 # it.
 
-test_expect_success 'setup: helpers for corruption tests' '
-	sha1_file() {
-		remainder=${1#??} &&
-		firsttwo=${1%$remainder} &&
-		echo ".git/objects/$firsttwo/$remainder"
-	} &&
+sha1_file () {
+	git rev-parse --git-path objects/$(test_oid_to_path "$1")
+}
 
-	remove_object() {
-		rm "$(sha1_file "$1")"
-	}
-'
+remove_object() {
+	rm "$(sha1_file "$1")"
+}
 
 test_expect_success 'object with bad sha1' '
 	sha=$(echo blob | git hash-object -w --stdin) &&
-- 
gitgitgadget

