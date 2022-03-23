Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F2C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbiCWUeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbiCWUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F898BF33
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h126-20020a1c2184000000b0038ccb70e239so10558wmh.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RMu3JuArkkjhTneyTya4sDjQJFEjXBufFYHCDFcPhA8=;
        b=PHgrtyK+1w++UUs30iy2+7YphriLJUBEbfPo8W78jnebK0VZW6OXf4AjT6JcxS8+jP
         2EpRupfM8HZHPEY1SilHi55OEgcYS8Z7Z7LCPU/pL/bxGJgNZrb86jAJZ0HxHhyWtEcy
         8SjXCphct9CBCdLyutEeAgOfAgJgCvSouCgOUuxpLKl8vVhWoV4uWRkqnWMBDHal+2Xr
         reyYMII+cAHqYzZNYQ5+8QDKOm5XYjKiC109oarJhkHFhap0N8at21UI18Ly0LAt7t1b
         +OkNN+dMtjDmoAPiLiPMQVKfVBuAEsdShvt1pEcSRJKDkxa8XOzJltLy7uPR3FapOdgt
         4aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RMu3JuArkkjhTneyTya4sDjQJFEjXBufFYHCDFcPhA8=;
        b=Hm360UhRLpo6jTwsBptaHyihGyaauNhtLHKnIT8Z/W4WAx1im/FXCZaN1M9JCqiwOf
         9nvKnvLpiZ1OdH67Jud8CnZEqPhKsPJjRZgENtMkQbwy/R1Zfs+KDPZjBeg6v07CL3Ak
         ARr1ycffr07xoHaYltysND+y5o+7ijTu9Guo2BnkNeXvQK2gfttBTQk0SDhhZ3hWxshe
         WflNoaRX9QwXTQiQ5wjLusYzqW96NyhIaDJtiFKQJOqu+p9k+6mftP54M2lzrXCL+ZlD
         0N6QwLfVWD8BzG6IQIIZ93UcBW6owpnnr7h8s///xU52GZXyFI55Na5rbS8xcunjy6Ra
         aTPA==
X-Gm-Message-State: AOAM533vcW8sHPiqc2ZK5bwp7FLWLLScm+zZWALvgMkV6j/F/QAzX0Nd
        ruI2V4O6KURpJN/hmYTzKpbOUvlGbuQQjQ==
X-Google-Smtp-Source: ABdhPJzraJwAJZm42aXZP0/xpIkjXX9qrqyHHirbM+pXRAHSPCB0ePH+2EiWOFqh104YNV7bff6loQ==
X-Received: by 2002:a05:600c:4611:b0:389:9f47:30cd with SMTP id m17-20020a05600c461100b003899f4730cdmr1635724wmo.185.1648067549339;
        Wed, 23 Mar 2022 13:32:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:28 -0700 (PDT)
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
Subject: [PATCH v2 03/27] string_list API users: use string_list_init_{no,}dup
Date:   Wed, 23 Mar 2022 21:31:53 +0100
Message-Id: <patch-v2-03.27-151d1175905-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
2.35.1.1452.ga7cfc89151f

