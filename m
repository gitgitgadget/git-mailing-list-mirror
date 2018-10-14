Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B3A1F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeJOFzs (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:48 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37800 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:48 -0400
Received: by mail-ed1-f49.google.com with SMTP id c22-v6so16072128edc.4
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGCv0S3iU1pXgpILWpSQOTs9bu/6lNafr3DK6ZIMQGA=;
        b=b8nUp+s/ZqUmGIhVHzIGMwNIk+i0PyNVWHDqUDkGdFokMKAfmglaFpclttMsK6gS0f
         Ovj2IhbA+D2Vr95W00KmFzdbNBeEjzVr+MmTKSEN98tgYgc6Z0Xcki7s9JO3zzDxfX2X
         uQtMD4L8tqmwwjzfFCwHfoiaFz21g9ALMk9/zCqv5X682Mf4xiI+wTW2iaoLLmiuGm/c
         nekngqnv4MggHHsh6RT7Z+8b79rkudUSnhhak18qH9TXQ0GFe4hcDTDtkhkvW9esBZ4g
         kSR4i0/RXG6AookbGxS0pPBoBHFjDDaGGzEC81SRxtiApEiixCINohwGlBgcd/qk8xM4
         FgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGCv0S3iU1pXgpILWpSQOTs9bu/6lNafr3DK6ZIMQGA=;
        b=JcEJKkhGKM+Z1TjaL/mnRzlJBXBD7D3H+7Gmho40znTpM+saYD/kj08JkVNwIX86Fk
         jjyBEcQX473l99cMf2DgjQKjt+KRGcwezCX19m6iM+EY8ohHZ3V8eVydQ6Z1ujXZOR2F
         R7WVT6Iqe4hyBaA+5rxdOQ3qczr9amxF2usGi5qtB9UJqQ9gabsT3qkExGHx67jAB5YQ
         31iZuNIPdiMDbieJ4DBQGZNZVjB9RZUbRp7Xj/OPejbiKFCTzqwIrBr5Vtm70doMQhPJ
         91kukuBndg875VHPDJP8s5YItZArp9qHxqLbqzNC3f7SOWbI3YzLkN6uNEjNk7taqjLx
         jOcg==
X-Gm-Message-State: ABuFfoixu7azdNczSJyCGO5p0aoBYSBQLRYNv78GQEFGuIMeXFnvB5JZ
        34lwjIIKkztE1O6ZeMtvIsWrEfnY
X-Google-Smtp-Source: ACcGV62eVhW9hqbkQhgPrublnMD0R7kPC/DzDyBX+Cl6hacyR7T5PdsLAZvskJILu6haHXOkPykb7g==
X-Received: by 2002:a50:fa96:: with SMTP id w22-v6mr6395309edr.59.1539555200429;
        Sun, 14 Oct 2018 15:13:20 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:19 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 11/21] stash: convert pop to builtin
Date:   Mon, 15 Oct 2018 01:11:17 +0300
Message-Id: <192cba75acb1a65bf122ded65588a3a8e273be86.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref functions from the shell script now that they
are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 39 +++++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index c41aad7036..33f4e83353 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,7 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
@@ -24,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
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
@@ -545,6 +550,36 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	int index = 0;
+	int quiet = 0;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			 N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
+		printf_ln(_("The stash entry is kept in case "
+			    "you need it again."));
+	else
+		ret = do_drop_stash(prefix, &info, quiet);
+
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	int ret;
@@ -609,6 +644,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
 
diff --git a/git-stash.sh b/git-stash.sh
index 29d9f44255..8f2640fe90 100755
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
@@ -655,7 +611,8 @@ drop)
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
2.19.0.rc0.23.g10a62394e7

