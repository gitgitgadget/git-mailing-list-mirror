Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38168C54FCA
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E0320757
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpA4+nut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCUQOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:14:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36426 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCUQOB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 12:14:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so5201599wrs.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uw5HR6e20M9HisL/8TO3lfinEm0oJVAz0kwptsk9L7A=;
        b=BpA4+nutTZtPkOUv9OOz4uwiA2YjUzXJJ8QYRyxwPe/7iD6r7/tx6n9E56jY89npIE
         bSxI9PB0buh8u53JOL3diDyUwCb1rR10UNY3Gcu+oezpZ8wogWvaEmQMMYWCjo2nBk8l
         uMuCuAHb4dTAm/1efDdsPXUPGP3aqUUdl9LgVaaSryg9NRqSca6SAEsHJv+RTBkHOzx4
         fA3ZNfWLPAQhjwTvByfOHvJgGcCsMzNi1OQXFFdkkqKxawFlzQVZjWBKVBT8g/iWwRt3
         jl4I8lDaSLucMd8doxELMsAWKa+2Cihmx1dQPdQjYl62g5F5JAkndc4tMCXlW4+hq8NQ
         1ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uw5HR6e20M9HisL/8TO3lfinEm0oJVAz0kwptsk9L7A=;
        b=OP+tNHmjgeWnS5w6IlCpCV8OtPiUXxDgwZXFW1xnS31q0JUdPxwHf3IA0zZdp1mvnu
         +fe6SBmNb3P6DiWr/X0R792JWAHHU6ulqSdJlF88MMTCgK8HuvphY8SC+unCZHTnXGW/
         vm1anTLVz2lfwDPz/psZCwpomC8r9W9IMk0EIYTn9qiDpQHMNw5Ti6+grwcnKgSeClnI
         Qhg2oaczCaDYUNAPN+mZPSQscGjUKwsnn1vylyMro2OdxZEwmOXEs1n/t+etolY9fgym
         BvRBVQQ4a4k0t++K9dorQzv9CC8G+5N5RVgawOXtxmJEqslTn2OVMjeszgxI9JCsW3Z/
         FWWA==
X-Gm-Message-State: ANhLgQ0T+j/Dy8HvNsL8JV4cDoINiXDTS2WUGzmjh/wkdedLLSuCBncL
        iBkYWhWw9hkQPLFtYBmyFUAguVKB8qI=
X-Google-Smtp-Source: ADFU+vuVlBSnWH2qTVDJO8L83TiRA8qgtbsF5GtitV88khlQp74XbGN9YNJXo/RRhvtxUcSw2cZOLA==
X-Received: by 2002:a5d:468c:: with SMTP id u12mr3043870wrq.394.1584807238954;
        Sat, 21 Mar 2020 09:13:58 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id f22sm13992285wmf.2.2020.03.21.09.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 09:13:58 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 08/11] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
Date:   Sat, 21 Mar 2020 17:10:17 +0100
Message-Id: <20200321161020.22817-9-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200321161020.22817-1-mirucam@gmail.com>
References: <20200321161020.22817-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_state()` shell functions in C and also add a
subcommand `--bisect-state` to `git-bisect--helper` to call them from
git-bisect.sh .

Using `--bisect-state` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired and will be called by some
other methods.

`bisect_head()` is only called from `bisect_state()`, thus it is not
required to introduce another subcommand.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 68 ++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 55 +++-----------------------------
 2 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4496fd2228..6364bd82c0 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-next"),
 	N_("git bisect--helper --bisect-auto-next"),
 	N_("git bisect--helper --bisect-autostart"),
+	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
+	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
 	NULL
 };
 
@@ -832,6 +834,64 @@ static int bisect_autostart(struct bisect_terms *terms)
 	return bisect_start(terms, 0, NULL, 0);
 }
 
+static int bisect_head(struct object_id *oid)
+{
+	if (is_empty_or_missing_file(git_path_bisect_head()))
+		return get_oid("HEAD", oid);
+
+	return get_oid("BISECT_HEAD", oid);
+}
+
+static enum bisect_error bisect_state(struct bisect_terms *terms, const char **argv,
+			int argc)
+{
+	const char *state;
+	const char *hex;
+	int i;
+	struct oid_array revs = OID_ARRAY_INIT;
+	struct object_id oid;
+
+	if (!argc)
+		return error(_("Please call `--bisect-state` with at least one argument"));
+	state = argv[0];
+	if (check_and_set_terms(terms, state) ||
+	    !one_of(state, terms->term_good,terms->term_bad, "skip", NULL))
+		return BISECT_FAILED;
+	argv++;
+	argc--;
+	if (!strcmp(state, terms->term_bad) && (argc > 1))
+		return error(_("'git bisect %s' can take only one argument."),terms->term_bad);
+	if (argc == 0) {
+		if (bisect_head(&oid))
+			return error(_("Bad bisect_head rev input"));
+		hex = oid_to_hex(&oid);
+		if (bisect_write(state, hex, terms, 0))
+			return BISECT_FAILED;
+		check_expected_revs(&hex, 1);
+		return bisect_auto_next(terms, NULL);
+	}
+
+	/* Here argc > 0 */
+	for (; argc; argc--, argv++) {
+		struct object_id oid;
+		if (get_oid(*argv, &oid))
+			return error(_("Bad rev input: %s"), *argv);
+		oid_array_append(&revs, &oid);
+	}
+
+	for (i = 0; i < revs.nr; i++) {
+		hex = oid_to_hex(&revs.oid[i]);
+		if (bisect_write(state, hex, terms, 0)) {
+			oid_array_clear(&revs);
+			return BISECT_FAILED;
+		}
+		check_expected_revs(&hex, 1);
+	}
+
+	oid_array_clear(&revs);
+	return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -846,6 +906,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -871,6 +932,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -943,6 +1006,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_autostart(&terms);
 		break;
+	case BISECT_STATE:
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		res = error(_("BUG: unknown subcommand."));
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 049ffacdff..2da0810b1a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,16 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_head()
-{
-	if test -f "$GIT_DIR/BISECT_HEAD"
-	then
-		echo BISECT_HEAD
-	else
-		echo HEAD
-	fi
-}
-
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -61,43 +51,7 @@ bisect_skip() {
 		esac
 		all="$all $revs"
 	done
-	eval bisect_state 'skip' $all
-}
-
-bisect_state() {
-	git bisect--helper --bisect-autostart
-	state=$1
-	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
-	get_terms
-	case "$#,$state" in
-	0,*)
-		die "Please call 'bisect_state' with at least one argument." ;;
-	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
-		bisected_head=$(bisect_head)
-		rev=$(git rev-parse --verify "$bisected_head") ||
-			die "$(eval_gettext "Bad rev input: \$bisected_head")"
-		git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
-		git bisect--helper --check-expected-revs "$rev" ;;
-	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
-		shift
-		hash_list=''
-		for rev in "$@"
-		do
-			sha=$(git rev-parse --verify "$rev^{commit}") ||
-				die "$(eval_gettext "Bad rev input: \$rev")"
-			hash_list="$hash_list $sha"
-		done
-		for rev in $hash_list
-		do
-			git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
-		done
-		git bisect--helper --check-expected-revs $hash_list ;;
-	*,"$TERM_BAD")
-		die "$(eval_gettext "'git bisect \$TERM_BAD' can take only one argument.")" ;;
-	*)
-		usage ;;
-	esac
-	git bisect--helper --bisect-auto-next
+	eval git bisect--helper --bisect-state 'skip' $all
 }
 
 bisect_visualize() {
@@ -185,8 +139,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state="$TERM_GOOD"
 		fi
 
-		# We have to use a subshell because "bisect_state" can exit.
-		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
+		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
 		res=$?
 
 		cat "$GIT_DIR/BISECT_RUN"
@@ -201,7 +154,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 		if [ $res -ne 0 ]
 		then
 			eval_gettextln "bisect run failed:
-'bisect_state \$state' exited with error code \$res" >&2
+'git bisect--helper --bisect-state \$state' exited with error code \$res" >&2
 			exit $res
 		fi
 
@@ -242,7 +195,7 @@ case "$#" in
 	start)
 		git bisect--helper --bisect-start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		bisect_state "$cmd" "$@" ;;
+		git bisect--helper --bisect-state "$cmd" "$@" ;;
 	skip)
 		bisect_skip "$@" ;;
 	next)
-- 
2.25.0

