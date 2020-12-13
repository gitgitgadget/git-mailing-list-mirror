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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E3C4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B4B22D72
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 08:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbgLMIG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Dec 2020 03:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393498AbgLMIF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Dec 2020 03:05:59 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03606C061248
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:41 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id y23so12433367wmi.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 00:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GfaYyRxiX6gKvn9amEytdBpQnWUCwBNlm34sa3Sx/K0=;
        b=MOrZJX61IL3+511j37fie8NwzpBKj/0xb1uBlYrHc8Os6AQBF2GxMvdO5ouWXGS4Nv
         k13YPADBXgg5tF8MHElzS8V23sd513el3luYq/B4Zgq4nR3eho4IOyXPVyEnDjpoWKvL
         ZYHZUpFMYerBIDNQeJFedS4fIyuxMABJcj0MD3YG8xE5kI0I/X3ljADp2QIXdjuA5va+
         m9vVjriqITY85bNlxQSLap1SJjTCvloP3Do6XVogpbJ2JH/ec9oKLsuD+xuPntpOVya8
         yJvIYzsTua/0XoGiZgVAC55407nsnjNA4Y/VurBpNMIYJ83b9Eb8Xp4o8DAk/mb5lUp9
         2n9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GfaYyRxiX6gKvn9amEytdBpQnWUCwBNlm34sa3Sx/K0=;
        b=eZLkYFzc1npVTfVn8+HJ7BWy0RPf+7BB1vDOLspadm+YFlMrqBdYzEc3vt09LaaV6y
         84zNBvnwBp8jdI5Q7qlBUeNG1tyjt3p342GyEfD8+ot4KAAtPKNlUwqbZLcOHk7qMXfq
         bGtLratqS9Dr934J2OUd3t+sPArraXMNA8SQgZhkpLc3Nuk5SnaA+JG8aGHDnXvYgYsV
         Dtfite+hAjh7+/y0laexpgnNH7j13ZaccpvAcUqXUH2CaPvtHXjMuiu50QRxuhYQ2ujo
         Wtk6GSazUql2ZAJdKpEPkRNN4pRh3W/makeVJjy85UU9NMw4HR460F3mZL2TrG2ZPfs3
         dMbA==
X-Gm-Message-State: AOAM531jOK4PtBy1OVhZixpLcr5i2hWptmr7zHSC1gwNndOwcc57gkcZ
        /8Sx88zJyhcMUeyHX9ox9+IxWhoLv9o=
X-Google-Smtp-Source: ABdhPJxvOcF3VRrB8iUvFqHNyPx5ZTVtiIUk9MaHZyV2dKv5u9V4BsMgPgOocf6u/7rXfcdUs9N9hQ==
X-Received: by 2002:a1c:7318:: with SMTP id d24mr22265748wmb.39.1607846679542;
        Sun, 13 Dec 2020 00:04:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm24436861wrq.64.2020.12.13.00.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 00:04:39 -0800 (PST)
Message-Id: <260b12290fb4cbbf69e5114906b29c65f09dfdaa.1607846667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
References: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
        <pull.923.v3.git.git.1607846667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Dec 2020 08:04:19 +0000
Subject: [PATCH v3 12/20] merge-ort: have process_entries operate in a defined
 order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We want to handle paths below a directory before needing to handle the
directory itself.  Also, we want to handle the directory immediately
after the paths below it, so we can't use simple lexicographic ordering
from strcmp (which would insert foo.txt between foo and foo/file.c).
Copy string_list_df_name_compare() from merge-recursive.c, and set up a
string list of paths sorted by that function so that we can iterate in
the desired order.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d78b6b0873d..d83ed8768f5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -492,6 +492,33 @@ static int detect_and_process_renames(struct merge_options *opt,
 	return clean;
 }
 
+static int string_list_df_name_compare(const char *one, const char *two)
+{
+	int onelen = strlen(one);
+	int twolen = strlen(two);
+	/*
+	 * Here we only care that entries for D/F conflicts are
+	 * adjacent, in particular with the file of the D/F conflict
+	 * appearing before files below the corresponding directory.
+	 * The order of the rest of the list is irrelevant for us.
+	 *
+	 * To achieve this, we sort with df_name_compare and provide
+	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
+	 * We use the mode S_IFDIR for everything else for simplicity,
+	 * since in other cases any changes in their order due to
+	 * sorting cause no problems for us.
+	 */
+	int cmp = df_name_compare(one, onelen, S_IFDIR,
+				  two, twolen, S_IFDIR);
+	/*
+	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
+	 * that 'foo' comes before 'foo/bar'.
+	 */
+	if (cmp)
+		return cmp;
+	return onelen - twolen;
+}
+
 /* Per entry merge function */
 static void process_entry(struct merge_options *opt,
 			  const char *path,
@@ -578,24 +605,44 @@ static void process_entries(struct merge_options *opt,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
+	struct string_list plist = STRING_LIST_INIT_NODUP;
+	struct string_list_item *entry;
 
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
 		return;
 	}
 
+	/* Hack to pre-allocate plist to the desired size */
+	ALLOC_GROW(plist.items, strmap_get_size(&opt->priv->paths), plist.alloc);
+
+	/* Put every entry from paths into plist, then sort */
 	strmap_for_each_entry(&opt->priv->paths, &iter, e) {
+		string_list_append(&plist, e->key)->util = e->value;
+	}
+	plist.cmp = string_list_df_name_compare;
+	string_list_sort(&plist);
+
+	/*
+	 * Iterate over the items in reverse order, so we can handle paths
+	 * below a directory before needing to handle the directory itself.
+	 */
+	for (entry = &plist.items[plist.nr-1]; entry >= plist.items; --entry) {
+		char *path = entry->string;
 		/*
 		 * NOTE: mi may actually be a pointer to a conflict_info, but
 		 * we have to check mi->clean first to see if it's safe to
 		 * reassign to such a pointer type.
 		 */
-		struct merged_info *mi = e->value;
+		struct merged_info *mi = entry->util;
 
-		if (!mi->clean)
-			process_entry(opt, e->key, e->value);
+		if (!mi->clean) {
+			struct conflict_info *ci = (struct conflict_info *)mi;
+			process_entry(opt, path, ci);
+		}
 	}
 
+	string_list_clear(&plist, 0);
 	die("Tree creation not yet implemented");
 }
 
-- 
gitgitgadget

