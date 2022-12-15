Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8578C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiLOJtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLOJsX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3487A175B5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:58 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z92so26282844ede.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oRSP9ylVY+u3I9qZWduucl7hj24t2hz/kVFpAbwKug=;
        b=P/J4UTaI6N22nHP+glGCLpVLxrSWTUxkCNHW557gWsrNR216pC5k7+FsGPlXYR/ryL
         80HSq5hc98GK5Zw3egalxU++yP6c+UCFQjlTwM5FnZuX2Wu3VEOjVJbREVfgo+b/PjVW
         m3PLRJZraJZ+MWjo+HzzlKl1FN1N3NZjlmfjymuyMYITooyboDl9WZpuYTIDvM4d0t3V
         M4KLanPavLkSDkR+8xTKLJxv1hDf2ZCKLOpcfaD08IAfnz0IMXCsnMHa4jWVB9oxFuaV
         vt5+4PGow07u4GbujHlk1TvVEXoCJ6qw5+RepqSdZWcwR2UanpZBcn07gBBejDZEEh7s
         FTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oRSP9ylVY+u3I9qZWduucl7hj24t2hz/kVFpAbwKug=;
        b=UAj/kcWdpdJdfkxUe+Etw3gIkfDH12VyHxoGNVmsIT3NovnnVmmff6bx7lkI5zIs3Q
         6Cc9uIkw/8Nwp6OuzhaErEkyM90H8zBIf7caHK9APcfpY2AqyFK+FfQ33MwoLEoJRlqm
         QlyDbK+bOnXhHszR2lzEMn9Pkj3uXvIt2tsJNpsJe8tmBKDOzxzIQsu2qWvBmEHvVRFw
         7vU1deUYWcMN5b/ZHxl63vrpRJAZrCbn1nBYBkphWOMST9lFAlmiuTsD0KQB0jCLxITq
         hYKkiytIYhgX3Lwd5N6K/bz8+mUxHwX4wpuMwj+1zUNBYNONjXNXC+/wCGiCf3PVKdNG
         YOJw==
X-Gm-Message-State: ANoB5pmLWm9psRZoT6bKhbUudpil3BRrmbNe+XGIKVUqFvb1SbHoD1fJ
        T6HUwvG4qYlyIWKAgntFsK+eB3aJIZHxwg==
X-Google-Smtp-Source: AA0mqf5lX4skORTyHmELMBPFeN9+ycgD/Q1qUS8PDw+m6WAczrN36+yRTPnL5xynYkzx0MzXm23ZWw==
X-Received: by 2002:a05:6402:500c:b0:45c:835c:c6f4 with SMTP id p12-20020a056402500c00b0045c835cc6f4mr26274314eda.37.1671097676483;
        Thu, 15 Dec 2022 01:47:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm7189155eds.40.2022.12.15.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:47:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] bisect run: fix the error message
Date:   Thu, 15 Dec 2022 10:47:47 +0100
Message-Id: <patch-4.6-59a8a3085b1-20221215T094038Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
the part that prints out an error message when the implicit `git bisect
bad` or `git bisect good` failed.

However, the error message was supposed to print out whether the state
was "good" or "bad", but used a bogus (because non-populated) `args`
variable for it. This was fixed in 80c2e9657f2 (bisect--helper: report
actual bisect_state() argument on error, 2022-01-18), but the error
message still talks about `bisect--helper`, which is an implementation
detail that should not concern end users.

Fix that, and add a regression test to ensure that the intended form of
the error message.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect.c            |  2 +-
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index 9fc8db06944..0786ebf4012 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1292,7 +1292,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			puts(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'bisect-state %s'"
+			error(_("bisect run failed: 'git bisect %s'"
 				" exited with error code %d"), new_state, res);
 		} else {
 			continue;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9e56b42b5da..0a62ea2b3ce 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1221,4 +1221,14 @@ test_expect_success 'bisect state output with bad commit' '
 	grep -F "waiting for good commit(s), bad commit known" output
 '
 
+test_expect_success 'verify correct error message' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 &&
+	write_script test_script.sh <<-\EOF &&
+	rm .git/BISECT*
+	EOF
+	test_must_fail git bisect run ./test_script.sh 2>error &&
+	grep "git bisect good.*exited with error code" error
+'
+
 test_done
-- 
2.39.0.rc2.1048.g0e5493b8d5b

