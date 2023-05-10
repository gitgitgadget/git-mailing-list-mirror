Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BEAC7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 21:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjEJVhv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 17:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbjEJVhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 17:37:46 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8253A80
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:44 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1928ec49077so6252824fac.0
        for <git@vger.kernel.org>; Wed, 10 May 2023 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683754663; x=1686346663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5AkklYVZdEowsffJADb+bt3l3VpYsTpEGD1yWjfvgI=;
        b=BlIoiPp2vpBmREQUyEbazCUJvh3RCSaxUDTzG/K18isrSMxf9pNoE0uM/LYv+pby71
         XWgomIfdfOypdNJ6veO4+QieS3sTOcu7sKu4JR/ZjMMhhQ1iIVM7zpZvdvE9msRkv8AO
         qEZOOFRQXRBEo8c/A5kigyPY9sbp7DUq2xbuRhMPGofAWvk0c7SMsFgu+7F3MqbwdKjW
         V/1QxkYRv9b7pjaH7zsxVYU40pIH0/i4zTM8VNgI5+VnIOme8HdA7trSR2tzaFDHez2D
         M2opQpXm+6b4CdyXTKIbFJDtEVDWud/+2rKd+hfBYFNwGBJ+Hdz474UTi9qo3osXwXPX
         0j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754663; x=1686346663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5AkklYVZdEowsffJADb+bt3l3VpYsTpEGD1yWjfvgI=;
        b=ei2wdgdR/srgrW+nXPe108S2PnVQa166SRD6GBzYKUMYgjHVkFRjBj12NvrAdVP5QG
         CBNMs4xKGASrbQ3fp2+3VxYf2pnubGY1Imd1dy2vVvYn9hNctnm6jzH7Qp2qXV4cjyRm
         FITFmfWIPaqAYoPpNFX8FflCpDHN7WPH6BoMOgRJLKVUxY+MYCjhyBFWFW3hFA0/73/R
         Zf3NQmIau0k8hOr6Jd/GToGesoDEtXLYT5eUAMEqRdVppFIqbQiloXgXSQUTcWtOYu+F
         qMJQl/hNb6YIbfAtS0f8vRH5ItzRDj7V0gqOJz8M7VREFLH4gl5DAdnOSAwtaCBsC96F
         Jvgw==
X-Gm-Message-State: AC+VfDzQYXV2gQ/tjgtT/I5QLkZh4PURQ50/SIcX90tZsFVqWEQ1slil
        M47pXBg6ydP8I2EdrU1IVBQUGxVVkz8=
X-Google-Smtp-Source: ACHHUZ5a0DEY/apzDHXnhCAykLmMa2kTEFQvq58Dg0ajXPWdZsoOTTy7mEXHijfyMZmt+V7xYHLHpA==
X-Received: by 2002:a05:6870:a2c2:b0:192:8551:6d39 with SMTP id w2-20020a056870a2c200b0019285516d39mr8951539oak.55.1683754663238;
        Wed, 10 May 2023 14:37:43 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j16-20020a9d7690000000b006a6558ef17fsm6662718otl.30.2023.05.10.14.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 14:37:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/4] merge-tree: fix merge.conflictstyle handling
Date:   Wed, 10 May 2023 15:37:36 -0600
Message-Id: <20230510213738.505241-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230510213738.505241-1-felipe.contreras@gmail.com>
References: <20230510213738.505241-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently it's completely ignored.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-tree.c               |  4 ++++
 t/t6440-config-conflict-markers.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index aa8040c2a6..a98f84634e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -17,6 +17,8 @@
 #include "merge-blobs.h"
 #include "quote.h"
 #include "tree.h"
+#include "config.h"
+#include "xdiff-interface.h"
 
 static int line_termination = '\n';
 
@@ -628,6 +630,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	if (argc != expected_remaining_argc)
 		usage_with_options(merge_tree_usage, mt_options);
 
+	git_config(git_xmerge_config, NULL);
+
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
 		return real_merge(&o, merge_base, argv[0], argv[1], prefix);
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index 813d7dda9a..cb2ee3ad0a 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -34,4 +34,25 @@ test_expect_success 'merge' '
 	)
 '
 
+test_expect_success 'merge-tree' '
+	test_create_repo merge-tree &&
+	(
+		cd merge-tree &&
+
+		test_commit initial initial-file initial &&
+		test_commit r content r &&
+		git reset --hard initial &&
+		test_commit l content l &&
+
+		git merge-tree initial r l >actual &&
+		! grep "^+|||||||" content &&
+
+		git -c merge.conflictstyle=diff3 merge-tree initial r l >actual &&
+		grep "^+|||||||" actual &&
+
+		git -c merge.conflictstyle=merge merge-tree initial r l >actual &&
+		! grep "^+|||||||" content
+	)
+'
+
 test_done
-- 
2.40.0+fc1

