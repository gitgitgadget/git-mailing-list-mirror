Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76943C43381
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F10422D5A
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbhAETpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbhAETpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F89C0617BC
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t30so376707wrb.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9zO8W7ov/B2Omd/+XOSb1HaK2iItwuXV7V8QHTw3ZE=;
        b=Z2OHJgF3D+XWiWXXk1qWfFwXoO8OdOrhv7mRXDxknhip0WMN/QYB2+t97RMRlPvvq3
         P0YDw1R8K8pmJCjvAeq8hwiqbpyeYb0Ix2Zo27nL61+bRXKPLbI4yi/NEnrFPhxKv0E5
         hJVVVvcN9txAUiZXZ6Vz9d7pVb/zWuhrE58RxrUyaFqHcromaqPVQ34rYu4O+ya4X1el
         5AQJMQFnkt4PK8yScAMPft7TgQnQwgUdBUxYRXXEr7oFmm37h+xo02BoaJE8p9guIrWs
         Ak2ijStondiWCL8MxOTDrCvisHepcMRiu820qVQDmWkeEIMMtRiktykNoXQqBk7t2Cwi
         K7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9zO8W7ov/B2Omd/+XOSb1HaK2iItwuXV7V8QHTw3ZE=;
        b=oyp+UpbaZHiaJxqlTXyct6X0egoSLppuGsAgCIyio4Gmi1fdtZhMq/YwYD5m8thBWo
         ka2+omWseWgNCsp7XQbCMqbfPFlwgXGqH06Tm0NdiPcpnmi7ue7x3J+vvszi0zA7pcJK
         Ugx7J7OmXSsDFQonwBzp99WLBkygNJSwFK7bQF4xqev3+y3A9YGWNGo7VG6ygeY8ZAeW
         nNrR2bvfhIU4aw4DCpFJPtLs8ukb5c86V8bQw6Wl7rbIEt7iKjy+htiEL0fP4/SO29TQ
         eHugk7zre9tzEhJkLhx29gb6GfkV9xnOPaxerThoRm6L85kxWQelNi+jAAb7uDNLuR7Q
         rO0w==
X-Gm-Message-State: AOAM531b4tUGF7UiyDKASB3eGjkruwDae/9WXAqBvIIzFL964tvPdhfN
        ghC6W29/r5O4UL93umRUcj0zAMIUrmgwaQ==
X-Google-Smtp-Source: ABdhPJxOte+48xrRcIoEQ1k4dvakJ8KI4FfdpDWf3kabCM2x+pcsX/FOYCLilOti/5ZdFj7vl1ibIQ==
X-Received: by 2002:a5d:4dcd:: with SMTP id f13mr1095675wru.10.1609875831488;
        Tue, 05 Jan 2021 11:43:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 23/23] mktag: add a --no-strict option
Date:   Tue,  5 Jan 2021 20:42:52 +0100
Message-Id: <20210105194252.627-24-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that mktag has been migrated to use the fsck machinery to check
its input, it makes sense to teach it to run in the equivalent of "git
fsck"'s default mode, instead of hardcoding "git fsck --strict". Let's
do that and support the "--no-strict" option.

Since this is a new option we don't need to cater to parse-option.c's
default of automatically supporting --strict. So let's use
PARSE_OPT_NONEG, using a new trivial helper macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-mktag.txt |  8 ++++++++
 builtin/mktag.c             |  9 +++++++++
 t/t3800-mktag.sh            | 33 +++++++++++++++++++++++----------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 79813ff8df0..17a2603a600 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -11,6 +11,14 @@ SYNOPSIS
 [verse]
 'git mktag'
 
+OPTIONS
+-------
+
+--strict::
+	By default mktag turns on the equivalent of
+	linkgit:git-fsck[1] `--strict` mode. Use `--no-strict` to
+	disable it.
+
 DESCRIPTION
 -----------
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 9b04b61c2bb..41a399a69e4 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -10,6 +10,7 @@ static char const * const builtin_mktag_usage[] = {
 	N_("git mktag"),
 	NULL
 };
+static int option_strict = 1;
 
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
@@ -25,6 +26,12 @@ static int mktag_fsck_error_func(struct fsck_options *o,
 {
 	switch (msg_type) {
 	case FSCK_WARN:
+		if (!option_strict) {
+			fprintf_ln(stderr, _("warning: tag input does not pass fsck: %s"), message);
+			return 0;
+
+		}
+		/* fallthrough */
 	case FSCK_ERROR:
 		/*
 		 * We treat both warnings and errors as errors, things
@@ -67,6 +74,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_mktag_options[] = {
+		OPT_BOOL(0, "strict", &option_strict,
+			 N_("enable more strict checking")),
 		OPT_END(),
 	};
 	struct strbuf buf = STRBUF_INIT;
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0ddd0f01cc7..4d76ccbbc19 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -12,12 +12,17 @@ test_description='git mktag: tag object verify test'
 # given in the expect.pat file.
 
 check_verify_failure () {
-	expect="$2"
-	test_expect_success "$1" '
+	test_expect_success "$1" "
 		test_must_fail env GIT_TEST_GETTEXT_POISON=false \
 			git mktag <tag.sig 2>message &&
-		grep "$expect" message
-	'
+		grep '$2' message &&
+		if test '$3' != '--no-strict'
+		then
+			test_must_fail env GIT_TEST_GETTEXT_POISON=false \
+				git mktag --no-strict <tag.sig 2>message.no-strict &&
+			grep '$2' message.no-strict
+		fi
+	"
 }
 
 test_expect_mktag_success() {
@@ -65,7 +70,7 @@ too short for a tag
 EOF
 
 check_verify_failure 'Tag object length check' \
-	'^error:.* missingObject:'
+	'^error:.* missingObject:' 'strict'
 
 ############################################################
 #  2. object line label check
@@ -240,7 +245,7 @@ tagger . <> 0 +0000
 EOF
 
 check_verify_failure 'verify tag-name check' \
-	'^error:.* badTagName:'
+	'^error:.* badTagName:' '--no-strict'
 
 ############################################################
 # 11. tagger line label check #1
@@ -254,7 +259,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #1' \
-	'^error:.* missingTaggerEntry:'
+	'^error:.* missingTaggerEntry:' '--no-strict'
 
 ############################################################
 # 12. tagger line label check #2
@@ -269,7 +274,7 @@ This is filler
 EOF
 
 check_verify_failure '"tagger" line label check #2' \
-	'^error:.* missingTaggerEntry:'
+	'^error:.* missingTaggerEntry:' '--no-strict'
 
 ############################################################
 # 13. allow missing tag author name like fsck
@@ -298,7 +303,7 @@ tagger T A Gger <
 EOF
 
 check_verify_failure 'disallow malformed tagger' \
-	'^error:.* badEmail:'
+	'^error:.* badEmail:' '--no-strict'
 
 ############################################################
 # 15. allow empty tag email
@@ -422,13 +427,21 @@ this line should not be here
 EOF
 
 check_verify_failure 'detect invalid header entry' \
-	'^error:.* extraHeaderEntry:'
+	'^error:.* extraHeaderEntry:' '--no-strict'
 
 test_expect_success 'invalid header entry config & fsck' '
 	test_must_fail git mktag <tag.sig &&
+	git mktag --no-strict <tag.sig &&
+
 	test_must_fail git -c fsck.extraHeaderEntry=error mktag <tag.sig &&
+	test_must_fail git -c fsck.extraHeaderEntry=error mktag --no-strict <tag.sig &&
+
 	test_must_fail git -c fsck.extraHeaderEntry=warn mktag <tag.sig &&
+	git -c fsck.extraHeaderEntry=warn mktag --no-strict <tag.sig &&
+
 	git -c fsck.extraHeaderEntry=ignore mktag <tag.sig &&
+	git -c fsck.extraHeaderEntry=ignore mktag --no-strict <tag.sig &&
+
 	git fsck &&
 	env GIT_TEST_GETTEXT_POISON=false \
 		git -c fsck.extraHeaderEntry=warn fsck 2>err &&
-- 
2.29.2.222.g5d2a92d10f8

