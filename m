Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E1C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCHTVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCHTVc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:21:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C35C8597
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:21:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so16437392wrw.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 11:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678303289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJwrPboCwSpBVNE+pKPNld24LcC6F4py1/6nxmBMmPg=;
        b=GdELUSjqfIzwNlPkO9OX+9Nwe+9vtkVkqkrMT7ZdG32TR3Ha4mzgUUG2tE3ucRscFN
         6YCCpZZ631741ZpViTysJSX6dWgeh7unb818mmWxu5F6LMfoDuYthon+huEN8Nb44Az4
         ly0hmoUFvJwBUSsBFr1OKdoOdUn6eipBAoMOlG0HIOMkHxOmmUfuQiKhpgOpSm2ykfnS
         bwhak+TxZjfEr0htjYv53iwt4fNr6pW66s6TsA7BdYn0RcFkVOVMuSU7mrxEE3hgumr4
         R1v7PhFhDlfaCSNMjwjPsp+Y512jPew2luao08YxBCS3KRh6L0MBp9fKHcyK14j8b1zU
         pSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJwrPboCwSpBVNE+pKPNld24LcC6F4py1/6nxmBMmPg=;
        b=3Q0qfUfbLQcA5tMjRxQ7H86+/ik5CqzStxGZYFPhk24faVblZ/k63ziefsNhJ+wJE2
         67QRtXv4LrxRuP7AUrkZNaJbU6i7UgkjobH5B0RPGq7Bcz7iBAPBFr6b+bDBIQvVSPog
         jqTrrja6yuHl6rFGVI6fqLpnuUn7kPsj/FDvpg9pqrL1QOoZxfckogd0lg5N+yGaUvJp
         6XlrVG5nehLjmkVMU3NFEsDfzbgDZG2rNDr6QRC7RNg5SDPjnsdWqUH0upDBnR6B2WQ3
         GY0bfqZZWTr0qQjf4tsQQfNzhecfTXuI7osZaU+Y5qKUWrbJlgJ49eWbT7i13SGMf5PV
         kkWA==
X-Gm-Message-State: AO0yUKXWIlGlBtCn9kyOu7AwVuCIQeksHSx2g0n0muek4/v4MVgZbE2T
        paokkMVcfvuMQnRxlulZlERKg3dBB2PoMw==
X-Google-Smtp-Source: AK7set/0Hw/m51sUVcDwudQA8jpRNyBvHmGYpmZvWBQuEA15KZBsXNKtR5FRG5IJMjjFLtJAdKuBEA==
X-Received: by 2002:a5d:63c9:0:b0:2c3:d707:7339 with SMTP id c9-20020a5d63c9000000b002c3d7077339mr16190450wrw.6.1678303289329;
        Wed, 08 Mar 2023 11:21:29 -0800 (PST)
Received: from DESKTOP-FOQ07IR.localdomain ([2a00:a040:191:d233:88f:49ca:44fe:37f])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c458b00b003e20970175dsm321455wmo.32.2023.03.08.11.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:21:28 -0800 (PST)
From:   Roy Eldar <royeldar0@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH RESEND 1/2] t7508: test status output for detached HEAD after clone
Date:   Wed,  8 Mar 2023 21:20:49 +0200
Message-Id: <20230308192050.1291-2-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230308192050.1291-1-royeldar0@gmail.com>
References: <20230308192050.1291-1-royeldar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After cloning a repository, HEAD might be detached: for example, when
"--branch" specifies a non-branch (e.g. a tag). In this case, running
"git status" prints 'Not currently on any branch'.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 t/t7508-status.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index aed07c5b62..d279157d28 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -885,6 +885,18 @@ test_expect_success 'status shows detached HEAD properly after checking out non-
 	grep -E "HEAD detached at [0-9a-f]+" actual
 '
 
+test_expect_success 'status shows detached HEAD properly after cloning a repository' '
+	test_when_finished rm -rf upstream downstream actual &&
+
+	git init upstream &&
+	test_commit -C upstream foo &&
+	git -C upstream tag test_tag &&
+
+	git clone -b test_tag upstream downstream &&
+	git -C downstream status >actual &&
+	grep -E "Not currently on any branch." actual
+'
+
 test_expect_success 'setup status submodule summary' '
 	test_create_repo sm && (
 		cd sm &&
-- 
2.30.2

