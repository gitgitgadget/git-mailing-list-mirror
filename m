Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F514C3DA7A
	for <git@archiver.kernel.org>; Mon,  2 Jan 2023 11:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjABLEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 06:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjABLES (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 06:04:18 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D262CB
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 03:04:14 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so65925713ejc.4
        for <git@vger.kernel.org>; Mon, 02 Jan 2023 03:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=l1JJ9ODSLgypFqIEVP19t++gYyKh45EJ1tF2Gr5Vboe5dva7numuHQA7pCRoDXMdv+
         oigDwIAmp/iW3mOzcjEaDhEJv4lUy8g6ooJkwChYdNJmH8/t+jrcro5G8LySOj7PL67s
         jo/1oIBtr4Fo83D7PqXz3nlBD3eLQj4SYmZd6iIkVS8kggbdpbTS6LJKCYSAWv7ksnHk
         lnhq1VfumJLVA+/MQo5+wxZhGIUeQ41PGugFIMKkQwqVTdzLgU89EcBfHDXnZKffXeXL
         yx6qwwt+hrf/3equm/NQvoCe8ecdRVStO2Lzx99NQojTLSJZQVmtPlys9UnyKfOXJWTa
         uKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSnD3oj50yMKxc2IjMOHpDrQQSmCGlPi0WGyE394pEY=;
        b=1a3LR3oxCpSGuU11UfXls+JvQdDDSwwp1pwYx5w4+rTlBO/28TZXUsQizVK1FJhAkm
         YN+ERecvNWvfPY7WYWXoL6iH4HBR5AbTDZkv1xqLjHOouY7vAoTc2A1G6WJ1d35cfbEN
         8SZjfFQFfDrhs0BrRYcpWudE3l39d25dj8KnWge+4YeIXAkomTOd/sFxSw/1Me5jkMwQ
         YEK0/xDIruLOs9cHE6rlmWZIfu77GzC2Y2/cn/1SBYBcUzqu08dSh0zty4aWR2IPHZdL
         V8PGngF3SzlCC0pUO7vV7AN6t9EopZLpFmLNdZKxJMD2rNuQpOsI/SjZdFkCxdemHgnI
         T8ig==
X-Gm-Message-State: AFqh2krJSrgbWTb//R6VSil3P88Gvz35qn5viD0o5BYa/XJ9omXoBYTr
        zqtlvqynP95Bhypn3M528XyyUlJaT4dOrA==
X-Google-Smtp-Source: AMrXdXu83tqr1N1qAJRQew2VySNWKCcBPVaHfD0o3pyROjbR4OHjuBqm66gUsOfiyOG2yuTTGFw2sQ==
X-Received: by 2002:a17:906:99c7:b0:7ae:b637:633f with SMTP id s7-20020a17090699c700b007aeb637633fmr46483146ejn.4.1672657452911;
        Mon, 02 Jan 2023 03:04:12 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id m2-20020aa7d342000000b00488117821ffsm6651821edr.31.2023.01.02.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 03:04:12 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com
Subject: [PATCH v5 1/2] t0003: move setup for `--all` into new block
Date:   Mon,  2 Jan 2023 12:04:05 +0100
Message-Id: <622475417916cf48b8fb48e3587f6c87750d43ed.1671793109.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671793109.git.karthik.188@gmail.com>
References: <https://lore.kernel.org/git/cover.1671630304.git.karthik.188@gmail.com/> <cover.1671793109.git.karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is some setup code which is used by multiple tests being setup in
`attribute test: --all option`. This means when we run "sh
./t0003-attributes.sh --run=setup,<num>" there is a chance of failing
since we missed this setup block.

So to ensure that setups are independent of test logic, move this to a
new setup block.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Co-authored-by: toon@iotcl.com
---
 t/t0003-attributes.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f7ee2f2ff0..b3aabb8aa3 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -203,9 +203,12 @@ test_expect_success 'attribute test: read paths from stdin' '
 	test_cmp expect actual
 '
 
-test_expect_success 'attribute test: --all option' '
+test_expect_success 'setup --all option' '
 	grep -v unspecified <expect-all | sort >specified-all &&
-	sed -e "s/:.*//" <expect-all | uniq >stdin-all &&
+	sed -e "s/:.*//" <expect-all | uniq >stdin-all
+'
+
+test_expect_success 'attribute test: --all option' '
 	git check-attr --stdin --all <stdin-all >tmp &&
 	sort tmp >actual &&
 	test_cmp specified-all actual
-- 
2.39.0

