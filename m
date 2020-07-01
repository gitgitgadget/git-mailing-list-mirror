Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D673EC433E2
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D69206CB
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 04:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ2d7HfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGAE1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGAE12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 00:27:28 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF9C03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:28 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m8so6203906qvk.7
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 21:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kz+B32RAnkGwyFTOficrsLGlVxZI6QmjCoh7Hu/8EmU=;
        b=eQ2d7HfR0XCywikiVF1TUJ1Ta5+pSwCJ0FbaxyeATYtpx6NHEHyDdPLP+rM2O2fll6
         fJ10Eg5PSOe7KW2xUhEuaYtOn+z4PhZxkVpST4wnut1jTDlJb13tUBZwChChyJGdacbI
         PQFn1lJVgrCHxeu0nX/ymPyDE5xy8kBaFVZnr0EE8D94BTL4mqKV6ozlS16pkgN9mUyo
         5tdoPPrQCnZp/PcIr7vdEj8N6P68VmQp5TwJMVcnyq9+rTCT6FiFsD5eOByIbCXABA2v
         cw1Q20VBHbBtsyXmDLda2JMpex8NKLrspf3oNw0I9X03AjlcYIdnDeEqE6QEpd0GPNqE
         oOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kz+B32RAnkGwyFTOficrsLGlVxZI6QmjCoh7Hu/8EmU=;
        b=QeZkFx1LrCfzLpKE8WSAhyGyFY41VtRYLgiQ2MvaHRPUNt4tbbagnd7mgaBf63k8zf
         hzwowKeES54Y3LGwH5BpBcls5g+wuPUCtMSvQyez/FyuaBMLxXbyitanZDUSVBe4+W9v
         p5IzkhjGESao7yZZQUhUTOo/d2Zskl7DJ/aUUvPP5MvT7UXcFuyiYXrCuTQBs4Sy4jxP
         kq5ONGMB6DCvYhLx4Pqbzhi7GJ4vDVoRMXInp17TuZtC6ZtQbg+eNXDLGvJqw38EUSgw
         1OECowdlsJYsThSP+7iS331sENWIyIZsbOYMplq4ub8rnIp7EIJ1MCE9jm044Nzuy/kj
         pkLg==
X-Gm-Message-State: AOAM530c2HHTIv0opagM3Rs68aapbP4AZJMHfxP/X9bW7ps6VU910iW8
        6Mw7sA3tEjj/GzszsOd12I440TO9reE=
X-Google-Smtp-Source: ABdhPJxcx0cq7UXI/vAikCt7/4BPuFYfB8rUsB7VcGuNQYQveywiFy8k0rLigjobrkCUSff+w9ZOuw==
X-Received: by 2002:a0c:f486:: with SMTP id i6mr22768096qvm.229.1593577647220;
        Tue, 30 Jun 2020 21:27:27 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id x13sm4418813qts.57.2020.06.30.21.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 21:27:26 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] t3701: stop using `env` in force_color()
Date:   Wed,  1 Jul 2020 00:27:09 -0400
Message-Id: <654c864691866f644ff5ec92de5bfa0701645419.1593576602.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1593576601.git.liu.denton@gmail.com>
References: <cover.1593529394.git.liu.denton@gmail.com> <cover.1593576601.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we plan on making the test_must_fail()-family of
functions accept only git commands. Even though force_color() wraps an
invocation of `env git`, test_must_fail() will not be able to figure
this out since it will assume that force_color() is just some random
function which is disallowed.

Instead of using `env` in force_color() (which does not support shell
functions), export the environment variables in a subshell. Write the
invocation as `force_color test_must_fail git ...` since shell functions
are now supported.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3701-add-interactive.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 49decbac71..fb73a847cb 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -31,7 +31,16 @@ diff_cmp () {
 # indicates a dumb terminal, so we set that variable, too.
 
 force_color () {
-	env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
+	# The first element of $@ may be a shell function, as a result POSIX
+	# does not guarantee that "one-shot assignment" will not persist after
+	# the function call. Thus, we prevent these variables from escaping
+	# this function's context with this subshell.
+	(
+		GIT_PAGER_IN_USE=true &&
+		TERM=vt100 &&
+		export GIT_PAGER_IN_USE TERM &&
+		"$@"
+	)
 }
 
 test_expect_success 'setup (initial)' '
@@ -604,7 +613,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	echo content >test &&
 	test_config interactive.diffFilter "sed 1d" &&
 	printf y >y &&
-	test_must_fail force_color git add -p <y
+	force_color test_must_fail git add -p <y
 '
 
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
-- 
2.27.0.383.g050319c2ae

