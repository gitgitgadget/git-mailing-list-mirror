Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45A5C56201
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 830C12087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DA+KpdV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgKKUCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgKKUCc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:32 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3887C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:31 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so3493842wmi.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=egrP2YxGIqUqE7lI0Iu1Sp/CnRg8F1CK39E/Ny45G70=;
        b=DA+KpdV5LrwJnygi82b18MnbwvjVJRSvZ6FmYS87mtjX422t/zTvoB3MgLlqBHMl1s
         90SFE/v7oQcUPlD7iQAOuF2nx8MpvLkZYHEeXxH5GbOrx6nyv3mxhTnaqOoOi0sAmTkG
         P5qsaPz5P8YurV6MODp+1HQJ+KohVDC2IRtDEr/2Q0C53ydqLBF8kKsjqtPM4ESaXikf
         vCJq/TOlvdw9oTiHkO3TYMHAjIIScIVQsX+6BrwREqkrpc2ivZtULe5c9wGTXbzsSV6j
         U0I3f1lYKhguHYNu5F5j+P9AYIfBnxjzi8F0PabEEMWeNeAm5hi6PPfsxkNUKuscvT9l
         dMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=egrP2YxGIqUqE7lI0Iu1Sp/CnRg8F1CK39E/Ny45G70=;
        b=AxcchNQ3ZCT5jfa5YnCriJaQ5XN2WbPTMGQlFpCN8kW9TLLlJO/Irmji8W5iS/CH3m
         VmE9mwuhH+JgnOPEv2L3YQNLG7Ko3XdKPN/VuwL4Wx6fpwv+xnOAZ3soLYTMYPrPfpVc
         rrLfHzMEcUP6vBW9CKG1Ag6NSHI4RDBkN4g3JKrqjfgNqQLV/Q5pvI5u9iKWSQwFCNDl
         /tiyGS1rRalyljhIqQWWeO33XAY5FkpQZKuWrIQtGePR1t1v2NYlb6aj+cd3NQjav6io
         cBAjFsJbLYFydxSpimIwpElW0YcG+2M0ebiEQGSzbUHTKF0S2Tyw3IS9K1qYOW4MH/y6
         pssQ==
X-Gm-Message-State: AOAM530Fm7G5hJpKmN2LMCjhzJ8/q9ExAQi4FZ06XnstgxIcxLaqt78t
        o8hS3um0Phzggl2deAIox0lEK3AhBWM=
X-Google-Smtp-Source: ABdhPJzUzq5qe0uF3foSS/Y6FSe9hRCMMMSvvUqzbt9Ql0Q15S/uJdD1Nkem3f5cCi/lnIN9wA5hoA==
X-Received: by 2002:a1c:2041:: with SMTP id g62mr1471651wmg.118.1605124950503;
        Wed, 11 Nov 2020 12:02:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w21sm3628672wmi.29.2020.11.11.12.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:30 -0800 (PST)
Message-Id: <fd96e9fc8df23851022edf3799012441cd4c8728.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:14 +0000
Subject: [PATCH v6 08/15] strmap: enable faster clearing and reusing of
 strmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When strmaps are used heavily, such as is done by my new merge-ort
algorithm, and strmaps need to be cleared but then re-used (because of
e.g. picking multiple commits to cherry-pick, or due to a recursive
merge having several different merges while recursing), free-ing and
reallocating map->table repeatedly can add up in time, especially since
it will likely be reallocated to a much smaller size but the previous
merge provides a good guide to the right size to use for the next merge.

Introduce strmap_partial_clear() to take advantage of this type of
situation; it will act similar to strmap_clear() except that
map->table's entries are zeroed instead of map->table being free'd.
Making use of this function reduced the cost of
clear_or_reinit_internal_opts() by about 20% in mert-ort, and dropped
the overall runtime of my rebase testcase by just under 2%.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 6 ++++++
 strmap.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/strmap.c b/strmap.c
index 829f1bc095..c410c5241a 100644
--- a/strmap.c
+++ b/strmap.c
@@ -64,6 +64,12 @@ void strmap_clear(struct strmap *map, int free_values)
 	hashmap_clear(&map->map);
 }
 
+void strmap_partial_clear(struct strmap *map, int free_values)
+{
+	strmap_free_entries_(map, free_values);
+	hashmap_partial_clear(&map->map);
+}
+
 void *strmap_put(struct strmap *map, const char *str, void *data)
 {
 	struct strmap_entry *entry = find_strmap_entry(map, str);
diff --git a/strmap.h b/strmap.h
index f74bc582e4..c14fcee148 100644
--- a/strmap.h
+++ b/strmap.h
@@ -42,6 +42,12 @@ void strmap_init_with_options(struct strmap *map,
  */
 void strmap_clear(struct strmap *map, int free_values);
 
+/*
+ * Similar to strmap_clear() but leaves map->map->table allocated and
+ * pre-sized so that subsequent uses won't need as many rehashings.
+ */
+void strmap_partial_clear(struct strmap *map, int free_values);
+
 /*
  * Insert "str" into the map, pointing to "data".
  *
-- 
gitgitgadget

