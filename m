Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351AC64E8A
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709D92078D
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdGtVxHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgK2Hp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgK2Hp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:45:29 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565CEC08E85E
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:43 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r3so10836643wrt.2
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AV1blWkOnP2sBdEEc8SPkC3V7YMmQlaBdGixWNjkfn0=;
        b=VdGtVxHPoMHGPJ7hpqjNqplv74ZNKIB+cQ4kghSNYgbvK1gTaIONJl2YwZe3Jl9tmB
         B1Pa39oAgBn0TZ0N3ELoA6qQzFO9MBdwbwjqitMvPQR+octbgJxhVxFlU0OjP3fjuvAm
         uwNLhzKKy6M1B7FoF+Gg5UXOqmkZizKg+VDk0nnf5BHfNB6xUx9twCg8go5BUKIx/oIO
         5IlZO6ZOszRm3vmGTDOGMEK87dpvonucoKvn7FOr8KvGXoHZTENrLgPYFE68Vpg1dLi+
         rWJeh2+LJAGQyG5/uh1mPsTFAK7zRMNCAF2tRryTkzBa7Gl9RAo8x+HuTr4SQlAdrX56
         KiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AV1blWkOnP2sBdEEc8SPkC3V7YMmQlaBdGixWNjkfn0=;
        b=GnLYT/e/dCPnR+6kRg/s3xfkdnLh57CjyPMWHO8ea0JVy5eoEpWLVUfiEZc1AvYAyS
         SrbdBUyQzMIxCydXJqzruA63ZilwId6VOhPn4lzTlXRrtdvF6Gq2pAwpY11SS1NxHrkD
         xvHejdBFUYdCHxMK814ajeWa4PMq4m2qOfHGJpnKgGPEL6PHYbIDH20x6buqNwogn9ZQ
         K7o/V/0SHZhLc//sUs9D2qramyMfPliYCk6Om9BmI5Fs8bMtQkQCTDosRfhsUmmC/dCf
         NNJeDciA598jwXV91BpxWarKfbbKt4twklt6l9tcJ3I02KP3m/JR3TZ5LTeWU0rHCZNm
         WzAw==
X-Gm-Message-State: AOAM533P2ZwO9QrkwGTr1WVdA9q8attIGoIfgxUOOreuhir/4GZgeyIq
        gzrqdFKARvGF6xQb7UWVf+xa+4C+PKY=
X-Google-Smtp-Source: ABdhPJy58119qSBdns52fUPhJawen3P4Q5S1fE5Vd67irngajfcN/QcPofCSTAwYVL7Ugv4clluvFg==
X-Received: by 2002:adf:dd81:: with SMTP id x1mr21340434wrl.163.1606635821943;
        Sat, 28 Nov 2020 23:43:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm24236977wrw.17.2020.11.28.23.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:41 -0800 (PST)
Message-Id: <a4f722a46e127f1f136da4d4f65944e6790890fd.1606635803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:23 +0000
Subject: [PATCH 20/20] merge-ort: free data structures in merge_finalize()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index d1b98e2fca..ea6a9d7348 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -182,6 +182,16 @@ struct conflict_info {
 	assert((ci) && !(mi)->clean);        \
 } while (0)
 
+static void free_strmap_strings(struct strmap *map)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strmap_for_each_entry(map, &iter, entry) {
+		free((char*)entry->key);
+	}
+}
+
 static int err(struct merge_options *opt, const char *err, ...)
 {
 	va_list params;
@@ -1116,7 +1126,27 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result)
 {
-	die("Not yet implemented");
+	struct merge_options_internal *opti = result->priv;
+
+	assert(opt->priv == NULL);
+
+	/*
+	 * We marked opti->paths with strdup_strings = 0, so that we
+	 * wouldn't have to make another copy of the fullpath created by
+	 * make_traverse_path from setup_path_info().  But, now that we've
+	 * used it and have no other references to these strings, it is time
+	 * to deallocate them.
+	 */
+	free_strmap_strings(&opti->paths);
+	strmap_clear(&opti->paths, 1);
+
+	/*
+	 * All keys and values in opti->conflicted are a subset of those in
+	 * opti->paths.  We don't want to deallocate anything twice, so we
+	 * don't free the keys and we pass 0 for free_values.
+	 */
+	strmap_clear(&opti->conflicted, 0);
+	FREE_AND_NULL(opti);
 }
 
 static void merge_start(struct merge_options *opt, struct merge_result *result)
-- 
gitgitgadget
