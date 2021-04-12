Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFD5C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7261C610CE
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbhDLVJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbhDLVIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACDDC061345
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y124-20020a1c32820000b029010c93864955so9455859wmy.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UTgS6fWlaPrB1tG5T4dMOidBrl95/NqnCBhlxrzN4js=;
        b=mLnJ9KO6o9Q/sSA2iK8D4fO4GBya9rJ6zqPseCkB81XwHUjNfKvJ4RgHSVyl1/Ceh3
         8n1uonMA3LjFu0P1oaSKbw9wIVUCXsccvdJ0ffiyV7nD/Zz3P37kwm+CQndfoNkysKKA
         h5Nd2BXTx8zAcCt6HE12+NkOU5uHcjFObX6s0jWdthTOcMYiW/GqKnLFXxeBZ77ur4bX
         szlC8K3kqDu3krqzxttqVldni7I/YJ0dcUZcQ46aeT9N8ldufySZYLHnZPNpJc+Qi00p
         FmjLaoYrziL+fewlttKocAK9fpGLQg67ErYCM3W6j8xOZdAuAv8tk6ug53DLGPmRL00W
         3Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UTgS6fWlaPrB1tG5T4dMOidBrl95/NqnCBhlxrzN4js=;
        b=OjjAGun0JWKItUZgqX1A1ifQo1mPooKmtMyuy1QRgizm3HtCFJMyn3/X+8Eh33Gwjn
         qmfyHoCFYQK+zz2cSveTM4l9HyV8vJbHSv0LH1JWawKQ/fPI/jMYF+gEkuYiUfZjuVLX
         Nev+W4PbU8rqb4KzcA6+XpyVdrfMcczeDHfz2sKr4CAb35Uy+EyL/V+ngjL8DI06ajVv
         GwVVhcTyVD0aanfe/zLoYPMH+n271DOMjI/WGZ+LC4BPz7lKuX/cS2VotsGzpjU2tc8D
         p00RuPfIcwQrRvRHUQQ2UTU1OyTbly+cufCzciqwO+JEHGPvP4EAPLg2LmO8bQkU9ZhP
         Uucg==
X-Gm-Message-State: AOAM533C1xH9lea7wMJPMnx3edv6rfcYidWDfT6ptz87uVzXauPBc7Ox
        YsEWX/vmCC5KLFTuPqS9dm+FnAU1H+4=
X-Google-Smtp-Source: ABdhPJzR3JPNqAxzIneBlUj1eNyN+qG3ZQVgVAfsOD0P3I7G2ZW752yF45ju+6ok9VYmh6+d6RL2jQ==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr867510wmg.37.1618261714802;
        Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm18191996wrv.80.2021.04.12.14.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
Message-Id: <335fec3676a0f66dc68582027970b0bad886bde7.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:16 +0000
Subject: [PATCH v3 25/26] sparse-index: expand_to_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
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
 sparse-index.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sparse-index.h | 13 +++++++++
 2 files changed, 86 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 95ea17174da3..6f21397e2ee0 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -283,3 +283,76 @@ void ensure_full_index(struct index_state *istate)
 
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
+			 * hashtable, because only sparse directory entries
+			 * have a trailing '/' character.  Since "path" wasn't
+			 * in the index, perhaps it exists within this
+			 * sparse-directory.  Expand accordingly.
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

