Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D06C55194
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55984208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Detnx1zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgDWHJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgDWHJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AA2C03C1AF
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t14so5478598wrw.12
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=esI1Ng8e5Z7BGgJcjrZLm8dM4R+mAX73nBXE1MnJiSs=;
        b=Detnx1zOvO+a7AGHB6H0hFTtUk7EnJBpbcsEOTHiwBNfL+BnDamRuZF+wPB4Znm5BW
         OOXgdWpu5QFPiAkSetfM2EJCSzQcLxCU/ui/D4QQEWJXv28Gh53K7mMefiS7LqI7Fhzm
         xTMzS47D5u/pperArRI1C9IP8iIEhwLzTg5X5VTlaT6vE0+TH5YutZX1v2U7jbGLFMdH
         dA3RVYyXnpTLhqmKWOjEVowl8Ai/2AKDy66lyEgPhIJxnP+G2RtgUgpMVnRmZUyujnSG
         DmMbE0l7Gl16xVNkI6jgajtp0RAX+ga1gMCu1BdSBxS9vJku6jt91ZkS2gUaRHnqwRq6
         JAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=esI1Ng8e5Z7BGgJcjrZLm8dM4R+mAX73nBXE1MnJiSs=;
        b=dj6xlJtG7012eqDP86L9dwv2CeasLhtzLznAoAAxlnHPMJj50P2Q27mJT0jJB7V7hR
         GL+PL97hHyWgJKlWBbczWkgIJ6Lpc+W8Jzunm2W5BcMqMSljUmyXSO7lMktY7unjNK/C
         CpyDSp6aGhV1Da1dTCnSDaRAUUyWWgOGcz3xRFsZD8HX9bZFOk8XWgh8qWbwUYj2XOLm
         3K0gjTRKNoRpnYdT9oF3UCait4wyUfO9yWYBlxKBTD46bQODHdfEUHhxQbJ/kIEtX2Ut
         iWoa4Mip2mV98Ncemo8B4fnYKcuuu4feLu7FS8l9UKZHLgJel0se836T3Crj+CWMCtij
         RTNw==
X-Gm-Message-State: AGi0PuY7HSi8DHJAiPOPqiKe5fK2K0fgBQy4jaJNU3z+9Tl3YJcfWESO
        B7aWUA7FyA1du31Xl9zHJMOY4XhOWzXWow==
X-Google-Smtp-Source: APiQypKtSOj3ta59EwrgCOqJkgrrpmYrgbIDWHb7cUXIcG9aW3MSY4s6kjCcTaSgLG0tCId9DSL8PA==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr3107700wrm.287.1587625787381;
        Thu, 23 Apr 2020 00:09:47 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:46 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 10/12] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Thu, 23 Apr 2020 09:07:02 +0200
Message-Id: <20200423070704.39872-11-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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
index 9db72f5891..7db58ada6f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -898,7 +898,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -914,8 +913,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -956,9 +953,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
2.25.0

