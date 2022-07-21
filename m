Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71133C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiGUMBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiGUMBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:01:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DC222A7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso692662wmq.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4b8H94OM4fk28mr7XQ91vcSXuuwM1fwH/NjsOfgNnM=;
        b=jlp2hboAP1j6Ennur8mEgS55rcc0CtIzPM4HMCVCs+ASvCTaqWRQxTqik3Cv/uig8B
         cB9LP7M3vPwk79Ym+b8sCqGAK/5zBs/uneo6eXXqaUBBfit8j8tzWjjgMWAPFmBL0o9k
         ALfNm/ZQwlSyRVrTnGGOEShmKl6sWaStm21OGlpJsN410E4RV/wmKRX/oN+VDssICQPi
         lFTyddsnk+mepr2PfQqNThR9XJ+4LFb4V15zFWITuQJ95dbU7OBNInlUvEnZ6jKoQQiv
         9pc2KspZtlkj5ZEjM7yr8LeoB0o0deyUdMAt3q6iwgURGCqO9fc2zhS05EgxsXTf6M+P
         +Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4b8H94OM4fk28mr7XQ91vcSXuuwM1fwH/NjsOfgNnM=;
        b=Sat8s6s/kkq0iYoQGu4RSChr5P3uGgSW6lwA1Cz2EmmnUkBcfKWNguidZiDLUL7hrR
         qOvnJbel5rewj+D0ADkxShVWFMUGq0tG0YzfFtkD8pmKPYiqma8xZIbCHYUfGC5C1v3t
         sp55l7YR9/mPJEjcBVMzuzmbmYc94uCEnf40Y78u5066ESoTlyWBMU8rFM75r4ko87Sf
         MQCthb8GcFbEjWMW22ambcI9QM2hjykZEfrTfjWBjEtO+FZ/VxpC99p9CvZPNqZmJZkB
         F+fAexEXHm0O3C0lsCwVu6JHChEKptGKSDiF/VZdhdZftDfy670W9sRsE/NADJiUEXQY
         k76w==
X-Gm-Message-State: AJIora8uRJ/RJMPVrnuFZdUwB3AbyrFp4QgAF6MOUQI1w8nrsIXp622X
        7sAW8aZ9NAtRD+K9KdpDAkAbOghTCka9mQ==
X-Google-Smtp-Source: AGRyM1tErtrHKaV9Jkt6kL9qqwRLGB0VYY6gFrirSUB1dL2NPxxJAUOtS18VarD3zlv5HhC/9lKWkw==
X-Received: by 2002:a7b:ca48:0:b0:3a3:365d:1089 with SMTP id m8-20020a7bca48000000b003a3365d1089mr803293wml.153.1658404875186;
        Thu, 21 Jul 2022 05:01:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm5226069wmh.33.2022.07.21.05.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:01:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] notes.c: make "struct string_list display_notes_refs" non-static
Date:   Thu, 21 Jul 2022 14:00:53 +0200
Message-Id: <patch-v2-6.6-b0de7a63d1c-20220721T111808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "struct string_list" added in 894a9d333e9 (Support showing
notes from more than one notes tree, 2010-03-12) to be non-static. Now
we don't need to flip-flop from "NODUP" to ".strdup_strings = 1".

In 2721ce21e43 (use string_list initializer consistently, 2016-06-13)
the statically initialized variable was made to use
"STRING_LIST_INIT_NODUP". That was correct in the narrow sense, but
didn't make much sense when this code was viewed as a whole. We'd set
it to "NODUP" just to set it to "DUP" when we'd use it.

This change could be smaller in just changing the "NODUP" to a "DUP",
but let's prove to ourselves and the compiler that this data is only
ever used when we enter load_display_notes(). We can just allocate it
in that function, and pass it to the notes_display_config() callback.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 notes.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/notes.c b/notes.c
index acc35b580b6..272fcb270a1 100644
--- a/notes.c
+++ b/notes.c
@@ -75,7 +75,6 @@ struct non_note {
 
 struct notes_tree default_notes_tree;
 
-static struct string_list display_notes_refs = STRING_LIST_INIT_NODUP;
 static struct notes_tree **display_notes_trees;
 
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
@@ -967,14 +966,19 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }
 
+struct notes_display_config_cb {
+	struct string_list *list;
+	int *load_refs;
+};
+
 static int notes_display_config(const char *k, const char *v, void *cb)
 {
-	int *load_refs = cb;
+	struct notes_display_config_cb *data = cb;
 
-	if (*load_refs && !strcmp(k, "notes.displayref")) {
+	if (*data->load_refs && !strcmp(k, "notes.displayref")) {
 		if (!v)
 			return config_error_nonbool(k);
-		string_list_add_refs_by_glob(&display_notes_refs, v);
+		string_list_add_refs_by_glob(data->list, v);
 	}
 
 	return 0;
@@ -1080,7 +1084,11 @@ void load_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
 	int load_config_refs = 0;
-	display_notes_refs.strdup_strings = 1;
+	struct string_list display_notes_refs = STRING_LIST_INIT_DUP;
+	struct notes_display_config_cb cb_data = {
+		.list = &display_notes_refs,
+		.load_refs = &load_config_refs,
+	};
 
 	assert(!display_notes_trees);
 
@@ -1096,7 +1104,7 @@ void load_display_notes(struct display_notes_opt *opt)
 			load_config_refs = 1;
 	}
 
-	git_config(notes_display_config, &load_config_refs);
+	git_config(notes_display_config, &cb_data);
 
 	if (opt) {
 		struct string_list_item *item;
-- 
2.37.1.1095.g64a1e8362fd

