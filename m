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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFECBC43381
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F31C22D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgLUSOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgLUSOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:14:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D860FC0611C5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:13:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y17so11999115wrr.10
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SSxn00D6lEx94ttp23aI5Puw/LoAFasEmLcpM5Su8k=;
        b=W6gC6Ivc+PX4exDRa+He2CoORIvENH6xVehCOdrIPI7D6JubhMBnq2yaqCuxwOjSur
         h310059ZHjq4GdYTSRrWaglH5BqSW567FV2N3BWIleggY4n5FywUpOW5g2q+5YTjZtLu
         spXX8oWPNUAu9eLoMALdj89VOurk6/cOFlV+V/1ectETOJVrfSFR3GubQkw7grbU4qaZ
         64p30ESZEu4jntpndrcdbCthOFXxj7YGBwL2TgYOXUIj+oqIW2Ew9tE9DRan53SVd6mA
         47QxdZTxSCswJCoWy7XsUKqh2SY/mBg7OOaG0Hq2FJTKjKjWJCGUWUCxOzyiWTlWOn+z
         7cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SSxn00D6lEx94ttp23aI5Puw/LoAFasEmLcpM5Su8k=;
        b=O8dUNOW6gNWinwX/xQi5KmCIxvs5U42D0SbEdk7yROOxjNTWXnqm1p3UZc22rpbZ08
         h6fQ+OqUtqnwX3XIk1tg8d3YlUyEFTXhf+jzlj7N+y1eqySWAmGnC+OjSHgq8qCR4Ye5
         QX/9ogaSf/5o0RzRslzYhIPPGSJ/pj8aot/1pYwjcIUuhNJGgFg5pdu2Ggvhj9YJMqbX
         CtSivrQKVM4YQYJKAPdeb4yOpNTtlz51g2Aa410rKvWn3SiGgCcVYI+H137iHj24hycz
         VtPHnK477nYLeW2jMxzSFxDWh8lJvcpaxEBVaDVlMv3ydlmHP/T92VLEEJd3vPEiykhC
         hlEw==
X-Gm-Message-State: AOAM531Swcl9Sm5tAYN7Nvcd+ZYRCaZu2ovurJ10nFsNb69TyQDEMg+j
        8mpO+h/y/0Ca/2f9fe7Q5YEavPpwlZaAqw==
X-Google-Smtp-Source: ABdhPJw+k4y/TVrOXG56FvHWxzBuvGba+P0XM+c/LOzxYmXURh5ObcIAoDtTcbY8XfHVELPEd2wGjw==
X-Received: by 2002:a5d:6cc9:: with SMTP id c9mr19105366wrc.411.1608568168393;
        Mon, 21 Dec 2020 08:29:28 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:27 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 1/7] bisect--helper: reimplement `bisect_log` shell function in C
Date:   Mon, 21 Dec 2020 17:27:37 +0100
Message-Id: <20201221162743.96056-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
References: <20201221162743.96056-1-mirucam@gmail.com>
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
index 709eb713a3..1854377fa6 100644
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
+			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
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

