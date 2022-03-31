Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E1C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352252AbiCaBOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352235AbiCaBN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:13:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E728B66233
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w21so26980879wra.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7luTwgBx7dBAl5ByXttJKQfRlc/TI28tPc+t0xdBnr4=;
        b=Snunju1F/PhDOivMwM44oPCpbwz9MMaFFel0BrhZoWfkeFFvtzybAa0OvrQuSw0/a9
         0Xq96PeeiKFMipYxnsTIoRKYu7VSqU6vg6eXBmcw+RP9QwItDaZXjwmdjnaNpf+cFwtC
         O8sR4GMItmQg9yh7a5wN+ck3crVT2wJufjMAbXpnUfEDZ779w256vdoHhspV6F+Jf9XP
         CY+PgKbz0cF92hBf9EWoISICKp1CfGmkRDaEmxpyAmb7CjB86MUqumViUm1NRLdefLic
         1AkKP/l1PEp96BiXCJ3bTzSxbKx/IoWlvKH51itsDAo5X9XySvO3+gJYPjTzhfLerPlu
         hPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7luTwgBx7dBAl5ByXttJKQfRlc/TI28tPc+t0xdBnr4=;
        b=WuMaMQuotDdRxbDwb9+Ns0ddoPMMfNxq7sIeByD+9o55HgnZYv8AWBQbO6Jo1qguYK
         kMX/An5ApT42FY51xwEKpI1CK/tBPyqQ7zhB/WI03OL+saktmtdzlXpBlSxdMTR4hap5
         sAHP9OpspnXeWvSr7ulzDT8ZNoK98QiVzkBPM5u7STssYsAWDypZTbq9khga3a+mq1cd
         Btuos/bdSyQQuwK//nmRUNiiDZJdoBlX03Ms9tT6+fDGsrR2jmbOhQ6nEw0Fx1fjy19d
         0cv2/6k3dr3GuPUAP0Qf1z7hpwGfRAUoVuWAkEhFrj13R1F5xAjhXnFn4l+J4YngouHg
         5QYQ==
X-Gm-Message-State: AOAM532Vc53yJJtSqa+sXpXVJZGtPI6iR8/elTtRaatKrOAqvNlvnE+k
        VP2dJazlZhD58gzXXG2nFBvpaiylRcYzVg==
X-Google-Smtp-Source: ABdhPJx4JkwPGiA3FFhaCg9AnftZinjK9FRSTDvZv+QYUULoL4oGZGELw2SMYBUxSTbUFpX1ShEg+g==
X-Received: by 2002:a5d:61ca:0:b0:205:8e68:8f81 with SMTP id q10-20020a5d61ca000000b002058e688f81mr1964820wrv.145.1648689128306;
        Wed, 30 Mar 2022 18:12:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/27] string_list API users: use string_list_init_{no,}dup
Date:   Thu, 31 Mar 2022 03:11:08 +0200
Message-Id: <patch-v4-03.27-243f7c8df96-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
2.35.1.1557.g4e3e9cdb5e0

