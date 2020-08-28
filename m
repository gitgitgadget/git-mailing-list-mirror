Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BFEC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7916F208C9
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGzwbCgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgH1Ms4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgH1Mr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 08:47:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97644C06121B
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t14so784011wmi.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbrniexBZ0gYU+YQdW9xSXjq0+1QXCMa9esGoHTHjD8=;
        b=nGzwbCgI3BiZvyrb9hIX+dMFmGM8WkBuN/mkTIrfQn7XzfAlzKfoRQ35dgq9m3rvPr
         NXw4JOmk4XlfqnYHUTeGdEGTgcNJtfYX7ZOMhD0zK+J2+fnKIIJ3XliTqnDb1YNWWDsd
         yg6MBlu3bTXP0nBBCIgN1qBOaS7xfjw9tOhVx9I8Px7H7i+iX9xfYXgG2pP75CVYu6dm
         dhgvInK+E+cfesVozn5uzZ4k/usc5p6MIYJ5WAsQW58UnlvZtf3eP6qj37N9oCPzUcgJ
         Y4MFG4Rk0r7Wc+sPs0tpGr+oKr7Kndgxt+7r8tMwqKO9qHvNyIDbCt95eh4cHsyQCPnH
         vjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbrniexBZ0gYU+YQdW9xSXjq0+1QXCMa9esGoHTHjD8=;
        b=WrrTSheZ1mjQxYKPH+UmeFyMYDQRwSVHNFX4sVnNoOCOVbtuS0G9V8B/tikqgMKRZd
         G+a4lq1b9muTlLZoI8uubUab7wtICnLV08LGoCFecEEMGdT+t939qMZoa0FQS+vwybxJ
         3s+dQHoeFcMvpxPeHjtOWPY3rwuqQWJ5CuhIbQiKUoPpQ9lxZWigmnNnUya+PKYs73G4
         ZTbsMWrEHtxs3Uo33uDLBlrGgqjKh/xmGhdYsQAoZqdNVTLXHrHbpIKMQ3bBJSds58lQ
         PKxAtCSIxxijFETC/dwhDm73GYkatx1gE+3LUIzjlmHIkmLQgqFzu4Zz3HW770iZTDRO
         1kag==
X-Gm-Message-State: AOAM532LFjz0cH3CjRdo4xFg+I7KFYD68L99nmzVcAwETGbCBuhsCRGq
        U/dNuAo0D+lvJkayirn/9G43xO339go=
X-Google-Smtp-Source: ABdhPJw0UbFrK/zkRj/HpuZVOXeHoMGA8rxfWv8JEVkYfiQ4b4URAkLc+0PcFgwsEKPXVmeK70w6CA==
X-Received: by 2002:a1c:38c5:: with SMTP id f188mr1507038wma.58.1598618841926;
        Fri, 28 Aug 2020 05:47:21 -0700 (PDT)
Received: from localhost.localdomain ([178.237.236.228])
        by smtp.gmail.com with ESMTPSA id o66sm2176878wmb.27.2020.08.28.05.47.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:47:21 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 10/13] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
Date:   Fri, 28 Aug 2020 14:46:14 +0200
Message-Id: <20200828124617.60618-11-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200828124617.60618-1-mirucam@gmail.com>
References: <20200828124617.60618-1-mirucam@gmail.com>
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
 builtin/bisect--helper.c | 78 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 55 +++-------------------------
 2 files changed, 81 insertions(+), 52 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0a32dbb68f..6d2847dc9c 100644
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
 
@@ -865,6 +867,72 @@ static int bisect_autostart(struct bisect_terms *terms)
 	return res;
 }
 
+static enum bisect_error bisect_state(struct bisect_terms *terms, const char **argv,
+				      int argc)
+{
+	const char *state;
+	int i, verify_expected = 1;
+	struct object_id oid, expected;
+	struct strbuf buf = STRBUF_INIT;
+	struct oid_array revs = OID_ARRAY_INIT;
+
+	if (!argc)
+		return error(_("Please call `--bisect-state` with at least one argument"));
+
+	state = argv[0];
+	if (check_and_set_terms(terms, state) ||
+	    !one_of(state, terms->term_good, terms->term_bad, "skip", NULL))
+		return BISECT_FAILED;
+
+	argv++;
+	argc--;
+	if (argc > 1 && !strcmp(state, terms->term_bad))
+		return error(_("'git bisect %s' can take only one argument."), terms->term_bad);
+
+	if (argc == 0) {
+		enum get_oid_result res_head = get_oid("BISECT_HEAD", &oid);
+		if (res_head == MISSING_OBJECT)
+			res_head = get_oid("HEAD", &oid);
+		if (res_head) {
+			error(_("Bad bisect_head rev input"));
+			return BISECT_FAILED;
+		}
+		oid_array_append(&revs, &oid);
+	}
+
+	/*
+	 * All input revs must be checked before executing bisect_write()
+	 * to discard junk revs.
+	 */
+
+	for (; argc; argc--, argv++) {
+		if (get_oid(*argv, &oid)){
+			error(_("Bad rev input: %s"), *argv);
+			return BISECT_FAILED;
+		}
+		oid_array_append(&revs, &oid);
+	}
+
+	if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0) < the_hash_algo->hexsz ||
+	    get_oid_hex(buf.buf, &expected) < 0)
+		verify_expected = 0; /* Ignore invalid file contents */
+	strbuf_release(&buf);
+
+	for (i = 0; i < revs.nr; i++) {
+		if (bisect_write(state, oid_to_hex(&revs.oid[i]), terms, 0))
+			return BISECT_FAILED;
+
+		if (verify_expected && !oideq(&revs.oid[i], &expected)) {
+			unlink_or_warn(git_path_bisect_ancestors_ok());
+			unlink_or_warn(git_path_bisect_expected_rev());
+			verify_expected = 0;
+		}
+	}
+
+	oid_array_clear(&revs);
+	return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
@@ -878,7 +946,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART
+		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -904,6 +973,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -974,6 +1045,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_autostart(&terms);
 		break;
+	case BISECT_STATE:
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index 356264caf0..7a8f796251 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,16 +39,6 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-bisect_head()
-{
-	if git rev-parse --verify -q BISECT_HEAD > /dev/null
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
@@ -187,8 +141,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 			state="$TERM_GOOD"
 		fi
 
-		# We have to use a subshell because "bisect_state" can exit.
-		( bisect_state $state >"$GIT_DIR/BISECT_RUN" )
+		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
 		res=$?
 
 		cat "$GIT_DIR/BISECT_RUN"
@@ -203,7 +156,7 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
 		if [ $res -ne 0 ]
 		then
 			eval_gettextln "bisect run failed:
-'bisect_state \$state' exited with error code \$res" >&2
+'git bisect--helper --bisect-state \$state' exited with error code \$res" >&2
 			exit $res
 		fi
 
@@ -244,7 +197,7 @@ case "$#" in
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

