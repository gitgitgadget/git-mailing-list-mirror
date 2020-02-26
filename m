Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3D0C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4A9222C2
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El3sN6HX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBZKQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34444 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgBZKQU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so2270465wrl.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SnT74Enlxv8HE4//5YhW4aF0hAlv10LauSUC5ad9zI=;
        b=El3sN6HXCWdl1c0vLQIKUDyBKEyd+qqxxg4rUH89GEPTf/skyb3RdoKaYcbiS91LYu
         SmXU0HelJyymBCPfKSa1mJwnRrleOU7h7rZQDuntmx8ZbodX0vlDUiSvNG8tWypa9MLL
         pMY5aoL8LW1pVGoVp4yuHkBv2ltG/U4FGTSY5KknzFkKS8HqPhDYNpZ3ubJ0y2xhWDye
         vXsPFKaq15DPNv8z0/rhBitfGVCU1Dhw+hmC5rAVvBgsXqGcSRMK2i/qP8HZlYoJQHA6
         QukRbfR9DWGTrYROPMKBNi+hHNyycJzEFkz+ua/OWf1KZwbNpyY7BNN5Nq8RmM+9ZGtr
         pr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SnT74Enlxv8HE4//5YhW4aF0hAlv10LauSUC5ad9zI=;
        b=Ee78Kn5+0ebCbCSwIP2HBsTa8ani56AQycBg1KZI0f34UnjjnGNkkDxr4Dpu9GPg6C
         o7youMO7UrMx61ywC+TIJqKRX69ahKH5yOpPAJl8W4TlrtM3o5FuPGwXiFvnFk+pHfZs
         cAUIizYkjWm8wj75Z5PFsLGv3K8YCyLCUvuQNO0JZlqzSeZCfCvfhwKnDfPzS/Nmnbhq
         oD9Mqluyv90qGTdC3ZmmtzvkAK4WWiSMrvggr4yQMfssFgwnexbC+AfA402ermzrVbGW
         44GuQqsBua+3up6oaRE64gcUZaBuJaW3k+0rdKs8ZmcC4u9dfM330vI3LDEkZYBfC0od
         ye/A==
X-Gm-Message-State: APjAAAVSR1CTFZSa4H7F1L2Omp9PvghAtLOKA+ZaCwr6UOS2Hag/ARtz
        s2EJPM61XQH0KL+PM7IMUkgA6imdq3w=
X-Google-Smtp-Source: APXvYqwybiAJaYrzBKcX03sRmuaBws8y2lFDhwRRgCmuLZilBgX3i/ZJNfU8sZP7+OeaftCSWRwI3w==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr4383907wru.427.1582712178673;
        Wed, 26 Feb 2020 02:16:18 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:18 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 09/10] bisect--helper: retire `--write-terms` subcommand
Date:   Wed, 26 Feb 2020 11:14:28 +0100
Message-Id: <20200226101429.81327-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
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
index c2fd3ee1b3..650ceefcd7 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,7 +20,6 @@ static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 
 static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -906,8 +905,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
-		WRITE_TERMS = 1,
-		BISECT_RESET,
+		BISECT_RESET = 1,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
@@ -920,8 +918,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "write-terms", &cmdmode,
-			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -958,10 +954,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

