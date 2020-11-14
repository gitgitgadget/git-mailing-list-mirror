Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FA4C63798
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95372225E
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q71fw6wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKNAew (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKNAew (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 19:34:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2470C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a3so13506906wmb.5
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 16:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y+2H8e0PGgPoV+ewCQtlbWHgAxojGisT2unNKis/JvU=;
        b=q71fw6wZOsJ8BX7U92KBNeSfcLfnwN9BrBR+XTzHGa9+aTYP65+Wcd8y+S+TtUkHmz
         2+Dau4dZCmRwwryIurIV6p/vBbmVgiwOtDZ2Sfz6keEq7jxNlyyeefDhFEE7fItgDi9j
         MRnh8HLZgL1eWPG54Qr9LE11b0KNquMxkouFSIllvAHYbM/rjy+/WIHZ5aurD/CbjlRE
         zXl7zVL+RCqw16imnqKq/4PxEVjHzXSlBldXS5Km9m7LRmbBWV2xpwJC/diK3KkhOcM3
         O95YuBkW+EAyKPMTL5kH9PySSObkY/U09FievY4OV0+TWvoGbntwuyY4EcaTQkZAk9za
         MseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y+2H8e0PGgPoV+ewCQtlbWHgAxojGisT2unNKis/JvU=;
        b=mRZA/HkO2ex/YLzh6LedPYq0xUMX7xbHW2buvUr/69b6mBrrRzx/cjZfq4chV65c3B
         tRICRy8zf/T3Y5YTjpWafCNfjopLZHjlMt2VHvjo0YU3m3NDRZ84DE0oFUvM57/wppFP
         Ejww+uwrtyei+7rjQaKsN//l4GvVkxC4zF5VyI80Ss/VhsltF7+2UXuyh21/++LWpAFd
         z5eCojCKlKIGAY3DhB8KXJfuY0QB66zoRIZWz7rKLLTRo44Yfa88gGmM4zTmkJM6ow60
         rBAnnbMk/bElENOLZLu6HuDoQorN7IaZstBbSIk8JjpUbKXGawHuw8n0SO8q2tF0XEt4
         AmcQ==
X-Gm-Message-State: AOAM532/Qfu4P562b3ZKD82XOqtVP3daj08hT0Qm7veNm0jhxmDGHmAy
        ZJ6Dc5Ov3VFIRo1zI/CoFxHJnmAq0XE=
X-Google-Smtp-Source: ABdhPJw0XDop72BXtbNEzC68qPR3VLN7YTOS//I/eeYMMlFbSk9cs1EVYDSTx7br4p0ZFSaL84W56A==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr4633330wma.147.1605314089295;
        Fri, 13 Nov 2020 16:34:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm12396020wrt.25.2020.11.13.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:34:48 -0800 (PST)
Message-Id: <d019be1602e48fc2ab899a59027a084f85e4d5f2.1605314085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.789.git.1605314085.gitgitgadget@gmail.com>
References: <pull.789.git.1605314085.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Nov 2020 00:34:45 +0000
Subject: [PATCH 4/4] pull: check for local submodule modifications with the
 right range
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brice Goglin <bgoglin@free.fr>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Ever since 'git pull' learned '--recurse-submodules' in a6d7eb2c7a
(pull: optionally rebase submodules (remote submodule changes only),
2017-06-23), we check if there are local submodule modifications by
checking the revision range 'curr_head --not rebase_fork_point'.

The goal of this check is to abort the pull if there are submodule
modifications in the local commits being rebased, since this scenario is
not supported.

However, the actual range of commits being rebased is not
'rebase_fork_point..curr_head', as the logic in
'get_rebase_newbase_and_upstream' reveals, it is 'upstream..curr_head'.

If the 'git merge-base --fork-point' invocation in
'get_rebase_fork_point' fails to find a fork point between the current
branch and the remote-tracking branch we are pulling from,
'rebase_fork_point' is null and since 4d36f88be7 (submodule: do not pass
null OID to setup_revisions, 2018-05-24), 'submodule_touches_in_range'
checks 'curr_head' and all its ancestors for submodule modifications.

Since it is highly likely that there are submodule modifications in this
range (which is in effect the whole history of the current branch), this
prevents 'git pull --rebase --recurse-submodules' from succeeding if no
fork point exists between the current branch and the remote-tracking
branch being pulled. This can happen, for example, when the current
branch was forked from a commit which was never recorded in the reflog
of the remote-tracking branch we are pulling, as the last two paragraphs
of the "Discussion on fork-point mode" section in git-merge-base(1)
explain.

Fix this bug by passing 'upstream' instead of 'rebase_fork_point' as the
'excl_oid' argument to 'submodule_touches_in_range'.

Reported-by: Brice Goglin <bgoglin@free.fr>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/pull.c            |  2 +-
 t/t5572-pull-submodule.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ac6ef650ab..b7c87b87ea 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1037,7 +1037,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
-		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
+		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
 			struct commit_list *list = NULL;
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 7d9e12df4d..37fd06b0be 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -144,6 +144,35 @@ test_expect_success 'pull --rebase --recurse-submodules fails if both sides reco
 	test_i18ngrep "locally recorded submodule modifications" err
 '
 
+test_expect_success 'pull --rebase --recurse-submodules (no submodule changes, no fork-point)' '
+	# This tests the following scenario :
+	# - local submodule does not have new commits
+	# - local superproject has new commits that *do not* change the submodule pointer
+	# - upstream superproject has new commits that *do not* change the submodule pointer
+	# - local superproject branch has no fork-point with its remote-tracking counter-part
+
+	# create upstream superproject
+	test_create_repo submodule &&
+	test_commit -C submodule first_in_sub &&
+
+	test_create_repo superprojet &&
+	test_commit -C superprojet first_in_super &&
+	git -C superprojet submodule add ../submodule &&
+	git -C superprojet commit -m "add submodule" &&
+	test_commit -C superprojet third_in_super &&
+
+	# clone superproject
+	git clone --recurse-submodules superprojet superclone &&
+
+	# add commits upstream
+	test_commit -C superprojet fourth_in_super &&
+
+	# create topic branch in clone, not based on any remote-tracking branch
+	git -C superclone checkout -b feat HEAD~1 &&
+	test_commit -C superclone first_on_feat &&
+	git -C superclone pull --rebase --recurse-submodules origin master
+'
+
 # NOTE:
 #
 # This test is particular because there is only a single commit in the upstream superproject
-- 
gitgitgadget
