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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B136C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840FD613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhGEMfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhGEMfG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:06 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C121C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 10so5848845oiq.9
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zYK1vo8yAGJAYsE54/EftO3GuwM2BwPMDk5g0aNvWI=;
        b=LX+Au4PbUaiH3ZHzmwaHVGZyBeBS6zvPT3nV0bvpCPFGIc2KeK8Qn2l64TPk3otZhc
         Q0FpviLNlOcy2Po/TdliIgcbRus4jF/tnl+ipUADI1oZFku0Z9++ZMUDHDt5DYSQk6GT
         8+Qb7tucpCMxw/V1140cmdp2DAexQZ2SLVTexuOppNFRAiMBYVemY/cz4mzL+xWPx4Cp
         mdSuasnXpP3o6TwChz4nDcg245i1yFbpnJpBVTvrLImLok1eeFqVKqNohDpIOyznP9b4
         4jn70AtzRQgfVWDE+QsMoy6OwTB3BOJZ6F++uE0TsMJfdz+vytZ/dIevrO6MUXASGZAs
         b1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zYK1vo8yAGJAYsE54/EftO3GuwM2BwPMDk5g0aNvWI=;
        b=fe/oTOGEF60+MWKFHuOuy6UdK7kprJwRR3F1LTSJBwgVHplgBxCx4a2XyIbOLb5oDS
         0vSsF/FXTkKm1H/YJ+Qw/zjvqM1UpoKiYfIL9xvj77RCoZpttmXSQ8+ilIIt8uolSgdR
         8eAroxEPsc7TYlydgudtx6Y9Dv3Z7Iq1h4p0RdtMhOjtxP38sJOPz1LpwZUabQP+3qqS
         dWn68P9gWTrx/qTQjYChPl56oVsS2aJ6Fu2E5Fn8aUIWd6p0IqYTrdu5ZtK7+Mfc9RQs
         8uAWGzp39cyClrfLv9nXHd8z/Pp/wFFViFU95HNiMs+9ifmyzP9SkQYCLbpNUh0ItFw1
         DjdA==
X-Gm-Message-State: AOAM530UmBJLXa2weGONlKx1gy55s2rdsE0lnn6vNtPz9QaJHarNATZx
        6hP1QkCtWO8hut7Ir9TUuCjV8UK1BaUFDA==
X-Google-Smtp-Source: ABdhPJxPziNpJyyxntup7t/Br3rKoP3Yct42ZQuwmpGuLEGE45C9nMDDSVbiYK1EhmFRSPn7ue953Q==
X-Received: by 2002:aca:e107:: with SMTP id y7mr10151939oig.11.1625488348535;
        Mon, 05 Jul 2021 05:32:28 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l7sm2619150otn.80.2021.07.05.05.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 10/35] update: add --ff option
Date:   Mon,  5 Jul 2021 07:31:44 -0500
Message-Id: <20210705123209.1808663-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the default, it doesn't change anything.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-update.txt |  9 ++++++++-
 builtin/update.c             | 17 +++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-update.txt b/Documentation/git-update.txt
index 54c49c5d12..df778b7ef4 100644
--- a/Documentation/git-update.txt
+++ b/Documentation/git-update.txt
@@ -8,7 +8,7 @@ git-update - Update the current branch to the latest remote
 SYNOPSIS
 --------
 [verse]
-'git update'
+'git update' [<options>]
 
 DESCRIPTION
 -----------
@@ -22,6 +22,13 @@ the update operation is straight-forward, but if you do a further `git merge` or
 
 THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOUR MAY CHANGE.
 
+OPTIONS
+-------
+
+-f::
+--ff::
+	Forces a fast-forward.
+
 SEE ALSO
 --------
 linkgit:git-fetch[1], linkgit:git-fast-forward[1],
diff --git a/builtin/update.c b/builtin/update.c
index 1a69896aa8..34681fe21a 100644
--- a/builtin/update.c
+++ b/builtin/update.c
@@ -7,12 +7,22 @@
 #include "run-command.h"
 #include "dir.h"
 
+enum update_mode_type {
+	UPDATE_MODE_FAST_FORWARD = 0
+};
+
+static enum update_mode_type mode = UPDATE_MODE_FAST_FORWARD;
+
 static const char * const update_usage[] = {
-	N_("git update"),
+	N_("git update [<options>]"),
 	NULL
 };
 
 static struct option update_options[] = {
+	OPT_SET_INT_F('f', "ff", &mode,
+		N_("incorporate changes by fast-forwarding"),
+		UPDATE_MODE_FAST_FORWARD, PARSE_OPT_NONEG),
+
 	OPT_END()
 };
 
@@ -56,5 +66,8 @@ int cmd_update(int argc, const char **argv, const char *prefix)
 	if (run_fetch())
 		return 1;
 
-	return run_fast_forward();
+	if (mode == UPDATE_MODE_FAST_FORWARD)
+		return run_fast_forward();
+
+	return 1;
 }
-- 
2.32.0.36.g70aac2b1aa

