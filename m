Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A543C3DA79
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiL3CTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiL3CSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185621707D
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:45 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z11so13024544ede.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14JMX+D5fOZCP/BStNku8nHaXsfXlD3Lgx067PwizW4=;
        b=AGmsud1Y2wUxKF6e9Vgfhf/g4da+U7tQNlhursq4qm1Wz21EegmxpYS/7VLwieMKQg
         iKHkszx5lRfPXcSEeUo8Nb34pfwS5REQ4iwd14WTTI5xm8jX80Gw1qlu+fCXDdc6Lai7
         XRQ4EeA0cGuAeIp1Z1+zsZrv+unjof8wXv3o1/UTpdeN1qwJShMt/mZ6CQLjNZ1s7AtJ
         dRR64ynXay2PKZAVD/b8SkljXIMtmPc1BC8Qo2Sx/2L//I9DsDd5Ugpyr+Mtk+v0KI1K
         MEpsXSiW/FI7sebMVMYeQAx1Cj9oQWUL7jGse2A/yDyXBxujwEpAGnN68MQxluztRg7s
         Vbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14JMX+D5fOZCP/BStNku8nHaXsfXlD3Lgx067PwizW4=;
        b=L0JrR4JB/8SAeFXmr1Tg6BvBYAn8LOnJQ9NSfgr/y6FXpK2/pNku8GkrF+Mcj4bMQg
         YmEzEaA/F1k7W9ZSdzKwf+7FLmp2xEhXKCFt592VtCpxtdVL6AiBI2afh+/XstOJG/4P
         dPdFPJ5cUgcJ1hHbUMFRf7iAcI7yiKd8zqI59MDIOrHDSTVFRswma0hFQ10cylo9SpLN
         cXr4kQMkZHmYFjWSjAOz/xjpL8ScrKjBU9rHN+2mH2yLH/OU4LN+hzin+XRM9NTg0SH6
         qtL2ra5TvQseKkVViuAkEKzsAywuiDv3bVDblJ03oPeVIVprpGLunPeyoeRlxnSN9eht
         TXEQ==
X-Gm-Message-State: AFqh2koJQw9ch1zuybQwD/RjBcKL+RIkGH9NOhOQzSHZZdpwf1LkTN59
        ucx6LzamZhHKHrc64SG+m+8tTzHQ4O4JTw==
X-Google-Smtp-Source: AMrXdXsRTGSmxyeitqkuMKFQQmvLN55Bscq7ITLuvE4Xb259t6ha+BiE6zT22SfRp6S8nKa9MrzU+w==
X-Received: by 2002:aa7:c1c9:0:b0:468:fd17:aeb9 with SMTP id d9-20020aa7c1c9000000b00468fd17aeb9mr27015822edp.0.1672366723246;
        Thu, 29 Dec 2022 18:18:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/20] clone: use free() instead of UNLEAK()
Date:   Fri, 30 Dec 2022 03:18:19 +0100
Message-Id: <patch-v2-04.20-c05620cef49-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an UNLEAK() added in 0c4542738e6 (clone: free or UNLEAK further
pointers when finished, 2021-03-14) to use a "to_free" pattern
instead. In this case the "repo" can be either this absolute_pathdup()
value, or in the "else if" branch seen in the context the the
"argv[0]" argument to "main()".

We can only free() the value in the former case, hence the "to_free"
pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f518bb2dc1f..48156a4f2c2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -892,6 +892,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int is_bundle = 0, is_local;
 	int reject_shallow = 0;
 	const char *repo_name, *repo, *work_tree, *git_dir;
+	char *repo_to_free = NULL;
 	char *path = NULL, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
 	const struct ref *refs, *remote_head;
@@ -949,7 +950,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path) {
 		FREE_AND_NULL(path);
-		repo = absolute_pathdup(repo_name);
+		repo = repo_to_free = absolute_pathdup(repo_name);
 	} else if (strchr(repo_name, ':')) {
 		repo = repo_name;
 		display_repo = transport_anonymize_url(repo);
@@ -1392,7 +1393,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	free(unborn_head);
 	free(dir);
 	free(path);
-	UNLEAK(repo);
+	free(repo_to_free);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	transport_ls_refs_options_release(&transport_ls_refs_options);
-- 
2.39.0.1153.g589e4efe9dc

