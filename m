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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD8C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D038922B51
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbhAZFBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbhAYTSL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E2EC061786
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p15so7472930wrq.8
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etuzwx57DGg4ATPYEKGldv9+oa/V6x4dfr2h/axrjQU=;
        b=PfmRTGLQ2JPcLgDuSM5b0qcNFc8YbKng3rBw36Y74lzA/FFUOLOZWCV2xxKiKwdzDc
         NjHMeHlZBA7en498BJaTsk8OIcFC/kQ0TklCCCWut6cNULdcQp3trgz6yLfmsJP28OfO
         TTqqSFnOAl9FpCjzh6WEk+WG2OYO6YkHNGAtiIUoxZM57ZmlCGpckHp0PFOHsnMCh8Ws
         TbArmvjbfb2pSjmBZoMCIZ3vRVYtvHRCYNaAcZPVZPxZA0zQFdMAyyZE64snX/imsEAO
         J6t3/OBWQq3LVLalFYfvPUmGGccHK5nnTNKvH/cLsTBYSB+HOxlvTNMheT6hCx5QHekG
         iBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etuzwx57DGg4ATPYEKGldv9+oa/V6x4dfr2h/axrjQU=;
        b=cKol5C1Jf+xU/PwGfIbjRG+9T1aathcShY87rRDPAavA8glv+Q/xrF01g5eblUShfQ
         Ws4MblvmrzdePCusXQZqVvhe/Z0bqaJxNip6NGOnAe47IY0JJTDXXaVw6ENqV2eU8Egb
         wmK1eX0mPoQZBAiAN62zPMMRShvtLkaDiJG94N54Tu4UDdBn3NhcntFvWEp1GriyFJc3
         QvPG21iCNUNcrbUl6pXFeuaUsthpLOroOgivtSkxD9CeNaeKcRvsghree8fqo4BmNYxI
         XGSEvWcPgbfTDYVCxjeMHeHuTMKRzBnuqyHpKavywQeqBG14ZmGE0zJUtYzv7b5L5d30
         Orkg==
X-Gm-Message-State: AOAM531k6ko8Dxc0MF8dX/3KzLcSS2VTaxcHr8Y5DUFLmvCQlrCnRizQ
        WHHAa9R51UUZLJE1pKHRO+Yi2fTXGPM=
X-Google-Smtp-Source: ABdhPJxqfVaoqV+YCgVDwV4jZ5fHMw1R+x6RW20704PlEAxascwvsWCL6TBER9JhE/rsgzA3ev6wBA==
X-Received: by 2002:adf:b74d:: with SMTP id n13mr2697157wre.62.1611602245421;
        Mon, 25 Jan 2021 11:17:25 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:24 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 1/7] bisect--helper: reimplement `bisect_log` shell function in C
Date:   Mon, 25 Jan 2021 20:17:04 +0100
Message-Id: <20210125191710.45161-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com>
References: <20210125191710.45161-1-mirucam@gmail.com>
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
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 22 +++++++++++++++++++++-
 git-bisect.sh            |  7 +------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 709eb713a3..a65244a0f5 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -904,6 +904,18 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	return bisect_auto_next(terms, NULL);
 }
 
+static enum bisect_error bisect_log(void)
+{
+	int fd, status;
+	fd = open(git_path_bisect_log(), O_RDONLY);
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
@@ -916,7 +928,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_AUTOSTART,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_STATE
+		BISECT_STATE,
+		BISECT_LOG
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -938,6 +951,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("list the bisection steps so far"), BISECT_LOG),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1000,6 +1015,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

