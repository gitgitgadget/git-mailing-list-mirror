Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164BC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbiBHNOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350202AbiBHMOt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:14:49 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED523C03FECA
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:14:46 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y7so8406790plp.2
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:version:content-transfer-encoding;
        bh=rrvCUYNhlZftK7iQ3npZ6d2CXmyQoo84ZRBu32K3n44=;
        b=QVOXR7UsWfdDkJb3govrZWfkbPJembRiQT5PpgL1fZDnCPmNAg5Zd6rJVeLsSACWjC
         d7Fn28r3rs0dLHPiB6bLalcyovzs6FmGvN5zjyF3Vs72pcu6AloXw6Z/TVZWaF2aKl4f
         /yi5P3n7qmDsaaXxelMiImzxJTsXlfDHm9+JsM5jvHkzOaP+iP2rvT0Nff/yo2xtACJe
         xwCTFVOhDgrLorDin7OtlSOr5CZu4TJAnyR9hZWManhb+sAAcdCIFnFmKhMqsxeH6qSb
         CaxZti15eFAw90RAdOt7Y+ME29OqmI+LljYSvYSUw14imt/5pgBxCGoGP6E5Xtfcf1XM
         IuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:version:content-transfer-encoding;
        bh=rrvCUYNhlZftK7iQ3npZ6d2CXmyQoo84ZRBu32K3n44=;
        b=To6L6GFnyorakuR/GMj4fmGX6YYdwhnT2DtmqiLt9m2koVzZdt5VytrBv/rETzl5OC
         WM/F3I/V3bqHiNyuvPVZD7usAV2iiz1QltjAzkcnXNO97O3Ungolyi+RL24ME43Udf5O
         hY+/xth+AisalQylCNPdrva4efU3CWh9jY/IS16wmUDrDdvqQSvSyt7pBpOFTGKAN0cn
         zLO1Tw+g53l7trc1NIi1QRsx6X0ULfScbWZ8Atw4GjcBVXyw9unzbnVjDjUBums1IXQM
         Na3WXJz6+QDtB6AAHV6RK2KcXJVZ+1tdHeYOT/Alza/VWp+UTCYcBBXZVAtZQCVtEldu
         idWw==
X-Gm-Message-State: AOAM5304D/+LFvM3sEJQsAVOuiCorSh3u2QWg7tUcIS39XzqcjpxpJ45
        1GJe9K4bnkrWioH8qCGcJwQ=
X-Google-Smtp-Source: ABdhPJw4Y0weB0seMji5aohGZ+vCAZBmzM+tTEOI18hYaEZvPG4QZGPKhmUfHtXV2zR4YO/6ZYa7vQ==
X-Received: by 2002:a17:90a:5982:: with SMTP id l2mr1062272pji.100.1644322486061;
        Tue, 08 Feb 2022 04:14:46 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:14:45 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v11 00/13] ls-tree: "--object-only" and "--format" opts
Date:   Tue,  8 Feb 2022 20:14:25 +0800
Message-Id: <cover.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Main diffs from v10:

1. Remove commit b04188c822 (ls-tree: optimize naming and handling of "return" in
   show_tree()) and split to 2 new commits:
   		99e6d47108 (ls-tree: rename "retval" to "recurse" in "show_tree()")
		3816a65fe6 (simplify nesting if/else logic in "show_tree()")

   And also use existed `object_type()` instead of a new `get_type()` which bring by v10.

   These changes are based on Ævar Arnfjörð Bjarmason's suggestion on [1]. 

2. Better order of "--format" and "--object-only" features

   The v11 set `--format` before than `--object-only`, this make the patch progression
   much easier to read and let `--object-only` simplier to implement as a case of "--format".

   The change is based on Ævar Arnfjörð Bjarmason's suggestion on [2].

3. Replace to correct author names in partial commits.

   The change is based on Ævar Arnfjörð Bjarmason's suggestion on [3].

4. Changes on commit of "--format" feature.

   * Documentation bugfix:

     		  1) Add back the "\n" before "DESCRIPTION".
		  2) Use a simpler usage case instead of a fragile JSON example.
		  3) Other problems that be mentioned in [4].
   
   * Use a correspondingly uniform naming frame of the "fieldnames" instead of the old ones.

     	          1) mode   ->  objectmode
		  2) type   ->  objecttype
		  3) object ->  objectname
		  4) size   ->  objectsize
		  5) file   ->  path

   These changes are based on Ævar Arnfjörð Bjarmason's suggestion on [4].

5. Add more tests such as let "--format" combined with `-t`, `--full-tree` and `--full-name`. 

6. Add a new commit to introduce "fast_path()".

[1] https://public-inbox.org/git/220114.86ee5attm4.gmgdl@evledraar.gmail.com/
[2] https://public-inbox.org/git/CADMgQSSNQFHhf3=K+PiaoonBnheoDcoKpWy9-zjSu90d9rDY2w@mail.gmail.com/
[3] https://public-inbox.org/git/CADMgQSQaE4EtiNXyGKebPyPS_0YTQ=HN+dU89_jD6BgQ1C470A@mail.gmail.com/
[4] https://public-inbox.org/git/20220118125939.99956-1-dyroneteng@gmail.com/


Johannes Schindelin (1):
  cocci: allow padding with `strbuf_addf()`

Teng Long (6):
  ls-tree: rename "retval" to "recurse" in "show_tree()"
  ls-tree: simplify nesting if/else logic in "show_tree()"
  ls-tree: fix "--name-only" and "--long" combined use bug
  ls-tree: slightly refactor `show_tree()`
  ls-tree: introduce function "fast_path()"
  ls-tree.c: support --object-only option for "git-ls-tree"

Ævar Arnfjörð Bjarmason (6):
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
  ls-tree: introduce struct "show_tree_data"
  ls-tree.c: introduce "--format" option

 Documentation/git-ls-tree.txt   |  64 ++++++-
 builtin/ls-tree.c               | 322 +++++++++++++++++++++++++-------
 contrib/coccinelle/strbuf.cocci |   6 +-
 t/t3104-ls-tree-format.sh       |  93 +++++++++
 t/t3105-ls-tree-oid.sh          |  51 +++++
 5 files changed, 465 insertions(+), 71 deletions(-)
 create mode 100755 t/t3104-ls-tree-format.sh
 create mode 100755 t/t3105-ls-tree-oid.sh

Range-diff against v10:
 1:  b04188c822 <  -:  ---------- ls-tree: optimize naming and handling of "return" in show_tree()
 -:  ---------- >  1:  2fcff7e0d4 ls-tree: remove commented-out code
 -:  ---------- >  2:  6fd1dd9383 ls-tree: add missing braces to "else" arms
 -:  ---------- >  3:  208654b5e2 ls-tree: use "enum object_type", not {blob,tree,commit}_type
 -:  ---------- >  4:  2637464fd8 ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
 -:  ---------- >  5:  99e6d47108 ls-tree: rename "retval" to "recurse" in "show_tree()"
 -:  ---------- >  6:  3816a65fe6 ls-tree: simplify nesting if/else logic in "show_tree()"
 -:  ---------- >  7:  b22c2dc49e ls-tree: fix "--name-only" and "--long" combined use bug
 2:  bcfbc935b8 !  8:  41e8ed5047 ls-tree.c: support --object-only option for "git-ls-tree"
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    ls-tree.c: support --object-only option for "git-ls-tree"
    +    ls-treeMain diffs from v10:

1. Remove commit b04188c822 (ls-tree: optimize naming and handling of "return" in
   show_tree()) and split to 2 new commits:
                99e6d47108 (ls-tree: rename "retval" to "recurse" in "show_tree()")
                3816a65fe6 (simplify nesting if/else logic in "show_tree()")

   And also use existed `object_type()` instead of a new `get_type()` which bring by v10.

   These changes are based on Ævar Arnfjörð Bjarmason's suggestion on [1].

2. Better order of "--format" and "--object-only" features

   The v11 set `--format` before than `--object-only`, this make the patch progression
   much easier to read and let `--object-only` simplier to implement as a case of "--format".

   The change is based on Ævar Arnfjörð Bjarmason's suggestion on [2].

3. Fix the author'signs of som commits.

   The change is based on Ævar Arnfjörð Bjarmason's suggestion on [3].

4. Changes on commit of "--format" feature

   * Documentation bugfix:

                  1) Add back the "\n" before "DESCRIPTION".
                  2) Use a simplier usage case instead of a fragile JSON example.
                  3) Other problems that be mentioned in [4].

   * Use a correspondingly uniform naming frame of the "fieldnames" instead of the old ones.

                  1) mode   ->  objectmode
                  2) type   ->  objecttype
                  3) object ->  objectname
                  4) size   ->  objectsize
                  5) file   ->  path

   These changes are based on Ævar Arnfjörð Bjarmason's suggestion on [4].

5. Add more tests such like let "--format" combined with `-t`, `--full-tree` and `--full-name`.

6. Add a new commit to introduce "fast_path()".

[1] https://public-inbox.org/git/220114.86ee5attm4.gmgdl@evledraar.gmail.com/
[2] https://public-inbox.org/git/CADMgQSSNQFHhf3=K+PiaoonBnheoDcoKpWy9-zjSu90d9rDY2w@mail.gmail.com/
[3] https://public-inbox.org/git/CADMgQSQaE4EtiNXyGKebPyPS_0YTQ=HN+dU89_jD6BgQ1C470A@mail.gmail.com/
[4] https://public-inbox.org/git/20220118125939.99956-1-dyroneteng@gmail.com/: slightly refactor `show_tree()`
     
    -    We usually pipe the output from `git ls-trees` to tools like
    -    `sed` or `cut` when we only want to extract some fields.
    +    This is a non-functional change, we use a new int "shown_fields" to mark
    +    which columns to output, and `parse_shown_fields()` to calculate the
    +    value of "shown_fields".
     
    -    When we want only the pathname component, we can pass
    -    `--name-only` option to omit such a pipeline, but there are no
    -    options for extracting other fields.
    -
    -    Teach the "--object-only" option to the command to only show the
    -    object name. This option cannot be used together with
    -    "--name-only" or "--long" , they are mutually exclusive (actually
    -    "--name-only" and "--long" can be combined together before, this
    -    commit by the way fix this bug).
    -
    -    A simple refactoring was done to the "show_tree" function, intead by
    -    using bitwise operations to recognize the format for printing to
    -    stdout. The reason for doing this is that we don't want to increase
    -    the readability difficulty with the addition of "-object-only",
    -    making this part of the logic easier to read and expand.
    -
    -    In terms of performance, there is no loss comparing to the
    -    "master" (2ae0a9cb8298185a94e5998086f380a355dd8907), here are the
    -    results of the performance tests in my environment based on linux
    -    repository:
    -
    -        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    -        Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    -        Time (mean ± σ):     105.8 ms ±   2.7 ms    [User: 85.7 ms, System: 20.0 ms]
    -        Range (min … max):   101.5 ms … 111.3 ms    28 runs
    -
    -        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD"
    -        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD
    -        Time (mean ± σ):     105.0 ms ±   3.0 ms    [User: 83.7 ms, System: 21.2 ms]
    -        Range (min … max):    99.3 ms … 109.5 ms    27 runs
    -
    -        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
    -        Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    -        Time (mean ± σ):     337.4 ms ±  10.9 ms    [User: 308.3 ms, System: 29.0 ms]
    -        Range (min … max):   323.0 ms … 355.0 ms    10 runs
    -
    -        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD"
    -        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD
    -        Time (mean ± σ):     337.6 ms ±   6.2 ms    [User: 309.4 ms, System: 28.1 ms]
    -        Range (min … max):   330.4 ms … 349.9 ms    10 runs
    +    This has the advantage of making the show_tree logic simpler and more
    +    readable, as well as making it easier to extend new options (for example,
    +    if we want to add a "--object-only" option, we just need to add a similar
    +    "if (shown_fields == FIELD_OBJECT_NAME)" short-circuit logic in
    +    "show_tree()").
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    - ## Documentation/git-ls-tree.txt ##
    -@@ Documentation/git-ls-tree.txt: SYNOPSIS
    - --------
    - [verse]
    - 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
    --	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
    -+	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]]
    - 	    <tree-ish> [<path>...]
    - 
    - DESCRIPTION
    -@@ Documentation/git-ls-tree.txt: OPTIONS
    - --name-only::
    - --name-status::
    - 	List only filenames (instead of the "long" output), one per line.
    -+	Cannot be combined with `--object-only`.
    -+
    -+--object-only::
    -+	List only names of the objects, one per line. Cannot be combined
    -+	with `--name-only` or `--name-status`.
    - 
    - --abbrev[=<n>]::
    - 	Instead of showing the full 40-byte hexadecimal object
    -
      ## builtin/ls-tree.c ##
     @@
      
    @@ builtin/ls-tree.c
     +#define LS_SHOW_TREES (1 << 2)
     +#define LS_NAME_ONLY (1 << 3)
     +#define LS_SHOW_SIZE (1 << 4)
    -+#define LS_OBJECT_ONLY (1 << 5)
      static int abbrev;
      static int ls_options;
      static struct pathspec pathspec;
      static int chomp_prefix;
      static const char *ls_tree_prefix;
     +static unsigned int shown_fields;
    -+#define FIELD_FILE_NAME 1
    ++#define FIELD_PATH_NAME 1
     +#define FIELD_SIZE (1 << 1)
     +#define FIELD_OBJECT_NAME (1 << 2)
     +#define FIELD_TYPE (1 << 3)
    @@ builtin/ls-tree.c
      	NULL
      };
      
    --static int show_recursive(const char *base, size_t baselen, const char *pathname)
     +enum {
     +	MODE_UNSPECIFIED = 0,
     +	MODE_NAME_ONLY,
    -+	MODE_OBJECT_ONLY,
     +	MODE_LONG,
     +};
     +
    @@ builtin/ls-tree.c
     +static int parse_shown_fields(void)
     +{
     +	if (cmdmode == MODE_NAME_ONLY) {
    -+		shown_fields = FIELD_FILE_NAME;
    -+		return 0;
    -+	}
    -+	if (cmdmode == MODE_OBJECT_ONLY) {
    -+		shown_fields = FIELD_OBJECT_NAME;
    ++		shown_fields = FIELD_PATH_NAME;
     +		return 0;
     +	}
    ++
     +	if (!ls_options || (ls_options & LS_RECURSIVE)
     +	    || (ls_options & LS_SHOW_TREES)
     +	    || (ls_options & LS_TREE_ONLY))
    @@ builtin/ls-tree.c
     +	return 1;
     +}
     +
    -+static int show_recursive(const char *base, size_t baselen,
    -+			  const char *pathname)
    + static int show_recursive(const char *base, size_t baselen, const char *pathname)
      {
      	int i;
    - 
    -@@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
    - 	        : OBJ_BLOB);
    +@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
    + 	return 0;
      }
      
     +static int show_default(const struct object_id *oid, enum object_type type,
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -			printf("%06o %s %s\t", mode, type_name(type),
     -			       find_unique_abbrev(oid, abbrev));
     -		}
    -+	if (shown_fields == FIELD_OBJECT_NAME) {
    -+		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
    ++	if (shown_fields == FIELD_PATH_NAME) {
    ++		baselen = base->len;
    ++		strbuf_addstr(base, pathname);
    ++		write_name_quoted_relative(base->buf,
    ++					   chomp_prefix ? ls_tree_prefix : NULL,
    ++					   stdout, line_termination);
    ++		strbuf_setlen(base, baselen);
     +		return recurse;
      	}
     -	baselen = base->len;
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -				   stdout, line_termination);
     -	strbuf_setlen(base, baselen);
     +
    -+	if (shown_fields == FIELD_FILE_NAME) {
    -+		baselen = base->len;
    -+		strbuf_addstr(base, pathname);
    -+		write_name_quoted_relative(base->buf,
    -+					   chomp_prefix ? ls_tree_prefix : NULL,
    -+					   stdout, line_termination);
    -+		strbuf_setlen(base, baselen);
    -+		return recurse;
    -+	}
    -+
     +	if (shown_fields >= FIELD_DEFAULT)
     +		show_default(oid, type, pathname, mode, base);
     +
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      			LS_SHOW_TREES),
      		OPT_SET_INT('z', NULL, &line_termination,
      			    N_("terminate entries with NUL byte"), 0),
    --		OPT_BIT('l', "long", &ls_options, N_("include object size"),
    --			LS_SHOW_SIZE),
    --		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
    --			LS_NAME_ONLY),
    --		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
    --			LS_NAME_ONLY),
    +-		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
    +-			    LS_SHOW_SIZE),
    +-		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
    +-			    LS_NAME_ONLY),
    +-		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
    +-			    LS_NAME_ONLY),
     +		OPT_CMDMODE('l', "long", &cmdmode, N_("include object size"),
     +			    MODE_LONG),
     +		OPT_CMDMODE(0, "name-only", &cmdmode, N_("list only filenames"),
     +			    MODE_NAME_ONLY),
     +		OPT_CMDMODE(0, "name-status", &cmdmode, N_("list only filenames"),
     +			    MODE_NAME_ONLY),
    -+		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
    -+			    MODE_OBJECT_ONLY),
      		OPT_SET_INT(0, "full-name", &chomp_prefix,
      			    N_("use full path names"), 0),
      		OPT_BOOL(0, "full-tree", &full_tree,
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      	/*
      	 * show_recursive() rolls its own matching code and is
      	 * generally ignorant of 'struct pathspec'. The magic mask
    -
    - ## t/t3104-ls-tree-oid.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description='git ls-tree objects handling.'
    -+
    -+. ./test-lib.sh
    -+
    -+test_expect_success 'setup' '
    -+	test_commit A &&
    -+	test_commit B &&
    -+	mkdir -p C &&
    -+	test_commit C/D.txt &&
    -+	find *.txt path* \( -type f -o -type l \) -print |
    -+	xargs git update-index --add &&
    -+	tree=$(git write-tree) &&
    -+	echo $tree
    -+'
    -+
    -+test_expect_success 'usage: --object-only' '
    -+	git ls-tree --object-only $tree >current &&
    -+	git ls-tree $tree >result &&
    -+	cut -f1 result | cut -d " " -f3 >expected &&
    -+	test_cmp current expected
    -+'
    -+
    -+test_expect_success 'usage: --object-only with -r' '
    -+	git ls-tree --object-only -r $tree >current &&
    -+	git ls-tree -r $tree >result &&
    -+	cut -f1 result | cut -d " " -f3 >expected &&
    -+	test_cmp current expected
    -+'
    -+
    -+test_expect_success 'usage: --object-only with --abbrev' '
    -+	git ls-tree --object-only --abbrev=6 $tree >current &&
    -+	git ls-tree --abbrev=6 $tree >result &&
    -+	cut -f1 result | cut -d " " -f3 >expected &&
    -+	test_cmp current expected
    -+'
    -+
    -+test_expect_success 'usage: incompatible options: --name-only with --object-only' '
    -+	test_expect_code 129 git ls-tree --object-only --name-only $tree
    -+'
    -+
    -+test_expect_success 'usage: incompatible options: --name-status with --object-only' '
    -+	test_expect_code 129 git ls-tree --object-only --name-status $tree
    -+'
    -+
    -+test_expect_success 'usage: incompatible options: --long with --object-only' '
    -+	test_expect_code 129 git ls-tree --object-only --long $tree
    -+'
    -+
    -+test_done
 3:  3ddffa1027 !  9:  46e10a5392 ls-tree.c: introduce struct "show_tree_data"
    @@
      ## Metadata ##
    -Author: Teng Long <dyroneteng@gmail.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    ls-tree.c: introduce struct "show_tree_data"
    +    ls-tree: introduce struct "show_tree_data"
     
         "show_tree_data" is a struct that packages the necessary fields for
         "show_tree()". This commit is a pre-prepared commit for supporting
         "--format" option and it does not affect any existing functionality.
     
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## builtin/ls-tree.c ##
    @@ builtin/ls-tree.c: static unsigned int shown_fields;
      static const  char * const ls_tree_usage[] = {
      	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
      	NULL
    -@@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
    - 	        : OBJ_BLOB);
    +@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
    + 	return 0;
      }
      
     -static int show_default(const struct object_id *oid, enum object_type type,
    @@ builtin/ls-tree.c: static int show_default(const struct object_id *oid, enum obj
      }
      
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    + 	int recurse = 0;
      	size_t baselen;
    - 	enum object_type type = get_type(mode);
    - 
    + 	enum object_type type = object_type(mode);
     +	struct show_tree_data data = {
     +		.mode = mode,
     +		.type = type,
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     +		.pathname = pathname,
     +		.base = base,
     +	};
    -+
    + 
      	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
      		recurse = READ_TREE_RECURSIVE;
    - 	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
      	}
      
 4:  4b58a707c2 ! 10:  c04320b801 cocci: allow padding with `strbuf_addf()`
    @@
      ## Metadata ##
    -Author: Teng Long <dyroneteng@gmail.com>
    +Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     
      ## Commit message ##
         cocci: allow padding with `strbuf_addf()`
 5:  db058bf670 ! 11:  5936004f13 ls-tree.c: introduce "--format" option
    @@
      ## Metadata ##
    -Author: Teng Long <dyroneteng@gmail.com>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
         ls-tree.c: introduce "--format" option
    @@ Commit message
         Links:
                 [1] https://public-inbox.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/
     
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## Documentation/git-ls-tree.txt ##
    @@ Documentation/git-ls-tree.txt: SYNOPSIS
      --------
      [verse]
      'git ls-tree' [-d] [-r] [-t] [-l] [-z]
    --	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]]
    --	    <tree-ish> [<path>...]
    --
    -+	    [--name-only] [--name-status] [--object-only]
    -+	    [--full-name] [--full-tree] [--abbrev[=<n>]]
    -+	    [--format=<format>] <tree-ish> [<path>...]
    +-	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
    ++	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
    + 	    <tree-ish> [<path>...]
    + 
      DESCRIPTION
    - -----------
    - Lists the contents of a given tree object, like what "/bin/ls -a" does
     @@ Documentation/git-ls-tree.txt: OPTIONS
      	Do not limit the listing to the current working directory.
      	Implies --full-name.
    @@ Documentation/git-ls-tree.txt: OPTIONS
      
      Output Format
      -------------
    +-        <mode> SP <type> SP <object> TAB <file>
    ++
    ++The output format of `ls-tree` is determined by either the `--format`
    ++option, or other format-altering options such as `--name-only` etc.
    ++(see `--format` above).
     +
    -+Default format:
    ++The use of certain `--format` directives is equivalent to using those
    ++options, but invoking the full formatting machinery can be slower than
    ++using an appropriate formatting option.
     +
    -         <mode> SP <type> SP <object> TAB <file>
    ++In cases where the `--format` would exactly map to an existing option
    ++`ls-tree` will use the appropriate faster path. Thus the default format
    ++is equivalent to:
    ++
    ++        %(objectmode) %(objecttype) %(objectname)%x09%(path)
      
      This output format is compatible with what `--index-info --stdin` of
    + 'git update-index' expects.
    + 
    + When the `-l` option is used, format changes to
    + 
    +-        <mode> SP <type> SP <object> SP <object size> TAB <file>
    ++        %(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)
    + 
    +-Object size identified by <object> is given in bytes, and right-justified
    ++Object size identified by <objectname> is given in bytes, and right-justified
    + with minimum width of 7 characters.  Object size is given only for blobs
    + (file) entries; for other entries `-` character is used in place of size.
    + 
     @@ Documentation/git-ls-tree.txt: quoted as explained for the configuration variable `core.quotePath`
      (see linkgit:git-config[1]).  Using `-z` the filename is output
      verbatim and the line is terminated by a NUL byte.
    @@ Documentation/git-ls-tree.txt: quoted as explained for the configuration variabl
     +
     +It is possible to print in a custom format by using the `--format` option,
     +which is able to interpolate different fields using a `%(fieldname)` notation.
    -+For example, if you want to only print the <object> and <file> fields with a
    -+JSON style, executing with a specific "--format" like
    -+
    -+        git ls-tree --format='{"object":"%(object)", "file":"%(file)"}' <tree-ish>
    ++For example, if you only care about the "objectname" and "path" fields, you
    ++can execute with a specific "--format" like
     +
    -+The output format changes to:
    -+
    -+        {"object":"<object>", "file":"<file>"}
    ++        git ls-tree --format='%(objectname) %(path)' <tree-ish>
     +
     +FIELD NAMES
     +-----------
    @@ Documentation/git-ls-tree.txt: quoted as explained for the configuration variabl
     +into the resulting output. For each outputing line, the following
     +names can be used:
     +
    -+mode::
    ++objectmode::
     +	The mode of the object.
    -+type::
    ++objecttype::
     +	The type of the object (`blob` or `tree`).
    -+object::
    ++objectname::
     +	The name of the object.
    -+size[:padded]::
    ++objectsize[:padded]::
     +	The size of the object ("-" if it's a tree).
     +	It also supports a padded format of size with "%(size:padded)".
    -+file::
    -+	The filename of the object.
    ++path::
    ++	The pathname of the object.
     +
      GIT
      ---
      Part of the linkgit:git[1] suite
     
      ## builtin/ls-tree.c ##
    +@@ builtin/ls-tree.c: static unsigned int shown_fields;
    + #define FIELD_MODE (1 << 4)
    + #define FIELD_DEFAULT 29 /* 11101 size is not shown to output by default */
    + #define FIELD_LONG_DEFAULT  (FIELD_DEFAULT | FIELD_SIZE)
    +-
    ++static const char *format;
    ++static const char *default_format = "%(objectmode) %(objecttype) %(objectname)%x09%(path)";
    ++static const char *long_format = "%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)";
    ++static const char *name_only_format = "%(path)";
    + struct show_tree_data {
    + 	unsigned mode;
    + 	enum object_type type;
     @@ builtin/ls-tree.c: enum {
      
      static int cmdmode = MODE_UNSPECIFIED;
      
    -+static const char *format;
    -+static const char *default_format = "%(mode) %(type) %(object)%x09%(file)";
    -+static const char *long_format = "%(mode) %(type) %(object) %(size:padded)%x09%(file)";
    -+static const char *name_only_format = "%(file)";
    -+static const char *object_only_format = "%(object)";
    -+
    - static int parse_shown_fields(void)
    - {
    - 	if (cmdmode == MODE_NAME_ONLY) {
    -@@ builtin/ls-tree.c: static int parse_shown_fields(void)
    - 	return 1;
    - }
    - 
     +static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
     +			      const enum object_type type, unsigned int padded)
     +{
    @@ builtin/ls-tree.c: static int parse_shown_fields(void)
     +			die(_("could not get object info about '%s'"),
     +			    oid_to_hex(oid));
     +		if (padded)
    -+			strbuf_addf(line, "%7" PRIuMAX, (uintmax_t)size);
    ++			strbuf_addf(line, "%7"PRIuMAX, (uintmax_t)size);
     +		else
    -+			strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
    ++			strbuf_addf(line, "%"PRIuMAX, (uintmax_t)size);
     +	} else if (padded) {
     +		strbuf_addf(line, "%7s", "-");
     +	} else {
    @@ builtin/ls-tree.c: static int parse_shown_fields(void)
     +	}
     +}
     +
    -+static size_t expand_show_tree(struct strbuf *line, const char *start,
    ++static size_t expand_show_tree(struct strbuf *sb, const char *start,
     +			       void *context)
     +{
     +	struct show_tree_data *data = context;
     +	const char *end;
     +	const char *p;
     +	unsigned int errlen;
    -+	size_t len = strbuf_expand_literal_cb(line, start, NULL);
    ++	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
     +
     +	if (len)
     +		return len;
    @@ builtin/ls-tree.c: static int parse_shown_fields(void)
     +		die(_("bad ls-tree format: element '%s' does not end in ')'"), start);
     +
     +	len = end - start + 1;
    -+	if (skip_prefix(start, "(mode)", &p)) {
    -+		strbuf_addf(line, "%06o", data->mode);
    -+	} else if (skip_prefix(start, "(type)", &p)) {
    -+		strbuf_addstr(line, type_name(data->type));
    -+	} else if (skip_prefix(start, "(size:padded)", &p)) {
    -+		expand_objectsize(line, data->oid, data->type, 1);
    -+	} else if (skip_prefix(start, "(size)", &p)) {
    -+		expand_objectsize(line, data->oid, data->type, 0);
    -+	} else if (skip_prefix(start, "(object)", &p)) {
    -+		strbuf_add_unique_abbrev(line, data->oid, abbrev);
    -+	} else if (skip_prefix(start, "(file)", &p)) {
    ++	if (skip_prefix(start, "(objectmode)", &p)) {
    ++		strbuf_addf(sb, "%06o", data->mode);
    ++	} else if (skip_prefix(start, "(objecttype)", &p)) {
    ++		strbuf_addstr(sb, type_name(data->type));
    ++	} else if (skip_prefix(start, "(objectsize:padded)", &p)) {
    ++		expand_objectsize(sb, data->oid, data->type, 1);
    ++	} else if (skip_prefix(start, "(objectsize)", &p)) {
    ++		expand_objectsize(sb, data->oid, data->type, 0);
    ++	} else if (skip_prefix(start, "(objectname)", &p)) {
    ++		strbuf_add_unique_abbrev(sb, data->oid, abbrev);
    ++	} else if (skip_prefix(start, "(path)", &p)) {
     +		const char *name = data->base->buf;
     +		const char *prefix = chomp_prefix ? ls_tree_prefix : NULL;
     +		struct strbuf quoted = STRBUF_INIT;
    -+		struct strbuf sb = STRBUF_INIT;
    ++		struct strbuf sbuf = STRBUF_INIT;
     +		strbuf_addstr(data->base, data->pathname);
    -+		name = relative_path(data->base->buf, prefix, &sb);
    ++		name = relative_path(data->base->buf, prefix, &sbuf);
     +		quote_c_style(name, &quoted, NULL, 0);
    -+		strbuf_addbuf(line, &quoted);
    -+		strbuf_release(&sb);
    ++		strbuf_addbuf(sb, &quoted);
    ++		strbuf_release(&sbuf);
     +		strbuf_release(&quoted);
     +	} else {
     +		errlen = (unsigned long)len;
    @@ builtin/ls-tree.c: static int parse_shown_fields(void)
     +	return len;
     +}
     +
    - static int show_recursive(const char *base, size_t baselen,
    - 			  const char *pathname)
    + static int parse_shown_fields(void)
      {
    -@@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
    - 	        : OBJ_BLOB);
    + 	if (cmdmode == MODE_NAME_ONLY) {
    +@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
    + 	return 0;
      }
      
     +static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
    @@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
     +{
     +	size_t baselen;
     +	int recurse = 0;
    -+	struct strbuf line = STRBUF_INIT;
    -+	enum object_type type = get_type(mode);
    ++	struct strbuf sb = STRBUF_INIT;
    ++	enum object_type type = object_type(mode);
     +
     +	struct show_tree_data data = {
     +		.mode = mode,
    @@ builtin/ls-tree.c: static enum object_type get_type(unsigned int mode)
     +		return 0;
     +
     +	baselen = base->len;
    -+	strbuf_expand(&line, format, expand_show_tree, &data);
    -+	strbuf_addch(&line, line_termination);
    -+	fwrite(line.buf, line.len, 1, stdout);
    -+	strbuf_release(&line);
    ++	strbuf_expand(&sb, format, expand_show_tree, &data);
    ++	strbuf_addch(&sb, line_termination);
    ++	fwrite(sb.buf, sb.len, 1, stdout);
    ++	strbuf_release(&sb);
     +	strbuf_setlen(base, baselen);
     +	return recurse;
     +}
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      			 N_("list entire tree; not just current directory "
      			    "(implies --full-name)")),
     +		OPT_STRING_F(0, "format", &format, N_("format"),
    -+			     N_("format to use for the output"),
    -+			     PARSE_OPT_NONEG),
    ++					 N_("format to use for the output"),
    ++					 PARSE_OPT_NONEG),
      		OPT__ABBREV(&abbrev),
      		OPT_END()
      	};
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		die("not a tree object");
     -	return !!read_tree(the_repository, tree,
     -			   &pathspec, show_tree, NULL);
    -+
     +	/*
     +	 * The generic show_tree_fmt() is slower than show_tree(), so
     +	 * take the fast path if possible.
     +	 */
    -+	if (format &&
    -+	    (!strcmp(format, default_format) ||
    -+	     !strcmp(format, long_format) ||
    -+	     !strcmp(format, name_only_format) ||
    -+	     !strcmp(format, object_only_format)))
    ++	if (format && (!strcmp(format, default_format))) {
    ++		fn = show_tree;
    ++	} else if (format && (!strcmp(format, long_format))) {
    ++		shown_fields = shown_fields | FIELD_SIZE;
     +		fn = show_tree;
    -+	else if (format)
    ++	} else if (format && (!strcmp(format, name_only_format))) {
    ++		shown_fields = FIELD_PATH_NAME;
    ++		fn = show_tree;
    ++	} else if (format)
     +		fn = show_tree_fmt;
     +
     +	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
      }
     
    - ## t/t3105-ls-tree-format.sh (new) ##
    + ## t/t3104-ls-tree-format.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t3105-ls-tree-format.sh (new)
     +test_expect_success 'ls-tree --format usage' '
     +	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
     +	test_expect_code 129 git ls-tree --format=fmt --name-only HEAD &&
    -+	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD &&
    -+	test_expect_code 129 git ls-tree --format=fmt --object-only HEAD
    ++	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD
     +'
     +
     +test_expect_success 'setup' '
    @@ t/t3105-ls-tree-format.sh (new)
     +test_ls_tree_format () {
     +	format=$1 &&
     +	opts=$2 &&
    ++	fmtopts=$3 &&
     +	shift 2 &&
     +	git ls-tree $opts -r HEAD >expect.raw &&
     +	sed "s/^/> /" >expect <expect.raw &&
    -+	git ls-tree --format="> $format" -r HEAD >actual &&
    ++	git ls-tree --format="> $format" -r $fmtopts HEAD >actual &&
     +	test_cmp expect actual
     +}
     +
     +test_expect_success 'ls-tree --format=<default-like>' '
     +	test_ls_tree_format \
    -+		"%(mode) %(type) %(object)%x09%(file)" \
    ++		"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
     +		""
     +'
     +
     +test_expect_success 'ls-tree --format=<long-like>' '
     +	test_ls_tree_format \
    -+		"%(mode) %(type) %(object) %(size:padded)%x09%(file)" \
    ++		"%(objectmode) %(objecttype) %(objectname) %(objectsize:padded)%x09%(path)" \
     +		"--long"
     +'
     +
     +test_expect_success 'ls-tree --format=<name-only-like>' '
     +	test_ls_tree_format \
    -+		"%(file)" \
    ++		"%(path)" \
     +		"--name-only"
     +'
     +
    -+test_expect_success 'ls-tree --format=<object-only-like>' '
    ++test_expect_success 'ls-tree combine --format=<default-like> and -t' '
    ++	test_ls_tree_format \
    ++	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    ++	"-t" \
    ++	"-t"
    ++'
    ++
    ++test_expect_success 'ls-tree combine --format=<default-like> and --full-name' '
     +	test_ls_tree_format \
    -+		"%(object)" \
    -+		"--object-only"
    ++	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    ++	"--full-name" \
    ++	"--full-name"
     +'
     +
    ++test_expect_success 'ls-tree combine --format=<default-like> and --full-tree' '
    ++	test_ls_tree_format \
    ++	"%(objectmode) %(objecttype) %(objectname)%x09%(path)" \
    ++	"--full-tree" \
    ++	"--full-tree"
    ++'
    ++
    ++test_expect_success 'ls-tree hit fast-path with --format=<default-like>' '
    ++	git ls-tree -r HEAD >expect &&
    ++	git ls-tree --format="%(objectmode) %(objecttype) %(objectname)%x09%(path)" -r HEAD >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'ls-tree hit fast-path with --format=<name-only-like>' '
    ++	git ls-tree -r --name-only HEAD >expect &&
    ++	git ls-tree --format="%(path)" -r HEAD >actual &&
    ++	test_cmp expect actual
    ++'
     +test_done
 -:  ---------- > 12:  6d26497749 ls-tree: introduce function "fast_path()"
 -:  ---------- > 13:  e6d98f2560 ls-tree.c: support --object-only option for "git-ls-tree"
-- 
2.34.1.403.gb35f2687cf.dirty

