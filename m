Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E13C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 14:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349329AbiA1OgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 09:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349324AbiA1OgR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 09:36:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D653EC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 06:36:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so4224588wme.0
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 06:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D30DIfhmZ0nxmVsd51h1NAFgy9YU9ZutQyTdZu/0GKk=;
        b=URgLRGrLOQ62uuaOYSd7cXW14/VQ7Hk68+cJAbtCBISZXGMOF7WUmL0lZ4KKay1PUf
         /Ys+hiwg4iiZKp56Ig3jjelYrajRQUhfva57DoDdtlc7tCfWBoGqpC16DSC2PHlj6TPy
         alrET5QIKBSuEQW7kOyKbzQ+3f2DhX8KV0UiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D30DIfhmZ0nxmVsd51h1NAFgy9YU9ZutQyTdZu/0GKk=;
        b=7630UW+TDY1Huv7ljKHbEpuab7Al42IvY2vjGvVTIgDINP7oBcbbv6a8W5Bo1LT6XF
         cVSWWLj3cIdDW12KkJcF005uZoPQ2ooU4J3BYfKxK0DzZz3fxmdwCLuFL2+riCMW8cfS
         wEzBsoiRIj0cjKNEwFGM8ykJYaXJEbCJLFb6TCTfFLO2fqbPtVl6RmyE28x3NCWbPoOw
         5MgS7lS+J9QzR//pNOx0Lx3YpnBHJAmyvp6nAvAVG7rqlfNfxba1v9YB2gJh80TvXSuQ
         dX/fGm0ZgbcfcY9xdG7HBNEwZFhpsX5BWwW4sOf71OOXtY1gGP8VciMeTGsu29Od8Fnl
         FZIA==
X-Gm-Message-State: AOAM531WAhLcRDuSn17TI8YLDoOD7+WPZKWgCmtqjNIYM6kGsp5nOHDg
        4Dx8Esp5eJdtk++dsURQ3rPXMJm1oIDh7Ru2
X-Google-Smtp-Source: ABdhPJyMdwRzNOuWob5wINsCRhsefJ2wBUNjTNYK6FJrZe/ig9u4d4vPcIud/1fsooM1UBlPp2BYnA==
X-Received: by 2002:a05:600c:4186:: with SMTP id p6mr2957172wmh.97.1643380575045;
        Fri, 28 Jan 2022 06:36:15 -0800 (PST)
Received: from otata.home ([2a00:23c5:da95:1901:307e:402b:1d92:5628])
        by smtp.gmail.com with ESMTPSA id y2sm1991008wmj.13.2022.01.28.06.36.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jan 2022 06:36:14 -0800 (PST)
From:   Robert Coup <robert@coup.net.nz>
To:     git@vger.kernel.org
Cc:     Robert Coup <robert@coup.net.nz>
Subject: [PATCH] fetch: fix negotiate-only error message
Date:   Fri, 28 Jan 2022 14:36:02 +0000
Message-Id: <20220128143602.31842-1-robert@coup.net.nz>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message when invoking a negotiate-only fetch without providing
any tips incorrectly refers to a --negotiate-tip=* argument. Fix this to
use the actual argument, --negotiation-tip=*.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 builtin/fetch.c        | 2 +-
 t/t5702-protocol-v2.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5f06b21f8e..af689a72a8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2029,7 +2029,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (negotiate_only && !negotiation_tip.nr)
-		die(_("--negotiate-only needs one or more --negotiate-tip=*"));
+		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 710f33e2aa..59a49cede7 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -619,7 +619,7 @@ test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
 	setup_negotiate_only "$SERVER" "$URI" &&
 
 	cat >err.expect <<-\EOF &&
-	fatal: --negotiate-only needs one or more --negotiate-tip=*
+	fatal: --negotiate-only needs one or more --negotiation-tip=*
 	EOF
 
 	test_must_fail git -c protocol.version=2 -C client fetch \
-- 
2.34.0

