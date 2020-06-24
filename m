Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21311C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85E820702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtlgXB1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403976AbgFXOqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403954AbgFXOqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623EBC061795
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so2581406wmh.4
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q0pF5yj7wjNRE2JCBd7v1az84w+LZ8K2+6NNlyKt2yU=;
        b=YtlgXB1KhNiDcwY5o/6l5a5UNmzwb6RI9j3/tCdqzp7GVRDWf8iIkeAHKhZiEiL3uk
         HkkPyvKaynOYOCjxsBs1OEDUuUT4HumKzF6SbJn1+fL3KBlQQwd/yQgwvjy0VWtFbC+5
         layqGgKiR5JvZrxqrxBHUsyOgKLWWT8eT4VGZ9bjEqWkHXDG6IZCE+KYpoIfaZmHHWA3
         bt6dO/EI61FbEXN9QUNEbNNjQl9RYLxFIKcPmF4JMQe2fHWRAGrZ8P1ibTm5hTgCNKks
         T3k43rXauHK2FbakThjbq2mpR4xU4hgsvoHjris3/wa3i4qyZY0ldpewixj04LcOQyyD
         SCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q0pF5yj7wjNRE2JCBd7v1az84w+LZ8K2+6NNlyKt2yU=;
        b=o+05tJliMoKcG4x3NfpG7Ncw65nPbv9zz0Wh+p8IYA6qnZbaiVDw2qmuaNYjgeqXAM
         0iv5MhPpvXSNtJmXrSvnnhqNhy7qW7JkhsYgvSgVg9gdzlB1Fw+H9QVdZHMf/A73OI5f
         HdY9pfsKjwE24Gbm8WSCwXonBarAu60qdUIv/dYiOxxtSBr3Nz2aC7wWZTflpahH19jC
         pt7FzsEsoP6Wvr+kic2mLjslvzQLN1cUTnLdoaJPi+5VorenYgmmZGI94MsxfWYuX2OA
         XE/sXHLfTsnAzxnBnxgcK28DAJ9HkEydfIpxPHHzF8xR6FST98yO/Em0eNZ6YXen21kk
         3bvQ==
X-Gm-Message-State: AOAM530UBQx9zb8za5+3W0jXuxTHXmLRDA8jDGADtQjWYjd7pXm9QMZx
        vAgWH5vIrrYX4mHDWRiqarTH+RPbeO0=
X-Google-Smtp-Source: ABdhPJzaZeP+OsJu27T8Me/w94koIL054O5QBuCageOfdclyroMzaJeiR2VR/3629PdNWfg3dsXdcg==
X-Received: by 2002:a1c:48:: with SMTP id 69mr31208850wma.32.1593010004024;
        Wed, 24 Jun 2020 07:46:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a81sm8719330wmf.30.2020.06.24.07.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:43 -0700 (PDT)
Message-Id: <1cff7705e43ef79902e03f1420d611c53429ea11.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:34 +0000
Subject: [PATCH v4 7/9] clone: use configured default branch name when
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
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
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

