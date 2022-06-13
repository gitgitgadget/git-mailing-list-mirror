Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46471C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiFMWjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiFMWjP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A7B62D3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso5296418wms.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RaYUB6dc3MjI0KrKAldX9uKkBpj215Xyhi9z6NWyvHk=;
        b=L01yylDin5HiZ2Zx0gW8DkDOpMp6o9xGUW45Iq5oH+mOj4bVo45hiINRnEKO5r9Gml
         L9QO6Yq3MmVhmM0Mz78FLQLmLAjWUEJzV5V8CuvF5PgWLvETBlYAlCUhUGbc6J8w/n+a
         WDizU6bN5EzVCIGYpLjrhi+5Dfa/D9w9g6XrssPtgUOW2LM7gd3LOvD1DcshEpq90ZpA
         2ryN7y0RfC09Oodz3k7yLZz5j99E9zanmoPkjav/rcG35s0wjOowRBaskz/XZfaCO3rw
         2O82ZNuRT9ZItvrFnGFogHqPX/6sKSlpVoTeoZK1i9wO1BB2WjVSLBHU/oLHnZ0HAl3L
         b3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RaYUB6dc3MjI0KrKAldX9uKkBpj215Xyhi9z6NWyvHk=;
        b=3YgdE/2EuIWlcpYt9wgHjC/e/QjFpS9lmSAFvSX5GpajUx/ljW3BN31ycFR+f+Rr/s
         EAZ8plG6HFkcxZbSeljHwD+tJA0jZcWD2Mdl/D7qlaR/p7O/zRg7fWggsSQro3rK1Lmx
         FNM66qQH7KQwmteEpjnRu4oiTbetetqM9g8jxK8SeZIhoiGFcL4Y87rFpTUTCVhJVwX1
         dBjjvucxVNJTMstG6H4Jgu72jr4sIJBqw7/CHhxiaWLx/ueLc7JyJwrvSw2OV5ddZUDr
         pmrFtfHur18iHae5lgFXrsAzWUT2P6zUTOKA8vBmWVGtb6hwVPKWDuqmWWJSLiV17UE/
         OuNQ==
X-Gm-Message-State: AOAM530qXq/eh4KyTwnvApR9ZYbW77/weuLMuwA/dc1ngb3Zq7wJtjCY
        uTRXO0239WXpvytkT7ZqQRa5Nq/dd+qrrQ==
X-Google-Smtp-Source: ABdhPJyHGXJJ6llXinbb8enMZOMH3CZvbqug8vDEZs42M2wP7PTHRjTMXVVIbDDi535NKqLyCJZANg==
X-Received: by 2002:a1c:5418:0:b0:39c:3552:c85e with SMTP id i24-20020a1c5418000000b0039c3552c85emr942342wmb.68.1655159952963;
        Mon, 13 Jun 2022 15:39:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/12] submodule update: remove "-v" option
Date:   Tue, 14 Jun 2022 00:38:57 +0200
Message-Id: <patch-v2-06.12-025694644fc-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In e84c3cf3dc3 (git-submodule.sh: accept verbose flag in cmd_update to
be non-quiet, 2018-08-14) the "git submodule update" sub-command was
made to understand "-v", but the option was never documented.

The only in-tree user has been this test added in
3ad0401e9e6 (submodule update: silence underlying merge/rebase with
"--quiet", 2020-09-30), it wasn't per-se testing --quiet, but fixing a
bug in e84c3cf3dc3: It used to set "GIT_QUIET=0" instead of unsetting
it on "-v", and thus we'd end up passing "--quiet" to "git
submodule--helper" on "-v", since the "--quiet" option was passed sing
the ${parameter:+word} construct.

Furthermore, even if someone had used the "-v" option they'd only be
getting the default output. Our default in both git-submodule.sh and
"git submodule--helper" has been to be "verbose", so the only way this
option could have matter is if it were used as e.g.:

    git submodule --quiet update -v [...]

I.e. to undo the effect of a previous "--quiet" on the command-line.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh            | 3 ---
 t/t7406-submodule-update.sh | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5b9683bf766..0df6b0fc974 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,9 +241,6 @@ cmd_update()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
-		-v)
-			unset GIT_QUIET
-			;;
 		--progress)
 			progress=1
 			;;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 43f779d751c..06d804e2131 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1074,7 +1074,7 @@ test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
 	 git submodule update --rebase --quiet >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err &&
-	 git submodule update --rebase -v >out 2>err &&
+	 git submodule update --rebase >out 2>err &&
 	 test_file_not_empty out &&
 	 test_must_be_empty err
 	)
-- 
2.36.1.1239.gfba91521d90

