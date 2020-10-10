Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C427C2BD0C
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B582075E
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 23:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc2zQGYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbgJJW43 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgJJTvA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:51:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2375AC05BD1A
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v12so12460593wmh.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=by3iRDMlk3KSH3j9BsojlrItvA6EQjr2c+PpEbJBCbQ=;
        b=oc2zQGYEloWCTvO4nj81INAebiTZhf2onW7QI4em9+IU5+68G5ZmHnRgXdznPyeAHo
         JH4X/aTHYMF3hTYmZObILoYm0p3R7TA23L6JzC+Q552wjwr48xZKxCrkt2I1h8tMlRLQ
         WjavpmtFTJjoJ4UgBxInELkedPeqJ0gGZO2IeOi/jbioFAqhaGzwWOAYZl2JnUGiJqFJ
         FaxbJGv9nrIA2jHGKE1EtnoVxAQVI4/wLcmImOKL2TyrnD+wP7dMw+sCngdGGHdtRNxJ
         tceRzluyxSxBk7AmazUVtCWi25n1nCathLbwMTYAsxd3eSFfqxi5Xi4zmQP1QhbMZ47W
         e/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=by3iRDMlk3KSH3j9BsojlrItvA6EQjr2c+PpEbJBCbQ=;
        b=MIcr8HrfGjnT1Ba7rgP26+hFXwAk4gGM6JnrRU4QFhMaYV/HyJ0dO5kLI1+uAh5Z8E
         8er6Y7Lm3nTzn0Jr77mw9/QyhugKCFInIUr0hF+DpwuACePYBzcZKH+GLEG0dMw72XhV
         H//cnvR+wgYPe4DN2RlLxqdo/CckmYJ/XIe+/d9yf/zUYliPmxufnDMivUKkfFYV4Ud+
         ywsCc2isn1BW1reB18GzbXGmnqo2BEQShm6sbDnaOlhzYUDygyd8MfFa5tn6wbb4hWdU
         nBghsDMizZEfUKvWBj85zgzs/4RDtjPaeS/qaT/QRim1ShACERBKY0/zyILhFJplzrdw
         KSoQ==
X-Gm-Message-State: AOAM5312c8b4celmxJy5aEp600tow675t/JZoBzixrKfMoZ6zQrIco8u
        HjNGgFqO1bWS8VcHGElXgFll6HZfYvQ=
X-Google-Smtp-Source: ABdhPJwgYs1O2gm879X+AVSrSmC4bdjPFZmIEFoM7op1e38t4EsTV5eS4moV/kjOKvm/iiyGgAwPAQ==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr2830091wmb.173.1602338938163;
        Sat, 10 Oct 2020 07:08:58 -0700 (PDT)
Received: from localhost.localdomain ([91.242.153.231])
        by smtp.gmail.com with ESMTPSA id g83sm15746737wmf.15.2020.10.10.07.08.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Oct 2020 07:08:57 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v10 4/7] bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
Date:   Sat, 10 Oct 2020 16:07:40 +0200
Message-Id: <20201010140743.580-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20201010140743.580-1-mirucam@gmail.com>
References: <20201010140743.580-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Note that the `eval` in the changed line of `git-bisect.sh` cannot be
dropped: it is necessary because the `rev` and the `tail`
variables may contain multiple, quoted arguments that need to be
passed to `bisect--helper` (without the quotes, naturally).

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 84 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 55 ++------------------------
 2 files changed, 87 insertions(+), 52 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index f1a7cfbfaf..66b5346e42 100644
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
 
@@ -854,6 +856,78 @@ static int bisect_autostart(struct bisect_terms *terms)
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
+	if (bisect_autostart(terms))
+		return BISECT_FAILED;
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
+		const char *head = "BISECT_HEAD";
+		enum get_oid_result res_head = get_oid(head, &oid);
+
+		if (res_head == MISSING_OBJECT) {
+			head = "HEAD";
+			res_head = get_oid(head, &oid);
+		}
+
+		if (res_head)
+			error(_("Bad rev input: %s"), head);
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
@@ -867,7 +941,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_START,
 		BISECT_AUTOSTART,
 		BISECT_NEXT,
-		BISECT_AUTO_NEXT
+		BISECT_AUTO_NEXT,
+		BISECT_STATE
 	} cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
@@ -893,6 +968,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_CMDMODE(0, "bisect-autostart", &cmdmode,
 			 N_("start the bisection if it has not yet been started"), BISECT_AUTOSTART),
+		OPT_CMDMODE(0, "bisect-state", &cmdmode,
+			 N_("mark the state of ref (or refs)"), BISECT_STATE),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -963,6 +1040,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
index dda386bc3a..1f3f6e9fc5 100755
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
-	git bisect--helper --bisect-autostart || exit
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
+'bisect-state \$state' exited with error code \$res" >&2
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

