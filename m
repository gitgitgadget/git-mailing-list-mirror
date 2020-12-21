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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEEFC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DC622CB2
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgLUEtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgLUEtp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 23:49:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B52C0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:49:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o13so20613536lfr.3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lVSk/0eg+VzE8sES68ypaAs1tKpJNEqgg3qp7LS0ezg=;
        b=pEEI2YTBZu9MmItMbX+O8lsb+nQhBhlWQbD5wVJUE5lea6dZ9VCLmOOoxCBvioOI9D
         w6UAu/JHgizqdwdWlR2ePg5+7asxP2NFLaXZqGh1g1FmnP1+Fr6fJIz5vaA0cjERTnGM
         sJhTqUNGe7Aytzxg5cAoR0XaDDEczG9iTzSGNQk2zfFJj3c0zgL0Y99rDX4xO77wlwxS
         TJJYoig5rIQFqYsN0Wiy4OF3NgqtKKRWg1LAvxjVL7Jon6oWlmGvLwzHkY+opm5UGzmA
         X8wAOXznr7FJbJMnDNqu4+aD+o/KZ4ZQAbVmPSwMvZo3t6Iao82RMX6YQYxvNSzfuYQX
         y1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lVSk/0eg+VzE8sES68ypaAs1tKpJNEqgg3qp7LS0ezg=;
        b=s+fe9bC3QLSoWxCcfsxwmLQzescJVgd3sDkUIIr4C9zbkaAeJtr76UMuIdr/HnyaoH
         f4z80YW22WVR1yr2GaneUvMl/dl4icYlH5a/Xm7Zfi1uaaIAJ3gEoSUIjvmRW8P4pmYO
         ZMhSRgzUH3zDcFZHDdMNJbztnlnwoiqpNiCPbuqSAR9zAQVoCoUfSO7Bkny33OoWanqp
         aW4UqXpJnQs0h0p7ErkgNqFrlTOgnAtgWfh7ReyDK4hauX4FRgliHj8cvBjQHyF7YOR7
         1mJD3bVdxRqS3kc0gqyKZuts7wvMxzoq8YpeGE8y67CGeiTIZDm3N4T29NxU4Geh/z3q
         aNig==
X-Gm-Message-State: AOAM533G3ISu6zTT5rDWy1PBVoMLV5J3hbY6ORp2xVLhpN3gtBXS7GG/
        LL54sfSoqndoJKxt2lRbncWlfStg14w=
X-Google-Smtp-Source: ABdhPJw+uImXPo1fRx9ZjC57wNxhtZaqnl7Rse+UPHb1fosQAI49XLkEZyLv2KzdYyPcOOoTT9WS0w==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr15783077wrq.78.1608516323952;
        Sun, 20 Dec 2020 18:05:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm25311950wrs.26.2020.12.20.18.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 18:05:23 -0800 (PST)
Message-Id: <20cff2f5c59adb1076c845657aabed7ebbf0a6b5.1608516320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
        <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Dec 2020 02:05:19 +0000
Subject: [PATCH v3 2/3] negative-refspec: fix segfault on : refspec
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
causing a segfault within strcmp

Tell git to handle matching refspec by adding the needle to the
set of positively matched refspecs, since matching ":" refspecs
match anything as src.

Added testing for matching refspec pushes fetch-negative-refspec
both individually and in combination with a negative refspec

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 remote.c                          | 10 +++++++---
 t/t5582-fetch-negative-refspec.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 9f2450cb51b..7323694b163 100644
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
index 8c61e28fec8..30209e98a62 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -186,4 +186,26 @@ test_expect_success "fetch --prune with negative refspec" '
 	)
 '
 
+test_expect_success "push with matching ':' refspec" '
+	test_config -C two remote.one.push : &&
+	# Fails w/ tip behind counterpart - but should not segfault
+	test_must_fail git -C two push one
+'
+
+test_expect_success "push with matching '+:' refspec" '
+	test_config -C two remote.one.push +: &&
+	# Fails w/ tip behind counterpart - but should not segfault
+	test_must_fail git -C two push one
+'
+
+test_expect_success "push with matching and negative refspec" '
+	test_config -C two --add remote.one.push : &&
+	# Fails to push master w/ tip behind counterpart
+	test_must_fail git -C two push one &&
+
+	# If master is in negative refspec, then the command will succeed
+	test_config -C two --add remote.one.push ^refs/heads/master &&
+	git -C two push one
+'
+
 test_done
-- 
gitgitgadget

