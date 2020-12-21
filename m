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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C0AC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4119322D08
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgLUS3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgLUS3R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:29:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDEC061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:28:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id x22so10754106wmc.5
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 10:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJqhNm87GSjCdCywAYJpS4qIgGDyQgol4K63s9C25jQ=;
        b=hz/5wd5pGXchAaQBhmLv87KDI4MjpfV/UEQ/ElCdm3tQ0HSSv5+jRpbShmn6/LsCcW
         WeladbuBF67Ic3a6ND6LJYglcG0RSbnHwWVxLIVr4VwU/lbfvOG2LKhPpC/SzD+bvlmH
         uHtheV50pEN7aWPLRRlU2hohgbnXdZk8A4whICGc6mfmXgrCRtg1a1WyjegXUJ6/fYsr
         Fh4UzoACNTjLnN3HnGPuIfC7HT0lTHTfG81JQnLf0gJCLwnvD4iUi8C0mSfsjCVNFpD+
         m6OTNHtAE0cp7szptq7dXWl7D+vOTMzkow6tX04G//vPycbCn74sPCYkvbBMyP0lJPDX
         hsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJqhNm87GSjCdCywAYJpS4qIgGDyQgol4K63s9C25jQ=;
        b=nvNq+MDuOWSPl4NcJAt0BimHWDnwhs0HZFrjCCTAuOlG6l+ioAyvP+1LJ128kkHFxt
         0hSJqUvw0K0zRFsNTZ9DIZqJbk27Twh/kJBDSzyRBIkJNHqBj31FQ/vm8/CWaFn1zApb
         EbvgKfP7T9IJDY53CNBHovtfRI2/ksZyDzydKUO1/xZxUF+pEOYMm+RpAu5/rdtTqx4A
         w4i3IyJWqesxG+PP63fBvj80WAfDWG7ih2HDulV+5NuJLSDAtpyTmMBzMpPO+Vn91ige
         ZGOmMEQqx3k0q0QjHtdiWn8BosdR/lcxgbLmygZI6uwK8dMWK4hgQZs4YXGJsuVHBqFQ
         GxtA==
X-Gm-Message-State: AOAM532+TlCqKx6L/MYqjQ6KvTno5zfYLyFG5btF9XKTjeUlO2FFEU33
        ZDkchV7EK0krYGJj0g/zvA4pYS0ea67XLQ==
X-Google-Smtp-Source: ABdhPJz0yNA/mkH82QxR8A8Nhg7gwq5S4Bz3BvJZa4YjQnnIv3vxGgQpEarkNYOVNOuexlqc8hCNWw==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr17210194wmh.132.1608568169437;
        Mon, 21 Dec 2020 08:29:29 -0800 (PST)
Received: from localhost.localdomain ([81.0.34.85])
        by smtp.gmail.com with ESMTPSA id w18sm28523532wrn.2.2020.12.21.08.29.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 08:29:28 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 2/7] bisect--helper: reimplement `bisect_replay` shell function in C
Date:   Mon, 21 Dec 2020 17:27:38 +0100
Message-Id: <20201221162743.96056-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221162743.96056-1-mirucam@gmail.com>
References: <20201221162743.96056-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 127 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  34 +----------
 2 files changed, 127 insertions(+), 34 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 1854377fa6..92c783237d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-replay <filename>"),
 	NULL
 };
 
@@ -916,6 +917,121 @@ static enum bisect_error bisect_log(void)
 	return status ? BISECT_FAILED : BISECT_OK;
 }
 
+static int get_next_word(const char *line, int pos, struct strbuf *word)
+{
+	int i, len = strlen(line), begin = 0;
+
+	strbuf_reset(word);
+	for (i = pos; i < len; i++) {
+		if (line[i] == ' ' && begin)
+			return i + 1;
+
+		if (!begin)
+			begin = 1;
+		strbuf_addch(word, line[i]);
+	}
+
+	return i;
+}
+
+static int process_line(struct bisect_terms *terms, struct strbuf *line, struct strbuf *word)
+{
+	int res = 0;
+	int pos = 0;
+
+	while (pos < line->len) {
+		pos = get_next_word(line->buf, pos, word);
+
+		if (!strcmp(word->buf, "git"))
+			continue;
+		else if (!strcmp(word->buf, "git-bisect"))
+			continue;
+		else if (!strcmp(word->buf, "bisect"))
+			continue;
+		else if (starts_with(word->buf, "#"))
+			break;
+
+		get_terms(terms);
+		if (check_and_set_terms(terms, word->buf))
+			return -1;
+
+		if (!strcmp(word->buf, "start")) {
+			struct strvec argv = STRVEC_INIT;
+			int res;
+			sq_dequote_to_strvec(line->buf+pos, &argv);
+			res = bisect_start(terms, argv.v, argv.nr);
+			strvec_clear(&argv);
+			if (res)
+				return -1;
+			break;
+		}
+
+		if (one_of(word->buf, terms->term_good,
+			   terms->term_bad, "skip", NULL)) {
+			if (bisect_write(word->buf, line->buf+pos, terms, 0))
+				return -1;
+			break;
+		}
+
+		if (!strcmp(word->buf, "terms")) {
+			struct strvec argv = STRVEC_INIT;
+			int res;
+			sq_dequote_to_strvec(line->buf+pos, &argv);
+			res = bisect_terms(terms, argv.nr == 1 ? argv.v[0] : NULL);
+			strvec_clear(&argv);
+			if (res)
+				return -1;
+			break;
+		}
+
+		error(_("Replay file contains rubbish (\"%s\")"),
+		      word->buf);
+		res = -1;
+	}
+	return res;
+}
+
+static int process_replay_file(FILE *fp, struct bisect_terms *terms)
+{
+	struct strbuf line = STRBUF_INIT;
+	struct strbuf word = STRBUF_INIT;
+	int res = 0;
+
+	while (strbuf_getline(&line, fp) != EOF) {
+		res = process_line(terms, &line, &word);
+		if (res)
+			break;
+	}
+
+	strbuf_release(&line);
+	strbuf_release(&word);
+	return res;
+}
+
+static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *filename)
+{
+	FILE *fp = NULL;
+	enum bisect_error res = BISECT_OK;
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
+	res = process_replay_file(fp, terms);
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
@@ -929,7 +1045,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_STATE,
-		BISECT_LOG
+		BISECT_LOG,
+		BISECT_REPLAY
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -953,6 +1070,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1020,6 +1139,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

