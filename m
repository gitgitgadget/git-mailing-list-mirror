Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05BDC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiDMUEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiDMUE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7FA7B11A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so1158910wml.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSVxdNhwrv9fPSK8q0WpGsvCbpg6dgi5S1TxeJMIpKM=;
        b=eHTAeb/v4sMH0Vk64ACMmrXVFRoEZI6kDjv7XJ8oMG+jBOUsjLgU+62+WdK3JJcI7q
         NAiqE+z5hc8j4TrHxlLV1SRI5KSW7NzWQSv8FU+c/xf8sgWjPSEFbee59HehkH46AqiS
         HwOyyJTmYhGIHokqkHS11WH7s9oOVIuy32za3eVQtC9opX5W1X9LnSYkslzKeLy9YPU7
         GpNJ490kdG2LE9O9oNEODrbfOqn6LHXnqtUPOyV91j7sqR2WglGGYnWdPD7D5E24oeJ6
         aJuJdPiagZSCC/mlLCPSlVLyw6BWCnJTXGV++1U7cPtKxscWiQgWJdG8GlOsukxVVmvm
         vLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSVxdNhwrv9fPSK8q0WpGsvCbpg6dgi5S1TxeJMIpKM=;
        b=PKKtxJxE2TcJND7s+Y4CmNn88o5cg/0bHreqEIdD+0dgk5lXUqcXPHZX9T9DZJwX6T
         PSd28ys0hejKAXznnPAl/uJv3jFVazD/HjNqzgzZVK4m/BDqFh/edQzbDYRkTDXKZom9
         V+i1WDNfci4wSlsvFvw2sIeKxtxlxsd0Y3I8h4BDUfyLrhN48vTssbcif+rStM6KVQX/
         HYQET7ELjyoHfKyoN8IJHLKiC8FZBAbeq40UIxYzk5yv6gEEAg8D9VEBrfSEfMpplBKr
         KtmhdWldTF8Ncy/ppwRO+ISWHTaAWUniY4b62HNKbklYEXDoGoafQ/l5rOIoo4Rff5p8
         64QA==
X-Gm-Message-State: AOAM533u9VrjqDkauZaRuxCYyRwPQIUntCjjmSpJebETrtBMiRkbJb4Q
        5BzQvn9awahzM6pWQJi5xMTWgiX8jERReA==
X-Google-Smtp-Source: ABdhPJwyi9w4yNmrEL2LF+zFSmmDZc2oQaOY2ICN2zdoBOSYdpXGs96BoI2HGm/w1cncarF7GNRffQ==
X-Received: by 2002:a05:600c:4e12:b0:38b:b715:18a6 with SMTP id b18-20020a05600c4e1200b0038bb71518a6mr296615wmq.17.1649880123328;
        Wed, 13 Apr 2022 13:02:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:02 -0700 (PDT)
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
Subject: [PATCH v6 03/27] string_list API users: use string_list_init_{no,}dup
Date:   Wed, 13 Apr 2022 22:01:32 +0200
Message-Id: <patch-v6-03.27-21fe41e4ad8-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

