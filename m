Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18219C0018C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00A623A23
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgLSV7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 16:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgLSV7W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 16:59:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF93C061282
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 13:58:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y23so6936049wmi.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 13:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TIr7+Yi44S+nYaB04bW0X7K/x1XckZ7DEkeNRBwS4b4=;
        b=snDq7U5C4lsEtKn2dqh/reFMsP5ynfOzPYJaGvUB7wXrhSnueZ1lBvGmRsoi2xqyjv
         dJb3cVIxVuBkIpL2UpUAS0Uz1Qh8lufeEx92IyuXVUXGC/haToURygKcf4e1egB+N9uv
         oJfGjXeGq5diBxd5M5uGvxRN5vaubNnXsvl1ZrwST2L1y0Er6M6XEc01OcfRCjjFr3/I
         x2w2JioiEYT8kg3R2ApW80zb8KIEtTDBimghFKqPb72i9Xct3EZj+sKgOKf6Q94zvTnv
         etDo2o8ogNV1vWKdDqZUlqLYpkEx7J3jQsRBaXSMXA+Z0OisrRPw/Q66GoKxojxlcAou
         zh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TIr7+Yi44S+nYaB04bW0X7K/x1XckZ7DEkeNRBwS4b4=;
        b=HDpqh1EXxXPxnl7j5umRS1aQ1TO+d/+9X0Z+ycoIoQAbVdGJK1EezQNFVY+a7TD4jB
         ALgdJ+MaxQG/E7O59qW8wjpyzz2n4pIAZUnXk1LnxN+3GOUsWsliwniLeAngUHd0W/eo
         bu/h6NmjuB+XljZ2r3fb83ot0mr5lCugHmwDNrpiK79K75z3zfKWbtYAU1M3A1yWHCpD
         SzvKpwBYEU4b7tgMw+FIn14f6bRgwia0KuEEepqw01pSZ3QKy1t3a/R6qFaGxZmimmHV
         7UEZ0qTYPD+7l7St52rcVk3Z57+jQvoN4xrVpQDQl3E2cd75rfRbPIqnX1A7FvJ9Bzg/
         KpLw==
X-Gm-Message-State: AOAM533GkPEyTQXboWYqtW3zlzkoqjEhAN/Z3/pCerI3HH+psUM/QHMD
        YmneEvwD7EPmiwgtaXwr6h3ro4kNEgg=
X-Google-Smtp-Source: ABdhPJwKsenM2RNYM9KVWkjbJRttZgJY3qtJZdYfdHIn4sbGbq0R2OK1QTPlh1aKqT0Z2rj5KuMfnQ==
X-Received: by 2002:a1c:8115:: with SMTP id c21mr9564064wmd.1.1608415119661;
        Sat, 19 Dec 2020 13:58:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm19840153wrq.29.2020.12.19.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 13:58:39 -0800 (PST)
Message-Id: <e42200b644adab3ad78bf23e0258466287dbae70.1608415117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
References: <pull.820.git.1608398598893.gitgitgadget@gmail.com>
        <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Dec 2020 21:58:36 +0000
Subject: [PATCH v2 1/2] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

The logic added to check for negative pathspec match by c0192df630
(refspec: add support for negative refspecs, 2020-09-30) looks at
refspec->src assuming it is never NULL, however when
remote.origin.push is set to ":", then refspec->src is NULL,
causing a segfault within strcmp

Added testing for this case in fetch-negative-refspec

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 remote.c                          | 10 +++++++---
 t/t5582-fetch-negative-refspec.sh | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 9f2450cb51b..cbb3113b105 100644
--- a/remote.c
+++ b/remote.c
@@ -751,9 +751,13 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 
 			if (match_name_with_pattern(key, needle, value, &expn_name))
 				string_list_append_nodup(&reversed, expn_name);
-		} else {
-			if (!strcmp(needle, refspec->src))
-				string_list_append(&reversed, refspec->src);
+		} else if (refspec->matching) {
+			/* For the special matching refspec, any query should match */
+			string_list_append(&reversed, needle);
+		} else if (refspec->src == NULL) {
+			BUG("refspec->src should not be null here");
+		} else if (!strcmp(needle, refspec->src)) {
+			string_list_append(&reversed, refspec->src);
 		}
 	}
 
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 8c61e28fec8..58b42fabd97 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -186,4 +186,19 @@ test_expect_success "fetch --prune with negative refspec" '
 	)
 '
 
+test_expect_success "push with matching ':' refspec" '
+	(
+		cd two &&
+		git config remote.one.push : &&
+		# Fails w/ tip behind counterpart - but should not segfault
+		test_must_fail git push one master &&
+
+		git config remote.one.push +: &&
+		# Fails w/ tip behind counterpart - but should not segfault
+		test_must_fail git push one master &&
+
+		git config --unset remote.one.push
+	)
+'
+
 test_done
-- 
gitgitgadget

