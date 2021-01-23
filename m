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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96155C433E9
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615D623340
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 15:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbhAWPmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 10:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAWPmb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 10:42:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD30C061788
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id y187so6951051wmd.3
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 07:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aUJrjMK0Q+C12jQSkQ0AcHKYHmtpKa9IXdaArtkdLA=;
        b=GEubxHBhYE8Pont5dLfB35tAYFt2o8uavygsFGRSzZMJ3c+pg2JIqnj3YAUuM4at4n
         A0O6jqQZsELjgzS81SidfOyJxo9HnUu3cQO79hQ/knJ8InrEOpI/AhEfG/oXmST6evxh
         QJW8lgisWZdc215/VfcII/VQhMWy8j6Rg6ujWXIZrwiYpFLTmn6Q8/c6I4qF1p+12sFy
         vEXv/JMHJMJQqdC4ogeExZIgvEhY4hYmKN75o4OxJjViFx+XAQe6kyPv/lEz4TLWxEb4
         dCavdzcJ3HLGdP/zBJO2sEuNNJAMbq0em3wrsXpCAtCXZWZBT1yCRAaYO4DLBFoHv3Ru
         S+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aUJrjMK0Q+C12jQSkQ0AcHKYHmtpKa9IXdaArtkdLA=;
        b=qHIvzMGsbJv1dCOPSriLO/Ji4Pz1ixUO79e82ufERpu2jhSpf5Ikgm5qBb2Z8jzBrN
         G0g5bkR0N+/BqnSKuTCL6sqv94ZdeFDNlrC0Q0gnTFH2d1ajlNK4SybwDR+dg6El17Cy
         /tQXZ4MCZPL3u5pZPwZFqIzPGWStV6/iDzt0Fh8TfR/vu5A46P535GBtCBjsTqHlIs1K
         FqN8UOD0n7AVnFnXvDK5+8d2FEH5ex4ZGk0ImM5mn7RrpGTOZoPA7ClouOoxwo5eSL+g
         dGZC3Gnbnccrp49N6M0sjNzbOLnuBF7hUMFp0hHjXHscWwySJ9XaS21cnjQwTzbaKs2A
         0hEw==
X-Gm-Message-State: AOAM532xzH0SxHKABHUfY/nNEstkBocz7XTzPPaI/c1AnsFbvgziVQC/
        VIOP/Evb7ZrZBhAUbJGWrqhTQx/a6jI=
X-Google-Smtp-Source: ABdhPJz0HLJCYSaG0K7K880GZNfraMNvHKBcL6HgWKcGDYBpFrfJSyF1x5AI36Ri3Fe5sp9kLUf+3g==
X-Received: by 2002:a1c:a501:: with SMTP id o1mr8687919wme.21.1611416508413;
        Sat, 23 Jan 2021 07:41:48 -0800 (PST)
Received: from localhost.localdomain ([81.0.50.72])
        by smtp.gmail.com with ESMTPSA id o8sm16772353wrm.17.2021.01.23.07.41.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 07:41:47 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 2/7] bisect--helper: reimplement `bisect_replay` shell function in C
Date:   Sat, 23 Jan 2021 16:40:51 +0100
Message-Id: <20210123154056.48234-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123154056.48234-1-mirucam@gmail.com>
References: <20210123154056.48234-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 84 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 34 +---------------
 2 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a65244a0f5..4d8dca3717 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-replay <filename>"),
 	NULL
 };
 
@@ -916,6 +917,78 @@ static enum bisect_error bisect_log(void)
 	return status ? BISECT_FAILED : BISECT_OK;
 }
 
+static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
+{
+	const char *p = line->buf + strspn(line->buf, " \t");
+
+	if ((!skip_prefix(p, "git bisect", &p) &&
+	!skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
+		return 0;
+	p += strspn(p, " \t");
+
+	char *word_end = (char*)p + strcspn(p, " \t");
+	char *rev = word_end + strspn(word_end, " \t");
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
@@ -929,7 +1002,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_STATE,
-		BISECT_LOG
+		BISECT_LOG,
+		BISECT_REPLAY
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -953,6 +1027,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
 			 N_("list the bisection steps so far"), BISECT_LOG),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1020,6 +1096,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index c6149846ff..79bcd31bd7 100755
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
 		git bisect--helper --bisect-log || exit;;
 	run)
-- 
2.29.2

