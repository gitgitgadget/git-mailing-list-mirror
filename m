Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408BC4320E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFED86138B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhHWKpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbhHWKpC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:45:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F9CC061764
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso13723623wmb.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gn+01kd3B0VCVlQH7eq0rILv3JBERy5BUQlL9HF9wZs=;
        b=pN6bl5IEvMb/FSteL3c7d7jJ5t/0qwjJwtU7RLAb9C+iYJbln7GHFbpCCApq+unyac
         3G9I3k36z4u4UgBYTS9SlAiIWpfWYSq8jmdAoqprwWKW8gbuE2z4kiG/aD71X46NYQUh
         DMZzO8Qzl3qHTvzLnCQ+nEFx4bwcboQW0mUp/JY9zsY9TCa1mWC4iI2NVpRhxvM6xsjX
         2Eso/EYCCtUPX0RnUKvao8HRQ3iuiKqCtlIdIMBvYqo9TnUa2hocL8/jwn9IKl/3xFUO
         5L/T7MSpHdaaNfV3ivgQfG4bq43sn6BDaD/CsBkvPpENaNvefOU/RWxyR6IZt3uslgdX
         vrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gn+01kd3B0VCVlQH7eq0rILv3JBERy5BUQlL9HF9wZs=;
        b=EEjVSOW2c+b1DdgJX/BlW/suYHKSRvnF4lndO5mXrocrFEaBVZJW9cn1PHvCapV7cR
         AcmMTFhrGVj4tD2kdPptkefLRCpGgdcB5MQyP0NDvVzP6JMkUcnX8eIyJ/6VfGXvSfxd
         KX4tWGk1r7lKw8ROIxsBzHSij8LuTWeeAQYjrhKMjZ+ih3XBdbSRnUSbvgZuwcNvueW3
         h24dSBSdifJu9fntYWfYyhD8q6ciu6BERXxcFJq2MzJ+cITCZAXsdEB2BSuPPCxiBnRO
         ux5lU/Ay5dgIUgATjXapoCpnZFC0E4q7E0OIYv8HCdmug2mW7lpxP1Ymq46OYu9h8DxL
         dv+g==
X-Gm-Message-State: AOAM530wZHJC4rijMphHEgZK5p5KxZZjl3tt0XAvjXWVRKuzHsW2oE+W
        Eejzyf0/9MqMM0y755PwTKL7iSiynHWWy3t1
X-Google-Smtp-Source: ABdhPJyofl2He+t3BpZnK+GSXKf1hnOlXdkJYeJe/s92IQqZKrbak3yikdPieNii1s5TWyKGYsH9wQ==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr14949419wmc.95.1629715456598;
        Mon, 23 Aug 2021 03:44:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k12sm15351187wrd.75.2021.08.23.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:44:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/4] advice: move advice.graftFileDeprecated squashing to commit.[ch]
Date:   Mon, 23 Aug 2021 12:44:02 +0200
Message-Id: <patch-v4-4.4-7f79fb282e5-20210823T103719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
References: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the squashing of the advice.graftFileDeprecated advice over to an
external variable in commit.[ch], allowing advice() to purely use the
new-style API of invoking advice() with an enum.

See 8821e90a09a (advice: don't pointlessly suggest
--convert-graft-file, 2018-11-27) for why quieting this advice was
needed. It's more straightforward to move this code to commit.[ch] and
use it builtin/replace.c, than to go through the indirection of
advice.[ch].

Because this was the last advice_config variable we can remove that
old facility from advice.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.c          | 16 ----------------
 advice.h          |  2 --
 builtin/replace.c |  2 +-
 commit.c          |  4 +++-
 commit.h          |  1 +
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/advice.c b/advice.c
index 41cfea82d06..e716ddebffe 100644
--- a/advice.c
+++ b/advice.c
@@ -4,8 +4,6 @@
 #include "help.h"
 #include "string-list.h"
 
-int advice_graft_file_deprecated = 1;
-
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -33,13 +31,6 @@ static const char *advise_get_color(enum color_advice ix)
 	return "";
 }
 
-static struct {
-	const char *name;
-	int *preference;
-} advice_config[] = {
-	{ "graftFileDeprecated", &advice_graft_file_deprecated },
-};
-
 static struct {
 	const char *key;
 	int enabled;
@@ -162,13 +153,6 @@ int git_default_advice_config(const char *var, const char *value)
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
-		if (strcasecmp(k, advice_config[i].name))
-			continue;
-		*advice_config[i].preference = git_config_bool(var, value);
-		break;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
 		if (strcasecmp(k, advice_setting[i].key))
 			continue;
diff --git a/advice.h b/advice.h
index 4b754f4c626..e380a0562e3 100644
--- a/advice.h
+++ b/advice.h
@@ -5,8 +5,6 @@
 
 struct string_list;
 
-extern int advice_graft_file_deprecated;
-
 /*
  * To add a new advice, you need to:
  * Define a new advice_type.
diff --git a/builtin/replace.c b/builtin/replace.c
index cd487659117..946938d011e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -507,7 +507,7 @@ static int convert_graft_file(int force)
 	if (!fp)
 		return -1;
 
-	advice_graft_file_deprecated = 0;
+	no_graft_file_deprecated_advice = 1;
 	while (strbuf_getline(&buf, fp) != EOF) {
 		if (*buf.buf == '#')
 			continue;
diff --git a/commit.c b/commit.c
index 143f472c0f2..551de4903c1 100644
--- a/commit.c
+++ b/commit.c
@@ -25,6 +25,7 @@
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
 int save_commit_buffer = 1;
+int no_graft_file_deprecated_advice;
 
 const char *commit_type = "commit";
 
@@ -190,7 +191,8 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
-	if (advice_graft_file_deprecated)
+	if (!no_graft_file_deprecated_advice &&
+	    advice_enabled(ADVICE_GRAFT_FILE_DEPRECATED))
 		advise(_("Support for <GIT_DIR>/info/grafts is deprecated\n"
 			 "and will be removed in a future Git version.\n"
 			 "\n"
diff --git a/commit.h b/commit.h
index df42eb434f3..3ea32766bcb 100644
--- a/commit.h
+++ b/commit.h
@@ -41,6 +41,7 @@ struct commit {
 };
 
 extern int save_commit_buffer;
+extern int no_graft_file_deprecated_advice;
 extern const char *commit_type;
 
 /* While we can decorate any object with a name, it's only used for commits.. */
-- 
2.33.0.663.gfcc3c7013a8

