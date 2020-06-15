Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76F8C433E3
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9256C20739
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnAT5JWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgFOMub (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbgFOMuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD16C05BD1E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so14699075wmi.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nba56dVUR5Dnd+7OUTZMvAAvtt8ioGbpIrIGmaG/97A=;
        b=BnAT5JWdvuotp5dyr1EbW6oxXkprRUFltJpp3JZ4RtbEeMIFrQZ3BxIOZ0FbT5OuUs
         vf30uIihsJ8fJSS1ieXd5hmA2x1oWP/sN7uv7IwndB9wRVgOd8H3J2RbdDD86stl3AOt
         OqvNP4DxWVfkArT4kFyjkNkio1IBebP9whfPHk1zhos6muKARSNp+1lfc4QhK/2i7FCp
         lHKZWI6DKwoItYeKL0gLpJIdoksXZqwlwRwoc16uuGDEkc5HATcKgbH2nzm9LlU1WLiX
         abcSH96mGL5JPPpBD3Q/08jUsYozgToAAEIFrBk3jzg1lMPExtH4Xo4IQAYwFmjN2l6j
         ARAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Nba56dVUR5Dnd+7OUTZMvAAvtt8ioGbpIrIGmaG/97A=;
        b=e6f0AP3xjrhqio4gyqnWhxhDpHsr/C4+ZMWZzZgm9DYsErLEau8GAfuxCuSy6bmg/V
         lw+paIUfK5uzlNolJXjvBPuyCNjkkqXnYtJKS/Ds7o/lmYyJIYU3RpufSGYN0wmKwHFN
         +fewkc1kgpcNngBQ3ZdLNBz7ljwJFW+magLkEJl0jWKcFhEEIc003E+BFdFG3a2E1T49
         FQea8p4bf970J2mKakFGq5ojrw99zj03C37Xnqr5qgfMracCN3MO0CnSUj11xqQjlknG
         FV4nB07UrXmu8ZnZAwobPBM6hII37CV7t45L2i5SX51eBasQQTkUzaT7VQNhCuHWmHg+
         LqDw==
X-Gm-Message-State: AOAM5333zHLw8ooZRkhs1eQNkdpAQVUpZ68++Vy8KfG3IPgbxUGCyHfC
        0B+4ol48vrsRlMjXI9Zr/sfiT7af
X-Google-Smtp-Source: ABdhPJwwVyTtNEzh3rhFK+YwXOKtRfxsxFOAvvi1Q8GNXdeu1SnukNdnGQH6mjWArJ7b2Wm6jmA7sA==
X-Received: by 2002:a1c:a943:: with SMTP id s64mr12764838wme.103.1592225421513;
        Mon, 15 Jun 2020 05:50:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm27312427wrb.31.2020.06.15.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:21 -0700 (PDT)
Message-Id: <bd8af3755ad2a1e2cfe84fed939c9e23585b8c7f.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:07 +0000
Subject: [PATCH v2 03/12] send-pack/transport-helper: respect
 `core.mainBranch`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When mentioning the main branch name in an error message, we want to go
with the preference specified by the user, only falling back to Git's
own, hard-coded default when none was configured explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 send-pack.c             | 6 +++++-
 t/t5528-push-default.sh | 7 +++++++
 transport-helper.c      | 6 +++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 0abee22283d..2532864c812 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -405,8 +405,12 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (!remote_refs) {
+		char *branch_name = git_main_branch_name();
+
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
+			"Perhaps you should specify a branch such as '%s'.\n",
+			branch_name);
+		free(branch_name);
 		return 0;
 	}
 	if (args->atomic && !atomic_supported)
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4d1e0c363ea..f7583b20f87 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -98,6 +98,13 @@ test_expect_success 'push from/to new branch with upstream, matching and simple'
 	test_push_failure upstream
 '
 
+test_expect_success '"matching" fails if none match' '
+	git init --bare empty &&
+	test_must_fail git -c core.mainBranch=unmatch push empty : 2>actual &&
+	needle="Perhaps you should specify a branch such as '\''unmatch'\''" &&
+	test_i18ngrep "$needle" actual
+'
+
 test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
 	git checkout -b ambiguous &&
 	test_config branch.ambiguous.remote parent1 &&
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69db..8c8f40e322d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1044,9 +1044,13 @@ static int push_refs(struct transport *transport,
 	}
 
 	if (!remote_refs) {
+		char *branch_name = git_main_branch_name();
+
 		fprintf(stderr,
 			_("No refs in common and none specified; doing nothing.\n"
-			  "Perhaps you should specify a branch such as 'master'.\n"));
+			  "Perhaps you should specify a branch such as '%s'.\n"),
+			branch_name);
+		free(branch_name);
 		return 0;
 	}
 
-- 
gitgitgadget

