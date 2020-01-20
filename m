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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5348C33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A936622314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUEUQ0+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgATOi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50457 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgATOiy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so14748208wmb.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YH/6cvLSMNBqAwybMMY2K2J8ycTikeC6mftg5OrOzG0=;
        b=NUEUQ0+tFqdhQrhkdI142KSkFcKYNaUxfX6sNZNxGNfzl/vGBZtbmhpTr+yu5fi89E
         +zdoztxcJFCASuVYYR5d5Fu4olPX+rSK+OR5T/fuoDRI/BhnECPfV/JSl7TFxH4rmzjF
         YfC6PXeqi7X3QHtGqFxhOyQMSd4MDJfGJrhwtkUZA301GmHykk6HEfnCVy70zRGfrblc
         1K+xq/br4bPogbso7i23bntJyqNrRy2yThw+VhTw9+ok3BbzuaqaKkpht/nzMHAZBeQR
         obwNGPZ11QjJHRCrBmfiR25p37bn6x6Kt6aimkuaqgmFpt+n0crjBIa0tr9KBr+lZn2j
         GTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YH/6cvLSMNBqAwybMMY2K2J8ycTikeC6mftg5OrOzG0=;
        b=TDKsZdNOUnvSCNYITvajdMMb9YwqpDgOa34YPQhVYciKOddmwfInN5p0jMTYB2Iq/x
         jCVXEuYxGaxaDRevJMkxidZxNC8+J/gGGmticbWK8V/Kg895HW4hIrqQ8/1Cog6lhf3Y
         G+xWDEDhu2ZbTkavmCSQGycoHaRlt1ssFSPvPnjU97EZvx1eI5dMMDMOVZpDHUxFZndO
         qjltTJtttxuEqveujYsiQqcpFYo9aUHfYChmIy/Iz8nTeuRX6oT2GMzNRIWWKQ4g/BpW
         fcIRy8q6xOxd4P/wdBh3b2yPACAipckrxKtkpq+G4Ko6+oDVxQFMXzRkkjJ4sOewh6YJ
         wtFg==
X-Gm-Message-State: APjAAAWdzJifRMs78siVoSgp6RbUs1bR7IfrennHAmyvT9xUl2mOdL7P
        CcUhA1oi46y7pu/gsbQtxjxFQpcvTYQ=
X-Google-Smtp-Source: APXvYqxMlvbia7+aA3a5Gwt6Ve+NhXs7qPZcx0W+iIkeCNMNDI41P/RCdiuaN4d1y8k4A8S4LZwq4A==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr20134629wmg.154.1579531133094;
        Mon, 20 Jan 2020 06:38:53 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:52 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 20/29] bisect--helper: reimplement `bisect_log` shell function in C
Date:   Mon, 20 Jan 2020 15:37:51 +0100
Message-Id: <20200120143800.900-21-mirucam@gmail.com>
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
index 4ff8035cd8..4795b7880c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -892,6 +892,18 @@ static int bisect_state(struct bisect_terms *terms, const char **argv,
 	return -1;
 }
 
+static int bisect_log(void)
+{
+	int fd, status;
+	fd = open(git_path_bisect_log(), O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	status = copy_fd(fd, STDOUT_FILENO);
+	close(fd);
+        return status ? -1 : 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -904,7 +916,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
-		BISECT_STATE
+		BISECT_STATE,
+		BISECT_LOG
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -928,6 +941,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
 		OPT_CMDMODE(0, "bisect-state", &cmdmode,
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
+		OPT_CMDMODE(0, "bisect-log", &cmdmode,
+			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -1000,6 +1015,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_state(&terms, argv, argc);
 		break;
+	case BISECT_LOG:
+		if (argc > 1)
+			return error(_("--bisect-log requires 0 arguments"));
+		res = bisect_log();
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 4a5afc7a93..151358aeda 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -167,11 +167,6 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
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
@@ -209,7 +204,7 @@ case "$#" in
 	replay)
 		bisect_replay "$@" ;;
 	log)
-		bisect_log ;;
+		git bisect--helper --bisect-log ;;
 	run)
 		bisect_run "$@" ;;
 	terms)
-- 
2.21.1 (Apple Git-122.3)

