Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460DD1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDEC2b (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:28:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32942 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbeDEC21 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:28:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id s10-v6so15057739plp.0
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+Vl249opYKGJ3nVgNMaeNxLxHTl8u+InncR0vI7G4E=;
        b=m33JGsaAZifBImMC8XzDQ8m5tVkA2NoPp4UZN8pWpaWe/n3BpNixaETJA65IYd6P9h
         c2GxzRk1S72lEyC0VxbML4HKYprDFLnAB1ACeW9dlA/s0EquymatOGALqoXrT63sdoJ7
         ANp8Z1naGMyHeOsCXuCIS+Q3zw29WC/f2rfuRjNgqvkLdSk/WC94zOht2I6SKtjadC67
         Y1CZkxTyPY6o/Yyo1ty5X6fKEA/MKaebtE8bREOKZbV6RoTUTkJUDYkr3ZZriDqIEb7q
         ujTIuJJXxqjLfaRfVHgKCBZP/C7nm0AAl6vm/xi8riAsvufKABQHoxoDISDV+kUPzzJi
         p+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+Vl249opYKGJ3nVgNMaeNxLxHTl8u+InncR0vI7G4E=;
        b=PfUgUpriM0zhDSXNUX46dy6dDc1tmKj1Vu7JguXsWcNO34lDTKjoCrLywEtWNBrVI/
         ya4WlCbiEJVMvqTKwTD2N6qcdVAeU91DENm4jXDRMsuuMLs2UNmCR9IyR3BkV7LvyBj+
         845FmWn+Q0Y6EWe9LhzU2LFcldaprKVXIfBG0XKQzkh0EA0h+EYFEfvcciZjLQLGJD3Y
         J5aqyU7I2xxTo20oJd9GnsQcWo0T5sIxOg2oAIHzn8ZoQFZ+545E9wyzI8cEBhYyBA60
         SYFnFPEjrCxBP6EvZSI0TVag64ujcef5oPbfs1f22aWGTi3lgTXw+80EWmEraERq9Ego
         JqDA==
X-Gm-Message-State: AElRT7E+FJT09dbXZocnjBMqZULTxUBDtUvqEedwRJcTxyDZ4neYq8P4
        HKCae8QxsOksM/z11+4PConUF74=
X-Google-Smtp-Source: AIpwx482ZZ6HbjselWEE/EvK0FDdulSgjRgXeFCIMZK56iFlUzGE9bjDlDOOZF/eG7I0+U/LSwGO5w==
X-Received: by 2002:a17:902:2941:: with SMTP id g59-v6mr21005260plb.55.1522895307278;
        Wed, 04 Apr 2018 19:28:27 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id 86sm14194093pfh.93.2018.04.04.19.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:28:26 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v5 5/5] stash: convert pop to builtin
Date:   Wed,  4 Apr 2018 19:28:10 -0700
Message-Id: <20180405022810.15796-6-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405022810.15796-1-joel@teichroeb.net>
References: <20180405022810.15796-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref and pop_stash functions from the shell script
now that they are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 41 ++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 50 ++++---------------------------------------------
 2 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 486796bb6a..7c8950bc90 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,6 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
@@ -24,6 +25,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -508,6 +514,39 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int index = 0, ret;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	if (assert_stash_ref(&info)) {
+		free_stash_info(&info);
+		return -1;
+	}
+
+	if (do_apply_stash(prefix, &info, index)) {
+		printf_ln(_("The stash entry is kept in case you need it again."));
+		free_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_drop_stash(prefix, &info);
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *branch = NULL;
@@ -577,6 +616,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		result = pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		result = branch_stash(argc, argv, prefix);
 	else {
diff --git a/git-stash.sh b/git-stash.sh
index c5fd4c6c44..8f2640fe90 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -554,50 +554,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	res=$?
-	cd_to_toplevel
-	return $res
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -634,7 +590,8 @@ push)
 	;;
 apply)
 	shift
-	apply_stash "$@"
+	cd "$START_DIR"
+	git stash--helper apply "$@"
 	;;
 clear)
 	shift
@@ -654,7 +611,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.16.3

