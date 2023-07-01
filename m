Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D5C0015E
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 06:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjGAGzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 02:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGAGzH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 02:55:07 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9914B44A6
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:48:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ff24a193dbso20962581cf.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688194138; x=1690786138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXiHIdG93bLAj5qmq4MzcvVzvjH/AdCV1o8ttPL6ntg=;
        b=BCI/prcnAMlwVeBPbAnWygSO2QTOA+CWEGO/9EY2KeLW3fcGFQ3af/PdnuwjS+5tRX
         UVsqejws3AFJtXwbxt6zwLsLef+KA0peyoe96Kj3ptTZV4T1nZEstR+oF32eGyeWmMkL
         JQGAIimztQUQCD9nue5OHePGZmgVz+13sXMhA5eapGxQoH7aPB1pQf8/2KUNCUjJCFPq
         wIqYwgxBcilBuSx265dC+5A2BRpwyHzBs/o0EUxfkZbjDE2BNzCXDXtYXsQ7uCT6NgpF
         34yY63pp2FMULHPqQvNZJQH+HlbF+/4GrTsLBzv9RCCnxBylEnZEyR/pz+oLuuCrT83u
         0Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688194138; x=1690786138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXiHIdG93bLAj5qmq4MzcvVzvjH/AdCV1o8ttPL6ntg=;
        b=HD3j8zsYicyy7vFmOEPMlsljeWHlHsLFCl5dxb9gftboaig/ufnu9aGfFs1QNgWMkk
         k3zPYOi0poizHj73iPtGgzZt8ObXjgXw6TxkNorRvVYLSa8kbScE1kdFJ8L0F/WfeVbE
         kNx+ruRYCBruw1a0Nobt6W6yyRMhudBLZdJFwwK5f56g+enMEJz/Ty+lDnf45Lul40E/
         Mnl6AVQIbuk6yIjqynoF6EmIwFau7EnJwKroQ2guLcH8t35S8DYM3tAQ1T35MCyyrJRK
         2L70SHwv/WK+ya3l4g5qLhh7YjmwdNvIkgesEQ42lMl12cr9+qorVDg0zxg7nfh5MUKj
         +tbA==
X-Gm-Message-State: AC+VfDxSYuyM6Igc239zTM6YwODuu/0kNrdBJxSLOU/u13xg+Ogd3Tsq
        Lf9r9Z7tV+wP6d/CkvkBpGZNjtNc4cex5w==
X-Google-Smtp-Source: ACHHUZ62J8XUqGWrgeDczR+fGoaowQXefXdjrPqcYsLkFTM3aQzgpNs606tT46//avZr5noequW9Kw==
X-Received: by 2002:ac8:5fc7:0:b0:3ec:47d5:ec65 with SMTP id k7-20020ac85fc7000000b003ec47d5ec65mr6236020qta.60.1688194138381;
        Fri, 30 Jun 2023 23:48:58 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-18-69-158-189-182.dsl.bell.ca. [69.158.189.182])
        by smtp.googlemail.com with ESMTPSA id a26-20020ac8435a000000b003e69c51cf53sm2269720qtn.72.2023.06.30.23.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 23:48:58 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v1 1/3] attr.c: read attributes in a sparse directory
Date:   Sat,  1 Jul 2023 02:48:41 -0400
Message-Id: <20230701064843.147496-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230701064843.147496-1-cheskaqiqi@gmail.com>
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch,`git check-attr` can't find the attributes of a file
within a sparse directory. In order to read attributes from
'.gitattributes' files that may be in a sparse directory:

When path is in cone mode of sparse checkout:

1.If path is a sparse directory, read the tree OIDs from the sparse
directory.

2.If path is a regular files, read the attributes directly from the blob
data stored in the cache.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 attr.c | 64 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/attr.c b/attr.c
index 7d39ac4a29..b0d26da102 100644
--- a/attr.c
+++ b/attr.c
@@ -808,35 +808,57 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 static struct attr_stack *read_attr_from_index(struct index_state *istate,
 					       const char *path, unsigned flags)
 {
+	struct attr_stack *stack = NULL;
+	int i;
+	struct strbuf path1 = STRBUF_INIT;
+	struct strbuf path2 = STRBUF_INIT;
+	char *first_slash = NULL;
 	char *buf;
 	unsigned long size;
 
 	if (!istate)
 		return NULL;
 
-	/*
-	 * The .gitattributes file only applies to files within its
-	 * parent directory. In the case of cone-mode sparse-checkout,
-	 * the .gitattributes file is sparse if and only if all paths
-	 * within that directory are also sparse. Thus, don't load the
-	 * .gitattributes file since it will not matter.
-	 *
-	 * In the case of a sparse index, it is critical that we don't go
-	 * looking for a .gitattributes file, as doing so would cause the
-	 * index to expand.
-	 */
-	if (!path_in_cone_mode_sparse_checkout(path, istate))
-		return NULL;
-
-	buf = read_blob_data_from_index(istate, path, &size);
-	if (!buf)
-		return NULL;
-	if (size >= ATTR_MAX_FILE_SIZE) {
-		warning(_("ignoring overly large gitattributes blob '%s'"), path);
-		return NULL;
+	first_slash = strchr(path, '/');
+	if (first_slash) {
+		strbuf_add(&path1, path, first_slash - path + 1);
+		strbuf_addstr(&path2, first_slash + 1);
 	}
 
-	return read_attr_from_buf(buf, path, flags);
+	if(!path_in_cone_mode_sparse_checkout(path, istate)){
+		for (i = 0; i < istate->cache_nr; i++) {
+			struct cache_entry *ce = istate->cache[i];
+			if ( !strcmp(istate->cache[i]->name, path1.buf)&&S_ISSPARSEDIR(ce->ce_mode)) {
+				stack = read_attr_from_blob(istate, &ce->oid, path2.buf, flags);
+			}else if(S_ISREG(ce->ce_mode) && !strcmp(istate->cache[i]->name, path)){
+				unsigned long sz;
+				enum object_type type;
+				void *data;
+
+				data = repo_read_object_file(the_repository, &istate->cache[i]->oid,
+							&type, &sz);
+				if (!data || type != OBJ_BLOB) {
+					free(data);
+					strbuf_release(&path1);
+					strbuf_release(&path2);
+					return NULL;
+				}
+				stack = read_attr_from_buf(data, path, flags);
+			}
+		}
+	}else{
+		buf = read_blob_data_from_index(istate, path, &size);
+		if (!buf)
+			return NULL;
+		if (size >= ATTR_MAX_FILE_SIZE) {
+			warning(_("ignoring overly large gitattributes blob '%s'"), path);
+			return NULL;
+		}
+		 stack = read_attr_from_buf(buf, path, flags);
+	}
+	strbuf_release(&path1);
+	strbuf_release(&path2);
+	return stack;
 }
 
 static struct attr_stack *read_attr(struct index_state *istate,
-- 
2.39.0

