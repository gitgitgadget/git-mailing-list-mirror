Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D4BC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiADRhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbiADRhK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:10 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FBC06179C
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t26so77637153wrb.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pTpoUXeXgrXUcRnuUUYzoXFaL7nXDUg6tUh+tbzPw3U=;
        b=nB72icQjt0nIO56pgEj3CARq51/lFfmowwYDug6evuoay2PAbkba5O00BjKGcG0nVq
         gGEqsXSR2XVxmfUeiIngkF3CRMeLHn5Y2B/rsqIC43cNqq0u3ahWrnM+MFJAe7yJSuL2
         XVXgFqftMnLtTl41OSSLkRxpfrKE/ItT5odMF9TsubUscJ2eu9M1cdu3ERi4o8FXnpYd
         chkXbsh7HtbrZGYlJd4yEyTX1exwYSv8s1K/YZa6b/cEniVX7SPfKg89qdESLv/JxQJN
         /5uCYEzWlnmybM6fsr3lKfhqfSdh0V4srkXtzTGovqvKCyDWSN8alBlRuh69p/YJrg/G
         6VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pTpoUXeXgrXUcRnuUUYzoXFaL7nXDUg6tUh+tbzPw3U=;
        b=ZxExBVj5sqcD23BkwNwo1JC+49YuL0dycBrjQeOulGaDtSvXQbfNgtRUn02PVDw/u2
         IcPdClLIG+DJaSvCAXfBSCiMqQ0pCU3RbVRMIsbfT+YSyZbQlDYAgxnaPND+DauKc5vL
         kkp6nPyGGryDDt5kv+H/ZA5IOp0ZxHTXavM/wcZ6qI6FRPeAHzwctxk6Lplb8Tu2Cbe+
         0zoCeQx1nAkF22k7vcu0kt/bOnTx/Y2lfPsNNVYPDB2Jiawqv9J9ErKRcVv8xdz2czT4
         ImlVUl9RWzZJmMP5tEb8HqAH6eANj0boQ+JVeH2OnZ/XETc4MJAQlEm902BkiC70KYWE
         saPQ==
X-Gm-Message-State: AOAM5305VSpba0sI1BZ/1rQ5gPLS2jWHLjJw6DP7RgqyHgBzL7P90qxJ
        1HmIWvLS8afCfAC15UAt/U6xLjaoXfE=
X-Google-Smtp-Source: ABdhPJxgLa8tXKviBgkfI36TXL5Z/hycxXdoWN8WozgCI60FWBhkfqGmtHtnFvUM6u1Vl8cwcojq7g==
X-Received: by 2002:adf:e788:: with SMTP id n8mr45083506wrm.685.1641317828124;
        Tue, 04 Jan 2022 09:37:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10sm24116wmq.16.2022.01.04.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:07 -0800 (PST)
Message-Id: <de7fc14356231a60c8cac9aa6f92a7fec1560b6a.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:37:00 +0000
Subject: [PATCH 9/9] update-index: reduce scope of index expansion in
 do_reupdate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Expand the full index (and redo reupdate operation) only if a sparse
directory in the index differs from HEAD. Only the index entries that differ
between the index and HEAD are updated when performing `git update-index
--again`, so unmodified sparse directories are safely skipped. The index
does need to be expanded when sparse directories contain changes, though,
because `update_one(...)` will not operate on sparse directory index
entries.

Because the index should only be expanded if a sparse directory is modified,
add a test ensuring the index is not expanded when differences only exist
within the sparse cone.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c                   | 14 +++++++++++---
 t/t1092-sparse-checkout-compatibility.sh |  5 ++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 605cc693bbd..52ecc714d99 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -606,7 +606,7 @@ static struct cache_entry *read_one_ent(const char *which,
 			error("%s: not in %s branch.", path, which);
 		return NULL;
 	}
-	if (mode == S_IFDIR) {
+	if (!the_index.sparse_index && mode == S_IFDIR) {
 		if (which)
 			error("%s: not a blob in %s branch.", path, which);
 		return NULL;
@@ -743,8 +743,6 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++) {
 		const struct cache_entry *ce = active_cache[pos];
 		struct cache_entry *old = NULL;
@@ -761,6 +759,16 @@ static int do_reupdate(int ac, const char **av,
 			discard_cache_entry(old);
 			continue; /* unchanged */
 		}
+
+		/* At this point, we know the contents of the sparse directory are
+		 * modified with respect to HEAD, so we expand the index and restart
+		 * to process each path individually
+		 */
+		if (S_ISSPARSEDIR(ce->ce_mode)) {
+			ensure_full_index(&the_index);
+			goto redo;
+		}
+
 		/* Be careful.  The working tree may not have the
 		 * path anymore, in which case, under 'allow_remove',
 		 * or worse yet 'allow_replace', active_nr may decrease.
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index bc0741c970d..0863c9747c4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1225,7 +1225,10 @@ test_expect_success 'sparse index is not expanded: update-index' '
 
 	ensure_not_expanded update-index --add README.md &&
 	ensure_not_expanded update-index a &&
-	ensure_not_expanded update-index --remove deep/a
+	ensure_not_expanded update-index --remove deep/a &&
+
+	ensure_not_expanded reset --soft update-deep &&
+	ensure_not_expanded update-index --add --remove --again
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget
