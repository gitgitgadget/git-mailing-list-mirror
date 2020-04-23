Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD65C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6CC208E4
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 07:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWjMTQcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgDWHJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbgDWHJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 03:09:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0CC03C1AB
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:47 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v4so6685917wme.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 00:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpdbud4hfnMVUvj7AlpMG3y8rFTxRiD4XDqYg8qCQGU=;
        b=BWjMTQcuaFeiZtW5SxdEs7cTMXQ1sIKckp97sFH5wzbuJ7IBfQOJOYxU7+ArxuFgaA
         WLYGF1FSA3iw7Z7vBdsqPF0Xlk0843N2YPPlkWZocwTnnUT00DxHd52f+aGf0mW9Io+F
         IaShww0NznUtjkjCeYt+Obm/o0wQVQ/WiQrM1p3BfDrX4jXz7ofjypEUohyFZUETYd0U
         AZMagETK5Tmbjpv5BgFj/ALLJZ5TrWb8tv005f8Mzf9eqNNCiaKSZtypkfaS6R4O9dCw
         lvTirN7W5HA+UB4h5EpWhkkb0zG2HXNM8O3/Le7jKIFU3nuXNbQY3y5C+sWhMTTGdD8j
         tanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpdbud4hfnMVUvj7AlpMG3y8rFTxRiD4XDqYg8qCQGU=;
        b=XWmChgE7mAVHCMiRrtV8J20med8bPeX5maewtBw+wBf6hM7rZdSGR6BZpxdZt31G7Y
         2HF/9o1ndRJC7Uw3Y0xg6xi8MCZR6IjCYaXWLyJpyn4J6e0NxLXkP7H5vxt7TjdMnwqv
         b5JZWBLrlk/+OQLA7jC7RsQ5AjNYXMQAikgUxhlUj+UUJmrdX7I8YpT6ieemb2DzQ9Z/
         Dt+8YtR31ybR5WD15QrZDKmgmducz5Xw02/z/1BMdy0UslnYAfzgyUMc1Eh0cKqzrv/G
         /u58LYycF2fVYYgIqs45G5wwAvpvMuRaxEmwdFbwzgShgquqac4PkSSMNxRU0evENSZS
         mvGw==
X-Gm-Message-State: AGi0PubhRx1W9pYUMLxT9H7rHtUFsKsGSUsjM8d1Eqmlacfo7rqlvEd8
        rIZU0QAPqd+BkUUF/BGO2DWa+Y1ZHrNfdA==
X-Google-Smtp-Source: APiQypL5Tw5hkjBtRi61MBPne8x2Q6JHH/Z5ca7zP96NFcVmCqq0t9IBH+SS2dVBKKmou50eS4FazQ==
X-Received: by 2002:a7b:ce13:: with SMTP id m19mr2405760wmc.76.1587625786081;
        Thu, 23 Apr 2020 00:09:46 -0700 (PDT)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u17sm2518585wra.63.2020.04.23.00.09.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:09:45 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 09/12] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
Date:   Thu, 23 Apr 2020 09:07:01 +0200
Message-Id: <20200423070704.39872-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200423070704.39872-1-mirucam@gmail.com>
References: <20200423070704.39872-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 70 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 55 +++----------------------------
 2 files changed, 73 insertions(+), 52 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2d8660c79f..9db72f5891 100644
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
 
@@ -834,6 +836,64 @@ static int bisect_autostart(struct bisect_terms *terms)
 	return bisect_start(terms, 0, NULL, 0);
 }
 
+static int bisect_head(struct object_id *oid)
+{
+	if (!file_exists(git_path_bisect_head()))
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
@@ -847,7 +907,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART
+		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -873,6 +934,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if BISECT_START is empty or missing"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -945,6 +1008,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_autostart(&terms);
 		break;
+	case BISECT_STATE:
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", (int)cmdmode);
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

