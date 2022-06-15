Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F2C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 11:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347003AbiFOLI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348846AbiFOLIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 07:08:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0B33E07
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 04:08:43 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so922846wml.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BUw9zng33tadGMvizJ2+n1aX10qoZ5+fjvOTadfxUu4=;
        b=nSjTdDj3DmV+q2SJe/mhsCG30EOTwbr1zf1bMUbaB07MXnqr2qlmVInjyFcGT6uso9
         tyOuzQDZYGpu6x4q1V2LG3ojqJ8StqQk6beox7s9p+WzMFNXrOdOph72Hx3prwNKQt3q
         3tXME7HmGvGOVd8P7wncnDXwQuAfOKzNKqs4rRbEnTHTuOfqDlsEXc1btC2SgD5Hg0ub
         25msLy14UFm01BAZAeOL8ysydCpH6ck96bC9WMMX0sci32DQbo5vJ9qzP0swTwI8bkZ1
         1r78udSNQ5EJ5nPnDk/WdYNWjd27YC41vygTelRliLXw3X5zZZSA3cR/sj6pqCgw9qd+
         TMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BUw9zng33tadGMvizJ2+n1aX10qoZ5+fjvOTadfxUu4=;
        b=BYUyUadMRAMos4IEtCwsUZfGm7eQbALJcgBHaNXLZBPBx5a/udhINlR2wpwkmJbrx2
         lXrEEfVWDVoKY7fHfTb0zmFVrEf7Jdmk1tYkrtYbJ9UZgCehz5M/m669AqTEeyN21Tw/
         43BlABchsnpbl6l+H3g3Tg3P1Ne8zGO75GPCSsdNEv5VADPsIyWviC4NhsaWKHVHxyFX
         Checlm7rxqjZC5w1cMgqrG3z3CeLVf2Pmv/3JRul8QPyBJmb0jmJ44xjrkMM8NwvTgOH
         +qzqJaEKuxGAf10uJw/dFi91GKufXTYBZuRAabOuK1KclHshYcTxawdG3snHDvTxg/71
         T5qw==
X-Gm-Message-State: AOAM530qLUA4NU0Uzkb27ygkIAk1u3H8eS0vaBQopbHgBa7kyuGZkcmv
        /zSIxvtyDQiNr9pfrJjdv17tcGjK5Aqqvg==
X-Google-Smtp-Source: ABdhPJzZ0VUexiTU6VwZYgL5uKUd7UJoNnPr/eqITKVCBuf1JyB3ownIOyqo1IjplnnOE9LbmmUbcw==
X-Received: by 2002:a1c:6a16:0:b0:39c:655a:ac2c with SMTP id f22-20020a1c6a16000000b0039c655aac2cmr9458903wmc.66.1655291322061;
        Wed, 15 Jun 2022 04:08:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11-20020a056000004b00b0020d02262664sm14465799wrx.25.2022.06.15.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:08:41 -0700 (PDT)
Message-Id: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
From:   "Kyle Zhao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 11:08:40 +0000
Subject: [PATCH] send-pack.c: add config push.useBitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Kyle Zhao <kylezhao@tencent.com>,
        Kyle Zhao <kylezhao@tencent.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kyle Zhao <kylezhao@tencent.com>

This allows you to disabled bitmaps for "git push". Default is false.

Bitmaps are designed to speed up the "counting objects" phase of
subsequent packs created for clones and fetches.
But in some cases, turning bitmaps on does horrible things for "push"
performance[1].

[1]: https://lore.kernel.org/git/87zhoz8b9o.fsf@evledraar.gmail.com/

Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
---
    send-pack.c: add config push.useBitmaps
    
    This patch add config push.useBitmaps to prevent git push using bitmap.
    
    The origin discussion is here:
    https://lore.kernel.org/git/b940e705fbe9454685757f2e3055e2ce@tencent.com/
    
    Thanks, Kyle

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1263%2Fkeyu98%2Fkz%2Fpush-usebitmps-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1263/keyu98/kz/push-usebitmps-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1263

 Documentation/config/push.txt |  4 ++++
 send-pack.c                   |  6 ++++++
 send-pack.h                   |  3 ++-
 t/t5516-fetch-push.sh         | 11 +++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index e32801e6c91..d8fb0bd1414 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -137,3 +137,7 @@ push.negotiate::
 	server attempt to find commits in common. If "false", Git will
 	rely solely on the server's ref advertisement to find commits
 	in common.
+
+push.useBitmaps::
+	If this config and `pack.useBitmaps` are both "true", git will
+	use pack bitmaps (if available) when git push. Default is false.
\ No newline at end of file
diff --git a/send-pack.c b/send-pack.c
index bc0fcdbb000..d6091571caa 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -84,6 +84,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 		strvec_push(&po.args, "--progress");
 	if (is_repository_shallow(the_repository))
 		strvec_push(&po.args, "--shallow");
+	if (!args->use_bitmaps)
+		strvec_push(&po.args, "--no-use-bitmap-index");
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
@@ -482,6 +484,7 @@ int send_pack(struct send_pack_args *args,
 	int use_push_options = 0;
 	int push_options_supported = 0;
 	int object_format_supported = 0;
+	int use_bitmaps = 0;
 	unsigned cmds_sent = 0;
 	int ret;
 	struct async demux;
@@ -497,6 +500,9 @@ int send_pack(struct send_pack_args *args,
 	git_config_get_bool("push.negotiate", &push_negotiate);
 	if (push_negotiate)
 		get_commons_through_negotiation(args->url, remote_refs, &commons);
+	git_config_get_bool("push.usebitmaps", &use_bitmaps);
+	if (use_bitmaps)
+		args->use_bitmaps = 1;
 
 	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 
diff --git a/send-pack.h b/send-pack.h
index e148fcd9609..f7af1b0353e 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -26,7 +26,8 @@ struct send_pack_args {
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert:2,
 		stateless_rpc:1,
-		atomic:1;
+		atomic:1,
+		use_bitmaps:1;
 	const struct string_list *push_options;
 };
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dedca106a7a..ee0b912a5e8 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1865,4 +1865,15 @@ test_expect_success 'push warns or fails when using username:password' '
 	test_line_count = 1 warnings
 '
 
+test_expect_success 'push with config push.useBitmaps' '
+	mk_test testrepo heads/main &&
+	git checkout main &&
+	GIT_TRACE=1 git push testrepo main:test >/dev/null 2>stderr &&
+	grep "no-use-bitmap-index" stderr &&
+
+	git config push.useBitmaps true &&
+	GIT_TRACE=1 git push testrepo main:test2 >/dev/null 2>stderr &&
+	! grep "no-use-bitmap-index" stderr
+'
+
 test_done

base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
-- 
gitgitgadget
