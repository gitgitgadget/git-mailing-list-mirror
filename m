Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A64C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4FF61106
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 17:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhGKRJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 13:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhGKRJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 13:09:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28959C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 10:07:09 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s23so5957186oij.0
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kv/SBv4nLb1OPXOsxk3cIYbzgiiHeTPd3uFDjvhmYk=;
        b=mnhIQB0cKNYJD4RHakyicRymbCwH/2WPWkzlAJiixJIIrBxIqtiv1wXH44Xj6qJ3WW
         5T3f1mtgsOpKrJALbbTAg3V/Tyty/MeXd2vNA1m/ONL1J5kA+PYH/oiHwQKURnmw4xTJ
         5qs6+dO/TjEni57z8MiYss0lgvWF3LHN+xCkg2s6dWrKEORDeqZvsoxdCAEFnRWndTTp
         lnr3YhNekMdQX7RNcgnzW40iVegihlu3t7kKoWFOr6cr8aodJQ5N3WwY4iUWiJuQ/vXi
         pIW082w4Yo9u6ly3qmDC3o6FhRtejov3WBSB0iAqDZQa8jfLTmgEo/T5RR/OWcLyWTSv
         pWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kv/SBv4nLb1OPXOsxk3cIYbzgiiHeTPd3uFDjvhmYk=;
        b=dWe7QcWpo5NET+01sP/eCgDLqEAKGCVKW4dkwRy9s+Tlo8K9kWN4TPvk7N//g1F1QM
         6ZPLDAweHDwFLKEq6HPJHmRxekPOHv1l0R4Fh2TmLpOqC24xVqiEzcApQE1qcUUTv26G
         0Glidqa4235TU2OS0L1aCRZo0I0ROvgGdqdolWH9LWNd4fFggW6F5rwH4b091HRpzxII
         KrFAaZdiWhyyKwsY16P2wXYKxKT5m8WpjCTksuSAn6Go906Z5rkVKw1n2iPWwAEnb1G0
         6EJTsfqegPl82KWYtiIsviBi5IiMu+8gaZGqrclx3KRENHLXkZBbE8y5OvffaFw+rNh6
         7xXw==
X-Gm-Message-State: AOAM530odthmhfWkSpGf3BWvfZrpE3tXLKK6pNJwEJNvTeTGtoZIqAR3
        HzLj7jfWAyOE2048Lf+/yEPpLfw3daCQ/A==
X-Google-Smtp-Source: ABdhPJwxzp4QFnQPRsm2h58JLQkoNln2BnmuIv8a3nV+Td5fQQI5vUU8gmDUIsgXLmPoJpAmYSBvVA==
X-Received: by 2002:aca:c7d6:: with SMTP id x205mr11600537oif.92.1626023228223;
        Sun, 11 Jul 2021 10:07:08 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id y26sm266749otq.23.2021.07.11.10.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:07:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: pull: add test for disabling pull.ff=only
Date:   Sun, 11 Jul 2021 12:07:03 -0500
Message-Id: <20210711170703.651081-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.172.gaf9b24eeb1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The advice clearly says it should be possible to override pull.ff=only
with --rebase:

  You can also pass --rebase, --no-rebase, or --ff-only on the command
  line to override the configured default per invocation.

Since the intended behavior of `git pull` is very easily forgotten let's
add a test to make sure it isn't.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t7601-merge-pull-config.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 52e8ccc933..72164593fd 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -183,6 +183,12 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
 	test_must_fail git pull . c3
 '
 
+test_expect_success 'pull allows non-fast-forward with "only" in pull.ff if --rebase' '
+	git reset --hard c1 &&
+	test_config pull.ff only &&
+	git pull --rebase . c3
+'
+
 test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
 	git reset --hard c1 &&
 	git config pull.twohead ours &&
-- 
2.32.0.172.gaf9b24eeb1

