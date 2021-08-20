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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F3FC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3D160BD3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhHTPlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241116AbhHTPlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:41:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8ABC061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f5so14822468wrm.13
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NqiGd7UZb5BPkCPqvCDgmSg2YEJComAB+J/uOMxS5Ek=;
        b=oFzbsiQxtvclHY5MW0S6dRxZ0i3PpANdWpImbJfUnz/yb9LEoWyfJJqBzzyHx/RnMV
         lKTr7L1lW/0yAaPP9PxHzbDerlIVRp64vDOJRMDpSP6yNsgfajxpc6NZIZyA/rZXNsVw
         5n3MjsvyMPezYb/8go3psy8G8eL11aSQm/u2P22MnabmuARDobuOtxQaUp9dm/jxq1Vl
         ql6uj8sGAc3DikARaXXrVJFWd879w1UPkEQm6RnkVaSAfI4ifOxAHbK5J8w/44L77pZN
         /08kwcmysxlC444N+nPBsdUh33PJ6Gt1XpBvRmlz2LXNCbz9Q3vl7r4RCXD+7EjrQ07W
         7btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NqiGd7UZb5BPkCPqvCDgmSg2YEJComAB+J/uOMxS5Ek=;
        b=hTLbWijxhd7aqXhBUwvka0ilPclVryTFPx5DqTlz3HX0k30GPvDIyDsNky8tmeATWD
         iJHI75KzLiQgKDPmSD77gHTW99Qfx1ky6b1b48R4oKmbduY7Vq1f5VrKqXmC6cEl2c6g
         NNcH4takxr7jRj/epK+fgLtW9J03OfP0BXRpkRGIL+81MzeWWbYAgqJBiC6nyBsnjvDf
         HNtbmNhbf6wsaIhI1TJD8siVOLq8X3vwzxYrrSodY0jTzhcQNeUSnKC50PZKmgCQWJtK
         lPH6pf4YdP4ocZ9/44MoVcNuMX4/YE6w9eRIj5DvkIAE03wWUU/yXU6EvOJ9Q1drrUgR
         hgmQ==
X-Gm-Message-State: AOAM531eaD+ekot0NtL4xOGaaTR8nDRjk17qlhxQvXmPXoUH4aXukpxF
        rXY3uUhU2JkzLvNtWsJFeQeXLwNUuv4=
X-Google-Smtp-Source: ABdhPJzCHFOZYFjUianc3r8VERjDw1XJOaaoErSbAN059ISvOXiywdMANWxdLT859iiDDnEdg9auLw==
X-Received: by 2002:adf:f4cf:: with SMTP id h15mr10945705wrp.67.1629474041268;
        Fri, 20 Aug 2021 08:40:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm6272604wrw.19.2021.08.20.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:40:40 -0700 (PDT)
Message-Id: <511cf9204ad5a785ffb2e2eebc757a4e58579826.1629474038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
        <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Aug 2021 15:40:36 +0000
Subject: [PATCH v2 2/4] rebase -i: Add another reword test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

None of the existing reword tests check that there are no uncommitted
changes when the editor is opened. Reuse the editor script from the
last commit to fix this omission.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66bcbbf9528..d877872e8f4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -839,6 +839,19 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
+test_expect_success 'no uncommited changes when rewording the todo list is reloaded' '
+	git checkout E &&
+	test_when_finished "git checkout @{-1}" &&
+	(
+		set_fake_editor &&
+		GIT_SEQUENCE_EDITOR="\"$PWD/fake-editor.sh\"" &&
+		export GIT_SEQUENCE_EDITOR &&
+		set_reword_editor &&
+		FAKE_LINES="reword 1 reword 2" git rebase -i C
+	) &&
+	check_reworded_commits D E
+'
+
 test_expect_success 'rebase -i can copy notes' '
 	git config notes.rewrite.rebase true &&
 	git config notes.rewriteRef "refs/notes/*" &&
-- 
gitgitgadget

