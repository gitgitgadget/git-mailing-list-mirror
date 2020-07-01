Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F0FC433E3
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0190420760
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn/RgKGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbgGANfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgGANft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9078EC08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so15804269wrs.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FuqbPT995bQBC22i6nIMpjMilS0Bnmx5rLqItIgpbfs=;
        b=Hn/RgKGWSvi/igpPsCh9Ugoq0v407LTOjNn4SXueQxe8JLnIuWru4GHAf8VIFZltvM
         0gEF54mROEKRPpuPZ1ko+iWRyvk3wjsUNtAoi9mylR/8+QeX6O/E1BwHO7EQO3NYlWRs
         7LRDv86Ykjj7kiR8PVkis2pOMSmr6foCRPdbcisii3jabok0jxigLaAcQ1LRlRE7o4TJ
         5qNLpwgfBdvLVKK7JCc4XkIdvzErjHv7n77yc1YgGxzg71jf6ZFv88G8YG8I8FJ0TSDr
         4wT/FLud4z6w85K6UTg57cz/+qOInocWjrY5Wgdbq9WdjK5t+Rw98J6Wlwup9ctQJ12L
         eFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FuqbPT995bQBC22i6nIMpjMilS0Bnmx5rLqItIgpbfs=;
        b=tfhBM801wPGaJe9MIl4DpxulYWF8kN0RX5fCwnX8Eh+o4sUJvS9KY2orEMqh8L4/zX
         Q13qs4Nds8gQ4h5fj93edkMouK9UMF1Ae+DhIBWO8MPFFK8ARP21xTI9Id23DtLQRXgX
         PTsXXVwCau5ALZzSch36TYuItQNvogDgMav9uFU/blhwTVDoEtkXr81wFhsL3+66Tw3b
         VUdxayvKaTHLoFdhRM+6jMyD20I4slksOpfFEPAAVLXVeSrrFHOl91cx31KHYY3uQftP
         tqiRkTi2Zu/GW9WJGEXjFBqE7JTFoOAQZ0HE45F01/KKz/H+kGCzsrvUzrQrj7yFjILv
         Pj8g==
X-Gm-Message-State: AOAM533h3jIyyumDo+jzR7VvcaixOngZWfxreQbFaZ9pxFlqnbj9BTRg
        JFy3zs35LJRCn0nG6dUiUfGHoaj3kpeeJw==
X-Google-Smtp-Source: ABdhPJy4sI5J2jac3oReUjai6wz7jbPRXSS8sWCYBEc6w9MyT0NPJOFMmNcqN7p1IB1ZtK3axve9PA==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr25737369wrm.181.1593610547002;
        Wed, 01 Jul 2020 06:35:47 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:46 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 12/13] bisect--helper: retire `--write-terms` subcommand
Date:   Wed,  1 Jul 2020 15:35:03 +0200
Message-Id: <20200701133504.18360-13-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200701133504.18360-1-mirucam@gmail.com>
References: <20200701133504.18360-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--write-terms` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function `write_terms()`
is called from the C implementation of `set_terms()` and
`bisect_start()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 874f8c38c4..ca9d27b005 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -913,8 +912,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -927,8 +925,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -965,10 +961,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	switch (cmdmode) {
-	case WRITE_TERMS:
-		if (argc != 2)
-			return error(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
2.25.0

