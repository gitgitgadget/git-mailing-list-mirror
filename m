Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD8C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiGRQqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGRQq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:46:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1F92BE4
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:46:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 5so9529541plk.9
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9HGUqO2EmPHw7piEs5vZSJv87ZubEF++bLUqbuOdn8=;
        b=ORpN42cUQhQodxaFzc4eXS9B0k6X7K5B4etcYQdBritJlMJ+Z2M1/sRvAhkVFp33rV
         Kwd0+XfLpRMojGa0N0kA66xEhJ/ZoCN2LySJsMHWIWaZvd8Vb8b7uTsica4bCvy2XADD
         aNiKLFlUPbTYwvUClpdnpDoK7gpj4md1tcxGgt90dVnRxs3S1+PNSJd566AAlkzf1UGn
         EWtp/g4xArox8wVbnMcpEYdek6I5FGDEUDSAv5qm7QfLF/jhwZ4fRUK4yP118QD4lNO7
         qGyYHGr8aSdUiX3ynh8jdQJgMs+PPXUuinKXSLY0x+Bf89vsEemAKAEO9bcqe/FSqtWh
         6yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9HGUqO2EmPHw7piEs5vZSJv87ZubEF++bLUqbuOdn8=;
        b=dEC144ShngKZ+XNApp8O8k5wkLzOJL9Uq15DZRXWh+SDS8Ygy0fmZpgYSAdg/mauTi
         HkIWa4YgHgpb9tvyMbr8OaBJPred6xZyLtjNpbCxbEdtxKnIGfLBXm1zW3QAtS/llcTt
         iC22u+2BaKWkXBpw9398pIj+bf19Gc301NiD2OZeF2CHz6MNt+8zXCMxxEBy3SJRgfT/
         YM/hOETAEFZQShWjaGhlx/k4pQY85m9Z/AW4Hya4ELAm2CmKOaj6qk2VAefJRi984BcA
         I9BXMVs2LRCsn2Tfuq7cWkxfA0ZbpXkZD55ZwhnjBe0Sm/RPlA1/8eXb731jO5JYIkFz
         /pFA==
X-Gm-Message-State: AJIora8anZxZ8EQ+cS+LsQFhrCTWIrCD7duggPprfxuyYPL6BXPNSDrP
        qt374Ge33h96iQbj2n2vfpo=
X-Google-Smtp-Source: AGRyM1tY4oWkj5hBcSEuxD1hbn8ffV5T8Pvd+qzaRjNK5HUOjZnJ9ovZTxThh1DyXibBLaj7Xe2ZyQ==
X-Received: by 2002:a17:902:8543:b0:16b:fbd1:9f68 with SMTP id d3-20020a170902854300b0016bfbd19f68mr29555442plo.101.1658162784861;
        Mon, 18 Jul 2022 09:46:24 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm9671074pfd.90.2022.07.18.09.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:46:16 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 0/7] trace2: dump scope when print "interesting" config 
Date:   Tue, 19 Jul 2022 00:45:59 +0800
Message-Id: <cover.1658159745.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v6:

1. [1/7] Fixed the mistitled commit mesage.

   [PATCH v6 1/7] "clean: fixed issues related to text output format"

   to:

   [PATCH v7 1/7] "pack-bitmap.c: fix formatting of error messages"

2. [4/7] replace "warning()" to "warning_errno()" and rewrite commit message.

3. [5/7] fix the logic error, move "error_errno()" before close(fd) to
   avoid errno lost.

4. [7/7] update Documentation/technical/api-trace2.txt here too.

Thanks.

Teng Long (7):
  pack-bitmap.c: fix formatting of error messages
  pack-bitmap.c: mark more strings for translations
  pack-bitmap.c: rename "idx_name" to "bitmap_name"
  pack-bitmap.c: do not ignore error when opening a bitmap file
  pack-bitmap.c: using error() instead of silently returning -1
  pack-bitmap.c: continue looping when first MIDX bitmap is found
  tr2: dump names if config exist in multiple scopes

 Documentation/technical/api-trace2.txt |  45 +++++++++++
 pack-bitmap.c                          | 103 ++++++++++++++-----------
 trace2/tr2_tgt_event.c                 |   3 +
 trace2/tr2_tgt_normal.c                |   5 +-
 trace2/tr2_tgt_perf.c                  |   9 ++-
 5 files changed, 117 insertions(+), 48 deletions(-)

Range-diff against v6:
1:  94a64ba895 ! 1:  7426b277ba clean: fixed issues related to text output format
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    clean: fixed issues related to text output format
    +    pack-bitmap.c: fix formatting of error messages
     
         There are some text output issues in 'pack-bitmap.c', they exist in
         die(), error() etc. This includes issues with capitalization the
2:  cadecd6b84 = 2:  4e493426a0 pack-bitmap.c: mark more strings for translations
3:  d8a2235cb0 = 3:  263f45ba96 pack-bitmap.c: rename "idx_name" to "bitmap_name"
4:  009cc49a18 ! 4:  d11ea092d5 pack-bitmap.c: don't ignore ENOENT silently
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    pack-bitmap.c: don't ignore ENOENT silently
    +    pack-bitmap.c: do not ignore error when opening a bitmap file
     
    -    When finished call git_open(), instead of ignoring ENOENT silently
    -    and return error_errno(_("cannot stat...")), it's better to check
    -    the ENOENT before then output the warning.
    +    Calls to git_open() to open the pack bitmap file and
    +    multi-pack bitmap file do not report any error when they
    +    fail.  These files are optional and it is not an error if
    +    open failed due to ENOENT, but we shouldn't be ignoring
    +    other kinds of errors.
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
     -	if (fd < 0)
     +	if (fd < 0) {
     +		if (errno != ENOENT)
    -+			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
    ++			warning_errno("cannot open '%s'", bitmap_name);
     +		free(bitmap_name);
      		return -1;
     +	}
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
     -	if (fd < 0)
     +	if (fd < 0) {
     +		if (errno != ENOENT)
    -+			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
    ++			warning_errno("cannot open '%s'", bitmap_name);
     +		free(bitmap_name);
      		return -1;
     +	}
5:  52783555e2 ! 5:  f60efe78d6 pack-bitmap.c: using error() instead of silently returning -1
    @@ Commit message
     
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    + 	free(bitmap_name);
      
      	if (fstat(fd, &st)) {
    ++		error_errno(_("cannot fstat bitmap file"));
      		close(fd);
    --		return -1;
    -+		return error_errno(_("cannot fstat bitmap file"));
    + 		return -1;
      	}
    - 
    - 	if (bitmap_git->pack || bitmap_git->midx) {
     @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      	if (load_bitmap_header(bitmap_git) < 0)
      		goto cleanup;
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      	if (load_midx_revindex(bitmap_git->midx) < 0) {
      		warning(_("multi-pack bitmap is missing required reverse index"));
     @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    + 	free(bitmap_name);
      
      	if (fstat(fd, &st)) {
    ++		error_errno(_("cannot fstat bitmap file"));
      		close(fd);
    --		return -1;
    -+		return error_errno(_("cannot fstat bitmap file"));
    + 		return -1;
      	}
    - 
    - 	if (bitmap_git->pack || bitmap_git->midx) {
6:  95832190b8 = 6:  83090308ad pack-bitmap.c: continue looping when first MIDX bitmap is found
7:  c45ead51ff ! 7:  a01ae8478d tr2: dump names if config exist in multiple scopes
    @@ Commit message
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    + ## Documentation/technical/api-trace2.txt ##
    +@@ Documentation/technical/api-trace2.txt: at offset 508.
    + This example also shows that thread names are assigned in a racy manner
    + as each thread starts and allocates TLS storage.
    + 
    ++Print Configs::
    ++
    ++	  Dump "interesting" config values to trace2 log.
    +++
    ++The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
    ++`trace2.configparams` can be used to output config values which you care
    ++about. For example, assume that we want to config different `color.ui`
    ++values in multiple scopes, such as:
    +++
    ++----------------
    ++$ git config --system color.ui never
    ++$ git config --global color.ui always
    ++$ git config --local color.ui auto
    ++$ git config --list --show-scope | grep 'color.ui'
    ++system  color.ui=never
    ++global  color.ui=always
    ++local   color.ui=auto
    ++----------------
    +++
    ++Then, mark the config `color.ui` as "interesting" config with
    ++`GIT_TRACE2_CONFIG_PARAMS`:
    +++
    ++----------------
    ++$ export GIT_TRACE2_PERF_BRIEF=1
    ++$ export GIT_TRACE2_PERF=~/log.perf
    ++$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
    ++$ git version
    ++...
    ++$ cat ~/log.perf
    ++d0 | main                     | version      |     |           |           |              | ...
    ++d0 | main                     | start        |     |  0.000284 |           |              | /opt/git/master/bin/git version
    ++d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
    ++d0 | main                     | cmd_name     |     |           |           |              | version (version)
    ++d0 | main                     | exit         |     |  0.000419 |           |              | code:0
    ++d0 | main                     | atexit       |     |  0.000426 |           |              | code:0
    ++d0 | main                     | version      |     |           |           |              | ...
    ++d0 | main                     | start        |     |  0.000275 |           |              | /opt/git/master/bin/git version
    ++d0 | main                     | cmd_ancestry |     |           |           |              | ancestry:[bash sshd sshd sshd systemd]
    ++d0 | main                     | cmd_name     |     |           |           |              | version (version)
    ++d0 | main                     | def_param    |     |           |           |              | color.ui:never
    ++d0 | main                     | def_param    |     |           |           |              | color.ui:always
    ++d0 | main                     | def_param    |     |           |           |              | color.ui:auto
    ++d0 | main                     | exit         |     |  0.000543 |           |              | code:0
    ++d0 | main                     | atexit       |     |  0.000549 |           |              | code:0
    ++----------------
    + == Future Work
    + 
    + === Relationship to the Existing Trace Api (api-trace.txt)
    +
      ## trace2/tr2_tgt_event.c ##
     @@ trace2/tr2_tgt_event.c: static void fn_param_fl(const char *file, int line, const char *param,
      {
-- 
2.35.0.rc0.679.gc613175da2

