Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F5BC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiGUMBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGUMBN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:01:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A4C222A7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m17so1645458wrw.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3iifzuJUvSeoDD3L9v4NNaaHkAGtR6/00xJdEhVSlI4=;
        b=ZiPIp5cgmcz5obYIzmTRZFViGyzV28uK22z7DY75BJox+ApHFB7MlXuKzEyaFBZ8n4
         fskTKd9Q+lpvqZPY3GEcPLleWVgLHSRSwY7RAqzJPWI3DxKtAuOGARZFAUekjRwhaeo4
         99af7N/QzyZJWoVhy1Cc8e6aRJRDRYRLTNb4BW2lCrfagRGOzvL4RJUUNRt6aL9VDfFL
         /Dw4PFsD+GBsEkQBL27/1GW1XHsBW+lvaXjlsVV4JejsJyEkZzdfyBptrFOP2WLZkvJX
         LpfyqGNhgwfC0jF0JFtVOmm5s8TnxdqpKAQvTQWQXTC7acqZWM2trh8xg49z7XqgBND0
         E5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3iifzuJUvSeoDD3L9v4NNaaHkAGtR6/00xJdEhVSlI4=;
        b=kpGOMfm3oD3VIXRYumynP035/grPcry/IRaZMlWvrMJbWrHeYpFqDqRvBRuuPhKt4i
         yue4iGtEN56VfwCbpz4dTPpSSlIpUwK7JZIiPmP83zGACOKm57sjytq59+Eow/kjDNKp
         4ElyvSD8ScCeLG9nJszCv+oX/MkW/t5SgR04510FCiiALeA1pc4aOYxyW76douCLPw5i
         ubvGBvUc7Mb45sOcKYHV/0iVShfOR6kU23aR5kSoiwtipnoJ62FfjZh3OAyqqALnthMb
         INwjGGs868HFHjxhIFyUJZoGGet8OKw5RA0zA8zVaUKebqi5/mYPDWJagLZ/jDpjDMw6
         WTBg==
X-Gm-Message-State: AJIora9emzHX1myb2E1VkhUtFAdbtEpG/1aXZBDZKwHXKqi2eC8nULK2
        8cvd7i2VAM9mH+Qr9honeJ3KyzZXT4v8gQ==
X-Google-Smtp-Source: AGRyM1t5+87HXrz+Mxpv/PzAaEGkkxfArbg7Zz9usJrqqBMxiupGeCsy2cgBTxRkjev0TJ9WqGvMTg==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr34195170wrr.2.1658404870715;
        Thu, 21 Jul 2022 05:01:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm5226069wmh.33.2022.07.21.05.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:01:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] string_list API users + cocci: use string_list_init_dup()
Date:   Thu, 21 Jul 2022 14:00:48 +0200
Message-Id: <patch-v2-1.6-61a62bdf8e9-20220721T111808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule to detect a particular misuse of the "struct
string_list" API. We have the *_INIT macros, but this code assumed
that a zero'd out "struct string_list" with a "strdup_string" set
would be the same as string_list_init_dup().

That assumption happens to be right, but let's instead use the helper
functions introduced in 183113a5ca9 (string_list: Add STRING_LIST_INIT
macro and make use of it., 2010-07-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/string-list.cocci     | 8 ++++++++
 contrib/coccinelle/tests/string-list.c   | 7 +++++++
 contrib/coccinelle/tests/string-list.res | 7 +++++++
 refs.c                                   | 4 ++--
 resolve-undo.c                           | 8 ++++----
 revision.c                               | 4 ++--
 6 files changed, 30 insertions(+), 8 deletions(-)
 create mode 100644 contrib/coccinelle/string-list.cocci
 create mode 100644 contrib/coccinelle/tests/string-list.c
 create mode 100644 contrib/coccinelle/tests/string-list.res

diff --git a/contrib/coccinelle/string-list.cocci b/contrib/coccinelle/string-list.cocci
new file mode 100644
index 00000000000..5d285d5732c
--- /dev/null
+++ b/contrib/coccinelle/string-list.cocci
@@ -0,0 +1,8 @@
+@@
+struct string_list *P;
+@@
+- CALLOC_ARRAY(P, 1);
++ ALLOC_ARRAY(P, 1);
+... when != P
+- (P)->strdup_strings = 1;
++ string_list_init_dup(P);
diff --git a/contrib/coccinelle/tests/string-list.c b/contrib/coccinelle/tests/string-list.c
new file mode 100644
index 00000000000..e77822b7682
--- /dev/null
+++ b/contrib/coccinelle/tests/string-list.c
@@ -0,0 +1,7 @@
+int init(void)
+{
+	struct string_list *list;
+
+	CALLOC_ARRAY(list, 1);
+	list->strdup_strings = 1;
+}
diff --git a/contrib/coccinelle/tests/string-list.res b/contrib/coccinelle/tests/string-list.res
new file mode 100644
index 00000000000..7e666f5bf48
--- /dev/null
+++ b/contrib/coccinelle/tests/string-list.res
@@ -0,0 +1,7 @@
+int init(void)
+{
+	struct string_list *list;
+
+	ALLOC_ARRAY(list, 1);
+	string_list_init_dup(list);
+}
diff --git a/refs.c b/refs.c
index 90bcb271687..83151a42b3a 100644
--- a/refs.c
+++ b/refs.c
@@ -1313,8 +1313,8 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 		while (len && ref[len - 1] == '/')
 			ref[--len] = '\0';
 		if (!hide_refs) {
-			CALLOC_ARRAY(hide_refs, 1);
-			hide_refs->strdup_strings = 1;
+			ALLOC_ARRAY(hide_refs, 1);
+			string_list_init_dup(hide_refs);
 		}
 		string_list_append(hide_refs, ref);
 	}
diff --git a/resolve-undo.c b/resolve-undo.c
index e81096e2d45..e66b8306fe0 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -15,8 +15,8 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 		return;
 
 	if (!istate->resolve_undo) {
-		CALLOC_ARRAY(resolve_undo, 1);
-		resolve_undo->strdup_strings = 1;
+		ALLOC_ARRAY(resolve_undo, 1);
+		string_list_init_dup(resolve_undo);
 		istate->resolve_undo = resolve_undo;
 	}
 	resolve_undo = istate->resolve_undo;
@@ -57,8 +57,8 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 	int i;
 	const unsigned rawsz = the_hash_algo->rawsz;
 
-	CALLOC_ARRAY(resolve_undo, 1);
-	resolve_undo->strdup_strings = 1;
+	ALLOC_ARRAY(resolve_undo, 1);
+	string_list_init_dup(resolve_undo);
 
 	while (size) {
 		struct string_list_item *lost;
diff --git a/revision.c b/revision.c
index 0c6e26cd9c8..e44af92cacc 100644
--- a/revision.c
+++ b/revision.c
@@ -1578,8 +1578,8 @@ void clear_ref_exclusion(struct string_list **ref_excludes_p)
 void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 {
 	if (!*ref_excludes_p) {
-		CALLOC_ARRAY(*ref_excludes_p, 1);
-		(*ref_excludes_p)->strdup_strings = 1;
+		ALLOC_ARRAY(*ref_excludes_p, 1);
+		string_list_init_dup(*ref_excludes_p);
 	}
 	string_list_append(*ref_excludes_p, exclude);
 }
-- 
2.37.1.1095.g64a1e8362fd

