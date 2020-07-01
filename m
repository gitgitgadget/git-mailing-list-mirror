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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD04C433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A56206BE
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRfVxBWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgGANfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgGANfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FF9C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:35:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so22447476wmh.4
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Npr/M7UuOj3UKyUGbMPYeV+rV5nr/9xAOEZN+JGZTjQ=;
        b=MRfVxBWhyz3lxIh5KPSAeNbJSEUjbxCFgtCfPYpw23EOWT43OLLX1g+JOxFsxWeNtY
         EVyvpmdQI0XdNW4iZRxfEmh8vW4NQwaqzEHMVQP3yOZZUQ8OIiIEf6LbWqvJl26vnzZG
         BezfhwPip8Zb7BeaEO9huUfbCIEIt5TsF3K8F/1leqzcFzc8Vz1phpM6LY6LtOy1s9Zq
         aLytNL0ksoKzgneHyIh4ciwc/K1+NNdxDY2A8KJb0tdSAgh5mcf9EYChGfVsCqNObkFd
         /8acsHg6V+khwED7+/Twdjrj80TKn1vCFq8meCapR8TVnU5K3Ivhvf14cJ4qUW5/zKEf
         V2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Npr/M7UuOj3UKyUGbMPYeV+rV5nr/9xAOEZN+JGZTjQ=;
        b=JbiKeFSKV0TPvbFnUto3R3YfsH10wwOPVicI/O3NIqXQW7amCcgN7UoVlahO2vuJAh
         vS/D55IxgyY96WYu7w8XWLVnyTSry+OehcjUN0PBjRG9XzdFhlgI0AMEIk0eSmCEIpZe
         +20JIVnoJNgrWWXMJpljrvgmcC/7lOr2pHZD4YHd+TAVeaaXQ4xp74zI0rE0YNRWgMuQ
         unmiWpIOBjw4EDk074OiMMOn2PlyNGjbD3CQ08w73VsEFPgGdCI6+HNhzJ6NABpvIec/
         hIW5WpG6ZrGMV9Ee2HW7B0n7BfSOtm9bTw1GxmmQvh8xx+bTZAyp4dzQBcqIuzu59E8d
         f7hw==
X-Gm-Message-State: AOAM531PGHT1OYp4Yqb5fqV0Y51aKMQKGH0gVq+l6VaPKwrjXCnCTAp8
        ljLoWd7tWzBbJ6BnaBd/3oh6MWoq7DWHAQ==
X-Google-Smtp-Source: ABdhPJznuPIejC+FybMJW6Nh5nQaWS5+YKn4oYCYfegQUZxRXuACcv5OrOmKPNbjDSoZIp2LxuH2wA==
X-Received: by 2002:a1c:2906:: with SMTP id p6mr26417446wmp.68.1593610544129;
        Wed, 01 Jul 2020 06:35:44 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id 30sm7928840wrm.74.2020.07.01.06.35.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:35:43 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 11/13] bisect--helper: retire `--check-expected-revs` subcommand
Date:   Wed,  1 Jul 2020 15:35:02 +0200
Message-Id: <20200701133504.18360-12-mirucam@gmail.com>
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

The `--check-expected-revs` subcommand is no longer used from the
git-bisect.sh shell script. Functions `check_expected_revs` and
`is_expected_revs` are also deleted.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ef8121afc7..874f8c38c4 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -185,30 +185,6 @@ static int write_terms(const char *bad, const char *good)
 	return (res < 0) ? -1 : 0;
 }
 
-static int is_expected_rev(const char *expected_hex)
-{
-	struct strbuf actual_hex = STRBUF_INIT;
-	int res = 0;
-	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
-		strbuf_trim(&actual_hex);
-		res = !strcmp(actual_hex.buf, expected_hex);
-	}
-	strbuf_release(&actual_hex);
-	return res;
-}
-
-static void check_expected_revs(const char **revs, int rev_nr)
-{
-	int i;
-
-	for (i = 0; i < rev_nr; i++) {
-		if (!is_expected_rev(revs[i])) {
-			unlink_or_warn(git_path_bisect_ancestors_ok());
-			unlink_or_warn(git_path_bisect_expected_rev());
-		}
-	}
-}
-
 static int bisect_reset(const char *commit)
 {
 	struct strbuf branch = STRBUF_INIT;
@@ -938,7 +914,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		WRITE_TERMS = 1,
-		CHECK_EXPECTED_REVS,
 		BISECT_RESET,
 		BISECT_WRITE,
 		CHECK_AND_SET_TERMS,
@@ -954,8 +929,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
-		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
-			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
 		OPT_CMDMODE(0, "bisect-write", &cmdmode,
@@ -996,9 +969,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

