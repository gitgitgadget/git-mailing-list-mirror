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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A8BC33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD966217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/GKXyNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgATOjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:39:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36985 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgATOjG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:39:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so14969979wmf.2
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8Stw97eWMONr6a8QPsDT9LSGfQY63VJ1CvSPOp3kY8=;
        b=i/GKXyNkbO+7FecUEka2DYqVshPnRged4MdXNY1qCmzw/lUmn9s0qxxhgTj9uG6dXJ
         AKcCQQ8F7fUJ+eHPsfpy09922F1h4SZD+aCIqfKgUEoxi6xiZG1RzAdtqC/PdCfUNySV
         ZF+4pGq5LLRzPgpd8tXXm65jBXTpjx3Injmq52g50SdQ6TlwuXV4IMMBJzSMPNfus9rK
         h9RXd9bticLyoWTXl4ItiBygY7QjuXFwA4MW/CwFq2yMgpS3vpRkyZkA9GWtT6r0s32Y
         /+bsRu4bbe4k2BmCYPh0Fo4WX80yYkQdQqsrwCNUrAehhMK5Nc4cXsjFbVI0hAVWvFLS
         9P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8Stw97eWMONr6a8QPsDT9LSGfQY63VJ1CvSPOp3kY8=;
        b=saIcecc3aMSZp4X2lgfqm/g52onSKjA9swobEIC6loWw+inRbKygF7/mA+dChrLXOF
         vQNeb5LILdsiA/yiRUp9QMbsbRbWnJViEi8oMb4B5OxkxChb5u4Fnw3hWlZO7eznMSUl
         HnyYfbGWxr1rxYoZfagI6PZc5cNaHFlqtaKEsMShGUM1BAc/J4aG1a7CJjdQuXv+TDAM
         204bMljx+UtBpUfRghIihjm8qTEa+g5Gdu4RFPW4F3Og+fscwllEnkNStJAnciHhqI83
         IdI1oc5bJDBkMoonAdgVZUcoV1HjOw7xcMeLrDGa5BhMd7yRxXrK0t96jacaC/ZFX6Ro
         0JoA==
X-Gm-Message-State: APjAAAVeygMqv51herUn5Ox1nUm34CwPvauypIxloSv+FaBX/uzpVANx
        I1h2mw1xtJeTm2TBXbu9s9cruFhhSJI=
X-Google-Smtp-Source: APXvYqw5LZOCllP0SV0ftGvu4ep3nlnUaUHi/SjeuewxtAXOeVBX0i3XhgWVfqgVTPu9D4QNbAyDNg==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr19060896wme.82.1579531144329;
        Mon, 20 Jan 2020 06:39:04 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:39:03 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 29/29] bisect--helper: reimplement `bisect_run` shell function in C
Date:   Mon, 20 Jan 2020 15:38:00 +0100
Message-Id: <20200120143800.900-30-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Reimplement the `bisect_run()` shell function
in C and also add `--bisect-run` subcommand to
`git bisect--helper` to call it from git-bisect.sh.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 66 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 62 +------------------------------------
 2 files changed, 66 insertions(+), 62 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4b41cc7749..1899cc8114 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-replay <filename>"),
 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	N_("git bisect--helper --bisect-visualize"),
+	N_("git bisect--helper --bisect-run <cmd>..."),
 	NULL
 };
 
@@ -1092,6 +1093,60 @@ static int bisect_visualize(struct bisect_terms *terms, const char **argv, int a
 	return res;
 }
 
+static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+{
+    	int i, res = 0;
+	struct strbuf command = STRBUF_INIT;
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	if (bisect_next_check(terms, NULL))
+        	return -1;
+
+	for (i = 0; i < argc; i++) {
+            	strbuf_addstr(&command, argv[i]);
+		strbuf_addstr(&command, " ");
+        }
+
+	while (1) {
+		argv_array_clear(&args);
+
+		printf(_("running %s"), command.buf);
+		res = run_command_v_opt(argv, RUN_USING_SHELL);
+
+		if (res < 0 && res >= 128) {
+			error(_("bisect run failed: exit code %d from"
+				" '%s' is < 0 or >= 128"), res, command.buf);
+			strbuf_release(&command);
+			return res;
+		}
+
+		if (res == 125)
+			argv_array_push(&args, "skip");
+		else if (res > 0)
+			argv_array_push(&args, terms->term_bad);
+		else
+			argv_array_push(&args, terms->term_good);
+		
+		res = bisect_state(terms, args.argv, args.argc);
+		
+		if (res == -11) {
+            		printf(_("bisect run success"));
+            		res = 0;
+        	}
+		else if (res == -2)
+            		error(_("bisect run cannot continue any more"));
+        	else if (res)
+            		error(_("bisect run failed:'git bisect--helper --bisect-state"
+               			" %s' exited with error code %d"), args.argv[0], res);
+        	else
+            		continue;
+
+		strbuf_release(&command);
+		argv_array_clear(&args);
+		return res;
+	}
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1104,7 +1159,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_LOG,
 		BISECT_REPLAY,
 		BISECT_SKIP,
-		BISECT_VISUALIZE
+		BISECT_VISUALIZE,
+		BISECT_RUN,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -1128,6 +1184,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
+		OPT_CMDMODE(0, "bisect-run", &cmdmode,
+			 N_("use <cmd>... to automatically bisect."), BISECT_RUN),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -1196,6 +1254,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_visualize(&terms, argv, argc);
 		break;
+	case BISECT_RUN:
+		if (!argc)
+			return error(_("bisect run failed: no command provided."));
+		get_terms(&terms);
+		res = bisect_run(&terms, argv, argc);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 084766636d..d4f64674fe 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,66 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_run () {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
-
-	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
-
-	while true
-	do
-		command="$@"
-		eval_gettextln "running \$command"
-		"$@"
-		res=$?
-
-		# Check for really bad run error.
-		if [ $res -lt 0 -o $res -ge 128 ]
-		then
-			eval_gettextln "bisect run failed:
-exit code \$res from '\$command' is < 0 or >= 128" >&2
-			exit $res
-		fi
-
-		# Find current state depending on run success or failure.
-		# A special exit code of 125 means cannot test.
-		if [ $res -eq 125 ]
-		then
-			state='skip'
-		elif [ $res -gt 0 ]
-		then
-			state="$TERM_BAD"
-		else
-			state="$TERM_GOOD"
-		fi
-
-		( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )
-		res=$?
-
-		cat "$GIT_DIR/BISECT_RUN"
-
-		if sane_grep "first $TERM_BAD commit could be any of" "$GIT_DIR/BISECT_RUN" \
-			>/dev/null
-		then
-			gettextln "bisect run cannot continue any more" >&2
-			exit $res
-		fi
-
-		if [ $res -ne 0 ]
-		then
-			eval_gettextln "bisect run failed:
-'git bisect--helper --bisect-state \$state' exited with error code \$res" >&2
-			exit $res
-		fi
-
-		if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BISECT_RUN" >/dev/null
-		then
-			gettextln "bisect run success"
-			exit 0;
-		fi
-
-	done
-}
-
 get_terms () {
 	if test -s "$GIT_DIR/BISECT_TERMS"
 	then
@@ -138,7 +78,7 @@ case "$#" in
 	log)
 		git bisect--helper --bisect-log ;;
 	run)
-		bisect_run "$@" ;;
+		git bisect--helper --bisect-run "$(git rev-parse --sq-quote "$@")" ;;
 	terms)
 		git bisect--helper --bisect-terms "$@" || exit;;
 	*)
-- 
2.21.1 (Apple Git-122.3)

