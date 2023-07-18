Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E104C001DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 23:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGRX35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 19:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGRX3x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 19:29:53 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC8EC
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:49 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-635f48814b4so28787746d6.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689722988; x=1692314988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bVAFlJh63sQ2n4HOPskk9lCAcA0GcMBKqVbWT3bQ54=;
        b=ifDVKpBnzi4WtEZ1+I4Ku/5ayWsPbaXWpBs1o5xbdemfqFC3iu7/Xr99YU3LrgWpgX
         opQ8a8/Iz62nmA2FpU/j9nfZEWuvp8VEG4CyXC9Gw3DDtYvmZc8iJjiVIbTTjM9SvCmn
         sxwy5KLB94b95SMWyjC/lVgX3k1c/efl7Q3a8fUa6oHxvJ+NTZMY/zLC1TOj/BP722xz
         U21auLJ6wJoF05nBtEVQOZWjJDrkZ2+5a54KMQAUfONLIQKtXP1ix1MCSVIsdPCpF4Uk
         rYUH5ULUe5HVwRy6ltU+DNcDvbOJyVjgzB/o/vGrW9cwkiq5PQMlepHyNODePmGktGIQ
         jXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722988; x=1692314988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bVAFlJh63sQ2n4HOPskk9lCAcA0GcMBKqVbWT3bQ54=;
        b=M1hBFamWRygX4YW3t2iAeW2NXYrRBVaa8TSwjZWbaYl1a1AynRoNLXcSQJsif73nUt
         QEPDERqm5LxS8IOR3MhwYXIcWaVPDuKfyzPRU1iKRCy/cj527iBz7JO9GbvOEbvCA3H8
         sK/2g0bmU9WSmlV7oryffqPhH0gbcG+pLi45Sz7L3Y8Y3/106lfXLVAnTysQK6JDz9qV
         rQvoJXH4+TUfyPZKbNMIvmqvv4Iys2G9IFSGDuY3VWko5oH1Bz3mAU9uOb2+aawRCn94
         sVPwe47PNWUIKn3j3GFaT1Fqh0I61nv2RNMtP67ZWbUa0jIGlJomx9+fPAQWvRJv69YJ
         4GFA==
X-Gm-Message-State: ABy/qLYfAlEJspdEhDmYGUJQs2HHN+C1tSCg7ofFi2b8B4/BCt7PjvbD
        N/chc7gzu7CnJRMlr5ubEn0zFdIxd/Axaw==
X-Google-Smtp-Source: APBJJlGRZ1eXQWAccOGISEEB93RjC09VNPqpqlpSYmu5I/vrdrofjQ81x+A64Nn740Foxh62oAN7Yg==
X-Received: by 2002:a0c:cd0f:0:b0:632:5fb:5642 with SMTP id b15-20020a0ccd0f000000b0063205fb5642mr13283730qvm.12.1689722987847;
        Tue, 18 Jul 2023 16:29:47 -0700 (PDT)
Received: from localhost.localdomain ([69.158.190.118])
        by smtp.googlemail.com with ESMTPSA id h18-20020a0cf212000000b0063640486254sm1057695qvk.116.2023.07.18.16.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 16:29:47 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v4 2/3] attr.c: read attributes in a sparse directory
Date:   Tue, 18 Jul 2023 19:29:15 -0400
Message-Id: <20230718232916.31660-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230718232916.31660-1-cheskaqiqi@gmail.com>
References: <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230718232916.31660-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, git check-attr was unable to read the attributes from
a .gitattributes file within a sparse directory. The original comment
was operating under the assumption that users are only interested in
files or directories inside the cones. Therefore, in the original code,
in the case of a cone-mode sparse-checkout, we didn't load the
.gitattributes file.

However, this behavior can lead to missing attributes for files inside
sparse directories, causing inconsistencies in file handling.

To resolve this, revise 'git check-attr' to allow attribute reading for
files in sparse directories from the corresponding .gitattributes files:

1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
to check if a path falls within a sparse directory.

2.If path is inside a sparse directory, employ the value of
index_name_pos_sparse() to find the sparse directory containing path and
path relative to sparse directory. Proceed to read attributes from the
tree OID of the sparse directory using read_attr_from_blob().

3.If path is not inside a sparse directory，ensure that attributes are
fetched from the index blob with read_blob_data_from_index().

Modify previous tests so such difference is not considered as an error.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 attr.c                                   | 60 +++++++++++++++++-------
 t/t1092-sparse-checkout-compatibility.sh |  4 +-
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/attr.c b/attr.c
index 7d39ac4a29..7650f5481a 100644
--- a/attr.c
+++ b/attr.c
@@ -808,35 +808,59 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 static struct attr_stack *read_attr_from_index(struct index_state *istate,
 					       const char *path, unsigned flags)
 {
+	struct attr_stack *stack = NULL;
 	char *buf;
 	unsigned long size;
+	int pos = -1;
+	char normalize_path[PATH_MAX];
+	const char *relative_path;
 
 	if (!istate)
 		return NULL;
 
 	/*
-	 * The .gitattributes file only applies to files within its
-	 * parent directory. In the case of cone-mode sparse-checkout,
-	 * the .gitattributes file is sparse if and only if all paths
-	 * within that directory are also sparse. Thus, don't load the
-	 * .gitattributes file since it will not matter.
-	 *
-	 * In the case of a sparse index, it is critical that we don't go
-	 * looking for a .gitattributes file, as doing so would cause the
-	 * index to expand.
+	 * When handling sparse-checkouts, .gitattributes files
+	 * may reside within a sparse directory. We distinguish
+	 * whether a path exists directly in the index or not by
+	 * evaluating if 'pos' is negative.
+	 * If 'pos' is negative, the path is not directly present
+	 * in the index and is likely within a sparse directory.
+	 * For paths not in the index, The absolute value of 'pos'
+	 * minus 1 gives us the position where the path would be
+	 * inserted in lexicographic order within the index.
+	 * We then subtract another 1 from this value
+	 * (pos = -pos - 2) to find the position of the last
+	 * index entry which is lexicographically smaller than
+	 * the path. This would be the sparse directory containing
+	 * the path. By identifying the sparse directory containing
+	 * the path, we can correctly read the attributes specified
+	 * in the .gitattributes file from the tree object of the
+	 * sparse directory.
 	 */
-	if (!path_in_cone_mode_sparse_checkout(path, istate))
-		return NULL;
+	if (!path_in_cone_mode_sparse_checkout(path, istate)) {
+		pos = index_name_pos_sparse(istate, path, strlen(path));
 
-	buf = read_blob_data_from_index(istate, path, &size);
-	if (!buf)
-		return NULL;
-	if (size >= ATTR_MAX_FILE_SIZE) {
-		warning(_("ignoring overly large gitattributes blob '%s'"), path);
-		return NULL;
+		if (pos < 0)
+			pos = -pos - 2;
 	}
 
-	return read_attr_from_buf(buf, path, flags);
+	if (pos >= 0 && !path_in_cone_mode_sparse_checkout(path, istate) &&
+	    S_ISSPARSEDIR(istate->cache[pos]->ce_mode) &&
+	    !strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) &&
+	    !normalize_path_copy(normalize_path, path)) {
+		relative_path = normalize_path + ce_namelen(istate->cache[pos]);
+		stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
+	} else {
+		buf = read_blob_data_from_index(istate, path, &size);
+		if (!buf)
+			return NULL;
+		if (size >= ATTR_MAX_FILE_SIZE) {
+			warning(_("ignoring overly large gitattributes blob '%s'"), path);
+			return NULL;
+		}
+		stack = read_attr_from_buf(buf, path, flags);
+	}
+	return stack;
 }
 
 static struct attr_stack *read_attr(struct index_state *istate,
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 90633f383a..3f32c1f972 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2271,7 +2271,7 @@ test_expect_success 'check-attr with pathspec inside sparse definition' '
 	test_all_match git check-attr -a --cached -- deep/a
 '
 
-test_expect_failure 'check-attr with pathspec outside sparse definition' '
+test_expect_success 'check-attr with pathspec outside sparse definition' '
 	init_repos &&
 
 	echo "a -crlf myAttr" >>.gitattributes &&
@@ -2288,7 +2288,7 @@ test_expect_failure 'check-attr with pathspec outside sparse definition' '
 	test_all_match git check-attr  -a --cached -- folder1/a
 '
 
-test_expect_failure 'diff --check with pathspec outside sparse definition' '
+test_expect_success 'diff --check with pathspec outside sparse definition' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
-- 
2.39.0

