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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B90BC33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F58217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBpQrKi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgATOi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39892 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgATOi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so29822528wrt.6
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJqn+RjswlxjZ5TZ5CR3uaYYOaI2PlfIF5pz3kxr92A=;
        b=EBpQrKi2mmfOKR3uDJ+l50LAT0ioEShQHBoCOZmlxAwuaoL44Ox08mKu8UxdVnBuix
         jlQ2FDAin868ZLB1Du1/sSo6OQsYTkdSdXICa/n7/33Xrokxwl/foL4V2s/Lm0UQgqVV
         QAmC/tAtbL9Ka/La30FdLeAvgOaXnLXicZEcNbGjvjac2QkuVS0OlHN9ryCVdtYgDAIA
         7d3OEUNtjusUdyBS9uJhh8swwUBgI9xRYoN3mhhNTgkjW5ESHxgbqG7U0/0Pc/na+lYp
         whJS06XJVW+QraSBqFX6mVolUNsm29N/K9e0Sro863fgzK+cGHPETGsFLae4nIu/+0vV
         ksLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJqn+RjswlxjZ5TZ5CR3uaYYOaI2PlfIF5pz3kxr92A=;
        b=lWKyimC1CohADc8X4JDAd9xz6Dvh/ug6W2nIgJCcIOTmpDJImRdYpoxtVafyO3BAsq
         VYB+iZttqGYukIObzL0RdfBZZBG7tJ+0is6qYQ9ieIH/guS2C3QCaUiceT5ImSCziNMI
         xxjC6SdPNgOphyFEsTc4+1z4cR15AWG57ATHxMXJ9BWWPdPIMXNbUerSxKs3GsHcoxsM
         CW5c9fq7RmD64D+lNnyRBQSN3OVVsBtJsqz2Rz3dJLA35POdRL8yVMyEPLKkhKgN9jcB
         nMp/yMXPWHDF4lF9s9XSRkbamhuH3L3rlQeg0cdy7pPYIeBPNZrCUlxGCv+xQZJp7nwy
         QnjA==
X-Gm-Message-State: APjAAAXOOoiEvw6Mo3piBBS/UyQKGQKNx67dep21+YKTMC7u+jCN+mmE
        +Awwxp6hAQ3ioj3UvtJW+Rc/ibjq5Kk=
X-Google-Smtp-Source: APXvYqzhWPP96e4N6X50ecp+iAqYY+zpB8QWKoB4l6X3l7A//EAYZJ6k3sZnK5IQaNsi/z01c4ndSg==
X-Received: by 2002:adf:b648:: with SMTP id i8mr18566296wre.91.1579531134338;
        Mon, 20 Jan 2020 06:38:54 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:53 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 21/29] bisect--helper: reimplement `bisect_replay` shell function in C
Date:   Mon, 20 Jan 2020 15:37:52 +0100
Message-Id: <20200120143800.900-22-mirucam@gmail.com>
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
 git-bisect.sh            |  32 +---------
 2 files changed, 127 insertions(+), 32 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4795b7880c..4b4ce13b50 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -32,6 +32,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-autostart"),
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+	N_("git bisect--helper --bisect-replay <filename>"),
 	NULL
 };
 
@@ -904,6 +905,121 @@ static int bisect_log(void)
         return status ? -1 : 0;
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
+			struct argv_array argv = ARGV_ARRAY_INIT;
+			int res;
+			sq_dequote_to_argv_array(line->buf+pos, &argv);
+			res = bisect_start(terms, 0, argv.argv, argv.argc);
+			argv_array_clear(&argv);
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
+			struct argv_array argv = ARGV_ARRAY_INIT;
+			int res;
+			sq_dequote_to_argv_array(line->buf+pos, &argv);
+			res = bisect_terms(terms, argv.argc == 1 ? argv.argv[0] : NULL);
+			argv_array_clear(&argv);
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
+static int bisect_replay(struct bisect_terms *terms, const char *filename)
+{
+	FILE *fp = NULL;
+	int res = 0;
+
+	if (is_empty_or_missing_file(filename))
+		return error(_("cannot read file '%s' for replaying"), filename);
+
+	if (bisect_reset(NULL))
+		return -1;
+
+	fp = fopen(filename, "r");
+	if (!fp)
+		return -1;
+
+	res = process_replay_file(fp, terms);
+	fclose(fp);
+	
+	if (res)
+		return -1;
+
+	return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -917,7 +1033,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
 		BISECT_STATE,
-		BISECT_LOG
+		BISECT_LOG,
+		BISECT_REPLAY
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -943,6 +1060,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_CMDMODE(0, "bisect-log", &cmdmode,
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
+		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
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
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 151358aeda..0555191c41 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,36 +77,6 @@ bisect_visualize() {
 	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }
 
-bisect_replay () {
-	file="$1"
-	test "$#" -eq 1 || die "$(gettext "No logfile given")"
-	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
-	git bisect--helper --bisect-reset || exit
-	while read git bisect command rev
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
-			eval "git bisect--helper --bisect-start $rev" ;;
-		"$TERM_GOOD"|"$TERM_BAD"|skip)
-			git bisect--helper --bisect-write "$command" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
-		terms)
-			git bisect--helper --bisect-terms $rev || exit;;
-		*)
-			die "$(gettext "?? what are you talking about?")" ;;
-		esac
-	done <"$file"
-	git bisect--helper --bisect-auto-next
-}
-
 bisect_run () {
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
@@ -202,7 +172,7 @@ case "$#" in
 	reset)
 		git bisect--helper --bisect-reset "$@" ;;
 	replay)
-		bisect_replay "$@" ;;
+		git bisect--helper --bisect-replay "$@" ;;
 	log)
 		git bisect--helper --bisect-log ;;
 	run)
-- 
2.21.1 (Apple Git-122.3)

