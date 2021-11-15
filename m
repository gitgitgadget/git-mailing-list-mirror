Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F0C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48076325A
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346827AbhKOXUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352943AbhKOXSa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:18:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74A8C03E034
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:40 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d5so33564953wrc.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4HtNHb+pCnRl004VUbgrNUf+Bq80g2ymn75VqCiaUg=;
        b=Vrrdo/Vs/rWwuy31tGgGaTkx/IZQhrAK2HEgSx1NHs3u5ihR0KzNbqZgq+Fy/JYap4
         9WY/2av4r1rk6Tpe5h6/pbaLCVVgpJ6ogNgmFg1cvrtLhJUI3zXNPqct0aJnGuMuT9Sw
         aNLJRoJCjgRpABvkvaPL2OXy21lHVysrCmyYBStfY7wA1rcExY9GW6pqZbiJ4Rjuac8D
         x4CG7/jAC04GhKEfKPW1M/41VVlvCXeIN9YCXsLc7XBHXioATfNZQ4u/UwbNf2axVao3
         fDv+Ghm7szAThMg2aKrvl+pEHbsETKcfLQ+rx60+i3rKn/VHvVIY6l5OKSv2lm/GLiQy
         /b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4HtNHb+pCnRl004VUbgrNUf+Bq80g2ymn75VqCiaUg=;
        b=hqa8Q/hC5WjvPaliXkJJiy+aDOzAkOVhFXddk9KbfFcg5D0R1VLqC/5/0xR8JI9i5v
         6iZPCzSE1T0fVZ5fe/DiDPetL5mZMxVNcWx+IbefXQV9mrOXKWRGcSN8NrrUWlyWcC0z
         tVpT+lOvFPsE+vCrZgM/9lpRLevbpw2U5CZMJ50jVenOIXasOvjR+3oRH3Pm1C72b+yr
         HYk+B+xkA2yQRua5N0Fxwnd629lwU1wGx9fUKFWSqcMuO+lVOvAN1L+jt91CMmEIyEEZ
         XdCCc5uyvXYUa2INEtDVlCWifAx+kUEDp8ZCmcOFtT1woz0JAOtxsQ9Csd9P+NTGSmYP
         z7NA==
X-Gm-Message-State: AOAM531iCbtNHBJ/4kCT+yYdhLhT5O9QG0/y4HkKVotTtG8GKvEgWeJ/
        CWP/PDW9eCMcFKaplHj49x2XYjl8UMJqFQ==
X-Google-Smtp-Source: ABdhPJzJ6amBwRPt0yDJjR/FlWUnSS5FiJmmUA2kLKZWbLJVE6h7Ov/ertd9dBdMPw8Ye/PiwInAfg==
X-Received: by 2002:adf:df0d:: with SMTP id y13mr3190755wrl.176.1637014719119;
        Mon, 15 Nov 2021 14:18:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 07/21] common-main.c: call exit(), don't return
Date:   Mon, 15 Nov 2021 23:18:17 +0100
Message-Id: <RFC-patch-07.21-3f897bf6b0e-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
In-Reply-To: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
References: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the main() function so that we always take the same path
towards trace2_cmd_exit() whether exit() is invoked, or we end up in
the "return" in the pre-image. This contains no functional change, and
is only intended for the benefit of readers of the code, who'll now be
pointed to our exit() wrapper.

Since ee4512ed481 (trace2: create new combined trace facility,
2019-02-22) we've defined "exit" with a macro to call
trace2_cmd_exit() for us in "git-compat-util.h". So in cases where an
exit() is invoked (such as in several places in "git.c") we don't
reach the trace2_cmd_exit() in the pre-image. This makes it so that
we'll always take that same exit() path.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 common-main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/common-main.c b/common-main.c
index 71e21dd20a3..eafc70718a5 100644
--- a/common-main.c
+++ b/common-main.c
@@ -51,7 +51,10 @@ int main(int argc, const char **argv)
 
 	result = cmd_main(argc, argv);
 
-	trace2_cmd_exit(result);
-
-	return result;
+	/*
+	 * We define exit() to call trace2_cmd_exit_fl() in
+	 * git-compat-util.h. Whether we reach this or exit()
+	 * elsewhere we'll always run our trace2 exit handler.
+	 */
+	exit(result);
 }
-- 
2.34.0.rc2.809.g11e21d44b24

