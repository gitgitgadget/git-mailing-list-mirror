Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5776C43331
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3BC65030
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhCFLFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCFLFE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE4C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:05:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l12so5240915wry.2
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Gh33eEWIwKhmpVG7Kza0ShY02HwXZ29hcx1BUxzzv4=;
        b=qnTIoTFHLVXHdsL7EfG/Lxyu+d1xp4nYQnn8lLrNxM6AUA0xic1bYH0m7G1sTnDK5O
         +TwYe0EiNQT/YUwpmuAb3cKEq8p3xRbKtl7mmFMjhDf4pC6SpB++yuzItep/gFyXp+Ch
         Z9f8fSuN1QI9U0GQqL4BIJ3dVR/Gbledxv+RG4ek0Xlxp0fWxO2XSseaqCPXdZxDcxen
         NoitAQUWjg/OfDHhpzjxyumRFx7UNtjX51DhO9/wJ3bE3r+zXjn22lnTSka7RqFMlwrr
         S0mTtatPtIQ8vFjnoWZqNmpoicdbCsOB2+w/gEEufzEX8bok7Bn2rvKoXdvQgpvd/uou
         YEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Gh33eEWIwKhmpVG7Kza0ShY02HwXZ29hcx1BUxzzv4=;
        b=gg2Wl2XqaPA09+iSq3SUQneteXyyzZMhV469ebUrjpBZ5WMAyMJPl0rPNDQ+JxOg19
         SlJGT7xORNl7dH4vALjiI38iAtqOp35nQgoy29w4yj04H6idn19vXNmvTcGS+ZLpkA69
         dryUaAH93Ixf0FH4oEcbvClb3GTCHH0WZa2l+I9T+FtLtRkzo1TLRILwOUv4Aw0vVw7j
         VSFbRj9Cocz9WbXy+SQMh6jXBLAP82RzG0Wu5IhJVhCDF557XFW2ChFqijVNPgle6OIT
         HUYqe8eO66xQhTUL+juTqLGGUUk4bgG6ei0BI60gxGtBDk+fyXP0MAzxg0DNaJp/TKLj
         IMIQ==
X-Gm-Message-State: AOAM533YcY+7AMaHDKf3ajnhTvzw7VnUFWN74Fp9Q9hqHGQEj/8YDx4C
        +D6GmdRIjcH01v05gAzw+XuKPH86pQt0Mw==
X-Google-Smtp-Source: ABdhPJwBURYcjZ2bV+kxoGbxIpLeMrAp2eD1we86RusJYPqWSxbvzhmfty9xUsn+vdrVZOlbWwc8GA==
X-Received: by 2002:adf:bbc2:: with SMTP id z2mr3899807wrg.180.1615028702775;
        Sat, 06 Mar 2021 03:05:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:05:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/22] fsck.c: call parse_msg_type() early in fsck_set_msg_type()
Date:   Sat,  6 Mar 2021 12:04:30 +0100
Message-Id: <20210306110439.27694-14-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
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
index fb7d071bbf9..2ccf1a2f0fd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -201,11 +201,10 @@ void fsck_set_msg_type(struct fsck_options *options,
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
2.31.0.rc0.126.g04f22c5b82

