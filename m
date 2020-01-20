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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A635C2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5D7217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4p0qu7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgATOjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:39:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40746 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgATOjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:39:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so14928027wmi.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8W2HmF+PR9JX5J6fMQs20rJdoG5VqweMrw7JI1tuJ4=;
        b=t4p0qu7iEaT9KcvDi+CBeaktIAhD2nXqrNtAV/VcslolrpXt6pSrp5ePObJysRTgwL
         wdIQSAzPnLHchQJhqrIHhbeIMxscyXRcqvFvfzoInb6Q9+k6IHk7ZXX99GzutpWGsxaV
         7JMsioB0HweAVOSZl4f8vz+ynut73bIkmoiyftvzcX4OZ1dG1J23/FkaBptElcWRznld
         qb4VY9Cv5LXN48zOn7DXBYH5jQPwcjKSb8WghVGT8nGMyuuwTARQVxAS3KrWuIb32yCF
         ip2jJNh4pdQAGxez9IzjsclcO4Mylsz710yFqnhkiOOh7d0Sm+du0qv9MLOVAROo4zDe
         eiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8W2HmF+PR9JX5J6fMQs20rJdoG5VqweMrw7JI1tuJ4=;
        b=dGkmkON1PmSH01Z8GBYGoSbfK6deufmBd20HnhvLhX0/1eut58adPMIn0jxyTgVfV8
         k5ivTnpsGAAqQaf4nANbfnULPzxZcQFrH/t5Wc/kZJysPGoFxVu8B7cKpwvrdsCD+rQc
         P7QHycrMBPPlVvIjIolT1I73DlmE/nYzp7OpFOVj/1VJf+jnQCTxt0R6OReat3v0+t+j
         a4p8y6jv/GI9NB4K653HsmBroNk3tfbh71V/98fqQ/ZOQE7bbUvaG+C5WU1nM++qmlyH
         i+Rf3zwUdnXZ4QLjDH0ZNdOZXBfJapvATjYs3XGNju9nre8DhPn5iyNOoPwxG9v6cysf
         J43A==
X-Gm-Message-State: APjAAAV/uhQWFQ5so+Tu2JkhsK6tI2qqe92B6h5KnVp0y8KZFzpur1J0
        VwGv6ZILVobcFb9GjTpP8j/uGCi6OgU=
X-Google-Smtp-Source: APXvYqxh7JhGuIF2snOgwmoLUUalbgsYvp43U2ltlQpo/eVT8roUDbJZdPpL87a0knoBEy8cy4vYvg==
X-Received: by 2002:a7b:c1c7:: with SMTP id a7mr19080367wmj.168.1579531140532;
        Mon, 20 Jan 2020 06:39:00 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:39:00 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 26/29] bisect--helper: reimplement `bisect_skip` shell function in C
Date:   Mon, 20 Jan 2020 15:37:57 +0100
Message-Id: <20200120143800.900-27-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 46 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 17 +--------------
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a40477811e..841a76fc7c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -30,6 +30,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
 	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	N_("git bisect--helper --bisect-replay <filename>"),
+	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
 	NULL
 };
 
@@ -1017,6 +1018,42 @@ static int bisect_replay(struct bisect_terms *terms, const char *filename)
 	return bisect_auto_next(terms, NULL);
 }
 
+static int bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
+{
+	int i, res;
+	const char *pattern = "*..*";
+	struct argv_array argv_state = ARGV_ARRAY_INIT;
+
+	argv_array_push(&argv_state, "skip");
+
+	for (i = 0; i < argc; i++) {
+		if (!wildmatch(pattern, argv[i], 0)) {
+			struct rev_info revs;
+			struct commit *commit;
+			struct argv_array rev_argv = ARGV_ARRAY_INIT;
+
+			argv_array_pushl(&rev_argv, "skipped_commits", argv[i], NULL);
+			init_revisions(&revs, NULL);
+			setup_revisions(rev_argv.argc, rev_argv.argv, &revs, NULL);
+			argv_array_clear(&rev_argv);
+
+			if (prepare_revision_walk(&revs))
+				die(_("revision walk setup failed\n"));
+			while ((commit = get_revision(&revs)) != NULL)
+				argv_array_push(&argv_state,
+						oid_to_hex(&commit->object.oid));
+
+			reset_revision_walk();
+		} else {
+			argv_array_push(&argv_state, argv[i]);
+		}
+	}
+	res = bisect_state(terms, argv_state.argv, argv_state.argc);
+	
+	argv_array_clear(&argv_state);
+	return res;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -1028,7 +1065,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_STATE,
 		BISECT_LOG,
-		BISECT_REPLAY
+		BISECT_REPLAY,
+		BISECT_SKIP
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -1050,6 +1088,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("output the contents of BISECT_LOG"), BISECT_LOG),
 		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
 			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
+		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
+			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -1116,6 +1156,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_replay(&terms, argv[0]);
 		break;
+	case BISECT_SKIP:
+		set_terms(&terms, "bad", "good");
+		res = bisect_skip(&terms, argv, argc);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 0555191c41..edfd3f8b3d 100755
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
+		git bisect--helper --bisect-skip "$@" ;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
 		get_terms
-- 
2.21.1 (Apple Git-122.3)

