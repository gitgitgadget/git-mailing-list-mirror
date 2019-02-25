Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF4920248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfBYXRT (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33604 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfBYXRS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id c13so877111wmb.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AiZ5gHkgE9MxyX2GDXY4baZ8TjAHTIrkjYa1Caqjfxk=;
        b=UUCdGXkd3pSu67Ho1JVuGbNpwBbcJ8fzLY2C1GKh/7SLkGz54itF4rB/ER1eLEuzJV
         kYNia/R4so4vmofP05I9Dkg/gOwvze9fiYvWXC2ViwQOnVdNHcIWZyyYTmKvqUQutVOj
         FTEpEQsnPx/cQBajNZ9Svl9ycmdVEGu0v3OxTrorXGu50a/Uyupe0igYHodumTnmXx3X
         wdLN6BmevETllmSY36KldGP+Tm+aBhD7tSRc+HwFGN4h9/8RRT+wPi+umScxjmF0hhVh
         BizQtqDZEj9iQt2W+2TGZEGgvQTbRYp48t4Tib7Pk1JvIM2kSJ8eYyjIkTJ0lQNVbyCL
         QrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiZ5gHkgE9MxyX2GDXY4baZ8TjAHTIrkjYa1Caqjfxk=;
        b=f86ZK2AAhSDPepkvjF9I5xGbRjukrGMd1AMUdXk4nmoD9jt+uTyu0cnjLQfLi5ecii
         yPJpHhLptSA+Epkj2P358bV+mnePiAeUeo6mwWccTWSJ/WhAX11yLVWZjKSRcHXZnjab
         /3TdeF/AuxjhSdaeMThHkvPYBGu1IWoW8L/mb0VNZy9bblCS3zdMqyfGDA/rQdIXx1xy
         7r2xRlndFZiLDh9KcySuX7pn1VIixWBjK7+lotZp6/lr/R67GC5WH6LNyZfuojS4x8dn
         jIW59Pfl6skFbboSbJMGeVl0KRb05ndN/twfxOiA9XK7rLwKbkzXR/zAOyF/MTTxu7fH
         +YhA==
X-Gm-Message-State: AHQUAuad5Vzl97UkmVl0a05Rhr5PnBTl9VMNsUSJm5KWoXfLJFUpAFqp
        lmiLpeOQ0Z99txksEY84twv68Hmc
X-Google-Smtp-Source: AHgI3IYWvYrYufByKy6zJgg4aftkBiKlwyltOEMnGEnBbYNKSNyv67DwSPyqOmWv15UQMM9hoSmJDQ==
X-Received: by 2002:a1c:2d08:: with SMTP id t8mr698089wmt.5.1551136634568;
        Mon, 25 Feb 2019 15:17:14 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id k6sm16303174wrq.82.2019.02.25.15.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:13 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 17/27] stash: convert store to builtin
Date:   Mon, 25 Feb 2019 23:16:21 +0000
Message-Id: <20190225231631.30507-18-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Add stash store to the helper and delete the store_stash function
from the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 62 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 43 ++--------------------------
 2 files changed, 64 insertions(+), 41 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 4028b64314..763a5ffd25 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -58,6 +58,11 @@ static const char * const git_stash_helper_clear_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_store_usage[] = {
+	N_("git stash--helper store [-m|--message <message>] [-q|--quiet] <commit>"),
+	NULL
+};
+
 static const char *ref_stash = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -729,6 +734,61 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	return diff_result_code(&rev.diffopt, 0);
 }
 
+static int do_store_stash(const struct object_id *w_commit, const char *stash_msg,
+			  int quiet)
+{
+	if (!stash_msg)
+		stash_msg = "Created via \"git stash store\".";
+
+	if (update_ref(stash_msg, ref_stash, w_commit, NULL,
+		       REF_FORCE_CREATE_REFLOG,
+		       quiet ? UPDATE_REFS_QUIET_ON_ERR :
+		       UPDATE_REFS_MSG_ON_ERR)) {
+		if (!quiet) {
+			fprintf_ln(stderr, _("Cannot update %s with %s"),
+				   ref_stash, oid_to_hex(w_commit));
+		}
+		return -1;
+	}
+
+	return 0;
+}
+
+static int store_stash(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	const char *stash_msg = NULL;
+	struct object_id obj;
+	struct object_context dummy;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet")),
+		OPT_STRING('m', "message", &stash_msg, "message",
+			   N_("stash message")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_store_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (argc != 1) {
+		if (!quiet)
+			fprintf_ln(stderr, _("\"git stash store\" requires one "
+					     "<commit> argument"));
+		return -1;
+	}
+
+	if (get_oid_with_context(argv[0], quiet ? GET_OID_QUIETLY : 0, &obj,
+				 &dummy)) {
+		if (!quiet)
+			fprintf_ln(stderr, _("Cannot update %s with %s"),
+					     ref_stash, argv[0]);
+		return -1;
+	}
+
+	return do_store_stash(&obj, stash_msg, quiet);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -763,6 +823,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!list_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "show"))
 		return !!show_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "store"))
+		return !!store_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index d0318f859e..ff5556ccb0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -208,45 +208,6 @@ create_stash () {
 	die "$(gettext "Cannot record working tree state")"
 }
 
-store_stash () {
-	while test $# != 0
-	do
-		case "$1" in
-		-m|--message)
-			shift
-			stash_msg="$1"
-			;;
-		-m*)
-			stash_msg=${1#-m}
-			;;
-		--message=*)
-			stash_msg=${1#--message=}
-			;;
-		-q|--quiet)
-			quiet=t
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-	test $# = 1 ||
-	die "$(eval_gettext "\"$dashless store\" requires one <commit> argument")"
-
-	w_commit="$1"
-	if test -z "$stash_msg"
-	then
-		stash_msg="Created via \"git stash store\"."
-	fi
-
-	git update-ref --create-reflog -m "$stash_msg" $ref_stash $w_commit
-	ret=$?
-	test $ret != 0 && test -z "$quiet" &&
-	die "$(eval_gettext "Cannot update \$ref_stash with \$w_commit")"
-	return $ret
-}
-
 push_stash () {
 	keep_index=
 	patch_mode=
@@ -325,7 +286,7 @@ push_stash () {
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
 	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
-	store_stash -m "$stash_msg" -q $w_commit ||
+	git stash--helper store -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
 	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
@@ -485,7 +446,7 @@ create)
 	;;
 store)
 	shift
-	store_stash "$@"
+	git stash--helper store "$@"
 	;;
 drop)
 	shift
-- 
2.21.0.rc2.291.g17236886c5

