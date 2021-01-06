Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1068C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588F623105
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbhAFLsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFLsY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:48:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253BC06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 03:47:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t16so2174548wra.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 03:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYkTsd6jFL3+PZ+XKxYOpJziuhCsN3/753OHEFGLKd0=;
        b=Iyz7FfABb+Kg7BttyD7eloi/9c5N3Z8JjraX+b2yljTl4zzkZiT3b0+pw3CntDWeFe
         AXbeNOYd7Qu5rm61oQNcQFm9kWXsum7oUCW2Qgv64sfEtDJwDmnapdKYN3ODxe9J8BFx
         vDNiI/jRUXRB80qdXm5IS9HqDPg3PPdgC+GW4eUOSmD8FuUJZvDSipThh+sNQbWzUSOo
         NDlCBkZbGf6MF1jTgboGZe6gG6RHWILxgBGyUhwt39eu7mAABea0mxsNrHxVMO0dE84N
         YXldVTrov9vQU5Bu11I2IoGqNJ8EAiPflnSkuP/ZhA7u4y0ZMi/Z0UCxY8XJzIxez5qN
         yQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYkTsd6jFL3+PZ+XKxYOpJziuhCsN3/753OHEFGLKd0=;
        b=eub6FtTbpvlnzxyVNTZEKZhhjHOpm5raQKrgxrJlnFNvAiQ95iNxk/p/u/bZSCqO+8
         v5u6XSQqQ3wSXBkQS0YQDJGtuySDxoPeWyYHJ/8NwWWVUpjuHO4ZmaqVGdXV6JvMO8P2
         SEQkxVH7boryVzstRaxqhphHaCmMuU91cRevo5ql8L/iO8FqnpmbZtvY3TLGagMPf8Ab
         x7jyNKNCQSK5DemDPXaroHm3vQuMipq5p0K+H5KE+rVq+94oFAXHxGhvDjV6/SQJtkfo
         bv8C1I22C6Zp2+Pw528VaOdwtIxcGFN3/0HcbCrShO59/CElTXUwfjMQoxGJhkadiJsQ
         IfdQ==
X-Gm-Message-State: AOAM532Do5ATtqBtccYAQcqAfbAY3137O9jJEECVzihfKQKXdttKF1vS
        72bHXYT0NnMpTtrL3XRfcxvb7t3AtfZMSQ==
X-Google-Smtp-Source: ABdhPJyFkI3+JB5ryUNPa0IBJtHxNzTCOlaxfnL44Fkh9godwJylKIjI2Z2vghFbWhsyeomJKzwWrQ==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr4122686wra.68.1609933661720;
        Wed, 06 Jan 2021 03:47:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c20sm2733406wmb.38.2021.01.06.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 03:47:41 -0800 (PST)
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
Subject: [PATCH v6 23/23] mktag: add a --[no-]strict option
Date:   Wed,  6 Jan 2021 12:47:27 +0100
Message-Id: <20210106114727.8405-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqq4kjuygw7.fsf@gitster.c.googlers.com>
References: <xmqq4kjuygw7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that mktag has been migrated to use the fsck machinery to check
its input, it makes sense to teach it to run in the equivalent of "git
fsck"'s default mode.

For cases where mktag is used to (re)create a tag object using data
from an existing and malformed tag object, the validation may
optionally have to be loosened. Teach the command to take the
"--[no-]strict" option to do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Jan 06 2021, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Now that mktag has been migrated to use the fsck machinery to check
>> its input, it makes sense to teach it to run in the equivalent of "git
>> fsck"'s default mode, instead of hardcoding "git fsck --strict". Let's
>> do that and support the "--no-strict" option.
>>
>> Since this is a new option we don't need to cater to parse-option.c's
>> default of automatically supporting --strict. So let's use
>> PARSE_OPT_NONEG, using a new trivial helper macro.
>
> I do not understand the last paragraph.

I forgot to update the commit message when changing this from
v4->v5. Here's a v6 of just this patch (to save on list traffic) with
an updated commit message. Thanks!

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

