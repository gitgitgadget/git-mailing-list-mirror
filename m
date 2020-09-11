Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CDC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D78208E4
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL/LDJD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIKSZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgIKSZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:25:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88920C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c18so12364824wrm.9
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ekSrOQKMCsry37eLIl1yJ3SMCc2KAst0M+YuBeb2DWo=;
        b=CL/LDJD7b4itIv/BUPHDuIXFM4a1UxpmHkoY03J8a8tv3FpFQB8AdnaYquQCxFpdPU
         7yPPNcKu28+HS0TSupwu9oE4Kua/pd/kQF5rI0m4WDelJOGxlcjm9bHORoCVlYaPt7Hv
         IZ5Uz0ZED4R7DlnGIiiy4kiQKFWX2phINJA92Vmj8YzhDwVl8tht35pysTue3Db0M6hx
         m8heRpqY9pKM/7lAMgAsHWHXqUeXSiM0cP3D+k8SqpDwEalbQckwESMEkrAXzVgFrBwc
         49+TQU/s0yx3gKw2sNWsk0EQ9cQBIfNLsLcEXywsffBDrc5vxnuU4520ahDDZTS7r1zF
         B6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ekSrOQKMCsry37eLIl1yJ3SMCc2KAst0M+YuBeb2DWo=;
        b=BY6NkZFOI/4n+v4gAeF9jGKEBXzc6wKnaxW31u08wAFBWOlKCKE50vGtCgV+GGK8Rw
         BmuGJ0Zpnjoh1NHjcMcRonD4KmvVay6KNI5OX8xJ1BwtT95PHKS89n32I33pB9Oxg8q8
         JPDeR31jyC6rm4BhONYeGB25YDxqK6km2bMex+KerGJK2dTIODOgvC9GZv/e+LUrwBRl
         qvf67m6fNDqnj4KwT5/Bv8BfL7XblK9kl6tRuLMd8BU6gKFmnAiv4Wve/isfI3T0Y0ky
         /k0ZbO30agWuJ0YLlJ84v86rHgCp9sYfqqOpvrnYBiexw3iyQTlr+RHjvKQz0eKW7QVm
         5+oA==
X-Gm-Message-State: AOAM533XsHMd+m0JK5E0+OmYgNNP19DAtcMkBXVuqAkqp2F1FfqKMwtp
        t/X7xlqBVfPop01DMAX0LJzZeg5v4j4=
X-Google-Smtp-Source: ABdhPJyULhTPQWsOn5V6R95Lk6U8DXezleAFM5LZTzSK3TcjW3b3qdz6XV9CNwsgAUdLjm4GgoYkvw==
X-Received: by 2002:adf:df81:: with SMTP id z1mr3441147wrl.9.1599848728913;
        Fri, 11 Sep 2020 11:25:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm6136057wrq.67.2020.09.11.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:25:28 -0700 (PDT)
Message-Id: <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.git.1599848727.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 18:25:24 +0000
Subject: [PATCH 1/4] clone: add tests for --template and some disallowed
 option pairs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

Some combinations of command-line options to `git clone` are invalid,
but there were previously no tests ensuring those combinations reported
errors.  Similarly, `git clone --template` didn't appear to have any
tests.

Signed-off-by: Sean Barag <sean@barag.org>
---
 t/t5606-clone-options.sh | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e69427f881..d20a78f84b 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -19,6 +19,50 @@ test_expect_success 'clone -o' '
 
 '
 
+test_expect_success 'disallows --bare with --origin' '
+
+	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
+	test_debug "cat err" &&
+	test_i18ngrep "\-\-bare and --origin foo options are incompatible" err
+
+'
+
+test_expect_success 'disallows --bare with --separate-git-dir' '
+
+	test_expect_code 128 git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
+	test_debug "cat err" &&
+	test_i18ngrep "\-\-bare and --separate-git-dir are incompatible" err
+
+'
+
+test_expect_success 'uses "origin" for default remote name' '
+
+	git clone parent clone-default-origin &&
+	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)
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
+	(cd clone-template-config && test "$(git config --local foo.bar)" = "from_template")
+
+'
+
+test_expect_success 'prefers -c config over --template config' '
+
+	template="$TRASH_DIRECTORY/template-with-ignored-config" &&
+	mkdir "$template" &&
+	git config --file "$template/config" foo.bar from_template &&
+	git clone "--template=$template" -c foo.bar=inline parent clone-template-inline-config &&
+	(cd clone-template-inline-config && test "$(git config --local foo.bar)" = "inline")
+
+'
+
 test_expect_success 'redirected clone does not show progress' '
 
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
-- 
gitgitgadget

