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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE3AC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E1B2256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLWBjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgLWBjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCFC0611BB
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id g25so526861wmh.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xbzoLyQKWP+3G6iPoUD7H7pBOwXPm4kWI5AOs02T6Q=;
        b=a7Mu1iKjJQ9mi8h246ilsNBCISW+ir6WEMInRH/M3LD1zG9SmdEK5W94OQTbTDhwJD
         7Bkw9H1zplF32Hp6njkvlNX3uy3/EZUf+9I3Aw66Dip2fA/JYa93skYdVaYq6c6wWMfG
         6Yif28IEbpZUm+NDVyPZbQBARGPcm9bO6GZxAw9fpg0WD6rEj6vKPBQw7gdrghSkN7p1
         o5+Tw/+lm3mYAAGlcdxpyv5dWrqtQLeE10lzOfJUS838B8+w4OOfo7NxJ+iIqhPqpsnk
         MQaXjV5zqhpmrC+hjsRTpNmqIKALM/7GNmMUGynVak9UztL0+IlFQEmh+AVVx/QVxhWX
         803Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xbzoLyQKWP+3G6iPoUD7H7pBOwXPm4kWI5AOs02T6Q=;
        b=ngE/MMdlEV0KffIbRO+Xs79YZ7QYr7hfADKRm46f4E7gN6MkTi/e9X/q1NHCTG8E6y
         UliZIQ8VZsCiHM7u4Gc/JFL4H7prcEHM0W8TrKvpi9vkTHiS8U6i/ELCOxoloXRMGxTn
         5xA9P7YS0aBDwdUjClQOeIip7hOu+jaugM/+GL51z9HTGgu7ZrWRh+oaD0dfi39nqV8a
         XPPS/gX6DGANIlXtuS7GkC9RLNIX5jNMPyMX78ddTBuHW4jUF4kVVDPco2Jm0eMxE5ku
         VZmwuhuqcyGcknAwAuzSmJI40FkRI/fA2EF1AK8x5GPSQOj0l6iIJRDoAHIW17nXBT/4
         h1jQ==
X-Gm-Message-State: AOAM530KRHyX+peHll66k5DLCUHFgBW9frihTDlB7wiVVsft574cdjCz
        moDjGTomBx9WcDnpltkwdb9BQ48FK2W4cA==
X-Google-Smtp-Source: ABdhPJxXL+Qm8sZKYeAbkhQ3bWL1nmePHmPSayt0qSa6uwXG0B7diZjvAHww21FkBlCiJoKwrsWvkQ==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr24296077wmi.90.1608687480058;
        Tue, 22 Dec 2020 17:38:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 18/20] mktag: convert to parse-options
Date:   Wed, 23 Dec 2020 02:36:03 +0100
Message-Id: <20201223013606.7972-19-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
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
index 373926d7e0..18b8492f4d 100644
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
index 9383f7795b..177ab1682d 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -39,6 +39,18 @@ test_expect_success 'setup' '
 	head=$(git rev-parse --verify HEAD)
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

