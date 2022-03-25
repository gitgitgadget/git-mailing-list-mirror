Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9264AC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiCYRgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCYRgK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:36:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE56BA5EB7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:34:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q14so11174405ljc.12
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOgUU4HL9bcXKogTNecqNkZvc6vRyVGwA1MfSfz32Og=;
        b=NxtP1AlavjDtdX7u5eZIdd+s1v9pyXvSja3eVzkIy72FDfJ8seEBz+wkRAyNcSTyEc
         NX+BE0Ft9nOdVNgzQDJVR17zXAqzISmS3n93JmhF22y8AfvIRfZ+q4lF4jUUwLp1MP9q
         7XzAWBfDifWgjrhoPiPWmNTS43pu+UslxZFBsFn0HTVmB5N6skSfnEvAivJyk+JD5fZ+
         jviZuCLJ70wduCENBPZziRpY486qMJhM7DAeivl9ZjDnrBqpF7keDi6OssAj/MAu1wMr
         4I6RxXU1/GwCs0uMOOwrI4+x8J8qmPxObGW7qKTWPxAJbYcyAwCUBG5JJIEsb7gtbFGy
         lXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOgUU4HL9bcXKogTNecqNkZvc6vRyVGwA1MfSfz32Og=;
        b=vOVvAKFlAFT36NSjiUODaw1aB0dGcxqXPdXnT/w1qTymkuFGD0wNDmE6G3DtzMAtL5
         SkE3INhFG6TxWpD/wq+10QPwBPa1+I7e5EREsp36H0criSNmbSCl9/F8pDwGKtMpa+Ex
         gevyq1flV7KNNwJOiqOoYda//bqvz0NoE35BiGkbxxX7VgQ/0aHAIE8RPlwRC46mn/DF
         myfSrK4QQDIUKkOA36DnXVClFoyWZLYgsbdwWn9WVZIQP4EVy3JiH7qWJ38FX+SSe5aH
         VGUbAIQDTHdM0InFkFu9d9JQ5CpklEAvUdo/9Q2mH2yqHz9zaU/kDS4X3Oka93oBESCa
         USEQ==
X-Gm-Message-State: AOAM532Fv3oarJkQ33w1BkMEz11dQwDCDu5XcaHkIbjrNWM3eyX+Rbcc
        0xCvsqFJrmtWwv6A8G5NE/dIK0HD0dWLNw==
X-Google-Smtp-Source: ABdhPJxOWNRkkHOk1ztVkXkVBsqeEefVY2KJIyHjR0fb9GR4Wa3sMvzQXJ6NtZsoF7wmbypbsTOzcg==
X-Received: by 2002:adf:d1c2:0:b0:205:7f2f:5043 with SMTP id b2-20020adfd1c2000000b002057f2f5043mr10171343wrd.238.1648228773837;
        Fri, 25 Mar 2022 10:19:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:33 -0700 (PDT)
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
Subject: [PATCH v3 03/27] string_list API users: use string_list_init_{no,}dup
Date:   Fri, 25 Mar 2022 18:18:27 +0100
Message-Id: <patch-v3-03.27-58b59542c2b-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
2.35.1.1509.ge4eeb5bd39e

