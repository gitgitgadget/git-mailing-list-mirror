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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD5CC4BA10
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40E820838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLEncRj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBZKQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41678 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBZKQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id v4so2224945wrs.8
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SxFmHPzLSjqQLb9n3yWLdrxL/nDy8gFWLI6z0FY5NKo=;
        b=QLEncRj1kEwWsdCrYsiBnA051yBIVbNb24+c4HwJADMBCwmgKtjNgG6CHtEtjSfSZ+
         4Hj/BmFX4fTusErIuTbGDhPwmScDMoX4WU+kCKfIEfxPn5PD0ebjpsllIxJmJ4d73V1p
         zUKqRToQMPJUjqCY5d17x8lcUzopb0WnQxM34At36xtW9Rk9cVhgxVnEq/B8bQl1KTzT
         0un2on6FS5Y2RqSdnNx5ZaW9x9IYQFrpvFZYPPq14CFGeZmYL+xugE1R75Xbka9HryYR
         LMcvF+GSBrP24t9Rb8DOf4MoIAq5NYfmJO0wx6oDGDyvxNzYMl6z13fW1Ity/ROadsGK
         QJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SxFmHPzLSjqQLb9n3yWLdrxL/nDy8gFWLI6z0FY5NKo=;
        b=uWD7fYoGhVhmaLoSvhAVME+UbvbxTHK5AjBETGHXQcaturJEKKtCPM0SUyjK2C+08z
         NYqswXOxIu5alEmaLJDlw0QygqFGhIED5c+UhKA7kQocqFjx0ZVwhhl8T4v+4fwsxgMK
         cs3CbfIBrerIIzTDORjXLdpZQ1vD3A4KynZCiPkoPwBic85KHIMF3q/z+CR5+83IlDDs
         cB0Vn+8YlLdM0M0mujsOufrxyyHqsxkNBLeVCLiekow1faEtC4Boa3nZ18TSuLWX94UC
         IaU6du5wMUpUwhCZXuD9y3O5RlUHexUwF1OaJj5Yau9C0DOzAAnNxYmxM3bLU6tosvgu
         o1kQ==
X-Gm-Message-State: APjAAAX5FuaimLf85uRu9s5HmKYK9bV7yqP6I10/7BsZUI/QoryTa7Tm
        FaDJJJbkpqCEGxjfL2es5Q6URyYfMPk=
X-Google-Smtp-Source: APXvYqyGyt4UDcvDy7dQw65CdOc73oWqnjIyAIxQ8xEcnHlRL2DS9eYDZxz7+BRQmeoufrPXlpyPuQ==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr4573803wro.316.1582712177303;
        Wed, 26 Feb 2020 02:16:17 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:16 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 08/10] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Wed, 26 Feb 2020 11:14:27 +0100
Message-Id: <20200226101429.81327-9-mirucam@gmail.com>
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
index fedcad4d9b..c2fd3ee1b3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -907,7 +907,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -923,8 +922,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -965,9 +962,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

