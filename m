Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6DBC48BE5
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD92C61374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhFKW54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:57:56 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:39618 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 18:57:54 -0400
Received: by mail-qk1-f201.google.com with SMTP id v16-20020ae9e3100000b02903aafadba721so7948157qkf.6
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C4Ecs1VoZMSdLkgCKV06ArCy7TfqUq6TKSoKEmyI068=;
        b=asEayoDm68oJHd6DRQSVu7778wXoKeuz+rN2zcv9oR+jx9XtVQyev/Xoc9/3O0ml2A
         /LH+Lh0yksu54QRHm98T7Z417cbu8dzUGvwjN8hMlWXjzM9ekt+c6FHkLLpxoy8ySXVD
         k/G+PEcDA+8ViI9XUcXJJaQ7joDxg54vT46mE+i3Up1+qROLNRHFlUy34DFbQ2bZ9bEQ
         9cNoALuX2czE06sRHAQus+5OyqicZXm2PGVF2c4nt/a1XrAJ2Ds6TNm3U7uDtEuEprvA
         dDH8I2jjTtoZReMfBdqe+QBnVLhT03zS0jsX2ow9lo41NGzJ2pchI8neLVVnJoTB0Pc0
         qUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C4Ecs1VoZMSdLkgCKV06ArCy7TfqUq6TKSoKEmyI068=;
        b=cZcji4ziHpp9Uut4ywCQJZd86yqJWvCN4r0FvVTpop1JY/4xmoWQThXdGrTgMdcckS
         ykOCwzSOFLyz2gIYtj5UcsF/ox/dQNMUTFUQmcOQvwOgECDFb4/NCJk2uTMrO0upmi02
         Bx20QRMqfwNvFczlcEZAuSMH/83xNeV2jClNuULqKHYb2nZY+hbL5Ggr8nYctXBJ5AvJ
         I5vXGC5W82wM9BM4uwEm/HWLJJzbYt2jk071tSdiFiBo92+GWeN6o1BWs+POBsDitILd
         0hxJI0NymEl6uHABoY+GQEuQ+3pmTNRIJYL4+532DO0FN4hwpuPIfNHYJ1dnpjDosSsU
         N/5Q==
X-Gm-Message-State: AOAM532IU5StmIzb5awfisPzrB8++7on/+ZXnp/1vwvayh1M18tLjdUO
        sWTJxoCOv+hDZPSUCVUUuhDTdhV8CWyVZBZR/Q3RoGdFcors2S6oq82E+vIXXaSkak2g+X2ciH0
        XXe+rvJl0n+bMRPua2b7/NXZiJModRh7/ilgNR5Ol98vOppAAw3pzQZpA4CErO63v2x0Fc1mwVg
        ==
X-Google-Smtp-Source: ABdhPJwQx6/RWMwzJFsBEHA7mTRknDVpnGeZkvKPpmzDaBpQY2t1NKFuoyV3S3mE3OZ4dE6R+JLr9x/mFUIkpw6j8RI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c894:862c:2364:ff78])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:20e3:: with SMTP id
 3mr7231493qvk.48.1623452083496; Fri, 11 Jun 2021 15:54:43 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:54:28 -0700
In-Reply-To: <20210611225428.1208973-1-emilyshaffer@google.com>
Message-Id: <20210611225428.1208973-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210611225428.1208973-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 4/4] submodule: cache superproject gitdir during 'update'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A cached path to the superproject's gitdir might be added during 'git
submodule add', but in some cases - like submodules which were created
before 'git submodule add' learned to cache that info - it might be
useful to update the cache. Let's do it during 'git submodule update',
when we already have a handle to the superproject while calling
operations on the submodules.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 git-submodule.sh            |  9 +++++++++
 t/t7406-submodule-update.sh | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index eb90f18229..ddda751cfa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -648,6 +648,15 @@ cmd_update()
 			fi
 		fi
 
+		# Cache a pointer to the superproject's gitdir. This may have
+		# changed, so rewrite it unconditionally. Writes it to worktree
+		# if applicable, otherwise to local.
+
+		sp_gitdir="$(git rev-parse --absolute-git-dir)"
+		relative_gitdir="$(realpath --relative-to "$sm_path" "$sp_gitdir")"
+		git -C "$sm_path" config --worktree \
+			submodule.superprojectgitdir "$relative_gitdir"
+
 		if test -n "$recursive"
 		then
 			(
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index ff3ba5422e..96023cbb6a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1037,4 +1037,14 @@ test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
 	)
 '
 
+test_expect_success 'submodule update adds superproject gitdir to older repos' '
+	(cd super &&
+	 git -C submodule config --unset submodule.superprojectGitdir &&
+	 git submodule update &&
+	 echo "../.git" >expect &&
+	 git -C submodule config submodule.superprojectGitdir >actual &&
+	 test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.32.0.272.g935e593368-goog

