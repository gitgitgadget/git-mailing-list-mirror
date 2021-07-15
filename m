Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64545C47E4B
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F852613E7
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbhGOPnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbhGOPnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB5C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so8374891wrw.5
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KBNjI5BYgdSYHTy/pHPt7Xu9dnSer//sxa4PfM3sDpY=;
        b=h0UHL61z3hYweu8bgTUpQQDH34jI+eySXl3Oi60wTv+AJTBLAiOID/F1Op2SCjBIFF
         BD7UF7ZdxKQ19O3alg+mHFOh2lbWc5ZnzRd3UBChwA+cimExMPh+I1iMEFNfES6Rq011
         QH2HcwAzsFjSaws8+BkPL4kbDYDANX5DhQ2WgYVW5z91Qiml9QaMtocA8NeUjnTVbLHQ
         2YmEJ5MivNCXb0pEkJjG6uDZ2uEkJOMSC1riLbmBQ2PVe5z7mS74vuIjKvy2cBBrP65L
         SOoCDX1P76V8EZcn0nXk7W5bfJE7jLlF4wkYCnkddkjSRKoD5tYDiiaQgAAQaK/Eqqt5
         nNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=KBNjI5BYgdSYHTy/pHPt7Xu9dnSer//sxa4PfM3sDpY=;
        b=md6oy/oHfhVlAINjX0sWwDDJoeHUWi6V1gqfkSgHtIAD0NuyXXqX+JG5jPYExnYGXE
         uJTKllAEZYDomA2p0y0uL/dFZCfLVpCL4EXeLROCGTXjdHf9JZ1ZEIgQvjGgFJiV7H1S
         GPhAitDi3YhcNwCgjWPnXvdGHZwNKR7AUOvaHw6h6/pKfqFXDJISGpIqz+SdZEWfec9S
         TpXLmAtbEpYVVtp3O6liV+KVmUJkVioCx5MYOHg9odS3h4VCJAI/NVNWDkF4IcR4q+7Z
         6VZWkttiZBmtAHHgt8PUAkW7yvajST8/dh1Xyq+iPx17qyU00J0ML6mMmH3RsAguCjZE
         TBRw==
X-Gm-Message-State: AOAM5328748quv/wxyg6F6IMvZccJ2QlD85xDaqYpmJESVfrPffWZTv7
        LuaZxlQKhv3eBUw9Mufv34SShb6fV0Y=
X-Google-Smtp-Source: ABdhPJww8EodaFnxPjSdKoGlj8mIkyMoBkV9QOyRbDua6jOBMfWaT+syoQcygvxxAup7HZwVt+/VlA==
X-Received: by 2002:a5d:6b8e:: with SMTP id n14mr6239900wrx.96.1626363628109;
        Thu, 15 Jul 2021 08:40:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm7207223wrj.66.2021.07.15.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:27 -0700 (PDT)
Message-Id: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:08 +0000
Subject: [PATCH v2 00/17] [GSOC] cat-file: reuse ref-filter logic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series makes cat-file reuse ref-filter logic.

Change from last version:

 1. Move some atoms' test to the commit: [GSOC] ref-filter: add
    cat_file_mode to ref_format.
 2. Advance the commit of performance tests.
 3. Modified some commit messages related to cat-file performance.

By the way, "[GSOC] ref-filter: add %(rest) atom" and its previous commits
should belong to zh/ref-filter-raw-data and the rest should belong to
zh/cat-file-batch-refactor.

ZheNing Hu (17):
  [GSOC] ref-filter: add obj-type check in grab contents
  [GSOC] ref-filter: add %(raw) atom
  [GSOC] ref-filter: --format=%(raw) re-support --perl
  [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  [GSOC] ref-filter: add %(rest) atom
  [GSOC] ref-filter: pass get_object() return value to their callers
  [GSOC] ref-filter: introduce free_ref_array_item_value() function
  [GSOC] ref-filter: add cat_file_mode to ref_format
  [GSOC] ref-filter: modify the error message and value in get_object
  [GSOC] cat-file: add has_object_file() check
  [GSOC] cat-file: change batch_objects parameter name
  [GSOC] cat-file: create p1006-cat-file.sh
  [GSOC] cat-file: reuse ref-filter logic
  [GSOC] cat-file: reuse err buf in batch_object_write()
  [GSOC] cat-file: re-implement --textconv, --filters options
  [GSOC] ref-filter: remove grab_oid() function
  [GSOC] cat-file: use fast path when using default_format

 Documentation/git-cat-file.txt     |   6 +
 Documentation/git-for-each-ref.txt |   9 +
 builtin/cat-file.c                 | 306 +++++++++----------------
 builtin/tag.c                      |   2 +-
 quote.c                            |  17 ++
 quote.h                            |   1 +
 ref-filter.c                       | 346 +++++++++++++++++++++--------
 ref-filter.h                       |  13 +-
 t/perf/p1006-cat-file.sh           |  28 +++
 t/t1006-cat-file.sh                | 239 ++++++++++++++++++++
 t/t3203-branch-output.sh           |   4 +
 t/t6300-for-each-ref.sh            | 235 ++++++++++++++++++++
 t/t6301-for-each-ref-errors.sh     |   2 +-
 t/t7004-tag.sh                     |   4 +
 t/t7030-verify-tag.sh              |   4 +
 15 files changed, 921 insertions(+), 295 deletions(-)
 create mode 100755 t/perf/p1006-cat-file.sh


base-commit: 75ae10bc75336db031ee58d13c5037b929235912
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-993%2Fadlternative%2Fcat-file-batch-refactor-2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-993/adlternative/cat-file-batch-refactor-2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/993

Range-diff vs v1:

  1:  9aef8882bd1 <  -:  ----------- cat-file: handle trivial --batch format with --batch-all-objects
  2:  1332006006f <  -:  ----------- cat-file: merge two block into one
  3:  0dacc60bbcc =  1:  45c0cbe44d5 [GSOC] ref-filter: add obj-type check in grab contents
  4:  5bd715ae9f0 =  2:  554d7653ee7 [GSOC] ref-filter: add %(raw) atom
  5:  df2cd9e8e61 =  3:  94addd4676a [GSOC] ref-filter: --format=%(raw) re-support --perl
  6:  2d34ad3bc77 =  4:  45984f94bf3 [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
  7:  460c807c6ab !  5:  6fb9cfdeab1 [GSOC] ref-filter: add %(rest) atom
     @@ Commit message
          [GSOC] ref-filter: add %(rest) atom
      
          In order to let "cat-file --batch=%(rest)" use the ref-filter
     -    interface, add %(rest) atom for ref-filter. "git for-each-ref",
     -    "git branch", "git tag" and "git verify-tag" will reject %(rest)
     -    by default.
     +    interface, add %(rest) atom for ref-filter. Introduce the
     +    reject_atom() to reject the atom %(rest) for "git for-each-ref",
     +    "git branch", "git tag" and "git verify-tag".
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
     @@ ref-filter.c: static struct {
       	/*
       	 * Please update $__git_ref_fieldlist in git-completion.bash
       	 * when you add new atoms
     +@@ ref-filter.c: static const char *find_next(const char *cp)
     + 	return NULL;
     + }
     + 
     ++static int reject_atom(enum atom_type atom_type)
     ++{
     ++	return atom_type == ATOM_REST;
     ++}
     ++
     + /*
     +  * Make sure the format string is well formed, and parse out
     +  * the used atoms.
      @@ ref-filter.c: int verify_ref_format(struct ref_format *format)
     + 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
       		if (at < 0)
       			die("%s", err.buf);
     ++		if (reject_atom(used_atom[at].atom_type))
     ++			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
       
     -+		if (used_atom[at].atom_type == ATOM_REST)
     -+			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
     -+
       		if ((format->quote_style == QUOTE_PYTHON ||
       		     format->quote_style == QUOTE_SHELL ||
     - 		     format->quote_style == QUOTE_TCL) &&
      @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
       			v->handler = else_atom_handler;
       			v->s = xstrdup("");
  8:  e1aca51d500 =  6:  c3378dbfaed [GSOC] ref-filter: pass get_object() return value to their callers
  9:  6ad42c96405 =  7:  e5cf5541024 [GSOC] ref-filter: introduce free_ref_array_item_value() function
 10:  b61d538d53d !  8:  bf052cc5d3f [GSOC] ref-filter: introduce reject_atom()
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC] ref-filter: introduce reject_atom()
     +    [GSOC] ref-filter: add cat_file_mode to ref_format
      
     -    Add `cat_file_mode` member in struct `ref_format` and introduce
     -    the function `reject_atom()`, when `cat-file --batch` use ref-filter
     -    logic later, it can help us reject atoms in verify_ref_format()
     -    which cat-file cannot use, e.g. `%(refname)`, `%(push)`,
     -    `%(upstream)`... or the atom `%(rest)` which for-each-ref family
     -    cannot use.
     +    Add `cat_file_mode` member to struct `ref_format`. When
     +    `cat-file --batch` use ref-filter logic later, it can help us
     +    reject atoms in verify_ref_format() which cat-file cannot use,
     +    e.g. `%(refname)`, `%(push)`, `%(upstream)"...
     +
     +    Add batch_test_atom() to t/t1006-cat-file.sh and add check
     +    for cat-file --batch, this can help us clearly show which
     +    atoms cat-file accepts and which atoms it rejects.
      
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     @@ ref-filter.c: static const char *find_next(const char *cp)
       	return NULL;
       }
       
     +-static int reject_atom(enum atom_type atom_type)
     +-{
     +-	return atom_type == ATOM_REST;
      +static int reject_atom(int cat_file_mode, enum atom_type atom_type)
      +{
      +	if (!cat_file_mode)
     @@ ref-filter.c: static const char *find_next(const char *cp)
      +	default:
      +		return 0;
      +	}
     -+}
     -+
     + }
     + 
       /*
     -  * Make sure the format string is well formed, and parse out
     -  * the used atoms.
      @@ ref-filter.c: int verify_ref_format(struct ref_format *format)
       		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
       		if (at < 0)
       			die("%s", err.buf);
     --
     --		if (used_atom[at].atom_type == ATOM_REST)
     --			die("this command reject atom %%(%.*s)", (int)(ep - sp - 2), sp + 2);
     +-		if (reject_atom(used_atom[at].atom_type))
      +		if (reject_atom(format->cat_file_mode, used_atom[at].atom_type))
     -+			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
     + 			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
       
       		if ((format->quote_style == QUOTE_PYTHON ||
     - 		     format->quote_style == QUOTE_SHELL ||
      
       ## ref-filter.h ##
      @@ ref-filter.h: struct ref_format {
     @@ ref-filter.h: struct ref_format {
       	int quote_style;
       	int use_rest;
       	int use_color;
     +
     + ## t/t1006-cat-file.sh ##
     +@@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch="batman" with --batch-all-objects will wor
     + 	cmp expect actual
     + '
     + 
     ++. "$TEST_DIRECTORY"/lib-gpg.sh
     ++. "$TEST_DIRECTORY"/lib-terminal.sh
     ++
     ++test_expect_success 'cat-file --batch|--batch-check setup' '
     ++	echo 1>blob1 &&
     ++	printf "a\0b\0\c" >blob2 &&
     ++	git add blob1 blob2 &&
     ++	git commit -m "Commit Message" &&
     ++	git branch -M main &&
     ++	git tag -a -m "v0.0.0" testtag &&
     ++	git update-ref refs/myblobs/blob1 HEAD:blob1 &&
     ++	git update-ref refs/myblobs/blob2 HEAD:blob2 &&
     ++	git update-ref refs/mytrees/tree1 HEAD^{tree}
     ++'
     ++
     ++batch_test_atom() {
     ++	if test "$3" = "fail"
     ++	then
     ++		test_expect_${4:-success} $PREREQ "basic atom: $1 $2 must fail" "
     ++			test_must_fail git cat-file --batch-check='$2' >bad <<-EOF
     ++			$1
     ++			EOF
     ++		"
     ++	else
     ++		test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
     ++			git for-each-ref --format='$2' $1 >expected &&
     ++			git cat-file --batch-check='$2' >actual <<-EOF &&
     ++			$1
     ++			EOF
     ++			sanitize_pgp <actual >actual.clean &&
     ++			cmp expected actual.clean
     ++		"
     ++	fi
     ++}
     ++
     ++batch_test_atom refs/heads/main '%(refname)' fail
     ++batch_test_atom refs/heads/main '%(refname:)' fail
     ++batch_test_atom refs/heads/main '%(refname:short)' fail
     ++batch_test_atom refs/heads/main '%(refname:lstrip=1)' fail
     ++batch_test_atom refs/heads/main '%(refname:lstrip=2)' fail
     ++batch_test_atom refs/heads/main '%(refname:lstrip=-1)' fail
     ++batch_test_atom refs/heads/main '%(refname:lstrip=-2)' fail
     ++batch_test_atom refs/heads/main '%(refname:rstrip=1)' fail
     ++batch_test_atom refs/heads/main '%(refname:rstrip=2)' fail
     ++batch_test_atom refs/heads/main '%(refname:rstrip=-1)' fail
     ++batch_test_atom refs/heads/main '%(refname:rstrip=-2)' fail
     ++batch_test_atom refs/heads/main '%(refname:strip=1)' fail
     ++batch_test_atom refs/heads/main '%(refname:strip=2)' fail
     ++batch_test_atom refs/heads/main '%(refname:strip=-1)' fail
     ++batch_test_atom refs/heads/main '%(refname:strip=-2)' fail
     ++batch_test_atom refs/heads/main '%(upstream)' fail
     ++batch_test_atom refs/heads/main '%(upstream:short)' fail
     ++batch_test_atom refs/heads/main '%(upstream:lstrip=2)' fail
     ++batch_test_atom refs/heads/main '%(upstream:lstrip=-2)' fail
     ++batch_test_atom refs/heads/main '%(upstream:rstrip=2)' fail
     ++batch_test_atom refs/heads/main '%(upstream:rstrip=-2)' fail
     ++batch_test_atom refs/heads/main '%(upstream:strip=2)' fail
     ++batch_test_atom refs/heads/main '%(upstream:strip=-2)' fail
     ++batch_test_atom refs/heads/main '%(push)' fail
     ++batch_test_atom refs/heads/main '%(push:short)' fail
     ++batch_test_atom refs/heads/main '%(push:lstrip=1)' fail
     ++batch_test_atom refs/heads/main '%(push:lstrip=-1)' fail
     ++batch_test_atom refs/heads/main '%(push:rstrip=1)' fail
     ++batch_test_atom refs/heads/main '%(push:rstrip=-1)' fail
     ++batch_test_atom refs/heads/main '%(push:strip=1)' fail
     ++batch_test_atom refs/heads/main '%(push:strip=-1)' fail
     ++batch_test_atom refs/heads/main '%(objecttype)'
     ++batch_test_atom refs/heads/main '%(objectsize)'
     ++batch_test_atom refs/heads/main '%(objectsize:disk)'
     ++batch_test_atom refs/heads/main '%(deltabase)'
     ++batch_test_atom refs/heads/main '%(objectname)'
     ++batch_test_atom refs/heads/main '%(objectname:short)' fail
     ++batch_test_atom refs/heads/main '%(objectname:short=1)' fail
     ++batch_test_atom refs/heads/main '%(objectname:short=10)' fail
     ++batch_test_atom refs/heads/main '%(tree)' fail
     ++batch_test_atom refs/heads/main '%(tree:short)' fail
     ++batch_test_atom refs/heads/main '%(tree:short=1)' fail
     ++batch_test_atom refs/heads/main '%(tree:short=10)' fail
     ++batch_test_atom refs/heads/main '%(parent)' fail
     ++batch_test_atom refs/heads/main '%(parent:short)' fail
     ++batch_test_atom refs/heads/main '%(parent:short=1)' fail
     ++batch_test_atom refs/heads/main '%(parent:short=10)' fail
     ++batch_test_atom refs/heads/main '%(numparent)' fail
     ++batch_test_atom refs/heads/main '%(object)' fail
     ++batch_test_atom refs/heads/main '%(type)' fail
     ++batch_test_atom refs/heads/main '%(raw)' fail
     ++batch_test_atom refs/heads/main '%(*objectname)' fail
     ++batch_test_atom refs/heads/main '%(*objecttype)' fail
     ++batch_test_atom refs/heads/main '%(author)' fail
     ++batch_test_atom refs/heads/main '%(authorname)' fail
     ++batch_test_atom refs/heads/main '%(authoremail)' fail
     ++batch_test_atom refs/heads/main '%(authoremail:trim)' fail
     ++batch_test_atom refs/heads/main '%(authoremail:localpart)' fail
     ++batch_test_atom refs/heads/main '%(authordate)' fail
     ++batch_test_atom refs/heads/main '%(committer)' fail
     ++batch_test_atom refs/heads/main '%(committername)' fail
     ++batch_test_atom refs/heads/main '%(committeremail)' fail
     ++batch_test_atom refs/heads/main '%(committeremail:trim)' fail
     ++batch_test_atom refs/heads/main '%(committeremail:localpart)' fail
     ++batch_test_atom refs/heads/main '%(committerdate)' fail
     ++batch_test_atom refs/heads/main '%(tag)' fail
     ++batch_test_atom refs/heads/main '%(tagger)' fail
     ++batch_test_atom refs/heads/main '%(taggername)' fail
     ++batch_test_atom refs/heads/main '%(taggeremail)' fail
     ++batch_test_atom refs/heads/main '%(taggeremail:trim)' fail
     ++batch_test_atom refs/heads/main '%(taggeremail:localpart)' fail
     ++batch_test_atom refs/heads/main '%(taggerdate)' fail
     ++batch_test_atom refs/heads/main '%(creator)' fail
     ++batch_test_atom refs/heads/main '%(creatordate)' fail
     ++batch_test_atom refs/heads/main '%(subject)' fail
     ++batch_test_atom refs/heads/main '%(subject:sanitize)' fail
     ++batch_test_atom refs/heads/main '%(contents:subject)' fail
     ++batch_test_atom refs/heads/main '%(body)' fail
     ++batch_test_atom refs/heads/main '%(contents:body)' fail
     ++batch_test_atom refs/heads/main '%(contents:signature)' fail
     ++batch_test_atom refs/heads/main '%(contents)' fail
     ++batch_test_atom refs/heads/main '%(HEAD)' fail
     ++batch_test_atom refs/heads/main '%(upstream:track)' fail
     ++batch_test_atom refs/heads/main '%(upstream:trackshort)' fail
     ++batch_test_atom refs/heads/main '%(upstream:track,nobracket)' fail
     ++batch_test_atom refs/heads/main '%(upstream:nobracket,track)' fail
     ++batch_test_atom refs/heads/main '%(push:track)' fail
     ++batch_test_atom refs/heads/main '%(push:trackshort)' fail
     ++batch_test_atom refs/heads/main '%(worktreepath)' fail
     ++batch_test_atom refs/heads/main '%(symref)' fail
     ++batch_test_atom refs/heads/main '%(flag)' fail
     ++
     ++batch_test_atom refs/tags/testtag '%(refname)' fail
     ++batch_test_atom refs/tags/testtag '%(refname:short)' fail
     ++batch_test_atom refs/tags/testtag '%(upstream)' fail
     ++batch_test_atom refs/tags/testtag '%(push)' fail
     ++batch_test_atom refs/tags/testtag '%(objecttype)'
     ++batch_test_atom refs/tags/testtag '%(objectsize)'
     ++batch_test_atom refs/tags/testtag '%(objectsize:disk)'
     ++batch_test_atom refs/tags/testtag '%(*objectsize:disk)' fail
     ++batch_test_atom refs/tags/testtag '%(deltabase)'
     ++batch_test_atom refs/tags/testtag '%(*deltabase)' fail
     ++batch_test_atom refs/tags/testtag '%(objectname)'
     ++batch_test_atom refs/tags/testtag '%(objectname:short)' fail
     ++batch_test_atom refs/tags/testtag '%(tree)' fail
     ++batch_test_atom refs/tags/testtag '%(tree:short)' fail
     ++batch_test_atom refs/tags/testtag '%(tree:short=1)' fail
     ++batch_test_atom refs/tags/testtag '%(tree:short=10)' fail
     ++batch_test_atom refs/tags/testtag '%(parent)' fail
     ++batch_test_atom refs/tags/testtag '%(parent:short)' fail
     ++batch_test_atom refs/tags/testtag '%(parent:short=1)' fail
     ++batch_test_atom refs/tags/testtag '%(parent:short=10)' fail
     ++batch_test_atom refs/tags/testtag '%(numparent)' fail
     ++batch_test_atom refs/tags/testtag '%(object)' fail
     ++batch_test_atom refs/tags/testtag '%(type)' fail
     ++batch_test_atom refs/tags/testtag '%(*objectname)' fail
     ++batch_test_atom refs/tags/testtag '%(*objecttype)' fail
     ++batch_test_atom refs/tags/testtag '%(author)' fail
     ++batch_test_atom refs/tags/testtag '%(authorname)' fail
     ++batch_test_atom refs/tags/testtag '%(authoremail)' fail
     ++batch_test_atom refs/tags/testtag '%(authoremail:trim)' fail
     ++batch_test_atom refs/tags/testtag '%(authoremail:localpart)' fail
     ++batch_test_atom refs/tags/testtag '%(authordate)' fail
     ++batch_test_atom refs/tags/testtag '%(committer)' fail
     ++batch_test_atom refs/tags/testtag '%(committername)' fail
     ++batch_test_atom refs/tags/testtag '%(committeremail)' fail
     ++batch_test_atom refs/tags/testtag '%(committeremail:trim)' fail
     ++batch_test_atom refs/tags/testtag '%(committeremail:localpart)' fail
     ++batch_test_atom refs/tags/testtag '%(committerdate)' fail
     ++batch_test_atom refs/tags/testtag '%(tag)' fail
     ++batch_test_atom refs/tags/testtag '%(tagger)' fail
     ++batch_test_atom refs/tags/testtag '%(taggername)' fail
     ++batch_test_atom refs/tags/testtag '%(taggeremail)' fail
     ++batch_test_atom refs/tags/testtag '%(taggeremail:trim)' fail
     ++batch_test_atom refs/tags/testtag '%(taggeremail:localpart)' fail
     ++batch_test_atom refs/tags/testtag '%(taggerdate)' fail
     ++batch_test_atom refs/tags/testtag '%(creator)' fail
     ++batch_test_atom refs/tags/testtag '%(creatordate)' fail
     ++batch_test_atom refs/tags/testtag '%(subject)' fail
     ++batch_test_atom refs/tags/testtag '%(subject:sanitize)' fail
     ++batch_test_atom refs/tags/testtag '%(contents:subject)' fail
     ++batch_test_atom refs/tags/testtag '%(body)' fail
     ++batch_test_atom refs/tags/testtag '%(contents:body)' fail
     ++batch_test_atom refs/tags/testtag '%(contents:signature)' fail
     ++batch_test_atom refs/tags/testtag '%(contents)' fail
     ++batch_test_atom refs/tags/testtag '%(HEAD)' fail
     ++
     ++batch_test_atom refs/myblobs/blob1 '%(refname)' fail
     ++batch_test_atom refs/myblobs/blob1 '%(upstream)' fail
     ++batch_test_atom refs/myblobs/blob1 '%(push)' fail
     ++batch_test_atom refs/myblobs/blob1 '%(HEAD)' fail
     ++
     ++batch_test_atom refs/myblobs/blob1 '%(objectname)'
     ++batch_test_atom refs/myblobs/blob1 '%(objecttype)'
     ++batch_test_atom refs/myblobs/blob1 '%(objectsize)'
     ++batch_test_atom refs/myblobs/blob1 '%(objectsize:disk)'
     ++batch_test_atom refs/myblobs/blob1 '%(deltabase)'
     ++
     ++batch_test_atom refs/myblobs/blob1 '%(contents)' fail
     ++batch_test_atom refs/myblobs/blob2 '%(contents)' fail
     ++
     ++batch_test_atom refs/myblobs/blob1 '%(raw)' fail
     ++batch_test_atom refs/myblobs/blob2 '%(raw)' fail
     ++batch_test_atom refs/mytrees/tree1 '%(raw)' fail
     ++
     ++batch_test_atom refs/myblobs/blob1 '%(raw:size)' fail
     ++batch_test_atom refs/myblobs/blob2 '%(raw:size)' fail
     ++batch_test_atom refs/mytrees/tree1 '%(raw:size)' fail
     ++
     ++batch_test_atom refs/myblobs/blob1 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)' fail
     ++batch_test_atom refs/myblobs/blob2 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)' fail
     ++batch_test_atom refs/mytrees/tree1 '%(if:equals=tree)%(objecttype)%(then)tree%(else)not tree%(end)' fail
     ++
     ++batch_test_atom refs/heads/main '%(align:60) objectname is %(objectname)%(end)|%(objectname)' fail
     ++batch_test_atom refs/heads/main '%(align:left,60) objectname is %(objectname)%(end)|%(objectname)' fail
     ++batch_test_atom refs/heads/main '%(align:middle,60) objectname is %(objectname)%(end)|%(objectname)' fail
     ++batch_test_atom refs/heads/main '%(align:60,right) objectname is %(objectname)%(end)|%(objectname)' fail
     ++
     ++batch_test_atom refs/heads/main 'VALID'
     ++batch_test_atom refs/heads/main '%(INVALID)' fail
     ++batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
     ++
     ++batch_test_atom refs/heads/main '%(objectname) %(objecttype) %(objectsize)
     ++%(raw)' fail
     ++batch_test_atom refs/tags/testtag '%(objectname) %(objecttype) %(objectsize)
     ++%(raw)' fail
     ++batch_test_atom refs/myblobs/blob1 '%(objectname) %(objecttype) %(objectsize)
     ++%(raw)' fail
     ++batch_test_atom refs/myblobs/blob2 '%(objectname) %(objecttype) %(objectsize)
     ++%(raw)' fail
     ++
     + test_done
 11:  790c558d7cc =  9:  7058f47d41d [GSOC] ref-filter: modify the error message and value in get_object
 12:  fca49379025 = 10:  3af0def894c [GSOC] cat-file: add has_object_file() check
 13:  43ce6bf2626 = 11:  c445fa6520b [GSOC] cat-file: change batch_objects parameter name
 18:  2edca9dc465 = 12:  ae3a7816013 [GSOC] cat-file: create p1006-cat-file.sh
 14:  70e83e4ba3c ! 13:  8b26c9e7455 [GSOC] cat-file: reuse ref-filter logic
     @@ Commit message
      
          The performance for `git cat-file --batch-all-objects
          --batch-check` on the Git repository itself with performance
     -    testing tool `hyperfine` changes from 669.4 ms ±  31.1 ms to
     -    1.134 s ±  0.063 s.
     +    testing tool `hyperfine` changes from 616.7 ms ± 8.9 ms to
     +    758.7 ms ± 16.4 ms.
      
          The performance for `git cat-file --batch-all-objects --batch
          >/dev/null` on the Git repository itself with performance testing
     -    tool `time` change from "27.37s user 0.29s system 98% cpu 28.089
     -    total" to "33.69s user 1.54s system 87% cpu 40.258 total".
     +    tool `time` change from "25.26s user 0.30s system 98% cpu 25.840 total"
     +    to "28.79s user 0.83s system 99% cpu 29.829 total".
     +
     +    The reasons for the performance degradation are as follows:
     +    1. There are a lot of data copies in the logic of ref-filter.
     +    2, In order to be able to support more useful formats, complex
     +    data structure and parsing process are used in ref-filter.
     +
     +    A later patch will add a fast path which will mitigate the
     +    performance regression introduced by this patch.
      
          Mentored-by: Christian Couder <christian.couder@gmail.com>
          Mentored-by: Hariom Verma <hariom18599@gmail.com>
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
       		die("git cat-file --allow-unknown-type: use with -s or -t");
      
       ## t/t1006-cat-file.sh ##
     -@@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch="batman" with --batch-all-objects will wor
     - 	git -C all-two cat-file --batch-all-objects --batch="batman" >actual &&
     - 	cmp expect actual
     - '
     -+. "$TEST_DIRECTORY"/lib-gpg.sh
     -+. "$TEST_DIRECTORY"/lib-terminal.sh
     -+
     -+test_expect_success 'cat-file --batch|--batch-check setup' '
     -+	echo 1>blob1 &&
     -+	printf "a\0b\0\c" >blob2 &&
     -+	git add blob1 blob2 &&
     -+	git commit -m "Commit Message" &&
     -+	git branch -M main &&
     -+	git tag -a -m "v0.0.0" testtag &&
     -+	git update-ref refs/myblobs/blob1 HEAD:blob1 &&
     -+	git update-ref refs/myblobs/blob2 HEAD:blob2 &&
     -+	git update-ref refs/mytrees/tree1 HEAD^{tree}
     -+'
     -+
     -+batch_test_atom() {
     -+	if test "$3" = "fail"
     -+	then
     -+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2 must fail" "
     -+			test_must_fail git cat-file --batch-check='$2' >bad <<-EOF
     -+			$1
     -+			EOF
     -+		"
     -+	else
     -+		test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
     -+			git for-each-ref --format='$2' $1 >expected &&
     -+			git cat-file --batch-check='$2' >actual <<-EOF &&
     -+			$1
     -+			EOF
     -+			sanitize_pgp <actual >actual.clean &&
     -+			cmp expected actual.clean
     -+		"
     -+	fi
     -+}
     -+
     -+batch_test_atom refs/heads/main '%(refname)' fail
     -+batch_test_atom refs/heads/main '%(refname:)' fail
     -+batch_test_atom refs/heads/main '%(refname:short)' fail
     -+batch_test_atom refs/heads/main '%(refname:lstrip=1)' fail
     -+batch_test_atom refs/heads/main '%(refname:lstrip=2)' fail
     -+batch_test_atom refs/heads/main '%(refname:lstrip=-1)' fail
     -+batch_test_atom refs/heads/main '%(refname:lstrip=-2)' fail
     -+batch_test_atom refs/heads/main '%(refname:rstrip=1)' fail
     -+batch_test_atom refs/heads/main '%(refname:rstrip=2)' fail
     -+batch_test_atom refs/heads/main '%(refname:rstrip=-1)' fail
     -+batch_test_atom refs/heads/main '%(refname:rstrip=-2)' fail
     -+batch_test_atom refs/heads/main '%(refname:strip=1)' fail
     -+batch_test_atom refs/heads/main '%(refname:strip=2)' fail
     -+batch_test_atom refs/heads/main '%(refname:strip=-1)' fail
     -+batch_test_atom refs/heads/main '%(refname:strip=-2)' fail
     -+batch_test_atom refs/heads/main '%(upstream)' fail
     -+batch_test_atom refs/heads/main '%(upstream:short)' fail
     -+batch_test_atom refs/heads/main '%(upstream:lstrip=2)' fail
     -+batch_test_atom refs/heads/main '%(upstream:lstrip=-2)' fail
     -+batch_test_atom refs/heads/main '%(upstream:rstrip=2)' fail
     -+batch_test_atom refs/heads/main '%(upstream:rstrip=-2)' fail
     -+batch_test_atom refs/heads/main '%(upstream:strip=2)' fail
     -+batch_test_atom refs/heads/main '%(upstream:strip=-2)' fail
     -+batch_test_atom refs/heads/main '%(push)' fail
     -+batch_test_atom refs/heads/main '%(push:short)' fail
     -+batch_test_atom refs/heads/main '%(push:lstrip=1)' fail
     -+batch_test_atom refs/heads/main '%(push:lstrip=-1)' fail
     -+batch_test_atom refs/heads/main '%(push:rstrip=1)' fail
     -+batch_test_atom refs/heads/main '%(push:rstrip=-1)' fail
     -+batch_test_atom refs/heads/main '%(push:strip=1)' fail
     -+batch_test_atom refs/heads/main '%(push:strip=-1)' fail
     -+batch_test_atom refs/heads/main '%(objecttype)'
     -+batch_test_atom refs/heads/main '%(objectsize)'
     -+batch_test_atom refs/heads/main '%(objectsize:disk)'
     -+batch_test_atom refs/heads/main '%(deltabase)'
     -+batch_test_atom refs/heads/main '%(objectname)'
     +@@ t/t1006-cat-file.sh: batch_test_atom refs/heads/main '%(objectsize)'
     + batch_test_atom refs/heads/main '%(objectsize:disk)'
     + batch_test_atom refs/heads/main '%(deltabase)'
     + batch_test_atom refs/heads/main '%(objectname)'
     +-batch_test_atom refs/heads/main '%(objectname:short)' fail
     +-batch_test_atom refs/heads/main '%(objectname:short=1)' fail
     +-batch_test_atom refs/heads/main '%(objectname:short=10)' fail
     +-batch_test_atom refs/heads/main '%(tree)' fail
     +-batch_test_atom refs/heads/main '%(tree:short)' fail
     +-batch_test_atom refs/heads/main '%(tree:short=1)' fail
     +-batch_test_atom refs/heads/main '%(tree:short=10)' fail
     +-batch_test_atom refs/heads/main '%(parent)' fail
     +-batch_test_atom refs/heads/main '%(parent:short)' fail
     +-batch_test_atom refs/heads/main '%(parent:short=1)' fail
     +-batch_test_atom refs/heads/main '%(parent:short=10)' fail
     +-batch_test_atom refs/heads/main '%(numparent)' fail
     +-batch_test_atom refs/heads/main '%(object)' fail
     +-batch_test_atom refs/heads/main '%(type)' fail
     +-batch_test_atom refs/heads/main '%(raw)' fail
     +-batch_test_atom refs/heads/main '%(*objectname)' fail
     +-batch_test_atom refs/heads/main '%(*objecttype)' fail
     +-batch_test_atom refs/heads/main '%(author)' fail
     +-batch_test_atom refs/heads/main '%(authorname)' fail
     +-batch_test_atom refs/heads/main '%(authoremail)' fail
     +-batch_test_atom refs/heads/main '%(authoremail:trim)' fail
     +-batch_test_atom refs/heads/main '%(authoremail:localpart)' fail
     +-batch_test_atom refs/heads/main '%(authordate)' fail
     +-batch_test_atom refs/heads/main '%(committer)' fail
     +-batch_test_atom refs/heads/main '%(committername)' fail
     +-batch_test_atom refs/heads/main '%(committeremail)' fail
     +-batch_test_atom refs/heads/main '%(committeremail:trim)' fail
     +-batch_test_atom refs/heads/main '%(committeremail:localpart)' fail
     +-batch_test_atom refs/heads/main '%(committerdate)' fail
     +-batch_test_atom refs/heads/main '%(tag)' fail
     +-batch_test_atom refs/heads/main '%(tagger)' fail
     +-batch_test_atom refs/heads/main '%(taggername)' fail
     +-batch_test_atom refs/heads/main '%(taggeremail)' fail
     +-batch_test_atom refs/heads/main '%(taggeremail:trim)' fail
     +-batch_test_atom refs/heads/main '%(taggeremail:localpart)' fail
     +-batch_test_atom refs/heads/main '%(taggerdate)' fail
     +-batch_test_atom refs/heads/main '%(creator)' fail
     +-batch_test_atom refs/heads/main '%(creatordate)' fail
     +-batch_test_atom refs/heads/main '%(subject)' fail
     +-batch_test_atom refs/heads/main '%(subject:sanitize)' fail
     +-batch_test_atom refs/heads/main '%(contents:subject)' fail
     +-batch_test_atom refs/heads/main '%(body)' fail
     +-batch_test_atom refs/heads/main '%(contents:body)' fail
     +-batch_test_atom refs/heads/main '%(contents:signature)' fail
     +-batch_test_atom refs/heads/main '%(contents)' fail
      +batch_test_atom refs/heads/main '%(objectname:short)'
      +batch_test_atom refs/heads/main '%(objectname:short=1)'
      +batch_test_atom refs/heads/main '%(objectname:short=10)'
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch="batman" with --batch
      +batch_test_atom refs/heads/main '%(contents:body)'
      +batch_test_atom refs/heads/main '%(contents:signature)'
      +batch_test_atom refs/heads/main '%(contents)'
     -+batch_test_atom refs/heads/main '%(HEAD)' fail
     -+batch_test_atom refs/heads/main '%(upstream:track)' fail
     -+batch_test_atom refs/heads/main '%(upstream:trackshort)' fail
     -+batch_test_atom refs/heads/main '%(upstream:track,nobracket)' fail
     -+batch_test_atom refs/heads/main '%(upstream:nobracket,track)' fail
     -+batch_test_atom refs/heads/main '%(push:track)' fail
     -+batch_test_atom refs/heads/main '%(push:trackshort)' fail
     -+batch_test_atom refs/heads/main '%(worktreepath)' fail
     -+batch_test_atom refs/heads/main '%(symref)' fail
     -+batch_test_atom refs/heads/main '%(flag)' fail
     -+
     -+batch_test_atom refs/tags/testtag '%(refname)' fail
     -+batch_test_atom refs/tags/testtag '%(refname:short)' fail
     -+batch_test_atom refs/tags/testtag '%(upstream)' fail
     -+batch_test_atom refs/tags/testtag '%(push)' fail
     -+batch_test_atom refs/tags/testtag '%(objecttype)'
     -+batch_test_atom refs/tags/testtag '%(objectsize)'
     -+batch_test_atom refs/tags/testtag '%(objectsize:disk)'
     + batch_test_atom refs/heads/main '%(HEAD)' fail
     + batch_test_atom refs/heads/main '%(upstream:track)' fail
     + batch_test_atom refs/heads/main '%(upstream:trackshort)' fail
     +@@ t/t1006-cat-file.sh: batch_test_atom refs/tags/testtag '%(push)' fail
     + batch_test_atom refs/tags/testtag '%(objecttype)'
     + batch_test_atom refs/tags/testtag '%(objectsize)'
     + batch_test_atom refs/tags/testtag '%(objectsize:disk)'
     +-batch_test_atom refs/tags/testtag '%(*objectsize:disk)' fail
      +batch_test_atom refs/tags/testtag '%(*objectsize:disk)'
     -+batch_test_atom refs/tags/testtag '%(deltabase)'
     + batch_test_atom refs/tags/testtag '%(deltabase)'
     +-batch_test_atom refs/tags/testtag '%(*deltabase)' fail
      +batch_test_atom refs/tags/testtag '%(*deltabase)'
     -+batch_test_atom refs/tags/testtag '%(objectname)'
     + batch_test_atom refs/tags/testtag '%(objectname)'
     +-batch_test_atom refs/tags/testtag '%(objectname:short)' fail
     +-batch_test_atom refs/tags/testtag '%(tree)' fail
     +-batch_test_atom refs/tags/testtag '%(tree:short)' fail
     +-batch_test_atom refs/tags/testtag '%(tree:short=1)' fail
     +-batch_test_atom refs/tags/testtag '%(tree:short=10)' fail
     +-batch_test_atom refs/tags/testtag '%(parent)' fail
     +-batch_test_atom refs/tags/testtag '%(parent:short)' fail
     +-batch_test_atom refs/tags/testtag '%(parent:short=1)' fail
     +-batch_test_atom refs/tags/testtag '%(parent:short=10)' fail
     +-batch_test_atom refs/tags/testtag '%(numparent)' fail
     +-batch_test_atom refs/tags/testtag '%(object)' fail
     +-batch_test_atom refs/tags/testtag '%(type)' fail
     +-batch_test_atom refs/tags/testtag '%(*objectname)' fail
     +-batch_test_atom refs/tags/testtag '%(*objecttype)' fail
     +-batch_test_atom refs/tags/testtag '%(author)' fail
     +-batch_test_atom refs/tags/testtag '%(authorname)' fail
     +-batch_test_atom refs/tags/testtag '%(authoremail)' fail
     +-batch_test_atom refs/tags/testtag '%(authoremail:trim)' fail
     +-batch_test_atom refs/tags/testtag '%(authoremail:localpart)' fail
     +-batch_test_atom refs/tags/testtag '%(authordate)' fail
     +-batch_test_atom refs/tags/testtag '%(committer)' fail
     +-batch_test_atom refs/tags/testtag '%(committername)' fail
     +-batch_test_atom refs/tags/testtag '%(committeremail)' fail
     +-batch_test_atom refs/tags/testtag '%(committeremail:trim)' fail
     +-batch_test_atom refs/tags/testtag '%(committeremail:localpart)' fail
     +-batch_test_atom refs/tags/testtag '%(committerdate)' fail
     +-batch_test_atom refs/tags/testtag '%(tag)' fail
     +-batch_test_atom refs/tags/testtag '%(tagger)' fail
     +-batch_test_atom refs/tags/testtag '%(taggername)' fail
     +-batch_test_atom refs/tags/testtag '%(taggeremail)' fail
     +-batch_test_atom refs/tags/testtag '%(taggeremail:trim)' fail
     +-batch_test_atom refs/tags/testtag '%(taggeremail:localpart)' fail
     +-batch_test_atom refs/tags/testtag '%(taggerdate)' fail
     +-batch_test_atom refs/tags/testtag '%(creator)' fail
     +-batch_test_atom refs/tags/testtag '%(creatordate)' fail
     +-batch_test_atom refs/tags/testtag '%(subject)' fail
     +-batch_test_atom refs/tags/testtag '%(subject:sanitize)' fail
     +-batch_test_atom refs/tags/testtag '%(contents:subject)' fail
     +-batch_test_atom refs/tags/testtag '%(body)' fail
     +-batch_test_atom refs/tags/testtag '%(contents:body)' fail
     +-batch_test_atom refs/tags/testtag '%(contents:signature)' fail
     +-batch_test_atom refs/tags/testtag '%(contents)' fail
      +batch_test_atom refs/tags/testtag '%(objectname:short)'
      +batch_test_atom refs/tags/testtag '%(tree)'
      +batch_test_atom refs/tags/testtag '%(tree:short)'
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch="batman" with --batch
      +batch_test_atom refs/tags/testtag '%(contents:body)'
      +batch_test_atom refs/tags/testtag '%(contents:signature)'
      +batch_test_atom refs/tags/testtag '%(contents)'
     -+batch_test_atom refs/tags/testtag '%(HEAD)' fail
     -+
     -+batch_test_atom refs/myblobs/blob1 '%(refname)' fail
     -+batch_test_atom refs/myblobs/blob1 '%(upstream)' fail
     -+batch_test_atom refs/myblobs/blob1 '%(push)' fail
     -+batch_test_atom refs/myblobs/blob1 '%(HEAD)' fail
     -+
     -+batch_test_atom refs/myblobs/blob1 '%(objectname)'
     -+batch_test_atom refs/myblobs/blob1 '%(objecttype)'
     -+batch_test_atom refs/myblobs/blob1 '%(objectsize)'
     -+batch_test_atom refs/myblobs/blob1 '%(objectsize:disk)'
     -+batch_test_atom refs/myblobs/blob1 '%(deltabase)'
     -+
     + batch_test_atom refs/tags/testtag '%(HEAD)' fail
     + 
     + batch_test_atom refs/myblobs/blob1 '%(refname)' fail
     +@@ t/t1006-cat-file.sh: batch_test_atom refs/myblobs/blob1 '%(objectsize)'
     + batch_test_atom refs/myblobs/blob1 '%(objectsize:disk)'
     + batch_test_atom refs/myblobs/blob1 '%(deltabase)'
     + 
     +-batch_test_atom refs/myblobs/blob1 '%(contents)' fail
     +-batch_test_atom refs/myblobs/blob2 '%(contents)' fail
      +batch_test_atom refs/myblobs/blob1 '%(contents)'
      +batch_test_atom refs/myblobs/blob2 '%(contents)'
     -+
     + 
     +-batch_test_atom refs/myblobs/blob1 '%(raw)' fail
     +-batch_test_atom refs/myblobs/blob2 '%(raw)' fail
     +-batch_test_atom refs/mytrees/tree1 '%(raw)' fail
      +batch_test_atom refs/myblobs/blob1 '%(raw)'
      +batch_test_atom refs/myblobs/blob2 '%(raw)'
      +batch_test_atom refs/mytrees/tree1 '%(raw)'
     -+
     + 
     +-batch_test_atom refs/myblobs/blob1 '%(raw:size)' fail
     +-batch_test_atom refs/myblobs/blob2 '%(raw:size)' fail
     +-batch_test_atom refs/mytrees/tree1 '%(raw:size)' fail
      +batch_test_atom refs/myblobs/blob1 '%(raw:size)'
      +batch_test_atom refs/myblobs/blob2 '%(raw:size)'
      +batch_test_atom refs/mytrees/tree1 '%(raw:size)'
     -+
     + 
     +-batch_test_atom refs/myblobs/blob1 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)' fail
     +-batch_test_atom refs/myblobs/blob2 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)' fail
     +-batch_test_atom refs/mytrees/tree1 '%(if:equals=tree)%(objecttype)%(then)tree%(else)not tree%(end)' fail
      +batch_test_atom refs/myblobs/blob1 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)'
      +batch_test_atom refs/myblobs/blob2 '%(if:equals=blob)%(objecttype)%(then)commit%(else)not commit%(end)'
      +batch_test_atom refs/mytrees/tree1 '%(if:equals=tree)%(objecttype)%(then)tree%(else)not tree%(end)'
     -+
     + 
     +-batch_test_atom refs/heads/main '%(align:60) objectname is %(objectname)%(end)|%(objectname)' fail
     +-batch_test_atom refs/heads/main '%(align:left,60) objectname is %(objectname)%(end)|%(objectname)' fail
     +-batch_test_atom refs/heads/main '%(align:middle,60) objectname is %(objectname)%(end)|%(objectname)' fail
     +-batch_test_atom refs/heads/main '%(align:60,right) objectname is %(objectname)%(end)|%(objectname)' fail
      +batch_test_atom refs/heads/main '%(align:60) objectname is %(objectname)%(end)|%(objectname)'
      +batch_test_atom refs/heads/main '%(align:left,60) objectname is %(objectname)%(end)|%(objectname)'
      +batch_test_atom refs/heads/main '%(align:middle,60) objectname is %(objectname)%(end)|%(objectname)'
      +batch_test_atom refs/heads/main '%(align:60,right) objectname is %(objectname)%(end)|%(objectname)'
     -+
     -+batch_test_atom refs/heads/main 'VALID'
     -+batch_test_atom refs/heads/main '%(INVALID)' fail
     -+batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
     -+
     -+test_expect_success '%(rest) works with both a branch and a tag' '
     -+	cat >expected <<-EOF &&
     -+	123 commit 123
     -+	456 tag 456
     -+	EOF
     -+	git cat-file --batch-check="%(rest) %(objecttype) %(rest)" >actual <<-EOF &&
     -+	refs/heads/main 123
     -+	refs/tags/testtag 456
     -+	EOF
     -+	test_cmp expected actual
     -+'
     -+
     -+batch_test_atom refs/heads/main '%(objectname) %(objecttype) %(objectsize)
     + 
     + batch_test_atom refs/heads/main 'VALID'
     + batch_test_atom refs/heads/main '%(INVALID)' fail
     + batch_test_atom refs/heads/main '%(authordate:INVALID)' fail
     + 
     + batch_test_atom refs/heads/main '%(objectname) %(objecttype) %(objectsize)
     +-%(raw)' fail
      +%(raw)'
     -+batch_test_atom refs/tags/testtag '%(objectname) %(objecttype) %(objectsize)
     + batch_test_atom refs/tags/testtag '%(objectname) %(objecttype) %(objectsize)
     +-%(raw)' fail
      +%(raw)'
     -+batch_test_atom refs/myblobs/blob1 '%(objectname) %(objecttype) %(objectsize)
     + batch_test_atom refs/myblobs/blob1 '%(objectname) %(objecttype) %(objectsize)
     +-%(raw)' fail
      +%(raw)'
     -+batch_test_atom refs/myblobs/blob2 '%(objectname) %(objecttype) %(objectsize)
     + batch_test_atom refs/myblobs/blob2 '%(objectname) %(objecttype) %(objectsize)
     +-%(raw)' fail
      +%(raw)'
      +
     -+
      +test_expect_success 'cat-file --batch equals to --batch-check with atoms' '
      +	git cat-file --batch-check="%(objectname) %(objecttype) %(objectsize)
      +%(raw)" >expected <<-EOF &&
 15:  e20780e9a6c = 14:  fd3901dfee6 [GSOC] cat-file: reuse err buf in batch_object_write()
 16:  fa74bf9451c = 15:  ed556e5f31e [GSOC] cat-file: re-implement --textconv, --filters options
 17:  ff74fa9f2f2 = 16:  96ef6431a2b [GSOC] ref-filter: remove grab_oid() function
 19:  c35e7dfe542 = 17:  5903d02324f [GSOC] cat-file: use fast path when using default_format

-- 
gitgitgadget
