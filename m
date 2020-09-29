Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DC8C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B21020715
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLsPp5z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgI2Dg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbgI2Dg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:36:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4D3C0613D0
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:36:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g4so3660226wrs.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kMKDnHn06oMedf8Zi981Xaj1FxFvUg58m4Kj+4amaPs=;
        b=jLsPp5z/QVw2IDKSNDncIjl1U5YKniJ1srPZdCcGHZdw5Tl7MACfyzBfdzM6mgbcm9
         DYuJmmtnFhrMbIcKD0J3bueZRJfowTlLN6JzFUegv1Z1EqzO1QHSXsrDjrz8cHMzTaV5
         VNLiEbMY4q8WhZP62LCZpaiEea0W6b9HkATA9y6lG4qTg5QGUnR1DTADgGMbrFDni9qA
         tkJQKqtkhmeOy3OwoUTRn5ohnSxDTmDKqmBltAop3N3NV8hSUbmjEy7LeIYWj6kJuugg
         VkTkgY3bsfWGSj5RbIIbnHlczLjYwbdZCeX5Nlr6vcsMCPrP+80Is2XK0WbsjuwNfq08
         9O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kMKDnHn06oMedf8Zi981Xaj1FxFvUg58m4Kj+4amaPs=;
        b=ZMKFVkS62muk4fmzr1FXXJGBY1AWHPiC41PSkUPJLSl+GfPnnh+tTK4OvRevXy2Hgi
         6hGnFqDhTf9aLT7SI5kye6f0G7VQUlHnFPGftcUSQsF49Hyane6TZ7xCqW7YU6vFzJIM
         iEKtuu76GCCHWWP334tnFps8DvU/BQaHDXRFTmNY8xj/Fzyd3ANpRrCqOfw3Br49HbQO
         y7VmDVGNwJDkpstsXuVIrDoC6WBTOp42uySbPtnJUlf+JGAXzoYyjWKdZ1+xFMJ5IDaP
         3qgFLKKKz1OZVweDWWmTSrGIb+XrI0Pz2yKMjZsVD9GAe8lozV0b7XaVLF7VDbd8c/fM
         40wQ==
X-Gm-Message-State: AOAM533jE/26VEkSYKtVt38N2HGzGMrUVGMrlC1zpAZ0U06RefPv8shz
        3cpm+iaaVK+S3cZK/ZsXzH7S3FFLK1I=
X-Google-Smtp-Source: ABdhPJwwokRu5WIm8Jh6aQJmoScYaxEMwSw739kcZ10xgwWuZlMj03wXQpdxZLrlRJvr+bf23V3Rzw==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr1607742wro.250.1601350617462;
        Mon, 28 Sep 2020 20:36:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm4033798wrx.82.2020.09.28.20.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:36:57 -0700 (PDT)
Message-Id: <29ab418b1b8028c566b1008a0673ad0f6c6d112f.1601350615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:49 +0000
Subject: [PATCH v2 1/7] clone: add tests for --template and some disallowed
 option pairs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

Some combinations of command-line options to `git clone` are invalid,
but there were previously no tests ensuring those combinations reported
errors.  Similarly, `git clone --template` didn't appear to have any
tests.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Sean Barag <sean@barag.org>
---
 t/t5606-clone-options.sh | 46 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e69427f881..0422b24258 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -15,7 +15,51 @@ test_expect_success 'setup' '
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&
-	(cd clone-o && git rev-parse --verify refs/remotes/foo/master)
+	git -C clone-o rev-parse --verify refs/remotes/foo/master
+
+'
+
+test_expect_success 'disallows --bare with --origin' '
+
+	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
+	test_debug "cat err" &&
+	test_i18ngrep -e "--bare and --origin foo options are incompatible" err
+
+'
+
+test_expect_success 'disallows --bare with --separate-git-dir' '
+
+	test_must_fail git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
+	test_debug "cat err" &&
+	test_i18ngrep -e "--bare and --separate-git-dir are incompatible" err
+
+'
+
+test_expect_success 'uses "origin" for default remote name' '
+
+	git clone parent clone-default-origin &&
+	git -C clone-default-origin rev-parse --verify refs/remotes/origin/master
+
+'
+
+test_expect_success 'prefers --template config over normal config' '
+
+	template="$TRASH_DIRECTORY/template-with-config" &&
+	mkdir "$template" &&
+	git config --file "$template/config" foo.bar from_template &&
+	test_config_global foo.bar from_global &&
+	git clone "--template=$template" parent clone-template-config &&
+	test "$(git -C clone-template-config config --local foo.bar)" = "from_template"
+
+'
+
+test_expect_success 'prefers -c config over --template config' '
+
+	template="$TRASH_DIRECTORY/template-with-ignored-config" &&
+	mkdir "$template" &&
+	git config --file "$template/config" foo.bar from_template &&
+	git clone "--template=$template" -c foo.bar=inline parent clone-template-inline-config &&
+	test "$(git -C clone-template-inline-config config --local foo.bar)" = "inline"
 
 '
 
-- 
gitgitgadget

