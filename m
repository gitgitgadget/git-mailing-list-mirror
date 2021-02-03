Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A49C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9E864F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhBCV4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBCV4H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:56:07 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E14C0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 13:55:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g10so1087680wrx.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 13:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHUFSHVftxro75ZZkAF+vpT+wiuC6ZRoJswaXw+dD4E=;
        b=PXO+L+QxlEq3RNJ7RZFqu9MZmdTXbstjrI+8hzPu7MmZ2y25nPUAv4z0+7/0mu8dAB
         wgp4q/mayFIPpz+EH2WWIwGa6upPutXZA0VOwwMaeEOyJpKfBtASU5nH2dO86iqj35mU
         Lq32papOomAl847QaF2E7BotFTMmDvuIhjGY6aZO7CTYY7gf3Yh/L7IcDNQsK3eQxDct
         odAsR/HKetcOrxGOBj1lWEM6Z9FboKMG4djlAPQCmTTxMj6iyUoOApRpmVjZcWHANZNM
         gPznWaQHlDXB7CgegwsJcp6bC+qKTRBCQ+yJjePTiDbxdl5qWg5Es57zpQT0hK1uBHLU
         wzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHUFSHVftxro75ZZkAF+vpT+wiuC6ZRoJswaXw+dD4E=;
        b=b/tJGZ7btjmF7pQX8bmYpQXlCqWdxnKw2gIVjwp5HHHni3YWDr97mkredoYaLz1mQK
         ADUgS2BiHWaK5SgtMRfpTjczmnNtmkKxmJdI3QdpUJP7tN87GKpT66NAKtHdoh8jrCB7
         n0hsu0JkEOlPq9bxXRaVxgY2rsmgCjlSjADN1MDVdHhrE3EFJVMDjc09KSx6fkuaySQD
         Wo3vp3KRDkdjccc26Wh4IF6nHDd2mzHC0IxRS/xyTaG3oC0A13n7e3wOZiL8xOa21BMD
         7Liz8xKlPNS7Og9qgJImFTgImVtPAJ1l+B1f+tkBLEaT0FZPXgBKBf+W/qHNKskU6UaZ
         rWgg==
X-Gm-Message-State: AOAM530MQ26gwSW2HH4nZ6sEK/zSdiQ26cFySN3lDItjuowQuDeVvPD2
        8t/agMAFMOZ1fRcY3Lwipo7ZXN+0nK8=
X-Google-Smtp-Source: ABdhPJxGqltUvlEiGtBpceNlHJnwPFqL6F2aQzl0ngfHM9/gF6dU1pdtFc+CLPw473YU/xsxvsuKMw==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr5639524wru.318.1612389325901;
        Wed, 03 Feb 2021 13:55:25 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.148])
        by smtp.gmail.com with ESMTPSA id 143sm2609531wmb.47.2021.02.03.13.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:55:25 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     rafaeloliveira.cs@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 1/7] bisect--helper: reimplement `bisect_log` shell function in C
Date:   Wed,  3 Feb 2021 22:54:32 +0100
Message-Id: <20210203215438.96760-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210203215438.96760-1-mirucam@gmail.com>
References: <20210203215438.96760-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_log()` shell function in C and also add
`--bisect-log` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-log` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 27 ++++++++++++++++++++++++++-
 git-bisect.sh            |  7 +------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 709eb713a3..ce11383125 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -904,6 +904,23 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	return bisect_auto_next(terms, NULL);
 }
 
+static enum bisect_error bisect_log(void)
+{
+	int fd, status;
+	const char* filename = git_path_bisect_log();
+
+	if (is_empty_or_missing_file(filename))
+		return error(_("We are not bisecting."));
+
+	fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		return BISECT_FAILED;
+
+	status = copy_fd(fd, STDOUT_FILENO);
+	close(fd);
+	return status ? BISECT_FAILED : BISECT_OK;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -916,7 +933,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_STATE
+		BISECT_STATE,
+		BISECT_LOG
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -938,6 +956,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("list the bisection steps so far"), BISECT_LOG),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1000,6 +1020,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_state(&terms, argv, argc);
 		break;
+	case BISECT_LOG:
+		if (argc)
+			return error(_("--bisect-log requires 0 arguments"));
+		res = bisect_log();
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 1f3f6e9fc5..05863cc142 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -169,11 +169,6 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 	done
 }
 
-bisect_log () {
-	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
-	cat "$GIT_DIR/BISECT_LOG"
-}
-
 get_terms () {
 	if test -s "$GIT_DIR/BISECT_TERMS"
 	then
@@ -210,7 +205,7 @@ case "$#" in
 	replay)
 		bisect_replay "$@" ;;
 	log)
-		bisect_log ;;
+		git bisect--helper --bisect-log || exit ;;
 	run)
 		bisect_run "$@" ;;
 	terms)
-- 
2.29.2

