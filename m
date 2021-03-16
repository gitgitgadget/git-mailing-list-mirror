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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E588C43619
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19BDA64F9F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhCPVSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhCPVRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41431C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4483271wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qHSWMVUd/JaRV1PnjZne6/VJzK+dPwaEdwERLlOy/zI=;
        b=Q6VowZqHhyiNgBlX0LQi09FPw+u4KEgZFGLiXQN/xv8XPkNc9gAX1CMgu/awG1Jfcr
         +qDyyQaSn9NCC06LqZ9qOSl/F45LJ/dneoZOQMW1LnsXqbKIXMm2th5pimEptoXXCP4q
         xDFRV3qhYfRUcaXIZ4idva7qcm06MgmxMVKS84ctmr8d6mMH4QoTMmwUYOSdwmtJmICz
         NxUnQgquNCBuoywRcv4rjFlm7OvQDkkFZo0unbYOp9KZJa804KeT1O5jB+mawx/7vgBr
         7PDAmAjCRMJxfzF0T5RWsTxnPfJgiAErZ2K0Z5a58pbB9u/WkdvhPXmq+7bboWJOcC2h
         t0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qHSWMVUd/JaRV1PnjZne6/VJzK+dPwaEdwERLlOy/zI=;
        b=sBjJ1rZjciFIRPEPsU0zT3OorvmjWu9ik7P0giWBwHRo2JshP30cUyz09/XqmSh8fx
         1dqdAEa56RVKIsDQqke5XLcGJ+vQoeRmYXG7eieGUGkxwbWMU32yMBsGJ67DLWUeHdfN
         wYanxoqztjCNnySneNMA8Vc/AiaQOJ2B4lSZfvPAqVuC6qniMyFyTAKG8MCzKeH0YKkZ
         SX/ShU4J59BJ3Cl4zTLrWlYAjvhhafHurNvjfXmnxKW0RMXC5QR3tQC8zz846uZ9XRNk
         wFo0Sw3Cuqq3xzGQJ/aXZ41QI1zjgZM8nC4mxsxDDBPJn4EEuXnFTpfImpX+JatHKl0c
         Mh7A==
X-Gm-Message-State: AOAM531IGBsjAxapRGUBAPlaThrnr/qLYSBydcMBAsstnb6LOYL9j+Cw
        OYL79Mai4R6EVHWC5LDVhRLox48FJjQ=
X-Google-Smtp-Source: ABdhPJyXavbbU1TFzZr7CSB57aT99XDPuX+3jkxKEf5UYtUBujZSMKW/wOO4+WBDzo0zjKBRWN5PAQ==
X-Received: by 2002:a1c:3d46:: with SMTP id k67mr665690wma.188.1615929454058;
        Tue, 16 Mar 2021 14:17:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm24590199wrl.49.2021.03.16.14.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:33 -0700 (PDT)
Message-Id: <1690d33c11e0008c437eadfcef80de0dd870a86e.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:14 +0000
Subject: [PATCH 26/27] sparse-index: expand_to_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Some users of the index API have a specific path they are looking for,
but choose to use index_file_exists() to rely on the name-hash hashtable
instead of doing binary search with index_name_pos(). These users only
need to know a yes/no answer, not a position within the cache array.

When the index is sparse, the name-hash hash table does not contain the
full list of paths within sparse directories. It _does_ contain the
directory names for the sparse-directory entries.

Create a helper function, expand_to_path(), for intended use with the
name-hash hashtable functions. The integration with name-hash.c will
follow in a later change.

The solution here is to use ensure_full_index() when we determine that
the requested path is within a sparse directory entry. This will
populate the name-hash hashtable as the index is recomputed from
scratch.

There may be cases where the caller is trying to find an untracked path
that is not in the index but also is not within a sparse directory
entry. We want to minimize the overhead for these requests. If we used
index_name_pos() to find the insertion order of the path, then we could
determine from that position if a sparse-directory exists. (In fact,
just calling index_name_pos() in that case would lead to expanding the
index to a full index.) However, this takes O(log N) time where N is the
number of cache entries.

To keep the performance of this call based mostly on the input string,
use index_file_exists() to look for the ancestors of the path. Using the
heuristic that a sparse directory is likely to have a small number of
parent directories, we start from the bottom and build up. Use a string
buffer to allow mutating the path name to terminate after each slash for
each hashset test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sparse-index.h | 13 +++++++++
 2 files changed, 85 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 56313e805d9d..e5712d98d8b9 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -291,3 +291,75 @@ void ensure_full_index(struct index_state *istate)
 
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
+
+/*
+ * This static global helps avoid infinite recursion between
+ * expand_to_path() and index_file_exists().
+ */
+static int in_expand_to_path = 0;
+
+void expand_to_path(struct index_state *istate,
+		    const char *path, size_t pathlen, int icase)
+{
+	struct strbuf path_mutable = STRBUF_INIT;
+	size_t substr_len;
+
+	/* prevent extra recursion */
+	if (in_expand_to_path)
+		return;
+
+	if (!istate || !istate->sparse_index)
+		return;
+
+	if (!istate->repo)
+		istate->repo = the_repository;
+
+	in_expand_to_path = 1;
+
+	/*
+	 * We only need to actually expand a region if the
+	 * following are both true:
+	 *
+	 * 1. 'path' is not already in the index.
+	 * 2. Some parent directory of 'path' is a sparse directory.
+	 */
+
+	if (index_file_exists(istate, path, pathlen, icase))
+		goto cleanup;
+
+	strbuf_add(&path_mutable, path, pathlen);
+	strbuf_addch(&path_mutable, '/');
+
+	/* Check the name hash for all parent directories */
+	substr_len = 0;
+	while (substr_len < pathlen) {
+		char temp;
+		char *replace = strchr(path_mutable.buf + substr_len, '/');
+
+		if (!replace)
+			break;
+
+		/* replace the character _after_ the slash */
+		replace++;
+		temp = *replace;
+		*replace = '\0';
+		if (index_file_exists(istate, path_mutable.buf,
+				      path_mutable.len, icase)) {
+			/*
+			 * We found a parent directory in the name-hash
+			 * hashtable, which means that this entry could
+			 * exist within a sparse-directory entry. Expand
+			 * accordingly.
+			 */
+			ensure_full_index(istate);
+			break;
+		}
+
+		*replace = temp;
+		substr_len = replace - path_mutable.buf;
+	}
+
+cleanup:
+	strbuf_release(&path_mutable);
+	in_expand_to_path = 0;
+}
diff --git a/sparse-index.h b/sparse-index.h
index 0268f38753c0..1115a0d7dd98 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -4,6 +4,19 @@
 struct index_state;
 int convert_to_sparse(struct index_state *istate);
 
+/*
+ * Some places in the codebase expect to search for a specific path.
+ * This path might be outside of the sparse-checkout definition, in
+ * which case a sparse-index may not contain a path for that index.
+ *
+ * Given an index and a path, check to see if a leading directory for
+ * 'path' exists in the index as a sparse directory. In that case,
+ * expand that sparse directory to a full range of cache entries and
+ * populate the index accordingly.
+ */
+void expand_to_path(struct index_state *istate,
+		    const char *path, size_t pathlen, int icase);
+
 struct repository;
 int set_sparse_index_config(struct repository *repo, int enable);
 
-- 
gitgitgadget

