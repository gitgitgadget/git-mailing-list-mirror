Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EB3C433F7
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC68206BE
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxvKBCn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgGQKyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgGQKyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:54:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E8C061755
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so7011567wmm.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2020 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPGXp2ryD4GzRgkCAFTvUG/JRc+vz1jNmIc9OkBJH1E=;
        b=YxvKBCn8AjtZ2QHUJMBihGsx4MjQEWzQ94Pxiaoeuu1KhmJpIEiMFdEw7WcVWQJLCz
         /ttTToBj+mGsg1Z8us3n0UX7vfCwYNA4Q28Ldgwohekat7425o+mE0Y6nApWdEqY9W4j
         wpLiUaxGs0QmYuvJJ141obTjC9RU8bqDgo+NS7P37BlYXr5hKHxacw0iyliNPGb3zwYr
         XzGB0wbwpBxMAnq6XqyKKoY93/nebwlzlJhA8qdFfASn6xYxPriTywg5z2vnMFZhnmNQ
         EpfCfIJ6rbZg0ck/fifxk7tL+UomhoSREOE+dgkCrCjlbVmBB3gdaowTReXk19xfQDVA
         AnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPGXp2ryD4GzRgkCAFTvUG/JRc+vz1jNmIc9OkBJH1E=;
        b=adMj3kfncoDsBRkRAIiHoeC/u8UoKSe3lxamJVkBaYUk3Bu42uDBDnv1M36i4GxhCR
         g3CqlS0pNHD6ykex6rcrraKvxlq19LXWdDwM3bc7NFMItAboUCNcOettitnJu1I3Wwq6
         2Ibpjn6A9KFo47WDamEXhKtLI9tlUN2rOxeOJj+KvD0iGbpX3j14lg3zfTFrFPmezRCq
         l0+fwcCqJG6wyzj9hdEDfcJDMYpIvh/XBH0rEnMXTZEd5/elqgZzBcQA9izh/r82nIDl
         6vE4tqRR8ALvXcHfHgEnB9J5jxe3RIE4spUH7DfsaNIqy6Yfj0xhYm5uUMURX64qiQ7w
         BTzQ==
X-Gm-Message-State: AOAM530iu1/qRcvLjFnpYWpv2RSfQH5EXtlr1SI7gMRCdunTl+K9jNdb
        ybloLZDPdgDdbGD4wGIVNH5dYA35
X-Google-Smtp-Source: ABdhPJzf9nXi4dVu7ojVyIj811XccT9VSCKZQn8WR4cJzu9zCV469csLZnYFE4al5Izyaigxq4PPUQ==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr8521536wmh.134.1594983284344;
        Fri, 17 Jul 2020 03:54:44 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.178])
        by smtp.gmail.com with ESMTPSA id w14sm13924474wrt.55.2020.07.17.03.54.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:54:43 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v5 10/13] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
Date:   Fri, 17 Jul 2020 12:54:03 +0200
Message-Id: <20200717105406.82226-11-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200717105406.82226-1-mirucam@gmail.com>
References: <20200717105406.82226-1-mirucam@gmail.com>
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
index fc6bf36e42..7369605e4c 100644
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
 
@@ -857,6 +859,72 @@ static int bisect_autostart(struct bisect_terms *terms)
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
@@ -870,7 +938,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_NEXT,
 		BISECT_AUTO_NEXT,
-		BISECT_AUTOSTART
+		BISECT_AUTOSTART,
+		BISECT_STATE
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -896,6 +965,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -968,6 +1039,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index cfb05c0511..7a8f796251 100755
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

