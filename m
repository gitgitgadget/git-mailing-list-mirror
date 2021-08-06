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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B99BC432BE
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1A561159
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 19:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbhHFTNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 15:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbhHFTNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 15:13:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457FC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 12:13:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so6799986wmg.4
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQgn/Qbe2WqwUjiO3JXeXKD5F4hVigk2W4Ylv8D8kis=;
        b=ruzLYttpcL6yfIyRtZzpF9FlIHeWUQ3wRITICf+E5xmZGoWF8bU7z65Avd4f03nAEs
         a+o0x369qOmHKOYf5t7k9ey36yDXIBnFE8PDjwAhAAjvzw/qf/caByag/OsFmysiS/WS
         EeXWUX/O6ANOPU2HDmF77+M7tyDWOB8qQ2paMAa5/o08HGjm+JFhT/TVXA6kolR+DMZg
         /yKzZXXbo2Nh0IRmCot5xRRH6Dpxsc1EOQGke6rL66ERb7tbDnDbOM1I6Jk4J3zfVbcu
         wKgxdvVsfeQ/QRPO2BPwuiPqrUnu0VYpndZjRG7Y7g4EgiN0rUfS/H1JT+aftOtULuKZ
         8q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQgn/Qbe2WqwUjiO3JXeXKD5F4hVigk2W4Ylv8D8kis=;
        b=iN3pOOZLJNHxqx44LxWlajihLRfqwQziF4nboWHveHF/jgMPyoo8UA1DlKhtYW6Jjw
         NkMcd19v29rfWEOMOrU28+kG6CyIpldFL7u+kX9YhDRym4Ns994yHLaa427K4v9oaHTy
         V8zxoDlauG0Fq5Kf1Krru0FzEohhAEJpjA7cqhlw9YSeM0u/UQU42D2eNcS53yYu3Ako
         x8UNgk8BGbns/ZQ79IFvhHDUtYOP1Ewju74BxgOldP9UwaLnkbKysbmqokWnjKd/aeCG
         ToUDCeSYMhM8nPaIGea0nibBlODBMuYVOYVjGTg283DH2eXDCG0cYPVvCM3hHnXDmudC
         CiLA==
X-Gm-Message-State: AOAM5317SqB5F/jsJWU489h3LuveHnqBjaLDqpzUvI0inclWEtPSMfaW
        2wFhT/Aw6MAMSZCronoLMENBPgitU7GcNg==
X-Google-Smtp-Source: ABdhPJyhe3+9i3lnFR4fIXSqSpLEBAc62tfztSNA/h9wmpTNrEYAJ3sq8hTgxuLSt5QmlpNCi86ERw==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr22056746wma.118.1628277203353;
        Fri, 06 Aug 2021 12:13:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12sm11039849wrn.31.2021.08.06.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 12:13:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v3 4/4] advice: move advice.graftFileDeprecated squashing to commit.[ch]
Date:   Fri,  6 Aug 2021 21:13:18 +0200
Message-Id: <RFC-patch-v3-4.4-fe6f6328f9-20210806T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.680.gf07173a897a
In-Reply-To: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
References: <20210805230321.532218-1-mathstuf@gmail.com> <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
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
index 41cfea82d0..e716ddebff 100644
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
index 4b754f4c62..e380a0562e 100644
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
index cd48765911..946938d011 100644
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
index 143f472c0f..551de4903c 100644
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
index df42eb434f..3ea32766bc 100644
--- a/commit.h
+++ b/commit.h
@@ -41,6 +41,7 @@ struct commit {
 };
 
 extern int save_commit_buffer;
+extern int no_graft_file_deprecated_advice;
 extern const char *commit_type;
 
 /* While we can decorate any object with a name, it's only used for commits.. */
-- 
2.33.0.rc0.680.gf07173a897a

