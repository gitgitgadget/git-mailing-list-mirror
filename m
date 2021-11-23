Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D86C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 04:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhKWFB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 00:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhKWFB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 00:01:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E25C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 20:58:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id np3so15615288pjb.4
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 20:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBLVFi+ouh/kn81IaM/vWR+p5YTZMTEoGcsfpcybC0w=;
        b=AavRcgg9eKGkIauhkrccYPjs6nE0ds8hMjwWBpf31uNwxoHMmIryDLoh94uoB4XIZ3
         0DZIKsCCNh8z8iXzSkll4B/CYtvDtdZJ4ko+uvHKXZqG1S6Bjr5iDIgbsNTDGPz1XU1V
         SLhig3mgBZ3+t2Jpy8FBdN6yxXtHaw0z+AX7PV9dJxQZ6DqJhEcfRvNusIaJ8/csE7m0
         WxsAuHrzRZfssp0ef0JIhAoYnG0yvzI7LPr5RqzYBIqCeHh+SyAWxoWRjeCPkzpfasDq
         vMJ6gHHZNEuRe6k4xdDpLsqZSW2DudK5f+y3WSAOh2AM//8YqloJwIxN+SRzNZal+5w+
         yocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBLVFi+ouh/kn81IaM/vWR+p5YTZMTEoGcsfpcybC0w=;
        b=rH5T0BF1rKP8HSp4p7uVItgVjgnwkllZvfvHaLQmV5Pg0l/M+5QZbEYhuQ/QYSl4V1
         GioHbam4ohL2p8f+4S0oTynkEUnBYEQoe1Hy29UqxA7leeBsVQiaf/MocoeTyUwXfY2l
         0yCtDPLeQS8KmBYc3mRwz4P464xIHqcmS57iwUDKckjIpa1VEn+7bTisA8Yl864hPF6L
         Nxzmk3S76I3HGDw78Xz3zFYiMD1FUTzxc4cdYM/t9j72hKZQWSjUa7bv57ZcO80pyNoi
         qUL4kJiyiYjTXcbneRddtPWIgl+FbYfQhVw0tg6xaBmniGYgtubMagGSNFeRX4xItdqY
         1beQ==
X-Gm-Message-State: AOAM531VtqQryMqJ3ggmFDVyCzoc8E0/TuGoTZPjxMmhs4YsXmfm54NQ
        JBnZV3qRU1qDLzzx7GSMO2VcDTkAIYaNmMvS/KI=
X-Google-Smtp-Source: ABdhPJwSrZ9f1SOXOATcWDQ8/ynBO9UWMTjVHJEk/ecIJQqZdus8aJ8LsuP/kJSqWFvmv8rp6gmNgg==
X-Received: by 2002:a17:902:db07:b0:141:ea12:218b with SMTP id m7-20020a170902db0700b00141ea12218bmr3096483plx.46.1637643499138;
        Mon, 22 Nov 2021 20:58:19 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.98])
        by smtp.gmail.com with ESMTPSA id y18sm11765513pfa.142.2021.11.22.20.58.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 20:58:18 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, congdanhqx@gmail.com, gitster@pobox.com,
        peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v4 0/1] ls-tree.c: support `--oid-only` option
Date:   Tue, 23 Nov 2021 12:58:05 +0800
Message-Id: <cover.1637642029.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g75523f744f.dirty
In-Reply-To: <cover.1637567328.git.dyroneteng@gmail.com>
References: <cover.1637567328.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the discussions on v3 (even I send a patch with
wrong contents and the right cover). So I looked at them, and
I think I have to send a new patch first, so this includes:

    1. Commit message modifications (Junio C Hamano's advice)
    2. Documentation modifications (Peter Baumann's advice)
    3. To use the MODE enum name instead (Đoàn Trần Công Danh's advice)

The other discussions I will reply today.

Teng Long (1):
  ls-tree.c: support `--oid-only` option for "git-ls-tree"

 Documentation/git-ls-tree.txt | 18 ++++++++++++---
 builtin/ls-tree.c             | 30 +++++++++++++++++-------
 t/t3104-ls-tree-oid.sh        | 43 +++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 11 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

Range-diff against v3:
1:  8b68568d6c ! 1:  63876dbeb7 ls-tree.c: support `--oid-only` option for "git-ls-tree"
    @@ Commit message
     
         Sometimes, we only want to get the objects from output of `ls-tree`
         and commands like `sed` or `cut` is usually used to intercept the
    -    origin output to achieve this purpose in practical.
    +    origin output to achieve this purpose in practice.
     
    -    This commit supply an option names `--oid-only` to let `git ls-tree`
    -    only print out the OID of the object. `--oid-only` and `--name-only`
    -    are mutually exclusive in use.
    +    This commit teach the "--oid-only" option to tell the command to
    +    only show the object name, just like "--name-only" option tells the
    +    command to only show the path component, for each entry. These two
    +    options are mutually exclusive.
     
    -    Reviewed-by: Jeff King <peff@peff.net>
    -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    -    Reviewed-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## Documentation/git-ls-tree.txt ##
    -@@ Documentation/git-ls-tree.txt: SYNOPSIS
    +@@ Documentation/git-ls-tree.txt: git-ls-tree - List the contents of a tree object
    + SYNOPSIS
      --------
      [verse]
    - 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
    +-'git ls-tree' [-d] [-r] [-t] [-l] [-z]
     -	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
    -+	    [--name-only] [--name-status] [--oid-only]
    ++'git ls-tree' [-d] [-r] [-t] [-l] [-z] [-n] [-s] [-o]
    ++	    [--name-only | --oid-only]
    ++	    [--name-status | --oid-only]
     +	    [--full-name] [--full-tree] [--abbrev[=<n>]]
      	    <tree-ish> [<path>...]
      
      DESCRIPTION
     @@ Documentation/git-ls-tree.txt: OPTIONS
    + 	\0 line termination on output and do not quote filenames.
    + 	See OUTPUT FORMAT below for more information.
    + 
    ++-n::
      --name-only::
    - --name-status::
    +---name-status::
      	List only filenames (instead of the "long" output), one per line.
    --
    -+	Cannot be used with `--oid-only` together.
    ++	Cannot be combined with `--oid-only`.
    ++
    ++-s::
    ++--name-status::
    ++	Consistent behavior with `--name-only`.
    ++
    ++-o::
     +--oid-only::
    -+	List only OIDs of the objects, one per line. Cannot be used with
    -+	`--name-only` or `--name-status` together.
    ++	List only names of the objects, one per line. Cannot be combined
    ++	with `--name-only` or `--name-status`.
    + 
      --abbrev[=<n>]::
      	Instead of showing the full 40-byte hexadecimal object
    - 	lines, show the shortest prefix that is at least '<n>'
     
      ## builtin/ls-tree.c ##
     @@ builtin/ls-tree.c: static int line_termination = '\n';
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
      		return 0;
      
     -	if (!(ls_options & LS_NAME_ONLY)) {
    -+	if (cmdmode == 2) {
    ++	if (cmdmode == MODE_OID_ONLY) {
     +		printf("%s\n", find_unique_abbrev(oid, abbrev));
     +		return 0;
     +	}
     +
    -+	if (cmdmode == 0) {
    ++	if (cmdmode == MODE_UNSPECIFIED) {
      		if (ls_options & LS_SHOW_SIZE) {
      			char size_text[24];
      			if (!strcmp(type, blob_type)) {
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
     -			LS_NAME_ONLY),
     -		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
     -			LS_NAME_ONLY),
    -+		OPT_CMDMODE('n', "name-only", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
    -+		OPT_CMDMODE('s', "name-status", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
    -+		OPT_CMDMODE('o', "oid-only", &cmdmode, N_("list only oids"), MODE_OID_ONLY),
    ++		OPT_CMDMODE('n', "name-only", &cmdmode,
    ++			    N_("list only filenames"), MODE_NAME_ONLY),
    ++		OPT_CMDMODE('s', "name-status", &cmdmode,
    ++			    N_("list only filenames"), MODE_NAME_ONLY),
    ++		OPT_CMDMODE('o', "oid-only", &cmdmode,
    ++			    N_("list only oids"), MODE_OID_ONLY),
      		OPT_SET_INT(0, "full-name", &chomp_prefix,
      			    N_("use full path names"), 0),
      		OPT_BOOL(0, "full-tree", &full_tree,
    @@ t/t3104-ls-tree-oid.sh (new)
     +. ./test-lib.sh
     +
     +test_expect_success 'setup' '
    -+	echo 111 >1.txt &&
    -+	echo 222 >2.txt &&
    -+	mkdir -p path0/a/b/c &&
    -+	echo 333 >path0/a/b/c/3.txt &&
    ++	test_commit A &&
    ++	test_commit B &&
    ++	mkdir -p C &&
    ++	test_commit C/D.txt &&
     +	find *.txt path* \( -type f -o -type l \) -print |
     +	xargs git update-index --add &&
     +	tree=$(git write-tree) &&
    @@ t/t3104-ls-tree-oid.sh (new)
     +
     +test_expect_success 'usage: --oid-only' '
     +	git ls-tree --oid-only $tree >current &&
    -+	git ls-tree $tree | awk "{print \$3}" >expected &&
    ++	git ls-tree $tree >result &&
    ++	cut -f1 result | cut -d " " -f3 >expected &&
     +	test_cmp current expected
     +'
     +
     +test_expect_success 'usage: --oid-only with -r' '
     +	git ls-tree --oid-only -r $tree >current &&
    -+	git ls-tree -r $tree | awk "{print \$3}" >expected &&
    ++	git ls-tree -r $tree >result &&
    ++	cut -f1 result | cut -d " " -f3 >expected &&
     +	test_cmp current expected
     +'
     +
     +test_expect_success 'usage: --oid-only with --abbrev' '
     +	git ls-tree --oid-only --abbrev=6 $tree >current &&
    -+	git ls-tree --abbrev=6 $tree | awk "{print \$3}" > expected &&
    ++	git ls-tree --abbrev=6 $tree >result &&
    ++	cut -f1 result | cut -d " " -f3 >expected &&
     +	test_cmp current expected
     +'
     +
    -+test_expect_failure 'usage: incompatible options: --name-only with --oid-only' '
    -+	test_incompatible_usage git ls-tree --oid-only --name-only
    ++test_expect_success 'usage: incompatible options: --name-only with --oid-only' '
    ++	test_expect_code 129 git ls-tree --oid-only --name-only
     +'
     +
     +test_done
-- 
2.33.1.10.g75523f744f.dirty

