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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF82C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2348064E2F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhBRMbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF0C061797
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l17so2478232wmq.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bgtr3f/MeCnD/j7PjA4vMCRDeAni++W3VFiTwiq3ZM=;
        b=fZcGPnnETfu0EaN74aZaiqE/L1MesLwSweu+FYvqH3eiDUf0kWLaUts/lRbzcbkXuG
         xAamswUOsE/IQzAhsHBnrNvX6hZngGFO8/K5EExldOmyvguvgi8IPxP4o4JpQZYCbyYO
         bE1O5YwLYKA6C/ugT5Uxyb+ohrxakQNkUL21PxQ22O5yUBq8xINtXmAXDYqu2Opujxdb
         H+aX0G8bRFheCRUsBGnrZj+6kq72GzESA0cpWwkTDbP4wYfvnZTsy+/DvuPHH6w4rusk
         UOq5uctM5SA/tCUw69HZttOp31RTtO2gUP+huEJn0wlTnCCt3Gg1tCB7rKdPpd/i+R5D
         e1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bgtr3f/MeCnD/j7PjA4vMCRDeAni++W3VFiTwiq3ZM=;
        b=nQfj5Xx0RSabm+puar0ClxBYXXoaKAsraZcv9wZKAkTWucBRq6M1B+0NxGjRlFYb6E
         EP99V0+pyQTEVduhsxNmSWrl/V3jwPTjOvdsY9t3KDnHx3BX81OG1DQAqilVSWPzxj0j
         wX1bVuGZzIZJm0rSn4o8YEYr6aPjKKaL3NvpgUmx1HJ45fN9Nx/Ni+Nvan8TdE642iQL
         AUDEfsN3/IKjCocmDJTEO7CmUmdzBXXoo8Ww5NbJiWXDod/5FOW+dOAFsMz1dfUURGoZ
         bV95EculYAtZjU1hA+4iS1RwIUPc+GqQuXY24/fR3sQg5PGs0fc43nLpEapEWDxWw9X9
         yzIg==
X-Gm-Message-State: AOAM533t+JsIdC1zt+DkwDMxvD+xR1zm4SjksXV20xFyKHzcr45lvU2u
        tBOLhSwqkMAt0IDABZ93ZrlthcOxmACnXg==
X-Google-Smtp-Source: ABdhPJw3YdlqI5v9qJo0YXCsgQPCfV6SqDkAaSkR/A58XybkK0tL/k+18jGht9zoSkmcuYxmGDLHPw==
X-Received: by 2002:a7b:c410:: with SMTP id k16mr3093957wmi.48.1613645928710;
        Thu, 18 Feb 2021 02:58:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] fsck.c: call parse_msg_type() early in fsck_set_msg_type()
Date:   Thu, 18 Feb 2021 11:58:37 +0100
Message-Id: <20210218105840.11989-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no reason to defer the calling of parse_msg_type() until after
we've checked if the "id < 0". This is not a hot codepath, and
parse_msg_type() itself may die on invalid input.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 00e0fef21ca..7c53080ad48 100644
--- a/fsck.c
+++ b/fsck.c
@@ -203,11 +203,10 @@ void fsck_set_msg_type(struct fsck_options *options,
 		const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
-	enum fsck_msg_type msg_type;
+	enum fsck_msg_type msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_id < 0)
 		die("Unhandled message id: %s", msg_id_str);
-	msg_type = parse_msg_type(msg_type_str);
 
 	if (msg_type != FSCK_ERROR && msg_id_info[msg_id].msg_type == FSCK_FATAL)
 		die("Cannot demote %s to %s", msg_id_str, msg_type_str);
-- 
2.30.0.284.gd98b1dd5eaa7

