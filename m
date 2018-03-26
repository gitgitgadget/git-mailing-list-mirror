Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298B31F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeCZBOv (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:14:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35313 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeCZBOq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:14:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id u86so1127496pfd.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DLG1/xmmJK/xhWE0rVgtMy73xvrw+oYrb3iZLZnLmDQ=;
        b=YmGfkg+DPmFSqrQd6kqeYLOtVS+38noHmP5TFxVAHro6aMYqHT9kGpjMzmNYHPic0X
         IgQ+VOYbiRp/jo6iJ1D29/D+wad/EkfgpjpVtIybBRwZi9lzwfbge6/475F/YgrSM6et
         5xLmJqoj4M/3gu9A/EY5CRmciIexw3gUQqOcQ5xyiFcJDScDTaX8pbJwV8tG9SjX+9vc
         MGoYTvscmx4Fol9y/uAnKEQPgWLf9mEwGE+y+TYdqwk7uvjap7a+IBWwM4hlSrdyTkRH
         3V+DyUrazcpIRB/C4AksRZDMpe4OBuao5Q+YEN5nnkmp7B+68qebgGHeXaelBac9PUuF
         L+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DLG1/xmmJK/xhWE0rVgtMy73xvrw+oYrb3iZLZnLmDQ=;
        b=WUfT1eWZJbE5QQo6LhRLlGckYjDSaz/NUPGO5DwRRArzNriR+XA9fGd9ss7yN4I8M7
         4YDFA8A0oOtbUx6u74z4vCstx0Fi161oeqB1etc/GpcilNHn2Ih6jFBQwvzOVtKYT/jB
         7jaVISziYGBuBYudXb4AWq/T7LQvvXPhxHkqzdZAsHuA8sqDIWbbS45WELITMaDOuGH4
         KmyF9fPIpC5vnINU1n5PZDsCJPucAhsLbMdE/pYashfqWYJVwvggPq5U9THC5TwD60PU
         HG80cKFJlke0qQxRIEvo0F55qFosoyGbn1NXRp77zesKK1+AzKMu7KiDtWz88Y2xCsLt
         OurQ==
X-Gm-Message-State: AElRT7HmbYkZaQ6AYLVW2J9ErfT3zVdDWxQ43x6A5hZI52hj2wYIqUsQ
        ucswXq9lmXp4Gaxy55pSU7qwoAE=
X-Google-Smtp-Source: AG47ELs++wFXf4BPHGighPxOpVxMhO/Q2pzoQWfVtItxy1K3Oye+tZiK3CDL74bJNSmoWql752x7iw==
X-Received: by 10.98.229.21 with SMTP id n21mr31276331pff.158.1522026885589;
        Sun, 25 Mar 2018 18:14:45 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id k70sm18664894pga.72.2018.03.25.18.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 18:14:44 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v2 6/6] stash: convert pop to builtin
Date:   Sun, 25 Mar 2018 18:14:26 -0700
Message-Id: <20180326011426.19159-7-joel@teichroeb.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326011426.19159-1-joel@teichroeb.net>
References: <20180326011426.19159-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 builtin/stash--helper.c | 41 +++++++++++++++++++++++++++++++++++++++++
 git-stash.sh            | 39 ++++-----------------------------------
 2 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 4226c13be3..36e7e660a0 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
@@ -23,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
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
@@ -502,6 +508,39 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
+		destroy_stash_info(&info);
+		return -1;
+	}
+
+	if (do_apply_stash(prefix, &info, index)) {
+		printf_ln(_("The stash entry is kept in case you need it again."));
+		destroy_stash_info(&info);
+		return -1;
+	}
+
+	ret = do_drop_stash(prefix, &info);
+	destroy_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	const char *branch = NULL;
@@ -567,6 +606,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		result = clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		result = drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		result = pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		result = branch_stash(argc, argv, prefix);
 	else {
diff --git a/git-stash.sh b/git-stash.sh
index c5fd4c6c44..1b8c7c4f63 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -565,39 +565,6 @@ assert_stash_ref() {
 	}
 }
 
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
@@ -634,7 +601,8 @@ push)
 	;;
 apply)
 	shift
-	apply_stash "$@"
+	cd "$START_DIR"
+	git stash--helper apply "$@"
 	;;
 clear)
 	shift
@@ -654,7 +622,8 @@ drop)
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
2.16.2

