Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B237C2BD09
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ECA206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcKb4ACM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFQIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:35 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45950 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFQIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:35 -0500
Received: by mail-wr1-f53.google.com with SMTP id j42so8303987wrj.12
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=8fpKHkrGVyle9dM7aXLs3Ow6RrFQkR3jnzzeRadZEIs=;
        b=pcKb4ACMx374+3ls9J7TnDi1eEGvBphRJukCrf7lromV3LfaRufixhrI5IYDfkbmhS
         tVZzZjPJDwqgAlpRe4C75XQBR7HdzvcCgo0QU35A1dPwFrlAvRpX1Zdid9TEZWmVfAz0
         dmwr/PNJz+or+1v+6kj6+aSBIGaRoDC/16vEUm9tWqjz3rC+eoEhv+WaOEvIkMd3gCKH
         r0qYgVmpChOxSCQt73s8ZsIZ/qo9dTkOWtJ4F5eH0MI8k28XZDgdtpvVraXFNTqZDFkZ
         I6Lob1xUd1RYBT3xLwJrZ5gGy4LcZLeUbikbH+eUEwsT7Wn9M8CXrj21/ol2RfjTOZv5
         oBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=8fpKHkrGVyle9dM7aXLs3Ow6RrFQkR3jnzzeRadZEIs=;
        b=PKbxIWAW6KiMoVslu7GaLcvbVxxBYZ4UiA81PL8/v/XH7gnOz3O4svNRtMXHmto9M6
         AoYwjlzHdpI7TepJMp7sJVpHIbhHa++/BblpNHu1xdeqYrJtuFa6AKcjzkCYwLTStkgR
         SzWg4d+v3ifyEKol5K4wrCxTxCyPsdT8MY5voAJkQGUtM8fYQRmrWNsW1vXc0Vs6vyeA
         EXscqyvh0rhtw2PImq27RVCcba4Mws66k0urDL8us+R0wHyAiK3yBgcirhUDMB8tS8dH
         tnOpBT8f8lDxbH/g8EmnRWLdDGGx3R7nyw4CvAAQhJSraxRBP2KAuJuMn4JBuvVNcURe
         dgAw==
X-Gm-Message-State: APjAAAXvhtvthKF5V8Hyi0YYA3MFUBiOa2Dr+sMXOEtfGueUq0dVC6v7
        M6ADc5UJqo5KQbcLaim8wLu+uZf1
X-Google-Smtp-Source: APXvYqyWVE2RGikZOFKpi/8Oll5jeDamkqk3M7QBmYBsw7ReDVBKNDKS9/3mRQUbD9fV09YPPLsd2g==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr15803197wrr.309.1575648512961;
        Fri, 06 Dec 2019 08:08:32 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:32 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/9] cherry-pick: check commit error messages
Date:   Fri,  6 Dec 2019 16:06:08 +0000
Message-Id: <20191206160614.631724-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We disallow partial commits and amending when CHERRY_PICK_HEAD
exists. Add a couple of tests to check the error message printed in each
case before we refactor the code responsible for this.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3507-cherry-pick-conflict.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 9b9b4ca8d4..c9715bf674 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -161,6 +161,29 @@ test_expect_success 'successful commit clears CHERRY_PICK_HEAD' '
 
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
+
+test_expect_success 'partial commit of cherry-pick fails' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick picked &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git commit foo 2>err &&
+
+	test_i18ngrep "cannot do a partial commit during a cherry-pick." err
+'
+
+test_expect_success 'commit --amend of cherry-pick fails' '
+	pristine_detach initial &&
+
+	test_must_fail git cherry-pick picked &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git commit --amend 2>err &&
+
+	test_i18ngrep "in the middle of a cherry-pick -- cannot amend." err
+'
+
 test_expect_success 'successful final commit clears cherry-pick state' '
 	pristine_detach initial &&
 
-- 
2.24.0

