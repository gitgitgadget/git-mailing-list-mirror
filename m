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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B62EC43381
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F132422D49
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgLUSFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUSFi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:05:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50753C061285
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:04:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c133so10706830wme.4
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UBmQ2+DuS9zvp0BUmDz70iD9CWedUfU1RNe+O6OvKY=;
        b=exH4FBEE97uJHmWgMqsGyXSjCo7jJLkRsLi9+xKbPxHu327OHYfLQhyJTKWsMHZq0Y
         rrlmgBCn3ggO0dl9M1SJtKIv+mczt4m3PNQZ4KRAscNP1TcT/svup2rkYnXjkgUDT195
         fUzpxSdySIz863sFp5Qco1rS890a+yGF50NbVmqB4RUNjFh9KgODL2WPR7US35c2uvrT
         70AKE4irEcNKIBN2xcsq11piAx9cKG5lK3NhJrJkYlhTtaWQRuiOZhfom0kzZRbTVNOK
         JBnyUAtxfzjlwqCn9hDN6J9hRVtD8ZI6+Gq8YVhMEogEVHlQtntrS0hFcGgBeVtWSU6w
         SxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UBmQ2+DuS9zvp0BUmDz70iD9CWedUfU1RNe+O6OvKY=;
        b=g1o7ND4jj9HABuZ7NTcTkwIV8W0t+vp8uKy+GF4Oh6TBxKWSIiKI9Qur3Kjl0Zl/UE
         5vM1wn5U1MnAtH+PiFJBfccwhlcf5Men6uOCbl5/gU5iuxO3a1nJuxD7ekJLI8GkWcEx
         kNtq8SXZ738xoddfWabsJFaKEQq9eSXNlzOxyjoaKHZ2Irkz2vLTPF4IbL7GaOeATGPK
         VKVjXe+wWWrIf8p7+U1gTc1hHvw8v0CNjYWIQGEv+aFZOILSfmpRGLyr8U7z22c+hjqs
         BwaDILg3nmpbcuMgbM4ehTRL2pfElHOH+yNznhtyxTSLcyjIGJkMSadk+nexTjgCwJoU
         E6Ew==
X-Gm-Message-State: AOAM532EitqSED4mRdgG9dJfsKWRljBHF39iEpjcxe7IBALTs4dKCb0K
        E7qXETzrpmgm16CiAGV12xoZLfGiGX0Gzg==
X-Google-Smtp-Source: ABdhPJwDXUQl9Y5PBFV2YYnJiJgkoyYH2YksWlGa2FRpbLk253zpnddbj4uLkhydPbX/PQSah5kmTg==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr17707426wmc.187.1608568173423;
        Mon, 21 Dec 2020 08:29:33 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:32 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 6/7] bisect--helper: reimplement `bisect_skip` shell function in C
Date:   Mon, 21 Dec 2020 17:27:42 +0100
Message-Id: <20201221162743.96056-7-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
References: <20201221162743.96056-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_skip()` shell function in C and also add
`bisect-skip` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-skip` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 47 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 17 +--------------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d570a165de..1a6c75183a 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
+	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	NULL
 };
 
@@ -1030,6 +1031,43 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	return bisect_auto_next(terms, NULL);
 }
 
+static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int i;
+	enum bisect_error res;
+	const char *pattern = "*..*";
+	struct strvec argv_state = STRVEC_INIT;
+
+	strvec_push(&argv_state, "skip");
+
+	for (i = 0; i < argc; i++) {
+		if (!wildmatch(pattern, argv[i], 0)) {
+			struct rev_info revs;
+			struct commit *commit;
+			struct strvec rev_argv = STRVEC_INIT;
+
+			strvec_pushl(&rev_argv, "skipped_commits", argv[i], NULL);
+			init_revisions(&revs, NULL);
+			setup_revisions(rev_argv.nr, rev_argv.v, &revs, NULL);
+			strvec_clear(&rev_argv);
+
+			if (prepare_revision_walk(&revs))
+				die(_("revision walk setup failed\n"));
+			while ((commit = get_revision(&revs)) != NULL)
+				strvec_push(&argv_state,
+						oid_to_hex(&commit->object.oid));
+
+			reset_revision_walk();
+		} else {
+			strvec_push(&argv_state, argv[i]);
+		}
+	}
+	res = bisect_state(terms, argv_state.v, argv_state.nr);
+
+	strvec_clear(&argv_state);
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1042,7 +1080,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-		BISECT_REPLAY
+		BISECT_REPLAY,
+		BISECT_SKIP
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -1064,6 +1103,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
+			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1126,6 +1167,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
+	case BISECT_SKIP:
+		set_terms(&terms, "bad", "good");
+		res = bisect_skip(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 79bcd31bd7..016cc34e03 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,21 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_skip() {
-	all=''
-	for arg in "$@"
-	do
-		case "$arg" in
-		*..*)
-			revs=$(git rev-list "$arg") || die "$(eval_gettext "Bad rev input: \$arg")" ;;
-		*)
-			revs=$(git rev-parse --sq-quote "$arg") ;;
-		esac
-		all="$all $revs"
-	done
-	eval git bisect--helper --bisect-state 'skip' $all
-}
-
 bisect_visualize() {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -162,7 +147,7 @@ case "$#" in
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
 		git bisect--helper --bisect-state "$cmd" "$@" ;;
 	skip)
-		bisect_skip "$@" ;;
+		git bisect--helper --bisect-skip "$@" || exit;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
 		git bisect--helper --bisect-next "$@" || exit ;;
-- 
2.29.2

