Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC4FC33CBA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44144217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We8Ve89p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgATOi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37499 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgATOiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so29888244wru.4
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkIG+TgGuReEDBRCRuROnJGRBmrj5UKSDbP9LCNLUjQ=;
        b=We8Ve89pRYZYIWq7zynWfBmRio1hIwggzb27jZy8bGp4d1VY5ijXTGsgrvPL0NFiwL
         QSOzEeY499MRcVAGGNv1djpmBPImCgak8vl1OBJxTCnAtnTsdlNnxIV81AI/HRApWYGl
         Es8RTnye4fE/kBzxm4DnwqTl+RMewASRxmM2bHIDwUo31JHzaGVaO7sBGjEcQXk8jQXn
         07uQmEbxAyPslFGLTJB/z7JBFJjvIuE35bMdRpBa+3072+K0DJmiDsuRJCvniDUf/86J
         iJ8TNr0hpN253PHzxFG0IHs08+i42D/4PJ6ygpAuAsPZufLcqbgZ/4TLLyaSeDPQP448
         vurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkIG+TgGuReEDBRCRuROnJGRBmrj5UKSDbP9LCNLUjQ=;
        b=Pgn8SKERYLZDqAYpWkRtKnGPRwMBfAbSpfkQZKWpDnq6LX0KZVbuc2GxGQjVCfSuei
         iipoaYjCji20NtnKI7a+pGjAxluF5eaDaWl5c22cRFV2FAWlHQB7W8ebB6CGOXs2tk99
         2wiQ6Z32VPVpupCKAZQybBuPM/sydo7Y31hyZBmSZFJgF7BO/KTOoCAgZwLvCXvuHNi5
         YEosR5HBFiiM+tJ6gStLPTOH5piGtKb+pnPGNmysdtBsWPQoGGEGUgDO8+Tz9d8ur9WS
         atVfjjWQD1B3ZmTr+BjwUBkSuIuuu2AwIiyiEB9aVZeklR09bAVRhpacE/7NZ0KPpQWn
         J64g==
X-Gm-Message-State: APjAAAUFQStYT5NWGhSvNpw9onpvre7sHPB2XK3J6ewr9ZrpmGYL/iwB
        83AWMPPivRAIXtjmxK7VdPtUWyigTHo=
X-Google-Smtp-Source: APXvYqwU2XBsf3eB8xZUpogfYEWGnxgk2U1Znuegqksi1R1tTdJcJ2yvkEwKgjBy7zChuR70CBxnqw==
X-Received: by 2002:adf:a109:: with SMTP id o9mr18740593wro.189.1579531130525;
        Mon, 20 Jan 2020 06:38:50 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:50 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 18/29] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Mon, 20 Jan 2020 15:37:49 +0100
Message-Id: <20200120143800.900-19-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

The `--check-expected-revs` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`check_expected_revs()` is called from the C implementation of
`bisect-next()`.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index fdcc5f47ec..3868d34a29 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -897,7 +897,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -913,8 +912,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -955,9 +952,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case CHECK_EXPECTED_REVS:
-		check_expected_revs(argv, argc);
-		return 0;
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-- 
2.21.1 (Apple Git-122.3)

