Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99835C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 04:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiANEYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 23:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiANEYb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 23:24:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971BC061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 20:24:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e19so12233544plc.10
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 20:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=woSaVvectLzl2dP3sAVBrklyMaQ9z8VoWrN0W0Z/MTU=;
        b=PdWyvyVTpq9/xNOTAL1xQerDQNOjYVFAr52pdC053lomf+vsg1OUa47pIKvIwt+RJz
         wiq4DYGy6zpKtKnasTsgrQZhf31+GEwXzX3XoH9x3IuyvNeqchYeCxc6kblTyMef7IxL
         9kNErUaJH/i9ptiQBO82I0EMAlXYHOOyoTKcta8uLGYWf7ic0k1VlkqXRu0oB9/QRguq
         IpUsbL+TKoMXCd6jnY9JFEi6b1PqBAO6r+3jHwtD9wra442dqZ+r+imSEwQ5X5Xt0gys
         8C1CnFzbXY6Esfng84X3NjfIvcrPdgVFPfMLf6WASv4owKx3n/KOuAmWhxYheS6kTlmu
         2gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=woSaVvectLzl2dP3sAVBrklyMaQ9z8VoWrN0W0Z/MTU=;
        b=WPxwoE8Xu+o4pDmL2YH/Mr42Xc+Z45YzCFMvXGnaZRf1y/GtDEArtwhT3HSGFXEb+5
         YcAnuIV7+4/JO5QJyr6I4nSRenHgDZWcJjg8XBy0BUD3xeaNDy1ZWC6Ah1WPDeRMoKKs
         cQIikzslTVi/2TiDP/GzXdwzI0v/G1Qsvtii/Ac98XTnZdPSmw+UmboyMv5iTlN3nMMX
         jTRRGL4AlWGft/d/eT/c9USxfR8ehLpvPe2T1SLp8mFDNonUshBUktKmWsibkk3PQyBq
         fk9egesuJ6XJs0/4+G/9p/0J6YJDzu3ht5QjdR/cY80UT4YkNvtUYOiNMuJqXMP5/Vxk
         u9cA==
X-Gm-Message-State: AOAM531tsHfFaM6t7wLerzJC1SNjDS9lTFELN6VBzW+3Kp/l/USquNrZ
        TTOItKXpE0IyfOw2DVrJk58aQyFOttVm1SH0
X-Google-Smtp-Source: ABdhPJwznusp8adjy2S1btkqKvyV+Mnirco7vmH76rq8HpKISoMq/yPPjaNu3pbmYaCwSNZKDSz0Tw==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr8693381pjb.246.1642134270777;
        Thu, 13 Jan 2022 20:24:30 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.59])
        by smtp.gmail.com with ESMTPSA id k20sm4084079pfk.111.2022.01.13.20.24.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 20:24:30 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v1 1/1] ls-remote: Make the output independent of the order of opts and <remote>
Date:   Fri, 14 Jan 2022 12:24:23 +0800
Message-Id: <9ef3d6f1338b06177ed22ed9453e2dcc9f1c3b7f.1642129840.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.391.g9ef3d6f133
In-Reply-To: <cover.1642129840.git.dyroneteng@gmail.com>
References: <cover.1642129840.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is used to solve the problem of inconsistent execution
results caused by switching the order of parameters and options
in some scenarios. For example, if we execute the following commands:

   $/opt/git/master/bin/git ls-remote .git
   >3ea29ad061137e321853d64fb38b6c6e907546a0        HEAD
   >3ea29ad061137e321853d64fb38b6c6e907546a0        refs/heads/master
   >3 ea29ad061137e321853d64fb38b6c6e907546a0 refs/tags/v1.0

   $/opt/git/master/bin/git ls-remote --heads .git
   >3ea29ad061137e321853d64fb38b6c6e907546a0        refs/heads/master

   $/opt/git/master/bin/git ls-remote .git --heads
   >

   Please omit the ">" because they are just to make the output more
   intuitive. The tests are based on 2ae0a9cb82 (The fifth batch, 2021-12-22).
   in master.

Similarily "--tags", "--refs" and "--symref" also produces the same result
(no output print in this case).

The issue is caused by `ls-remote` command supports args as "patterns", which
will filter the refs list from <remote> through the trailing matching rule. In
these usages, Options can be differentiated and processed more accurately with
"patterns", otherwise the result might lead to confusion if user has a loss of
the context.

This commit sets "parse_opt_flags" value in "parse_options()" to 0, this will
let the commands produce the same result in this scenario. At the same time,
this commit does not break the current test cases in t5512.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-remote.c  |  3 +--
 t/t5512-ls-remote.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 44448fa61d..45eeecdb71 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -80,8 +80,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 
 	memset(&ref_array, 0, sizeof(ref_array));
 
-	argc = parse_options(argc, argv, prefix, options, ls_remote_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+	argc = parse_options(argc, argv, prefix, options, ls_remote_usage, 0);
 	dest = argv[0];
 
 	packet_trace_identity("ls-remote");
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index f53f58895a..7c51cc23d1 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -349,4 +349,28 @@ test_expect_success 'ls-remote prefixes work with all protocol versions' '
 	test_cmp expect actual.v2
 '
 
+test_expect_success 'ls-remote same result if exchange the order of --heads and <remote>' '
+	git ls-remote --heads self > expect.heads &&
+	git ls-remote self --heads > actual.heads &&
+	test_cmp expect.heads actual.heads
+'
+
+test_expect_success 'ls-remote same result if exchange the order of --tags and <remote>' '
+	git ls-remote --tags self > expect.tags &&
+	git ls-remote self --tags > actual.tags &&
+	test_cmp expect.tags actual.tags
+'
+
+test_expect_success 'ls-remote same result if exchange the order of --refs and <remote>' '
+	git ls-remote --refs self > expect.refs &&
+	git ls-remote self --refs > actual.refs &&
+	test_cmp expect.refs actual.refs
+'
+
+test_expect_success 'ls-remote same result if exchange the order of --symref and <remote>' '
+	git ls-remote --symref self > expect.symref &&
+	git ls-remote self --symref > actual.symref &&
+	test_cmp expect.symref actual.symref
+'
+
 test_done
-- 
2.34.1.391.g9ef3d6f133

