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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D79EC43381
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BBB221FC
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhAZFBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbhAYTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841EFC061788
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j18so414591wmi.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAu+lyOkuwI3+lcw2UF8LucEAJAOCPo622DGOT+cEbE=;
        b=qFf2QVITFbOMZuYLGFrdAaelw7UPyCQgcVtXh6DdgkJPuLQ58BoJtjXykW+o34Mp/P
         c1HiP4cUACY/dw67Q5facZIV9CXcy0dG239QToCuzFxLWhGtjtu6L1COdYibd0pGBp16
         NE12xKh3CwnVmvv7zQ5SEdw6EHBJx+v4F0lIBiYIopT/EDkfLVWoQa9aUN+Eq8zMJO05
         G0oicBCyYSt7X5hcbCVlZktfOBiIKLo1t2JyK33zJD+H9AB1oq2iwT4G2Ov1Jx2FtjfP
         FduP3rZ2lL3yQ1Dp9D3606Cqr8qIq+XRb5webls6PRxdDpLTqCrhe2oAfUED/X8fBvKt
         NDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAu+lyOkuwI3+lcw2UF8LucEAJAOCPo622DGOT+cEbE=;
        b=DoFyB8pdKjsopwpkoejycJxL2Rv0mhV793UlwWBq+E5sZ7IARl/1p1ZqYaU9H/aDFe
         mDZ/4QLolg2PhlyuiFzLExvy/XwojyB+XK2Ri81eXJRqDUK40t6LxwYrUXzHDaTWNW08
         Ard1+DV677fmKuE5mKHVY/r7cMJtU/watp/Sd2D0myConw7i7mGDRoqADoaqWYJVK6Sp
         0QwK/5BPlNYZYJ60gTLAST7E38QDv7sDHOrcWf5QY/w5giXf/qHiDMfxJ4Y32MQPUQfN
         K62xOY91wHYxFFBycHV9PlBSY5I5Pf8yT4wu0mtzUmULSqeS+IrPHmQ5THXubCSV7Ypb
         LWiQ==
X-Gm-Message-State: AOAM530vOYb060qkr4yI+2bYawgpAcI8gQ2tF7HJA7yYSv6cGr2BmUJM
        8theJls5E2F+8TG23pTSdl2/QXAU2qw=
X-Google-Smtp-Source: ABdhPJyt9PzROqvgUUyxlwjLoa1Cb003Wtqk61LaiSmBXN84jP4t1POdnjCxwvzfzrXCJWk6qN3ohA==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr1438371wmb.108.1611602246349;
        Mon, 25 Jan 2021 11:17:26 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:25 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 2/7] bisect--helper: reimplement `bisect_replay` shell function in C
Date:   Mon, 25 Jan 2021 20:17:05 +0100
Message-Id: <20210125191710.45161-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com>
References: <20210125191710.45161-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_replay` shell function in C and also add
`--bisect-replay` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-replay` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 85 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 34 +---------------
 2 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a65244a0f5..d65b2f44c6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-replay <filename>"),
 	NULL
 };
 
@@ -916,6 +917,79 @@ static enum bisect_error bisect_log(void)
 	return status ? BISECT_FAILED : BISECT_OK;
 }
 
+static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
+{
+	const char *p = line->buf + strspn(line->buf, " \t");
+	char *word_end, *rev;
+
+	if ((!skip_prefix(p, "git bisect", &p) &&
+	!skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
+		return 0;
+	p += strspn(p, " \t");
+
+	word_end = (char *)p + strcspn(p, " \t");
+	rev = word_end + strspn(word_end, " \t");
+	*word_end = '\0'; /* NUL-terminate the word */
+
+	get_terms(terms);
+	if (check_and_set_terms(terms, p))
+		return -1;
+
+	if (!strcmp(p, "start")) {
+		struct strvec argv = STRVEC_INIT;
+		int res;
+		sq_dequote_to_strvec(rev, &argv);
+		res = bisect_start(terms, argv.v, argv.nr);
+		strvec_clear(&argv);
+		return res;
+	}
+
+	if (one_of(p, terms->term_good,
+	   terms->term_bad, "skip", NULL))
+		return bisect_write(p, rev, terms, 0);
+
+	if (!strcmp(p, "terms")) {
+		struct strvec argv = STRVEC_INIT;
+		int res;
+		sq_dequote_to_strvec(rev, &argv);
+		res = bisect_terms(terms, argv.nr == 1 ? argv.v[0] : NULL);
+		strvec_clear(&argv);
+		return res;
+	}
+	error(_("'%s'?? what are you talking about?"), p);
+
+	return -1;
+}
+
+static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *filename)
+{
+	FILE *fp = NULL;
+	enum bisect_error res = BISECT_OK;
+	struct strbuf line = STRBUF_INIT;
+
+	if (is_empty_or_missing_file(filename))
+		return error(_("cannot read file '%s' for replaying"), filename);
+
+	if (bisect_reset(NULL))
+		return BISECT_FAILED;
+
+	fp = fopen(filename, "r");
+	if (!fp)
+		return BISECT_FAILED;
+
+	while ((strbuf_getline(&line, fp) != EOF) && !res){
+		res = process_replay_line(terms, &line);
+	}
+
+	strbuf_release(&line);
+	fclose(fp);
+
+	if (res)
+		return BISECT_FAILED;
+
+	return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -929,7 +1003,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_STATE,
-		BISECT_LOG
+		BISECT_LOG,
+		BISECT_REPLAY
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -953,6 +1028,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
 			 N_("list the bisection steps so far"), BISECT_LOG),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1020,6 +1097,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-log requires 0 arguments"));
 		res = bisect_log();
 		break;
+	case BISECT_REPLAY:
+		if (argc != 1)
+			return error(_("no logfile given"));
+		set_terms(&terms, "bad", "good");
+		res = bisect_replay(&terms, argv[0]);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 05863cc142..e834154e29 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,38 +77,6 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_replay () {
-	file="$1"
-	test "$#" -eq 1 || die "$(gettext "No logfile given")"
-	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	git bisect--helper --bisect-reset || exit
-	oIFS="$IFS" IFS="$IFS$(printf '\015')"
-	while read git bisect command rev tail
-	do
-		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
-		if test "$git" = "git-bisect"
-		then
-			rev="$command"
-			command="$bisect"
-		fi
-		get_terms
-		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
-		get_terms
-		case "$command" in
-		start)
-			eval "git bisect--helper --bisect-start $rev $tail" ;;
-		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
-		terms)
-			git bisect--helper --bisect-terms $rev || exit;;
-		*)
-			die "$(gettext "?? what are you talking about?")" ;;
-		esac
-	done <"$file"
-	IFS="$oIFS"
-	git bisect--helper --bisect-auto-next || exit
-}
-
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -203,7 +171,7 @@ case "$#" in
 	reset)
 		git bisect--helper --bisect-reset "$@" ;;
 	replay)
-		bisect_replay "$@" ;;
+		git bisect--helper --bisect-replay "$@" || exit;;
 	log)
 		git bisect--helper --bisect-log || exit ;;
 	run)
-- 
2.29.2

