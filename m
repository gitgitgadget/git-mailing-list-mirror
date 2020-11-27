Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E2C63777
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C2C21D93
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 07:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvJ66EU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392792AbgK0Hvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 02:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392782AbgK0Hvx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 02:51:53 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BFAC0613D1
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:53 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id y5so2894258iow.5
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 23:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bp74vNjR3dZr5ilueZMUEgGapE5gBgheszf1OlmAx0g=;
        b=FvJ66EU5wpS3YXjzeJp+YL8wnEshOj396ePhmgtF6DMyeyRR34j9yI+bxgn70WeXp5
         SxLcKRmwdzXEHOKsEHtvuukaikMaeuyGysppMTYG1BhINpJH3eBFR2s5lxBzlrQUdqVj
         IQjy3oTJ1y5BM1D8Cm4nj+GLGl7sx0EZyCas2IucbNw6IUd9bIy/l3Dw4/lLw7KcIOmq
         oK9F+iuNfkZ7Rfj9CIeU41E30zeIVVP8lV3C0DFe125UMHyShDP2K3cwXQC/WPnGpuqs
         oZUxIKaJ2MRKyVWfsAGscUNuJI4LZpQ6jsaXRxFthu9zkeottDvP0eqoL5NI+nFt5tac
         YvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bp74vNjR3dZr5ilueZMUEgGapE5gBgheszf1OlmAx0g=;
        b=X4GjQQ/GfkEkRPsSISxx7dxKrcDM7LMxb1Wj9bnwFjw2/oLlu2j/x09wO7BnrX27Jz
         ce2Fwd8vp6ghBpX0/HlBTahvjy0Aqkha6eOtkMBRB92Xk/FFrDP3wctFBTZBXc2IqiBF
         0zET+iCQnXETceSK+CKg9Nk5wWgb8pDddaZhE7WFo6F4ddPSLPPZ+CY5cB9XmGbQEaN8
         L3o8x084HKujdMtUi4xD71lEFFb44xqqBrKhx1Fx1gBSmiQsogPbhBVZKcIX0QBeEQVy
         yWWdd5jHVw9bzmJOIcvO2v3rMTqvkldJ/belp/7j7w5PZKoHhZ6TxNfZnBCIl4g86hif
         3FZA==
X-Gm-Message-State: AOAM533WhvDz5WpkVvvriYCW6C1c/Z1fn3gRLOYkOwItKM+Wxq+bF3ZV
        mdbWYX/iU0LDqMDMh+5ouotjUA2wG9I=
X-Google-Smtp-Source: ABdhPJxjG9/8WPe8Y24v8m57Ot5EH/599oFkPktL4Ghwp4m0RCSZ+TPdUInXNoNqGgPAeqBCKK2hMw==
X-Received: by 2002:a05:6602:29cf:: with SMTP id z15mr5232101ioq.39.1606463512334;
        Thu, 26 Nov 2020 23:51:52 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 10sm4652447ill.75.2020.11.26.23.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Nov 2020 23:51:51 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] test-tool: add `getuid` subcommand
Date:   Fri, 27 Nov 2020 02:50:53 -0500
Message-Id: <20201127075054.31174-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84
In-Reply-To: <20201127075054.31174-1-sunshine@sunshineco.com>
References: <20201127075054.31174-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is difficult, if not impossible, for a test to obtain the user ID in
a portable fashion on all platforms and be guaranteed that it is the
same user ID Git itself sees when invoking getuid(). This is especially
true on Microsoft Windows for which getuid() in C code and $(id -u) in a
shell script may return entirely different values. Sidestep this problem
by adding a `getuid` subcommand to test-tool which is guaranteed to
provide tests with the same value as getuid() returns in Git code.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Makefile               | 1 +
 t/helper/test-getuid.c | 7 +++++++
 t/helper/test-tool.c   | 1 +
 t/helper/test-tool.h   | 1 +
 4 files changed, 10 insertions(+)
 create mode 100644 t/helper/test-getuid.c

diff --git a/Makefile b/Makefile
index c39b39bd7d..a5c38aad5e 100644
--- a/Makefile
+++ b/Makefile
@@ -703,6 +703,7 @@ TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-genzeros.o
+TEST_BUILTINS_OBJS += test-getuid.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
diff --git a/t/helper/test-getuid.c b/t/helper/test-getuid.c
new file mode 100644
index 0000000000..d741302461
--- /dev/null
+++ b/t/helper/test-getuid.c
@@ -0,0 +1,7 @@
+#include "test-tool.h"
+
+int cmd__getuid(int argc, const char **argv)
+{
+	printf("%d\n", getuid());
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 432b49d948..ad5f681e68 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -31,6 +31,7 @@ static struct test_cmd cmds[] = {
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
+	{ "getuid", cmd__getuid },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
 	{ "index-version", cmd__index_version },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7c3281e071..765976e1eb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -21,6 +21,7 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
+int cmd__getuid(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
-- 
2.29.2.576.ga3fc446d84

