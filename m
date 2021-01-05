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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A6C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F22822D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbhAETpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbhAETpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06162C0617BA
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q75so630529wme.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZAM0KXjAA17LKrIbopXlrJ6gpa4ing+EDYZdBFBToM=;
        b=pA2Iv/7YKgXSaLZop9RS3aYM7rnjdzR5YnaTYa7Hlwknl29nbZMbOCcqbTBrbSrTo8
         mIqWBdKttBzuXB3qZJ+0nlxSXjyCfxYcu/o3xEbp339pLDamb5AtTn6ANs1/4UELF3k5
         QIwwt+ZSuhnOsMtmAcSkhIzG479aGIr1V9n/4hmY3H1kR561iAthlBlFFZfUY4ADk8jx
         DDnp9qetkTqvjqUmHebyP0q+15/Y88O8ZHJlufHwTit/sJFCrBWh4RoL0Luu6vft79oU
         FLu6LoMXno+dzdMVonAv73SYw/O06P4f14+2aQpnPia8bApqO0CAf+dmf0QAUnZ+1qbj
         j6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZAM0KXjAA17LKrIbopXlrJ6gpa4ing+EDYZdBFBToM=;
        b=qqbdNj1zaeQ1e6i/DFeMIkCC4tfS76HQsAL1t79eKWc7crAgEpDjGeSKKbCfL6v/gQ
         lpBHF9evSKy+lgTfebRLTi4t5u90V6Wsgxqgg2jqJ7Gc4Q+KOlR5thHavKJ4rug/pJzC
         qmN0DeLSVh66quqVnAEjEggKtWvo1+AEUg6pxFLLZmy8bovu1ipnZE+ojhPHQcMccEPJ
         vfsjB8EUe2jZx84OrluGlO67U9YLuhFAoHTUZSBVeJl1C7xnz5hl/S58wQJUEeCN/rR5
         HezEHhjroMA+rG7pKixsNBu3hv9TUFLYFnp9wT+Uyauh0VthyR1Fjcfs+V+Re6bJ9sIp
         9Gqw==
X-Gm-Message-State: AOAM530VkUqbVrnMKNsj7/9Vbls+vrRXi3a74gQtvbAHRQt5wC+H8W8f
        NHW9sDNT49YiIhV6UHq16TYa6X9U2jVwhQ==
X-Google-Smtp-Source: ABdhPJy1obOzVJGdxUKymREzOS+vE6as0MI98MvCY+vr1lkfXlG8bSol2Bnw5k0lINzU+0RQ8bUz1g==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr583086wma.141.1609875829496;
        Tue, 05 Jan 2021 11:43:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:48 -0800 (PST)
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
Subject: [PATCH v5 21/23] mktag: convert to parse-options
Date:   Tue,  5 Jan 2021 20:42:50 +0100
Message-Id: <20210105194252.627-22-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the "mktag" command to use parse-options.h instead of its own
ad-hoc argc handling. This doesn't matter much in practice since it
doesn't support any options, but removes another special-case in our
codebase, and makes it easier to add options to it in the future.

It does marginally improve the situation for programs that want to
execute git commands in a consistent manner and e.g. always use
--end-of-options. E.g. "gitaly" does that, and has a blacklist of
built-ins that don't support --end-of-options. This is one less
special case for it and other similar programs to support.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c  | 14 ++++++++++++--
 t/t3800-mktag.sh | 12 ++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 373926d7e0c..18b8492f4d4 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,10 +1,16 @@
 #include "builtin.h"
+#include "parse-options.h"
 #include "tag.h"
 #include "replace-object.h"
 #include "object-store.h"
 #include "fsck.h"
 #include "config.h"
 
+static char const * const builtin_mktag_usage[] = {
+	N_("git mktag"),
+	NULL
+};
+
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 static int mktag_config(const char *var, const char *value, void *cb)
@@ -60,13 +66,17 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
+	static struct option builtin_mktag_options[] = {
+		OPT_END(),
+	};
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id tagged_oid;
 	int tagged_type;
 	struct object_id result;
 
-	if (argc != 1)
-		usage("git mktag");
+	argc = parse_options(argc, argv, NULL,
+			     builtin_mktag_options,
+			     builtin_mktag_usage, 0);
 
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno("could not read from stdin");
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 601b064e97a..0ddd0f01cc7 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -45,6 +45,18 @@ test_expect_success 'setup' '
 	blob=$(git rev-parse --verify HEAD:B.t)
 '
 
+test_expect_success 'basic usage' '
+	cat >tag.sig <<-EOF &&
+	object $head
+	type commit
+	tag mytag
+	tagger T A Gger <tagger@example.com> 1206478233 -0500
+	EOF
+	git mktag <tag.sig &&
+	git mktag --end-of-options <tag.sig &&
+	test_expect_code 129 git mktag --unknown-option
+'
+
 ############################################################
 #  1. length check
 
-- 
2.29.2.222.g5d2a92d10f8

