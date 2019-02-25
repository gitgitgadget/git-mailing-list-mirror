Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180E820248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfBYXRN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39315 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXRM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so553936wmg.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCvVoRU/qW376sxoaOgZNNaBAKbYcU4x25i3PWXUEi0=;
        b=IzhpNcwOlGoGKr1GTgSn3KZC+M8AjEKs2Q22JYBxHXpPUuFr8TCcKSR6JL15hleuzf
         7edF93YI0YUBlIcyUA5BTmbxJMOOcb1aU2kq9cZ37wXsGsDg7taSDIK4rUOO6FWCGf7G
         mdFDJdb/J78EBTX5N9/coBVXZWkPdnu9apJWKD5f9Yp8yxPVRUUE1cG0SYHgAOJ4hquD
         IreY3te5S9sCu8NGr8dLN9mSqp/sTk3CGyWbl1xLfw3CNDFEhvSA2s++NnlIdZko8AlB
         O8lLneXosCbpQE0KuCEEkVzYIg59+4yLrVIcyFew8Oy9Co65KdFl+nyXRz1N6b5xLAuy
         6L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCvVoRU/qW376sxoaOgZNNaBAKbYcU4x25i3PWXUEi0=;
        b=LWLVN0HW0ZNl/BZ8abgKxrC79075o2lmsLlOpfUDLj4dcvywbIVOu4qhpp30e0fnF2
         5aRe6UUIsqwZLKZHlccHqB1taFLld2SoGpmnJifIEtsBPnW8JingxS1hETkR6HZzYo1m
         dZwYbYmaDMb041Bn+VnOz0PQQeY6NfMDCLywQpLdLofuq9QvFPDi/TSZNh+rgQUVDLLH
         0lg4IGTsag/jYBsh8o5Nmp5OHctxktMdr9hLvsoKyj+eMxO1m3Nay2YIafn7FnsmNJrE
         sRd2y6Pskvz19eibvae/lUrk6eQL3lt0+rKKWRQ3+mYfFu/KLaxYyQrz/znN6Um6UL76
         E8PA==
X-Gm-Message-State: AHQUAuZkanglA+Ckm+y4GQsDl/XpWapvJlEKaOwEPVu6iyWAP7+/6rfe
        5m+AUvbk3M56AzR9mXkwPg62NAjS
X-Google-Smtp-Source: AHgI3Ia9aGze8YSv6jR1bBw29Uelys6mpZ4AUKK5Oe64eYDxDC7AV5U2vX2kBcogYzPaEZlDNj8U7A==
X-Received: by 2002:a1c:bcd7:: with SMTP id m206mr706404wmf.36.1551136629547;
        Mon, 25 Feb 2019 15:17:09 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id v6sm65135wme.24.2019.02.25.15.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:08 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 14/27] stash: convert pop to builtin
Date:   Mon, 25 Feb 2019 23:16:18 +0000
Message-Id: <20190225231631.30507-15-t.gummerer@gmail.com>
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

From: Joel Teichroeb <joel@teichroeb.net>

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref functions from the shell script now that they
are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 39 +++++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index c9874e2f5d..63e1e84e78 100644
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
@@ -542,6 +547,36 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
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
@@ -606,6 +641,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
 
diff --git a/git-stash.sh b/git-stash.sh
index 67db321a4c..8a9f907aa9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -571,50 +571,6 @@ assert_stash_like() {
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
@@ -672,7 +628,8 @@ drop)
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
2.21.0.rc2.291.g17236886c5

