Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD7C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245715AbhLVOVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245708AbhLVOVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:21:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3192C061747
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:20:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i22so5167743wrb.13
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H2dMSdv0uvCA8FMGUwtwG4tH8yQJwYoXOuPKT2Z90c8=;
        b=IH4SkbLNV4ON10ewiy1r4HNOI/3XVpogXvLVmqI0dhRQMRflbai5mS+JcwNWE+6XYw
         xDaBwQc08UP/xpS7cRFtP0cOUuVJpZjKi6hEfoQnyKXit9dqmp5eACO71TDbcX3mOA2N
         dF2LycAzDmsT4nH35H8V7m9ICdanaQsk6sKAZK37AJ+cfRiI3qibPIOo0yzr6cM2dCqH
         Y67n/8I1NZaANzIfruWClQTQIqfNH13gL+CI0nf2zNU8IowgxkY/ulGxmBHywV0OWEBm
         LMvBljSo4XZsWwNeAfYSwCpKmH2ZjbZVq1Gxxl/1ZWqc9aK+kzBByzrZmVtXwE0ilHme
         rcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H2dMSdv0uvCA8FMGUwtwG4tH8yQJwYoXOuPKT2Z90c8=;
        b=dzHw+gOVVZJh0Vo2LYAYq28j5j14PiNPKHuljlf1KH1wSs3SXR0Oqk1nKa/PH+M/N+
         cfwpFXRR7LsfGQCby+ycr09OAcARdzRzgSd/qlrk/LFe3ngyG16RILn3E5krIEi44M3D
         Dj8Uwti09i8jm8JFG46tP2eeOjV81MpOIyCaUN7hCq2q+wv9sJl2BW14fcRI7n8qYpXS
         otQXPYdlyKtWW4TDlwNXMCiwuwXSkC3BjGZso7G5EvPp08fD2vPUOUSuRTsC63tEfzx3
         /43albWYtzEUf+bfhOEe5K0P1YD+EcRxqOGnsqiatvxtjPbDMRXkHOPu4SCyntbiVOaN
         B9dw==
X-Gm-Message-State: AOAM53123O3h/2TlCGog6kiIY4yvVgoyJnlBDzAR4AQv33P3KUtH+bH2
        OWEsMuqbKPnaXKGpe/esz/Ao1eve1k4=
X-Google-Smtp-Source: ABdhPJxM/7qIiEcqTo2CaRqw8QVB/3hrJimoD7rc+PsytcQY9rhRVq65MrpCg6yIpLj7EOGl/QiT6A==
X-Received: by 2002:adf:e0c8:: with SMTP id m8mr2405557wri.113.1640182857989;
        Wed, 22 Dec 2021 06:20:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm2368575wry.85.2021.12.22.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:20:57 -0800 (PST)
Message-Id: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:20:51 +0000
Subject: [PATCH v4 0/5] Sparse index: fetch, pull, ls-files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is now based on 'master'.

Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
have been an integration much earlier in the cycle. They read the index to
look for the .gitmodules file in case there are submodules that need to be
fetched. Since looking for a file by name is already protected, we only need
to disable 'command_requires_full_index' and we are done.

The 'ls-files' builtin is useful when debugging the index, and some scripts
use it, too. We are not changing the default behavior which expands a sparse
index in order to show all of the cached blobs. Instead, we add a '--sparse'
option that allows us to see the sparse directory entries upon request.
Combined with --debug, we can see a lot of index details, such as:

$ git ls-files --debug --sparse
LICENSE
  ctime: 1634910503:287405820
  mtime: 1634910503:287405820
  dev: 16777220 ino: 119325319
  uid: 501  gid: 20
  size: 1098    flags: 200000
README.md
  ctime: 1634910503:288090279
  mtime: 1634910503:288090279
  dev: 16777220 ino: 119325320
  uid: 501  gid: 20
  size: 934 flags: 200000
bin/index.js
  ctime: 1634910767:828434033
  mtime: 1634910767:828434033
  dev: 16777220 ino: 119325520
  uid: 501  gid: 20
  size: 7292    flags: 200000
examples/
  ctime: 0:0
  mtime: 0:0
  dev: 0    ino: 0
  uid: 0    gid: 0
  size: 0   flags: 40004000
package.json
  ctime: 1634910503:288676330
  mtime: 1634910503:288676330
  dev: 16777220 ino: 119325321
  uid: 501  gid: 20
  size: 680 flags: 200000


(In this example, the 'examples/' directory is sparse.)

Thanks!


Updates in v2
=============

 * Rebased onto latest ld/sparse-index-blame without issue.
 * Updated the test to use diff-of-diffs instead of a sequence of greps.
 * Added patches that remove the use of 'test-tool read-cache --table' and
   its implementation.


Updates in v3
=============

 * Fixed typo in commit message.
 * Added comments around doing strange things in an ls-files test.
 * Fixed adjacent typo in a test comment.


Updates in v4
=============

 * Rebased on to 'master' now that ld/sparse-index-blame is merged.
 * Change testing strategy to check exact output instead of using 'diff -u'.
 * Updated documentation to state that directories have a trailing slash.

Derrick Stolee (5):
  fetch/pull: use the sparse index
  ls-files: add --sparse option
  t1092: replace 'read-cache --table' with 'ls-files --sparse'
  t1091/t3705: remove 'test-tool read-cache --table'
  test-read-cache: remove --table, --expand options

 Documentation/git-ls-files.txt           |   5 +
 builtin/fetch.c                          |   2 +
 builtin/ls-files.c                       |  12 ++-
 builtin/pull.c                           |   2 +
 t/helper/test-read-cache.c               |  64 ++---------
 t/t1091-sparse-checkout-builtin.sh       |  25 ++++-
 t/t1092-sparse-checkout-compatibility.sh | 132 ++++++++++++++++++++---
 t/t3705-add-sparse-checkout.sh           |   8 +-
 8 files changed, 168 insertions(+), 82 deletions(-)


base-commit: 597af311a2899bfd6640b9b107622c5795d5f998
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1080%2Fderrickstolee%2Fsparse-index%2Ffetch-pull-ls-files-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1080/derrickstolee/sparse-index/fetch-pull-ls-files-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1080

Range-diff vs v3:

 1:  f72001638d1 = 1:  1043a1927d2 fetch/pull: use the sparse index
 2:  b81174ba54b ! 2:  e1ec52881d9 ls-files: add --sparse option
     @@ Documentation/git-ls-files.txt: Both the <eolinfo> in the index ("i/<eolinfo>")
       
      +--sparse::
      +	If the index is sparse, show the sparse directories without expanding
     -+	to the contained files.
     ++	to the contained files. Sparse directories will be shown with a
     ++	trailing slash, such as "x/" for a sparse directory "x".
      +
       \--::
       	Do not interpret any more arguments as options.
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is expanded and converted back' '
     - 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
     + 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
       		git -C sparse-index reset -- folder1/a &&
       	test_region index convert_to_sparse trace2.txt &&
      +	test_region index ensure_full_index trace2.txt &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
      +test_expect_success 'ls-files' '
      +	init_repos &&
      +
     ++	# Use a smaller sparse-checkout for reduced output
     ++	test_sparse_match git sparse-checkout set &&
     ++
      +	# Behavior agrees by default. Sparse index is expanded.
      +	test_all_match git ls-files &&
      +
      +	# With --sparse, the sparse index data changes behavior.
     -+	git -C sparse-index ls-files >dense &&
     -+	git -C sparse-index ls-files --sparse >sparse &&
     ++	git -C sparse-index ls-files --sparse >actual &&
      +
      +	cat >expect <<-\EOF &&
     -+	@@ -13,13 +13,9 @@
     -+	 e
     -+	 folder1-
     -+	 folder1.x
     -+	-folder1/0/0/0
     -+	-folder1/0/1
     -+	-folder1/a
     -+	+folder1/
     -+	 folder10
     -+	-folder2/0/0/0
     -+	-folder2/0/1
     -+	-folder2/a
     -+	+folder2/
     -+	 g
     -+	-x/a
     -+	+x/
     -+	 z
     ++	a
     ++	deep/
     ++	e
     ++	folder1-
     ++	folder1.x
     ++	folder1/
     ++	folder10
     ++	folder2/
     ++	g
     ++	x/
     ++	z
      +	EOF
      +
     -+	diff -u dense sparse | tail -n +3 >actual &&
      +	test_cmp expect actual &&
      +
      +	# With --sparse and no sparse index, nothing changes.
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is n
      +	test_sparse_match git sparse-checkout add folder1 &&
      +	test_sparse_match git ls-files --modified &&
      +
     -+	git -C sparse-index ls-files >dense &&
     -+	git -C sparse-index ls-files --sparse >sparse &&
     ++	test_all_match git ls-files &&
     ++	git -C sparse-index ls-files --sparse >actual &&
      +
      +	cat >expect <<-\EOF &&
     -+	@@ -17,9 +17,7 @@
     -+	 folder1/0/1
     -+	 folder1/a
     -+	 folder10
     -+	-folder2/0/0/0
     -+	-folder2/0/1
     -+	-folder2/a
     -+	+folder2/
     -+	 g
     -+	-x/a
     -+	+x/
     -+	 z
     ++	a
     ++	deep/
     ++	e
     ++	folder1-
     ++	folder1.x
     ++	folder1/0/0/0
     ++	folder1/0/1
     ++	folder1/a
     ++	folder10
     ++	folder2/
     ++	g
     ++	x/
     ++	z
      +	EOF
      +
     -+	diff -u dense sparse | tail -n +3 >actual &&
      +	test_cmp expect actual &&
      +
      +	# Double-check index expansion is avoided
 3:  2a6a1c5a39c = 3:  0c53bd09ba4 t1092: replace 'read-cache --table' with 'ls-files --sparse'
 4:  f0143686754 = 4:  4952c9e724b t1091/t3705: remove 'test-tool read-cache --table'
 5:  9227dc54165 = 5:  3efffad814c test-read-cache: remove --table, --expand options

-- 
gitgitgadget
