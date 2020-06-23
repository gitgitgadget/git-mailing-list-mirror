Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F2DC433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8AC2078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNZBpC25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgFWWr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388294AbgFWWr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:47:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94DBC0612AD
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so383705wml.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q0pF5yj7wjNRE2JCBd7v1az84w+LZ8K2+6NNlyKt2yU=;
        b=eNZBpC25EtILpKiY+Y7hfedPXXc7FStEO26EiQiHbpCex76YPAsb14ZXy2aOjUuV6j
         zPgpSQlcg4jifbu4bLfuwpKYRdhy2KNMvXy/SOsA9Vlc3DI4AJIqZHbSWWXeG0Qv00bT
         dOZsHWBlL9gqF5Du43c+zqtkvbkGoz18tCn8+1KtOoNvltzj/PnYa/mBXvwezw+vlNCK
         4axGfNurxJFNj/otDYiTxshWB5YAkShV7sQ8TfiwVJlD3kiXOHMNQcyjS9a6TF/pL6dc
         QOwIEnbtzpB8NQDwavdImocN8F+VrXmqi+OWj4jgHdrMtef15LFdMXlQ43zTTgJ8I2qq
         AFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q0pF5yj7wjNRE2JCBd7v1az84w+LZ8K2+6NNlyKt2yU=;
        b=ZpE6+M78i3S08gos/wV9fwgy0uW2GtoBhKa53b9HjHKmOzvW939FbgHxFDj9C4k7a0
         uOdeiB1xSWKqq1lDo7Zfpow02cOx2LvVhmwTBHoIRW1wKA88pqTI+EqATiwLu/ZqVx1m
         MadFZz8ZZSuIfuTdCf+ihKGBmM1FbIeB2MtVYAWEZDH1alNdLxapjn7PGENmLi1sM86S
         THHkH+e4Ksmb7h3Qk/WXGYSs1UNtP7oJGlPE38cIp+nA7Dz7sTuUPtRgX24/aNILFex/
         UyfT0s5pkj5gUuBrLNQcuoJkIk19oB/Rlk3+S7B482Wk7SvZQMopmrrhUXPL6gf04HPp
         C/jw==
X-Gm-Message-State: AOAM532AMTeylu4M9S1J/w/ML7XE6+LFl/KF7tYBJBg5Wu0Wy/od/Y/m
        xzjAGMdPeiqa4SeZHpKWpN7BapAt
X-Google-Smtp-Source: ABdhPJzQzCkwhkAnIaUbnfNtiH0/M/+lHMjTTkQQpPUWGZhGGJefqEvlIdojQMZXObZr8EBcb1CPuw==
X-Received: by 2002:a7b:c5d5:: with SMTP id n21mr26441258wmk.106.1592951618389;
        Tue, 23 Jun 2020 15:33:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm10657582wrh.14.2020.06.23.15.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:33:37 -0700 (PDT)
Message-Id: <c0d74cedd1571e0d791ec123fc4d0e1ec98e7862.1592951611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 22:33:28 +0000
Subject: [PATCH v3 6/8] clone: use configured default branch name when
 appropriate
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
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When cloning a repository without any branches, Git chooses a default
branch name for the as-yet unborn branch.

As part of the implicit initialization of the local repository, Git just
learned to respect `init.defaultBranch` to choose a different initial
branch name. We now really want that branch name to be used as a
fall-back.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/init.txt |  4 ++--
 builtin/clone.c               | 10 +++++++---
 t/t5606-clone-options.sh      | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index 6ae4a38416..dc77f8c844 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -3,5 +3,5 @@ init.templateDir::
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
 init.defaultBranch::
-	Allows overriding the default branch name when initializing
-	a new repository.
+	Allows overriding the default branch name e.g. when initializing
+	a new repository or when cloning an empty repository.
diff --git a/builtin/clone.c b/builtin/clone.c
index b751bdf13e..9a3f91b268 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1267,9 +1267,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		remote_head_points_at = NULL;
 		remote_head = NULL;
 		option_no_checkout = 1;
-		if (!option_bare)
-			install_branch_config(0, "master", option_origin,
-					      "refs/heads/master");
+		if (!option_bare) {
+			const char *branch = git_default_branch_name();
+			char *ref = xstrfmt("refs/heads/%s", branch);
+
+			install_branch_config(0, branch, option_origin, ref);
+			free(ref);
+		}
 	}
 
 	write_refspec_config(src_ref_prefix, our_head_points_at,
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 9e24ec88e6..286bfd93ac 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -35,4 +35,19 @@ test_expect_success 'redirected clone -v does show progress' '
 
 '
 
+test_expect_success 'chooses correct default initial branch name' '
+	git init --bare empty &&
+	git -c init.defaultBranch=up clone empty whats-up &&
+	test refs/heads/up = $(git -C whats-up symbolic-ref HEAD) &&
+	test refs/heads/up = $(git -C whats-up config branch.up.merge)
+'
+
+test_expect_success 'guesses initial branch name correctly' '
+	git init --initial-branch=guess initial-branch &&
+	test_commit -C initial-branch no-spoilers &&
+	git -C initial-branch branch abc guess &&
+	git clone initial-branch is-it &&
+	test refs/heads/guess = $(git -C is-it symbolic-ref HEAD)
+'
+
 test_done
-- 
gitgitgadget

