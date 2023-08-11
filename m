Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63AC001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 14:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjHKOWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjHKOWn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 10:22:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC1110E4
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdc243d62bso2366285ad.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691763762; x=1692368562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/E4xOMKnxH54uJ9/08ofhrhHJhnQX/nXyx1sIDo+kA=;
        b=j/F+qn+QpeJJ4AjDKgTmDt29nc0zpPil5XlYHdU4+XCfTZD1eMD/HPvvXL+w/jSNAM
         rIOQPimWMpO3q6V+owAIYLkFWiAWphaT31RcEQWpESXVqxtYhaPBBCxAD0aBM/l8oRRd
         TZKWxedHGu+8lrrfyhuBOQdzIo3UZ3+4PDeFl43N6Eiedcntw2eQAyuFpNLsRWP7Dgtm
         4x9/Ccx+uhu9wZW4eGgdP7VLLTi0ycc992SmEzgKYapeIVtes8RARg3vyGeUjUcVwuVf
         mxhl+ak2XNIo3+YfNk01v4cjVb+Tj33K3Yw4ZM1rOs0wB4VHNpz+DnxuIOQt7aoCHKek
         zhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763762; x=1692368562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/E4xOMKnxH54uJ9/08ofhrhHJhnQX/nXyx1sIDo+kA=;
        b=RtTGIvNKj2Tm7H3cHG0KF/Znyvyz34HZBFF/MpviAs9p6OzCaFoqqMoOrqzFDZBDAR
         prFI/pbnAXXSrT7RprRsllqxGrur4XRO/I78YyOUO3S8xpna6hVd5O9XdomfNum2N+zw
         olavT1a+J9XMmtH7iBb9Th/1Rju3Eh1UOOOgUuQEAqOnht+EaaLGI4t24J6am7eRVfmY
         QLkCMZJ62hGoZFphWMnTjq4fmHpkxjFF8nbSw2wHJR7IJzW+B8EAoSYJBH5ZpcEwUSx1
         Z8aWqN+3hTyd8zUM688e+NvFiiALYTQPAVxRDWEF9cjwxIThFNfYAJhI2gA35inFLIC5
         kWoA==
X-Gm-Message-State: AOJu0Yz2P4k2NFLZUKZY7mLQ8+N4ogIsB52itpr76tpPr7fp+AOkgSEZ
        jyG+iKzUuADmY8WrgwImtXPtaTR75usG2w==
X-Google-Smtp-Source: AGHT+IE9XkrzjiDR7Nz/sgKAUX/LkMOtJW8FlWXGO0HfY1mmsIdDldh8P76nMO8D1LsehyXQ3lMBbA==
X-Received: by 2002:a17:90a:4e47:b0:268:3b8b:140d with SMTP id t7-20020a17090a4e4700b002683b8b140dmr1164199pjl.35.1691763761476;
        Fri, 11 Aug 2023 07:22:41 -0700 (PDT)
Received: from cheska.. ([120.231.214.68])
        by smtp.googlemail.com with ESMTPSA id p2-20020a17090a284200b00264044cca0fsm10000329pjf.1.2023.08.11.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:22:41 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v5 0/3] check-attr: integrate with sparse-index
Date:   Fri, 11 Aug 2023 10:22:08 -0400
Message-Id: <20230811142211.4547-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230718232916.31660-1-cheskaqiqi@gmail.com>
References: <20230718232916.31660-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

change against v4:

1/3:
* Add a commit message to explain why 'test_expect_failure' is set
and why 'test_expect_success' is set.

* Update 'diff --check with pathspec outside sparse definition' to
compare "index vs HEAD" rather than "working tree vs index".

* Use 'test_all_match' to apply the config to the test repos instead of
the parent .

* Use 'test_(all|sparse)_match' when running Git commands in
these tests.

2/3:
* Create a variable named 'sparse_dir_pos' to make the purpose of
variable clearer.

* Remove the redundant check of '!path_in_cone_mode_sparse_checkout()'
since 'pos' will always be '-1' if 'path_in_cone_mode_sparse_checkout()'
is true.

* Remove normalize path check because 'prefix_path'(builtin/check-attr.c)
call to 'normalize_path_copy_len' (path.c:1124). This confirms that the
path has indeed been normalized.

* Leave the 'diff --check' test as 'test_expect_failure' with a note about
the bug in 'diff' to fix later.


Shuqi Liang (3):
  t1092: add tests for 'git check-attr'
  attr.c: read attributes in a sparse directory
  check-attr: integrate with sparse-index

 attr.c                                   | 57 +++++++++++++------
 builtin/check-attr.c                     |  3 +
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 72 ++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 18 deletions(-)

Range-diff against v4:
1:  9c43eea9cc ! 1:  78d0fc0df1 t1092: add tests for 'git check-attr'
    @@ Commit message
     
         Add a test named 'diff --check with pathspec outside sparse definition'.
         It starts by disabling the trailing whitespace and space-before-tab
    -    checks using the core.whitespace configuration option. Then, it
    +    checks using the core. whitespace configuration option. Then, it
         specifically re-enables the trailing whitespace check for a file located
    -    in a sparse directory. This is accomplished by adding a
    -    whitespace=trailing-space rule to the .gitattributes file within that
    -    directory. To ensure that only the .gitattributes file in the index is
    -    being read, and not any .gitattributes files in the working tree, the
    -    test removes the .gitattributes file from the working tree after adding
    -    it to the index. The final part of the test uses 'git diff --check' to
    -    verify the correct application of the attribute rules. This ensures that
    -    the .gitattributes file is correctly read from index and applied, even
    -    when the file's path falls outside of the sparse-checkout definition.
    +    in a sparse directory by adding a whitespace=trailing-space rule to the
    +    .gitattributes file within that directory. Next, create and populate the
    +    folder1 directory, and then add the .gitattributes file to the index.
    +    Edit the contents of folder1/a, add it to the index, and proceed to
    +    "re-sparsify" 'folder1/' with 'git sparse-checkout reapply'. Finally,
    +    use 'git diff --check --cached' to compare the 'index vs. HEAD',
    +    ensuring the correct application of the attribute rules even when the
    +    file's path is outside the sparse-checkout definition.
    +
    +    Mark the two tests 'check-attr with pathspec outside sparse definition'
    +    and 'diff --check with pathspec outside sparse definition' as
    +    'test_expect_failure' to reflect an existing issue where the attributes
    +    inside a sparse directory are ignored. Ensure that the 'check-attr'
    +    command fails to read the required attributes to demonstrate this
    +    expected failure.
     
         Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'worktree is not e
     +	test_all_match git check-attr -a -- folder1/a &&
     +
     +	git -C full-checkout add folder1/.gitattributes &&
    -+	run_on_sparse git add --sparse folder1/.gitattributes &&
    -+	run_on_all git commit -m "add .gitattributes" &&
    ++	test_sparse_match git add --sparse folder1/.gitattributes &&
    ++	test_all_match git commit -m "add .gitattributes" &&
     +	test_sparse_match git sparse-checkout reapply &&
    -+	test_all_match git check-attr  -a --cached -- folder1/a
    ++	test_all_match git check-attr -a --cached -- folder1/a
     +'
     +
     +test_expect_failure 'diff --check with pathspec outside sparse definition' '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'worktree is not e
     +	echo "a " >"$1"
     +	EOF
     +
    -+	git config core.whitespace -trailing-space,-space-before-tab &&
    ++	test_all_match git config core.whitespace -trailing-space,-space-before-tab &&
     +
     +	echo "a whitespace=trailing-space,space-before-tab" >>.gitattributes &&
     +	run_on_all mkdir -p folder1 &&
     +	run_on_all cp ../.gitattributes ./folder1 &&
    -+	git -C full-checkout add folder1/.gitattributes &&
    -+	run_on_sparse git add --sparse folder1/.gitattributes &&
    -+	run_on_all rm folder1/.gitattributes &&
    -+	run_on_all  ../edit-contents folder1/a &&
    -+	test_all_match test_must_fail git diff --check -- folder1/a
    ++	test_all_match git add --sparse folder1/.gitattributes &&
    ++	run_on_all ../edit-contents folder1/a &&
    ++	test_all_match git add --sparse folder1/a &&
    ++
    ++	test_sparse_match git sparse-checkout reapply &&
    ++	test_all_match test_must_fail git diff --check --cached -- folder1/a
     +'
     +
      test_done
2:  63ff110b1c ! 2:  ef866930c6 attr.c: read attributes in a sparse directory
    @@ Commit message
         3.If path is not inside a sparse directory，ensure that attributes are
         fetched from the index blob with read_blob_data_from_index().
     
    -    Modify previous tests so such difference is not considered as an error.
    +    Change the test 'check-attr with pathspec outside sparse definition' to
    +    'test_expect_success' to reflect that the attributes inside a sparse
    +    directory can now be read. Ensure that the sparse index case works
    +    correctly for git check-attr to illustrate the successful handling of
    +    attributes within sparse directories.
     
         Helped-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
     +	struct attr_stack *stack = NULL;
      	char *buf;
      	unsigned long size;
    -+	int pos = -1;
    -+	char normalize_path[PATH_MAX];
    -+	const char *relative_path;
    ++	int sparse_dir_pos = -1;
      
      	if (!istate)
      		return NULL;
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
     +	 * minus 1 gives us the position where the path would be
     +	 * inserted in lexicographic order within the index.
     +	 * We then subtract another 1 from this value
    -+	 * (pos = -pos - 2) to find the position of the last
    -+	 * index entry which is lexicographically smaller than
    ++	 * (sparse_dir_pos = -pos - 2) to find the position of the
    ++	 * last index entry which is lexicographically smaller than
     +	 * the path. This would be the sparse directory containing
     +	 * the path. By identifying the sparse directory containing
     +	 * the path, we can correctly read the attributes specified
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
     -	if (!path_in_cone_mode_sparse_checkout(path, istate))
     -		return NULL;
     +	if (!path_in_cone_mode_sparse_checkout(path, istate)) {
    -+		pos = index_name_pos_sparse(istate, path, strlen(path));
    ++		int pos = index_name_pos_sparse(istate, path, strlen(path));
      
     -	buf = read_blob_data_from_index(istate, path, &size);
     -	if (!buf)
    @@ attr.c: static struct attr_stack *read_attr_from_blob(struct index_state *istate
     -		warning(_("ignoring overly large gitattributes blob '%s'"), path);
     -		return NULL;
     +		if (pos < 0)
    -+			pos = -pos - 2;
    ++			sparse_dir_pos = -pos - 2;
      	}
      
     -	return read_attr_from_buf(buf, path, flags);
    -+	if (pos >= 0 && !path_in_cone_mode_sparse_checkout(path, istate) &&
    -+	    S_ISSPARSEDIR(istate->cache[pos]->ce_mode) &&
    -+	    !strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) &&
    -+	    !normalize_path_copy(normalize_path, path)) {
    -+		relative_path = normalize_path + ce_namelen(istate->cache[pos]);
    -+		stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
    ++	if (sparse_dir_pos >= 0 &&
    ++	    S_ISSPARSEDIR(istate->cache[sparse_dir_pos]->ce_mode) &&
    ++	    !strncmp(istate->cache[sparse_dir_pos]->name, path, ce_namelen(istate->cache[sparse_dir_pos]))) {
    ++		const char *relative_path = path + ce_namelen(istate->cache[sparse_dir_pos]);
    ++		stack = read_attr_from_blob(istate, &istate->cache[sparse_dir_pos]->oid, relative_path, flags);
     +	} else {
     +		buf = read_blob_data_from_index(istate, path, &size);
     +		if (!buf)
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'check-attr with p
      
      	echo "a -crlf myAttr" >>.gitattributes &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'check-attr with pathspec outside sparse definition' '
    - 	test_all_match git check-attr  -a --cached -- folder1/a
    + 	test_all_match git check-attr -a --cached -- folder1/a
      '
      
    --test_expect_failure 'diff --check with pathspec outside sparse definition' '
    -+test_expect_success 'diff --check with pathspec outside sparse definition' '
    ++# NEEDSWORK: The 'diff --check' test is left as 'test_expect_failure' due
    ++# to an underlying issue in oneway_diff() within diff-lib.c.
    ++# 'do_oneway_diff()' is not called as expected for paths that could match
    ++# inside of a sparse directory. Specifically, the 'ce_path_match()' function
    ++# fails to recognize files inside a sparse directory (e.g., when 'folder1/'
    ++# is a sparse directory, 'folder1/a' cannot be recognized). The goal is to
    ++# proceed with 'do_oneway_diff()' if the pathspec could match inside of a
    ++# sparse directory.
    + test_expect_failure 'diff --check with pathspec outside sparse definition' '
      	init_repos &&
      
    - 	write_script edit-contents <<-\EOF &&
3:  7a9c2da30d ! 3:  310397de6d check-attr: integrate with sparse-index
    @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git diff-files -- $SPARSE_CO
      test_done
     
      ## t/t1092-sparse-checkout-compatibility.sh ##
    -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --check with pathspec outside sparse definition' '
    - 	test_all_match test_must_fail git diff --check -- folder1/a
    +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'diff --check with pathspec outside sparse definition' '
    + 	test_all_match test_must_fail git diff --check --cached -- folder1/a
      '
      
     +test_expect_success 'sparse-index is not expanded: check-attr' '
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --check with
     +	cp .gitattributes ./sparse-index/folder1 &&
     +
     +	git -C sparse-index add deep/.gitattributes &&
    -+	git -C sparse-index add --sparse  folder1/.gitattributes &&
    ++	git -C sparse-index add --sparse folder1/.gitattributes &&
     +	ensure_not_expanded check-attr -a --cached -- deep/a &&
     +	ensure_not_expanded check-attr -a --cached -- folder1/a
     +'
-- 
2.39.0

