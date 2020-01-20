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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790AEC33CB8
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BEC217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXMCaUhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgATOix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:53 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34115 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgATOiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:52 -0500
Received: by mail-wr1-f45.google.com with SMTP id t2so29834678wrr.1
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0d36u0TnqROHGHw4em5qvi5lNbyt5d5MgsR7trTkb0U=;
        b=RXMCaUhsAWB/JPc7pOLUfZfGHm7TsM3mIIKNTo5s6U8NIvG5vQzAYxrQYpRFB5Sx6Z
         iPjxz9E4NeCDZ78cPz1LDXEfOQfOVD/7apPAikEp5NKUfhWnqNGPdk1B8qVhnC4lla8R
         US0PNBzN8O5f0pYTH2aDsD13PpztkPa1/IfzqirDsNz2EsDCULKpJbmg4JoJBzvOGm4D
         +Gka4VUOFAzABcY+KP1CXReGRjBzO5bvXW/LIRV9qwyLgpYwlofSw1czmnmDnUVW0f3v
         YJpAQDE5sF5aCN1n81tQHeRL7l+CUVEJ25YLShrAHza0aDEm+ciC2ZYoKA/BiQk6Qw4x
         coAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0d36u0TnqROHGHw4em5qvi5lNbyt5d5MgsR7trTkb0U=;
        b=MOmAPueNvrA8kwsWyAyj7CfyVkD1/3c4fk6bLaPxLa9db7eo/4KMGJIHl5ZgZ1ThfQ
         iEROz8LJuDU4K0yA2qoN/YmNWKwzUYf0cZAQOjcsTkSjLLQGZen4S+kt62j9v1X9kyyQ
         gaXGJABi6yzERnXVodbpyJEujhTO8cHjNiVbZpMzqg4qkMdUA7KvJiqXLyleHyuLpMjz
         NmiOhPKhO7h9elHE/iO5NwXcsRC8s8c2ZnedXOhzQf2uQ3EOA7As/j8BcjDxCP9Ydfs1
         /gddAuz1QDMAUbrLDQztqHllRo8o+IbMDwzNMvahKsBHJIIAlvi0hM7WK94diW0wLTqd
         t5eA==
X-Gm-Message-State: APjAAAU6JbP/Pd2H0zXpVtF6YHksov4cILU10+OPcfHpXMgFM0uLkrF6
        CaDmtfB4Voxm4EJ6aN9t5I6O2Ne+eP4=
X-Google-Smtp-Source: APXvYqyBSOMJU+s9H+k0OFiJ1S5FF+HaKUlv3Pw8o+KX6eZ1fLDfh60VTys0XxsKaraRJinQrrhJJw==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr17774231wrv.333.1579531129251;
        Mon, 20 Jan 2020 06:38:49 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:48 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 17/29] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
Date:   Mon, 20 Jan 2020 15:37:48 +0100
Message-Id: <20200120143800.900-18-mirucam@gmail.com>
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
index f03ed23431..fdcc5f47ec 100644
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
 
@@ -823,6 +825,74 @@ static int bisect_autostart(struct bisect_terms *terms)
 	return 0;
 }
 
+static char *bisect_head(void)
+{
+	if (is_empty_or_missing_file(git_path_bisect_head()))
+		return "HEAD";
+	else
+		return "BISECT_HEAD";
+}
+
+static int bisect_state(struct bisect_terms *terms, const char **argv,
+			int argc)
+{
+	const char *state = argv[0];
+
+	if (check_and_set_terms(terms, state))
+		return -1;
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
+			return -1;
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
+				return -1;
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
+	return -1;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -837,6 +907,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
 		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -862,6 +933,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -934,6 +1007,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index 97bb15b38f..4a5afc7a93 100755
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
2.21.1 (Apple Git-122.3)

