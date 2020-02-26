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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A121C4BA0E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CDD24656
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKk1EXHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBZKQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55760 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBZKQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so2299551wmj.5
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pm2riwuEDG2cRwskss3EXJBA8dK9c4i6zEALvYUar9E=;
        b=tKk1EXHxewM68MRkqcq5fmCFLkNWmUQjyiruqmSmNez/tCsDKBR3gvFeegk/pI25pK
         /p+F0nAt5PMbFjqcI+NfL133AzKGVML/sItDea2pz7F/4PUqFvJBSxD63M0jGjjIvmvF
         h5tjddyMxwmoc86F6u79mRhNTB7Qm/i8SgRYwGDTadNFSyQDXOChzQA4TNUlGFBLPhfk
         BK7hntKGhwNESaVfraguGuAu23sAMimY2SBkuWdbm45dQJ65kQrQrhW2XXnL1hple8GH
         eSy0wsfHwP/ElV8gaIPQJr6R1XTceRsMhdk4h9ecLPFxTTx87FNRd+hmMe9w8XRAFsnv
         9xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pm2riwuEDG2cRwskss3EXJBA8dK9c4i6zEALvYUar9E=;
        b=Li2NzdGfTDhNSpNPJ6I47cR1yrvFqx2+p1vHTagS9ewZOXsOYHEKMW9mlet4kOyiRj
         XBusiPseilaXY9SXbMk+g5ZOBJBgFk270QZ06QbgW25vDBsTb0RSrwmdgQUZXQUulH8h
         5Cz33oqxjU+CFFstPtrrEthAo6+i+f6YQ1g2ypATBzNssD9qcGW9F1VANgtfXCbCgCNr
         6d6xToH3tsX10K6Rvd5uWcPiKF9ijdG2vjE/5L/2MNiogUUjUyXNzQDAyPZ6Kb6bijeh
         F4RbEZcgRIE2CFVS27cAp1xVpmSgaQdZGXkSuTHutyur4xYdhpi4oNMNDRnUXCUitOt0
         0Deg==
X-Gm-Message-State: APjAAAXJMy0IOiJQpen1eXLgAcpYIWMTGU3TgjTKDcIoC3Tbx5OcQbb+
        LFfXpQshCa+bsD4IBsn0V/+dwU81
X-Google-Smtp-Source: APXvYqw5o3SRXkBJaDewm+hQCvzjmrTjPaRbueiu2+MzjEpVz89qwgoiYdeM2oLU6wL54lUNLm694w==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr4668445wmf.60.1582712170871;
        Wed, 26 Feb 2020 02:16:10 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:10 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 04/10] bisect--helper: retire `--bisect-clean-state` subcommand
Date:   Wed, 26 Feb 2020 11:14:23 +0100
Message-Id: <20200226101429.81327-5-mirucam@gmail.com>
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

The `--bisect-clean-state` subcommand is no longer used from the
git-bisect.sh shell script. Instead the function
`bisect_clean_state()` is directly called from the C
implementation.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e75e7a0837..1792751179 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -22,7 +22,6 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
-	N_("git bisect--helper --bisect-clean-state"),
 	N_("git bisect--helper --bisect-reset [<commit>]"),
 	N_("git bisect--helper --bisect-write [--no-log] <state> <revision> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
@@ -810,7 +809,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		NEXT_ALL = 1,
 		WRITE_TERMS,
-		BISECT_CLEAN_STATE,
 		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
@@ -827,8 +825,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
-			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
 			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -870,10 +866,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
-	case BISECT_CLEAN_STATE:
-		if (argc != 0)
-			return error(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
 	case CHECK_EXPECTED_REVS:
 		check_expected_revs(argv, argc);
 		return 0;
-- 
2.25.0

