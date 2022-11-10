Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CB6C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiKJQhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbiKJQhf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1E54298E
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5184835pjc.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brJqNc91dtCLCnImpiWqFu2USO/KeVfszsCvDBQ5Mnw=;
        b=e4PO8sQs4CWj/gVTE2sHl67rei0yuQtrgXV9jVB/2aMksPx28uuc/xw36hB36QXdae
         Gs6xIJPFrmWTRFkLbWIWs0ISFtM852CL2E+TZmdB7xnDCdXObrkizYcbJ9aj5bHpSiWR
         +yVGI/h2vDi6A3NyR07hhnd/qJaeBQKsSPILybVJpS3A9NpX4yJ/Z6T6FCI4RNQRTn4i
         vXTNEpI5dWhcN9pPXfLDXstZGHtsFflC2fdvH6mHnbMT2AwZTUC8ImV7w/PYH8tULfrd
         qTYxZtunImg+mczwg0heI7hV7N5bjrgvWXo1HqCU5zWYzE8BcJpm5hmlBLCYBdEO1H8i
         Rl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brJqNc91dtCLCnImpiWqFu2USO/KeVfszsCvDBQ5Mnw=;
        b=B9Rdhski8ygDmqAgVjK/vmkXpSlctYI676FeQszTvfIzG8M9vZ1wr2ER4kNunWy8sl
         pVeYTGywZN3GWdcN2KylCwECkvUhgldYmC0N/NkxHc6jljggrHhg+VFMIXWysPIAkXsj
         4wofXRv49h657sLbGJhIiHvQwcmKDgzM8O7jaYU4UcIkbQVERrzEBBDciqUQo3abwujy
         YXD8+f/fM3lPmdDQsv+kDiYZrQucTocrTUASomsCcIJBxw7RsbfFByWidMW+B5mW9b2Z
         tOjxTKIkdeqRzq6bo/5CgcWgr4Vk7BMcmqeBVfy92qTiuaDhwDBNndnHP91xWtmpBmUM
         x7bw==
X-Gm-Message-State: ACrzQf0KvVAZyw/bZj6ccKPdPpPm98GEq3jPR601BONKi4uOrA+RtQWW
        WQN016cXGoxSXcE9VlfoG4mR7tgdUwg=
X-Google-Smtp-Source: AMsMyM51moEIfttJXz8LOPJBkkFW2G+t24mC8RgSO08+FELkjCNei+o4MtuT+DBQd1z3OU3iioyKtA==
X-Received: by 2002:a17:90a:4146:b0:213:2411:50e7 with SMTP id m6-20020a17090a414600b00213241150e7mr1473181pjg.212.1668098241620;
        Thu, 10 Nov 2022 08:37:21 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:21 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 07/11] bisect test: test exit codes on bad usage
Date:   Thu, 10 Nov 2022 23:36:42 +0700
Message-Id: <7c43abfcefc6bf6e6e667ba86ef81a5bd1cb10a5.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Address a test blindspot, the "log" command is the odd one out because
"git-bisect.sh" ignores any arguments it receives. Let's test both the
exit codes we expect, and the stderr and stdout we're emitting.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 03d99b22f1..98a72ff78a 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -34,6 +34,36 @@ HASH2=
 HASH3=
 HASH4=
 
+test_bisect_usage () {
+	local code="$1" &&
+	shift &&
+	cat >expect &&
+	test_expect_code $code "$@" >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+}
+
+test_expect_success 'bisect usage' "
+	test_bisect_usage 1 git bisect reset extra1 extra2 <<-\EOF &&
+	error: 'git bisect reset' requires either no argument or a commit
+	EOF
+	test_bisect_usage 1 git bisect terms extra1 extra2 <<-\EOF &&
+	error: 'git bisect terms' requires 0 or 1 argument
+	EOF
+	test_bisect_usage 1 git bisect next extra1 <<-\EOF &&
+	error: 'git bisect next' requires 0 arguments
+	EOF
+	test_bisect_usage 1 git bisect log extra1 <<-\EOF &&
+	error: We are not bisecting.
+	EOF
+	test_bisect_usage 1 git bisect replay <<-\EOF &&
+	error: no logfile given
+	EOF
+	test_bisect_usage 1 git bisect run <<-\EOF
+	error: 'git bisect run' failed: no command provided.
+	EOF
+"
+
 test_expect_success 'set up basic repo with 1 file (hello) and 4 commits' '
      add_line_into_file "1: Hello World" hello &&
      HASH1=$(git rev-parse --verify HEAD) &&
-- 
2.38.1.157.gedabe22e0a

