Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6C6C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 11:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiGNLta (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiGNLt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 07:49:28 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09216587
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:26 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10bf634bc50so2095872fac.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nugkGuyEX9x4KpCa8nxt4+B+MIyVPr+tIxWA5PgccP0=;
        b=Ujl1/x9cbRk5sEoApEKObEe4ohRFJT5Aic6L+5rCNiQcpHGZWkU2NXODPWk4Y8pzQR
         w4CLlfLuG7iJW3QsqRdt++fstvqKyWkLfkrqt99gcwXPckqpQptecvMLsatn7sMOwdg4
         fRQln3nIkBD/SBROBHlWbQM+nyD/0P0jQuPuMEFvyLsSo5JfjeCrE2urNEDYOMIdTYj/
         6IA0aOjZ5iOOxC0uUk1RICSY+/1XA0dMzrf61amWr/SioQc0MW5xibUQbBHh95Yc7Y8v
         Wnhwgh4qD5RrW2A7Kex0HBcBGphLTBuRI55KoU/pEirBTJ+thYOkJwYkjebSNSoMi3rw
         T2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nugkGuyEX9x4KpCa8nxt4+B+MIyVPr+tIxWA5PgccP0=;
        b=yy1amBGHr8m7Kd98h+wC7NPm4xCUC9ryM6tPJQ7Y/ZZdGSi3+XBk/aCGB28OwoqawF
         3JPl4fyzRTEafhSfB4oa5pB/pWv1k8sGCGOJlXFf3u5i8JkymoCNl179eL7f9gkL50px
         ITdpWz5rS8cNqyQ8YTjL0Nj5WZ32uyiLlfspci5tnyaEeb6GowtGOhFBDEvQeqU9zv4f
         x86vwP7cH1bWJBrY+PEuA6L6LLIU8F47cGDqjpFgzxkuMDNaL7/4yTPrHiyckn3FQq7p
         3nF4ALvcxKm7AwLdbbVYnUer/XDeGcmeKxOBlWaj0IJNbJyEq4NUJClmuAfEul0J3JeY
         XJcQ==
X-Gm-Message-State: AJIora/VZeIQK9bTK+XWUfrlZTILvhg91v0ojk3M5q0Xq/PCYHZKO1M2
        Yss565P++wn+gUPCot+5rv4iMUEEl8P5Dw==
X-Google-Smtp-Source: AGRyM1uWxzy4EgZDrFyeP0jhOuBwy1hPpsZnQOidepY0U8aOzJaaq7dWDci1dqtyLbmwwFKwC9KTYQ==
X-Received: by 2002:a05:6870:a550:b0:10c:1646:b6a3 with SMTP id p16-20020a056870a55000b0010c1646b6a3mr7042258oal.298.1657799365440;
        Thu, 14 Jul 2022 04:49:25 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id o23-20020a9d4117000000b00616c5ce1d83sm548035ote.68.2022.07.14.04.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:49:25 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: [PATCH v2 1/3] checkout: document bug where delayed checkout counts entries twice
Date:   Thu, 14 Jul 2022 08:49:10 -0300
Message-Id: <694aeb19f57297d9b9d07d47897385bdbedd309c.1657799213.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657799213.git.matheus.bernardino@usp.br>
References: <cover.1657799213.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the end of a `git checkout <pathspec>` operation, git reports how
many paths were checked out with a message like "Updated N paths from
the index". However, entries that end up on the delayed checkout queue
(as requested by a long-running process filter) get counted twice,
producing a wrong number in the final report. We will fix this bug in an
upcoming commit. For now, only document/demonstrate it with a
test_expect_failure.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t0021-conversion.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bad37abad2..00df9b5c18 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -1132,4 +1132,26 @@ do
 	'
 done
 
+test_expect_failure PERL 'delayed checkout correctly reports the number of updated entries' '
+	rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		git config filter.delay.process "../rot13-filter.pl delayed.log clean smudge delay" &&
+		git config filter.delay.required true &&
+
+		echo "*.a filter=delay" >.gitattributes &&
+		echo a >test-delay10.a &&
+		echo a >test-delay11.a &&
+		git add . &&
+		git commit -m files &&
+
+		rm *.a &&
+		git checkout . 2>err &&
+		grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delayed.log &&
+		grep "IN: smudge test-delay11.a .* \\[DELAYED\\]" delayed.log &&
+		grep "Updated 2 paths from the index" err
+	)
+'
+
 test_done
-- 
2.37.0

