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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B65C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7EE233E2
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbhAWPmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbhAWPm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:42:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC30C061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:48 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y187so6951021wmd.3
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7gNm+kZ8MADy2OTi7e4OwckHB5MgAicfPwWe0auEfs=;
        b=aQ62wMtVrl5PvlQQsy2BZ16IYzwaf2D4+U+rDYEkls+4cmFDsQpCm2Ec3RLtInGj4Z
         KRS4/vIpwTUl6aYy3WuLZa9mNG9LwJenlooWLfC3uNZ3SkoM4//IQhwjhU6vvDjIq1H2
         IS7YfV4FU8q50HNU0oSnQX7GTa4s7b9C5kBa68qH1lOmKOlAluCzQYaXxCX0937ZCSZH
         ARnldLt6wrAoK4pXLXHvmjH/egu4txWVKpfJLSGSAuTv8nrZ07MnUUsscNvJ14UUh+JS
         o+H5eoiiWtlnVeQ8Bh9ZPL5lo3h9EUR/sEzn60q6Pkg1d+k2UOJcfiEs5NcxoJWM2hf+
         QKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7gNm+kZ8MADy2OTi7e4OwckHB5MgAicfPwWe0auEfs=;
        b=iXI7yjealWVZJEiGRO9VKannVOhDyhXbUTyVoZZTbe5SrsLhZsfu/XSWNdD5AnE+Ln
         UC/KYW++k1FJJ2ZCL2igojscgiGlJE1n6dWcMIw4x5+P7RJYSuneSj73XZkZRbG0GV2S
         KS2yj2CHJ44rynAGs3u9+uo5VXTrrvv/NXnz5czSC8C127I4tJ14wXy8L2WDsYuQwDuy
         nDQbicJp2aafeLTfNHe7C0WqzoS2kqA2s3ZNlD6hrfRzh1QRpM1vELcVGao1nzGkswzr
         6P0pBFdcXp6vsRBHskh47XDQPdIEnu38+L9sbXRaB/99PNCorIjUM2PlFCNDeq2cjhE6
         X+9g==
X-Gm-Message-State: AOAM533kWW5evYU7YlFFeid/Tr7O5qyv2ghuyjlr/G+j559Og6Dx/KJ1
        hMSXHC6YHcXYSEixnOTaRZZKQquYNQU=
X-Google-Smtp-Source: ABdhPJw+fD+uzXyNDrb1BMsNoP8hIU0WrHtuQ0Xd+XEdszt5HM76IlXmDiWrbO7EQAIhiNoLW2tHsA==
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr8575001wml.11.1611416506926;
        Sat, 23 Jan 2021 07:41:46 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:46 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 1/7] bisect--helper: reimplement `bisect_log` shell function in C
Date:   Sat, 23 Jan 2021 16:40:50 +0100
Message-Id: <20210123154056.48234-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123154056.48234-1-mirucam@gmail.com>
References: <20210123154056.48234-1-mirucam@gmail.com>
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
index 1f3f6e9fc5..c6149846ff 100755
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
+		git bisect--helper --bisect-log || exit;;
 	run)
 		bisect_run "$@" ;;
 	terms)
-- 
2.29.2

