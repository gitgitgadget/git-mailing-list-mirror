Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4749C4BA0E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7062F20838
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mErzXYaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBZKQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:16:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46983 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgBZKQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 05:16:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so2183032wrp.13
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 02:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fulm3CjI26d9VOL5FFFdXoXKHBsKpl+F/VrnOyzKu4s=;
        b=mErzXYaPGgJuAG1+uEULJuQy+PR2kw3wuRXoh1xxjj3ekQcpSy2sQ39F/01h6QBO+E
         QE+I8j66vjgX5cJZjvEXhKsg/uI6fXQRfipyxOkNGAMHnEQbelCVO9OHDp510wsDI8tV
         Q8ItxKEcS3djvuE6cQuzsNafQSw+m8SsgK2se6iySJnb6QHRl77I5IMYedFRXki3gHBE
         Er87LBwPtixy+TcuH4CIKs54HWk966xlJKQ4yrS3RP4o4vHVC1voC8VqwbaEzkaLkZVg
         VUNBF73KA0pGQEtr72n7+q2soRRNJrQdkHHZcAgVUArrkiPItzDT9bUkPhiJOgu/jfFZ
         KL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fulm3CjI26d9VOL5FFFdXoXKHBsKpl+F/VrnOyzKu4s=;
        b=CJ0RMhDnQjQVYp7I6nRaqdnGif960/HcwFpFYlrRjjR9wAGTuxRks/f3YMckKXabR9
         7xMhV9SIVp8tsHn5gDHFg41qJdfNDEIvXuYT2im7kDQBw1aBeNtyvMRIrEFXyN4t46P4
         6riL15PcP5HcjSQt/UEkNL8FjXFBH9iHcsFqLhkFnJ65gT7h+r47lq2jSJ2QbwF+re65
         4alMtKBOFDwyDo/cVDD6aa5EJNhhMmOksemTy0whY4RHtQGOCpKozaBjnSyrv2vFnWVl
         2Vf5G/JeHm/pIYKElRXkHgZX5fsDDQskuV7H+zlE7tRGcEudH+72EqqcOYQW8qipSJG3
         8rUA==
X-Gm-Message-State: APjAAAXmLg4neMQJqgCQ976ChaT662DZwwx5y7jwQG329fXIs6tSQL9b
        SKVHehB4JCs/Y7FL5HjtUeQRSsW8P1g=
X-Google-Smtp-Source: APXvYqxVscQfHm86mk3XS44XLZx4irEApiiWXrORfq86GEarxvUTqBwyXg/9DzXVChjAyPIV4veM/w==
X-Received: by 2002:adf:e80e:: with SMTP id o14mr4620412wrm.212.1582712175922;
        Wed, 26 Feb 2020 02:16:15 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id t3sm2577081wrx.38.2020.02.26.02.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 02:16:15 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 07/10] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
Date:   Wed, 26 Feb 2020 11:14:26 +0100
Message-Id: <20200226101429.81327-8-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101429.81327-1-mirucam@gmail.com>
References: <20200226101429.81327-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 80 ++++++++++++++++++++++++++++++++++++++++
 git-bisect.sh            | 55 ++-------------------------
 2 files changed, 84 insertions(+), 51 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f9b04bee23..fedcad4d9b 100644
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
 
@@ -833,6 +835,74 @@ static int bisect_autostart(struct bisect_terms *terms)
 	return BISECT_OK;
 }
 
+static char *bisect_head(void)
+{
+	if (is_empty_or_missing_file(git_path_bisect_head()))
+		return "HEAD";
+	else
+		return "BISECT_HEAD";
+}
+
+static enum bisect_error bisect_state(struct bisect_terms *terms, const char **argv,
+			int argc)
+{
+	const char *state = argv[0];
+
+	if (check_and_set_terms(terms, state))
+		return BISECT_FAILED;
+
+	if (!argc)
+		return error(_("Please call `--bisect-state` with at least one argument"));
+
+	if (argc == 1 && one_of(state, terms->term_good,
+	    terms->term_bad, "skip", NULL)) {
+		const char *bisected_head = xstrdup(bisect_head());
+		const char *hex[1];
+		struct object_id oid;
+
+		if (get_oid(bisected_head, &oid))
+			return error(_("Bad rev input: %s"), bisected_head);
+		if (bisect_write(state, oid_to_hex(&oid), terms, 0))
+			return BISECT_FAILED;
+
+		*hex = xstrdup(oid_to_hex(&oid));
+		check_expected_revs(hex, 1);
+		return bisect_auto_next(terms, NULL);
+	}
+
+	if ((argc == 2 && !strcmp(state, terms->term_bad)) ||
+			one_of(state, terms->term_good, "skip", NULL)) {
+		int i;
+		struct string_list hex = STRING_LIST_INIT_DUP;
+
+		for (i = 1; i < argc; i++) {
+			struct object_id oid;
+
+			if (get_oid(argv[i], &oid)) {
+				string_list_clear(&hex, 0);
+				return error(_("Bad rev input: %s"), argv[i]);
+			}
+			string_list_append(&hex, oid_to_hex(&oid));
+		}
+		for (i = 0; i < hex.nr; i++) {
+			const char **hex_string = (const char **) &hex.items[i].string;
+			if (bisect_write(state, *hex_string, terms, 0)) {
+				string_list_clear(&hex, 0);
+				return BISECT_FAILED;
+			}
+			check_expected_revs(hex_string, 1);
+		}
+		string_list_clear(&hex, 0);
+		return bisect_auto_next(terms, NULL);
+	}
+
+	if (!strcmp(state, terms->term_bad))
+		return error(_("'git bisect %s' can take only one argument."),
+		      terms->term_bad);
+
+	return BISECT_FAILED;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -847,6 +917,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -872,6 +943,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -944,6 +1017,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_autostart(&terms);
 		break;
+	case BISECT_STATE:
+		if (!argc)
+			return error(_("--bisect-state requires at least one revision"));
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 049ffacdff..7f10187055 100755
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
+		( git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN" )
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

