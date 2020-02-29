Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D884C3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 01:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA3924672
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 01:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eocGvgXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB2BKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 20:10:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37359 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2BKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 20:10:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id q4so1900982pls.4
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 17:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9vyFZ9AOasmOv8XaQx1TebfX4hQ5a1ljxbG7UIhzIU=;
        b=eocGvgXhdVARVKTheJElDChjX+ZToiY1/3cVIKGt+9JBKW052GpAFB4WQL49+OQzA4
         YB5ufz+yTdJ3YRj2QFPPTJMfbzaKT1R/3MrjKnckRkNJ1yqfKnHlQglM+Ue5aa86EP+6
         Y5U2Ka9H9BAPmF4c2L2mLff78MoI1R23SyWUi+OXoub2RSiirhvdt2bSKb8fgN+bEFSD
         EzuVI9w6pRPfJLBM1/MhXU6rzYpJT2BGebvXNep6kq0ugzvwAepEqcEMX0FDuxj2Aff4
         netB/611w76ov9hNXcwkgBkNQuLKnFzSSCc5Cmc27xTT6aw9H+lnLJKGZbtFrXJY4znj
         67Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9vyFZ9AOasmOv8XaQx1TebfX4hQ5a1ljxbG7UIhzIU=;
        b=F48iX0THPQms6e8ya8o+9dm8Wn7DCQ2io+7g8Mprlz2EeoK5Avjo1CRGD7Uwt1SW4X
         A9zMvn3ZoV9xJKk/XCIl54ywFH3yMD79OmSo4B4TfSHc3oHUA0mIxQchorqrIYs9tw7W
         rssMAOrwbLFV1SYQuk005xYyol3jG2N5hHXNWXh9lg/Dz6AoOsxPbeLvk6L1s07try0U
         O99pgKPDXHfBym9TG+QrH1xFB6g9s7F+auB8XfBkNqrPh2YrB0AltXcOVF6t8qwoOjg7
         JbQZuUheOZTqTwR6rY1Pf/nb/Q+a+SEyV7FpBhbjgEGXq9DPahFmXya609wl4K0alpg7
         zdoQ==
X-Gm-Message-State: APjAAAU3Y0qny09RzvLucsxNL64TCUBk2EqY1pFcNq0v5OUaHGEKH7EN
        bBCXAGF2Wkq+rJKzGYUNZvKsQ7hs
X-Google-Smtp-Source: APXvYqzVoWcLhQkEE7cbslMel6dvA1wqDC0GKGyUq/SMOtq47DVDm2xd4tGezDPkp+UU/SqWRdXccw==
X-Received: by 2002:a17:902:ed14:: with SMTP id b20mr6746881pld.197.1582938650770;
        Fri, 28 Feb 2020 17:10:50 -0800 (PST)
Received: from viper.uconnect.utah.edu ([155.98.131.0])
        by smtp.gmail.com with ESMTPSA id j8sm3596401pjb.4.2020.02.28.17.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 17:10:49 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, gitster@pobox.com, annulen@yandex.ru
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] pull: warn if the user didn't say whether to rebase or to merge
Date:   Fri, 28 Feb 2020 18:09:27 -0700
Message-Id: <20200229010927.335119-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Often novice Git users forget to say "pull --rebase" and end up with an
unnecessary merge from upstream. What they usually want is either "pull
--rebase" in the simpler cases, or "pull --ff-only" to update the copy
of main integration branches, and rebase their work separately. The
pull.rebase configuration variable exists to help them in the simpler
cases, but there is no mechanism to make these users aware of it.

Issue a warning message when no --[no-]rebase option from the command
line and no pull.rebase configuration variable is given. This will
inconvenience those who never want to "pull --rebase", who haven't had
to do anything special, but the cost of the inconvenience is paid only
once per user, which should be a reasonable cost to help a number of new
users.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2:
- Use the commit message that Junio suggested
- Drop "!= 0" from the if condition
- Mention in the warning that --ff-only will also suppress the warning
---
 builtin/pull.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e00..96512a4b27 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -327,6 +327,13 @@ static enum rebase_type config_get_rebase(void)
 	if (!git_config_get_value("pull.rebase", &value))
 		return parse_config_rebase("pull.rebase", value, 1);
 
+	if (strcmp(opt_ff, "--ff-only")) {
+		warning(_("Pulling without specifying whether to rebase or to merge is discouraged\n"
+			"and will be disallowed in a future Git release.\n"
+			"Next time, run `git config pull.rebase (true|false)` first\n"
+			"or pass --rebase, --no-rebase, or --ff-only on the command line.\n"));
+	}
+
 	return REBASE_FALSE;
 }
 
-- 
2.25.1

