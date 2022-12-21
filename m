Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219F6C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiLUNrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiLUNrB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 08:47:01 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B831276F
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:46:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id jo4so28003156ejb.7
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HZJeto9zZilvN3qa3F8jjr9Sh733nOMfw0zMwXFi+w=;
        b=M3D0gsJmXbcF7XUTaURmdG3h1YIeeGk3EbCZD3XG/urz/0Yg5MtjQDmar6fu83vmr7
         BhwWI8kScbMwVObGxu/xYHsDolT6LH3cG3dpSlOXqlMzc7X/NiQYVoJIHG15uOiZTFef
         MOpizea+HSgsUuSfesM/v9KcseAWvIOOXRD84Rdeb9eyAI+Y3HWWOWDFEknezHU7RX2a
         1G5GfweXdLO7oqu7Go7oi4UQX7u7UBCCVI2LqEZwTSOvAam9fgunYqYaDmBQ7eLUNraq
         21xNh5mPZQ+Ul7/WOdSS6GoU+2wntaqRpaCrZS/a+ZPkH5uNihVi6oDo2q6kMnkbbGEj
         CpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HZJeto9zZilvN3qa3F8jjr9Sh733nOMfw0zMwXFi+w=;
        b=7Q5B/0Yy8ImledgnS4D9CbDGeJQrKOLEKuN9Gqa9zPXUSTHyvS6biIc/IljUzPDEqD
         WoulBbThev8r+L08YdjvBl39f3TZc/MJoypHMDE8QnZT3swT6P3CeK2/YFC79ee1pjtm
         U0jpWtWP2tSkYR6ucFAGrq8BlQnes9MLMQoksFcfWczr9owNIMiACZA245cHRSPacZLp
         u5JOMzFbfP6iT47zugGoMXkQ5kIH6gpj7dXWEFs4rhch7cxejB/hVHpZIpnw+E+uFNZl
         9DHEekrRRnBQ0q+/7cRWwdqaQR7vMW0QZ7Gcn9x9WTLxPUKhkZOhic8XEDc1V12yqdXd
         fRgg==
X-Gm-Message-State: AFqh2kpzOVwAxcs/SiUFwPzcTrpndfuWEyNLetu04NlTY5zx2K4jRQbo
        L6CU/NVc5oOmN/2w8mVEWnWLnb+H/elFmNgp09k=
X-Google-Smtp-Source: AMrXdXsRZbavhbqKQtum0tFubjzbLa1u/HcWpKVVwKEc8do+rr+62oQp4vtlj7QxEgvteMz4zePP6A==
X-Received: by 2002:a17:906:2813:b0:829:59d5:e661 with SMTP id r19-20020a170906281300b0082959d5e661mr1337773ejc.29.1671630417559;
        Wed, 21 Dec 2022 05:46:57 -0800 (PST)
Received: from localhost.localdomain ([79.140.126.226])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906670e00b007c0f45ad6bcsm7073365ejp.109.2022.12.21.05.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:46:57 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/2] check-attr: add support to work with revisions
Date:   Wed, 21 Dec 2022 14:46:52 +0100
Message-Id: <cover.1671630304.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/>
References: <https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t
v3: https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/

Given a pathname, git-check-attr(1) will list the attributes which apply to that
pathname by reading all relevant gitattributes files. Currently there is no way
to specify a revision to read the gitattributes from.

This is specifically useful in bare repositories wherein the gitattributes are
only present in the git working tree but not available directly on the
filesystem.

This series aims to add a new flag `--revision` to git-check-attr(1) which
allows us to read gitattributes from the specified revision.

Changes since version 3:
- Dropped the `-r` shorcut for the flag
- Fixed tests failing by initializing the tree_oid to NULL
- Incorporated some changes around the commit message

Range-diff against v3:

1:  6224754179 = 1:  6224754179 t0003: move setup for `--all` into new block
2:  d8f8b3c36c ! 2:  a161dbdf8b attr: add flag `-r|--revisions` to work with revisions
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    attr: add flag `-r|--revisions` to work with revisions
    +    attr: add flag `--revision` to work with revisions
     
         The contents of the .gitattributes files may evolve over time, but "git
         check-attr" always checks attributes against them in the working tree
         and/or in the index. It may be beneficial to optionally allow the users
    -    to check attributes against paths from older commits.
    +    to check attributes taken from a commit other than HEAD against paths.
     
    -    Add a new flag `--revision`/`-r` which will allow users to check the
    -    attributes against a tree-ish revision. When the user uses this flag, we
    -    go through the stack of .gitattributes files but instead of checking the
    -    current working tree and/or in the index, we check the blobs from the
    -    provided tree-ish object. This allows the command to also be used in
    -    bare repositories.
    +    Add a new flag `--revision` which will allow users to check the
    +    attributes against a commit (actually any tree-ish would do). When the
    +    user uses this flag, we go through the stack of .gitattributes files but
    +    instead of checking the current working tree and/or in the index, we
    +    check the blobs from the provided tree-ish object. This allows the
    +    command to also be used in bare repositories.
     
    -    Since we use a tree-ish object, the user can pass "-r HEAD:subdirectory"
    -    and all the attributes will be looked up as if subdirectory was the root
    -    directory of the repository.
    +    Since we use a tree-ish object, the user can pass "--revision
    +    HEAD:subdirectory" and all the attributes will be looked up as if
    +    subdirectory was the root directory of the repository.
     
    -    We cannot use the `<rev>:<path>` syntax like the one used in `git show`
    -    because any non-flag parameter before `--` is treated as an attribute
    -    and any parameter after `--` is treated as a pathname.
    +    We cannot simply use the `<rev>:<path>` syntax without the `--revision`
    +    flag, similar to how it is used in `git show` because any non-flag
    +    parameter before `--` is treated as an attribute and any parameter after
    +    `--` is treated as a pathname.
     
         The change involves creating a new function `read_attr_from_blob`, which
         given the path reads the blob for the path against the provided revision and
    @@ Commit message
         files.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    +    Signed-off-by: Toon Claes <toon@iotcl.com>
         Co-authored-by: toon@iotcl.com
     
      ## Documentation/git-check-attr.txt ##
    @@ Documentation/git-check-attr.txt: git-check-attr - Display gitattributes informa
      [verse]
     -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
     -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
    -+'git check-attr' [-r <revision>] [-a | --all | <attr>...] [--] <pathname>...
    -+'git check-attr' --stdin [-z] [-r <revision>] [-a | --all | <attr>...]
    ++'git check-attr' [--revision <revision>] [-a | --all | <attr>...] [--] <pathname>...
    ++'git check-attr' --stdin [-z] [--revision <revision>] [-a | --all | <attr>...]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-check-attr.txt: OPTIONS
      	If `--stdin` is also given, input paths are separated
      	with a NUL character instead of a linefeed character.
      
    -+--r <revision>::
     +--revision=<revision>::
    -+	Check attributes against the specified tree-ish revision. All the
    -+	attributes will be checked against the provided revision. Paths provided
    -+	as part of the revision will be treated as the root directory.
    ++	Check attributes against the specified commit. All the attributes will
    ++	be checked against the provided revision. Paths provided as part of the
    ++	revision will be treated as the root directory.
     +
      \--::
      	Interpret all preceding arguments as attributes and all following
    @@ attr.c
      #include "exec-cmd.h"
      #include "attr.h"
      #include "dir.h"
    -+#include "git-compat-util.h"
     +#include "strbuf.h"
     +#include "tree-walk.h"
      #include "utf8.h"
    @@ builtin/check-attr.c
      static const char * const check_attr_usage[] = {
     -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
     -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
    -+N_("git check-attr [-r <revision>] [-a | --all | <attr>...] [--] <pathname>..."),
    -+N_("git check-attr --stdin [-z] [-r <revision>] [-a | --all | <attr>...]"),
    ++N_("git check-attr [--revision <revision>] [-a | --all | <attr>...] [--] <pathname>..."),
    ++N_("git check-attr --stdin [-z] [--revision <revision>] [-a | --all | <attr>...]"),
      NULL
      };
      
    @@ builtin/check-attr.c: static const struct option check_attr_options[] = {
      	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
      	OPT_BOOL('z', NULL, &nul_term_line,
      		 N_("terminate input and output records by a NUL character")),
    -+	OPT_STRING('r', "revision", &revision, N_("revision"), N_("check attributes at this revision")),
    ++	OPT_STRING(0, "revision", &revision, N_("revision"), N_("check attributes at this revision")),
      	OPT_END()
      };
      
    @@ builtin/check-attr.c: static NORETURN void error_with_usage(const char *msg)
      int cmd_check_attr(int argc, const char **argv, const char *prefix)
      {
      	struct attr_check *check;
    -+	struct object_id tree_oid;
    ++	struct object_id *tree_oid = NULL;
      	int cnt, i, doubledash, filei;
      
      	if (!is_bare_repository())
    @@ builtin/check-attr.c: int cmd_check_attr(int argc, const char **argv, const char
      		}
      	}
      
    -+	if (revision)
    -+		if (repo_get_oid_tree(the_repository, revision, &tree_oid))
    ++	if (revision) {
    ++		tree_oid = xmalloc(sizeof(struct object_id));
    ++
    ++		if (repo_get_oid_tree(the_repository, revision, tree_oid))
     +			error("%s: not a valid revision", revision);
    ++	}
     +
      	if (stdin_paths)
     -		check_attr_stdin_paths(prefix, check, all_attrs);
    -+		check_attr_stdin_paths(prefix, check, &tree_oid, all_attrs);
    ++		check_attr_stdin_paths(prefix, check, tree_oid, all_attrs);
      	else {
      		for (i = filei; i < argc; i++)
     -			check_attr(prefix, check, all_attrs, argv[i]);
    -+			check_attr(prefix, check, &tree_oid, all_attrs, argv[i]);
    ++			check_attr(prefix, check, tree_oid, all_attrs, argv[i]);
      		maybe_flush_or_die(stdout, "attribute to stdout");
      	}
      
    @@ t/t0003-attributes.sh: attr_check_quote () {
     +attr_check_revision () {
     +	path="$1" expect="$2" revision="$3" git_opts="$4" &&
      
    -+	git $git_opts check-attr -r $revision test -- "$path" >actual 2>err &&
    ++	git $git_opts check-attr --revision $revision test -- "$path" >actual 2>err &&
     +	echo "$path: test: $expect" >expect &&
     +	test_cmp expect actual
      }
    @@ t/t0003-attributes.sh: test_expect_success 'setup' '
      	test_must_fail git check-attr test &&
      	test_must_fail git check-attr test -- &&
      	test_must_fail git check-attr -- f &&
    -+	test_must_fail git check-attr -r &&
    -+	test_must_fail git check-attr -r not-a-valid-ref &&
    ++	test_must_fail git check-attr --revision &&
    ++	test_must_fail git check-attr --revision not-a-valid-ref &&
      	echo "f" | test_must_fail git check-attr --stdin &&
      	echo "f" | test_must_fail git check-attr --stdin -- f &&
      	echo "f" | test_must_fail git check-attr --stdin test -- f &&


Karthik Nayak (2):
  t0003: move setup for `--all` into new block
  attr: add flag `--revision` to work with revisions

 Documentation/git-check-attr.txt |  9 ++-
 archive.c                        |  2 +-
 attr.c                           | 99 +++++++++++++++++++++++---------
 attr.h                           |  7 ++-
 builtin/check-attr.c             | 36 +++++++-----
 builtin/pack-objects.c           |  2 +-
 convert.c                        |  2 +-
 ll-merge.c                       |  4 +-
 pathspec.c                       |  2 +-
 t/t0003-attributes.sh            | 71 ++++++++++++++++++++++-
 userdiff.c                       |  2 +-
 ws.c                             |  2 +-
 12 files changed, 183 insertions(+), 55 deletions(-)

-- 
2.39.0

