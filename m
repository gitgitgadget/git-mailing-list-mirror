Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B074FC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354486AbiDBKvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353356AbiDBKvk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D1B1403E6
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y10so5682008edv.7
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b519pg8kwKE9L+rwYFXR5PkvGHLbEd634aF0KUanQF0=;
        b=MVWNmmDhHfoenfdhkYD5KAuw3yEtmis/7aSrwxEqyDwQzZesKXf+j9/Jb0IadbIkqe
         a5wo6Y35dNeF3ecgzpMlNECgdKQ1YNSeKqyJuMK2zaYTXp+nVwARthmW0NZ+l+O1OZjS
         jDPJ2RSf9YLozeKDXjwUq6J7IIrNDpJvMZeVjZvMUWzdKGnCTniUFeiJ5qx80zRFSPxH
         rlnHXm6R4XLhrnVQHcQyDti0f2dFUdG+tM9D757ntAOQ8/HgMHB3+BOAXhs2DgTlTpTh
         nh9wimtrLcDCkINI7hUyR/qOwW5igvmFdeqigETFl4khZnRAiySr+4yXYR/WvlzXUu56
         OPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b519pg8kwKE9L+rwYFXR5PkvGHLbEd634aF0KUanQF0=;
        b=MGgpa5GpjaEN42ARMrYScikjTTe03B+z772YWmmaUIvXdGp9tPS2ZVDiH2rgtgSQKS
         JzvTmSNZv7qI3fgN5tncSlW/dwuV/4CxhJhXbN7PFdO5V7NYSEiLlMynlGsMg1BLoREN
         zgcXbvbF3xAu7mWK2nqXq4ytlzXfguSVtw/eJ7xEzjTuAWAJXUIzXY8XLU5zfrG9Lmlq
         RybLR3OWUbu+6txFVq1bNGYmRuPJ3d/Mlgm62Hx9w9pWkzOHr40zE+/2nm2ELh7JGsPv
         8hOEked4C6pUQYUfZ/hqKTNboXV2/eI5Imso887cUS8AJYwHA/ppTrFSVMb9B+3CFDE/
         LYLw==
X-Gm-Message-State: AOAM5310zvAxFcZ+QwnpTH/7VaF4F5pkz6LfqGv2hKCXa0z4v6RNF0Gr
        UPRcHZ18hJv04yl00N7WrgcPAIKT76/Ouw==
X-Google-Smtp-Source: ABdhPJz8YJK2cz1mY+s/8py5V+Xc+zRoiUtxcjIy8ymrIfo+cdhWJKoG8OA7wNYZZ8iwBfRpSIEzZQ==
X-Received: by 2002:a50:eb8b:0:b0:419:a11c:8676 with SMTP id y11-20020a50eb8b000000b00419a11c8676mr24702577edr.267.1648896587852;
        Sat, 02 Apr 2022 03:49:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/27] string_list API users: use string_list_init_{no,}dup
Date:   Sat,  2 Apr 2022 12:49:17 +0200
Message-Id: <patch-v5-03.27-364aa7d8990-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up on the introduction of string_list_init_nodup() and
string_list_init_dup() in the series merged in bd4232fac33 (Merge
branch 'ab/struct-init', 2021-07-16) and convert code that implicitly
relied on xcalloc() being equivalent to the initializer to use
xmalloc() and string_list_init_{no,}dup() instead.

In the case of get_unmerged() in merge-recursive.c we used the
combination of xcalloc() and assigning "1" to "strdup_strings" to get
what we'd get via string_list_init_dup(), let's use that instead.

Adjacent code in cmd_format_patch() will be changed in a subsequent
commit, since we're changing that let's change the other in-tree
patterns that do the same. Let's also convert a "x == NULL" to "!x"
per our CodingGuidelines, as we need to change the "if" line anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c      | 9 ++++++---
 builtin/shortlog.c | 6 ++++--
 merge-recursive.c  | 4 ++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d0..634dc782cce 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -231,7 +231,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	}
 
 	if (mailmap) {
-		rev->mailmap = xcalloc(1, sizeof(struct string_list));
+		rev->mailmap = xmalloc(sizeof(struct string_list));
+		string_list_init_nodup(rev->mailmap);
 		read_mailmap(rev->mailmap);
 	}
 
@@ -2173,8 +2174,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		prepare_bases(&bases, base, list, nr);
 	}
 
-	if (in_reply_to || thread || cover_letter)
-		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
+	if (in_reply_to || thread || cover_letter) {
+		rev.ref_message_ids = xmalloc(sizeof(*rev.ref_message_ids));
+		string_list_init_nodup(rev.ref_message_ids);
+	}
 	if (in_reply_to) {
 		const char *msgid = clean_message_id(in_reply_to);
 		string_list_append(rev.ref_message_ids, msgid);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 26c5c0cf935..fcde07c9367 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -81,8 +81,10 @@ static void insert_one_record(struct shortlog *log,
 		format_subject(&subject, oneline, " ");
 		buffer = strbuf_detach(&subject, NULL);
 
-		if (item->util == NULL)
-			item->util = xcalloc(1, sizeof(struct string_list));
+		if (!item->util) {
+			item->util = xmalloc(sizeof(struct string_list));
+			string_list_init_nodup(item->util);
+		}
 		string_list_append(item->util, buffer);
 	}
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 1ee6364e8b1..32bbba5fbb1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -522,10 +522,10 @@ static struct stage_data *insert_stage_data(struct repository *r,
  */
 static struct string_list *get_unmerged(struct index_state *istate)
 {
-	struct string_list *unmerged = xcalloc(1, sizeof(struct string_list));
+	struct string_list *unmerged = xmalloc(sizeof(struct string_list));
 	int i;
 
-	unmerged->strdup_strings = 1;
+	string_list_init_dup(unmerged);
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(istate);
-- 
2.35.1.1585.gd85f8dcb745

