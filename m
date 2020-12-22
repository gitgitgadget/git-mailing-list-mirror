Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F9C433E6
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 01:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9C222B51
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 01:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgLVBMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 20:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVBMj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 20:12:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35515C061793
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 17:11:59 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id x22so517757wmc.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 17:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dpiyteKRb5FCh2olTVPVHtuQ+ETqGTpvtDGZkbG+y5c=;
        b=siIoR9sY5UtTDcnLKjGlFX/gnx17KDpSRU2peE+AKDl/3DFmegclmtlfOGIrpDSsUi
         gsAJpo6jEdZnMksNenCo/6vRV7JVt6z4uYsfUu7/UenNxMglcuzIXKnYXUNmxAOwHmXm
         Wx3ovFhnMxgBeoFWSSRyishP1WkihKbN8FLwJoMgJeJYqCqBy8Ln5yOro8ro3hK8zx+A
         DPRw3R2OhLyNg2eccZO1r5dMaASoFnWRwBPDR0urv4Bbw9kYgITNYdBphrO8WXGBDI3d
         QvF/OnW2pO4KTKC13pbMc7asGO89xMHjqHyX19IOU9BqilpeqBqZFXtr2w1IwI63xuqo
         vRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dpiyteKRb5FCh2olTVPVHtuQ+ETqGTpvtDGZkbG+y5c=;
        b=C42FObT52ZC8aW29TlhFKieTjE/0q0yUEVVxSLASFd1gl7hTyjihrP7B096lf/O2Qg
         t8OjxGxnMhEmfRPqxC4axTMO55z+Pg8CK1zrXxDsuoOIH7dd/A2SFlf0g7l6pI/HDBPw
         CxBMZKLU0Ey0fzb0CZuldOS0ZLzjVL47ZK+YbwntMl2llU87u0iz1ko5x8Jqkht9r9H2
         aCR3+VaFth6CxdUyb2Bh0aLBrBi2fHfmWUc8xmHU8zuebWco5r3co5DAuhsZ9u8hiHdV
         VKWoJ+7SskCrHz78onmMe5lalug6USTaXU377xu4ZTk8GrQSTKbmE0MmvlFh1/Q7cUmw
         1J9Q==
X-Gm-Message-State: AOAM530gW8k4WJGB7Bo0e6kxmBup8vEta1qlVRXxMPbKOe7ZXnIsa8GN
        v8NB0eusNLwy2k82xc9lScUSf5IbUAw=
X-Google-Smtp-Source: ABdhPJwbv9aQ32nIe0EMLm/NBdr0cAO6HI7dLPFruRVlJ+uDrs5lC8EkgLl7fHuGAJ95snXBMQAeEA==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr18665589wmh.38.1608599516057;
        Mon, 21 Dec 2020 17:11:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm26481087wmd.6.2020.12.21.17.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 17:11:55 -0800 (PST)
Message-Id: <e59ff29bdef9ce6bbdf8fbab307178e3e983cf2c.1608599513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
References: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
        <pull.820.v4.git.1608599513.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 01:11:52 +0000
Subject: [PATCH v4 1/2] negative-refspec: fix segfault on : refspec
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

The logic added to check for negative pathspec match by c0192df630
(refspec: add support for negative refspecs, 2020-09-30) looks at
refspec->src assuming it is never NULL, however when
remote.origin.push is set to ":", then refspec->src is NULL,
causing a segfault within strcmp.

Tell git to handle matching refspec by adding the needle to the
set of positively matched refspecs, since matching ":" refspecs
match anything as src.

Add test for matching refspec pushes fetch-negative-refspec
both individually and in combination with a negative refspec.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 remote.c                          | 10 +++++++---
 t/t5582-fetch-negative-refspec.sh | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 8be67f0892b..4f1a4099f1a 100644
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
+		} else if (!refspec->src) {
+			BUG("refspec->src should not be null here");
+		} else if (!strcmp(needle, refspec->src)) {
+			string_list_append(&reversed, refspec->src);
 		}
 	}
 
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 8c61e28fec8..a4960c586b1 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -186,4 +186,28 @@ test_expect_success "fetch --prune with negative refspec" '
 	)
 '
 
+test_expect_success "push with matching : and negative refspec" '
+	test_config -C two remote.one.push : &&
+	# Fails to push master w/ tip behind counterpart
+	test_must_fail git -C two push one &&
+
+	# If master is in negative refspec, then the command will not attempt
+	# to push and succeed.
+	# We do not need test_config here as we are updating remote.one.push
+	# again. The teardown of the first test_config will do --unset-all
+	git -C two config --add remote.one.push ^refs/heads/master &&
+	git -C two push one
+'
+
+test_expect_success "push with matching +: and negative refspec" '
+	test_config -C two remote.one.push +: &&
+	# Fails to push master w/ tip behind counterpart
+	test_must_fail git -C two push one &&
+
+	# If master is in negative refspec, then the command will not attempt
+	# to push and succeed
+	git -C two config --add remote.one.push ^refs/heads/master &&
+	git -C two push one
+'
+
 test_done
-- 
gitgitgadget

