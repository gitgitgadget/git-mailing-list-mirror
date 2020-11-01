Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE693C4741F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C02225C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8Bh5/2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKAR2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgKAR2v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD0EC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v5so7231952wmh.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J2bHyk7q0Of2rHY/K10KyRCB/J+mjA40WYX3In09Pb0=;
        b=U8Bh5/2tI90Mt8x8zPKPNNUq4f2W9WUE9lq4kkK+z+xvwx7qGcaKS6oKX/ED244hcb
         qpmiSt79XfcAA/ojJDJnp15FAh6G63AhNhgFkv6Ivh3f5ZeBcQIxC+rnVGnv0qYioaJx
         tDvVNfJGO5jrkhA1qE5CDVSNzobV80BDGwNZ7Tn4eKgg48jogKtvKAtXhKErGHXu7+aP
         oWln1Cp/ypcTXN+0aNnjAPhB8BiU0mDFDNOqJTvxETlO9pFxPo0V7rcB0j0XIBKPF+Ks
         ITB/O+B++kmc+X+AkLr9BXT8aK20pMG49loAj5XP+Fgcjq7cpBQ4f5EM9kk9GXo8Rano
         hW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J2bHyk7q0Of2rHY/K10KyRCB/J+mjA40WYX3In09Pb0=;
        b=HI3j1OyavGHk+BkgKqOQng5sMQws5CUWCe/kye8XYQy4YzmaVmgeURN8KOcqMbZ7+8
         eq1ro4GeeiO6Tl43QFA7OtUQybz5cUp9UvPSJA+G8oe5gIzeTWag07xm4Z8ycfzivYLx
         DOF5NXe1OMHmzTugksLbjCdfGGSP7x4IUIeBIMIA/mYLH/KRmN0i4pfdfuGCEnyRsojz
         NbmRxh0dTDf3/fmsFNEAt5hJiWx+Pn5Sr5U4TbUVItJ+Fimn2o1YNsqWTfoYofnAjIRC
         xlxtXYspM4CtMF+n/lj9ijuLA/YvBODkNUHw8jjx23hdJ4F+GrPZU5j6T3Wq2iwG3DEF
         A4Hw==
X-Gm-Message-State: AOAM5332XtKjl+pO84ILSvf9xPGWaDJo7JNdEqZGnTOTkIdqkEE+z1ck
        ztobUqee5qbY3jAtgG9QUoSyRCoLe7E=
X-Google-Smtp-Source: ABdhPJzYZS1UcD5KZyUjF8CUxQ2E/3hpKmB5Y+NpgTRSjUI8qjm/RwmHHJ9h1tUYujrpAR+tyYt6Nw==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr13244440wmb.141.1604251729180;
        Sun, 01 Nov 2020 09:28:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b63sm12987269wme.9.2020.11.01.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:48 -0800 (PST)
Message-Id: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.git.1603889270.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:39 +0000
Subject: [PATCH v2 0/8] blame: enable funcname blaming with userdiff driver
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 * patch 1: tweaked the message and took Junio's suggestion to only list the
   stuck form if the option in 'git-log' and 'gitk'.
 * patch 2: very minor formatting changes (removed double quotes)
 * patch 3: removed the parentheses as suggested by Junio, and did the same
   for git-log/gitk.
 * patch 4: grammar fix pointed out by Eric
 * patch 5: shortened the help text as suggested by Eric
 * patch 6: changed the approach by initializing 'sb.path' earlier in
   'cmd_blame', along with some of sb's other fields.
 * patches 7-8: new cleanup patches following the new patch 6 to simplify
   the interface of two functions in 'blame.c'


----------------------------------------------------------------------------

This series fixes a bug in git blame where any userdiff driver configured
via the attributes mechanism is ignored, which more often than not means
thatgit blame -L :<funcname> dies for paths that have a configured userdiff
driver. That's patch 6/6. 

Patches 1-5 are documentation improvements around the line-log
functionality.

Patches 7-8 are code clean-up patches following the changes in patch 6.

The fact that this bug has been present ever since git blame learned -L
:<funcname> makes me a little sad. I think that the fact that the diff 
attribute (either with a builtin userdiff pattern or with diff.*.xfuncname )
influences way more than just the hunk header, but also features like git
log -L, git blame -L, and the different options that I mention in patch 4/6,
is not well-known enough. I'm not saying the code or the doc is wrong, but I
think it's a visibility issue. Maybe more blog posts about that would
help.... I noticed that the "Git Attributes" chapter in the ProGit book [1]
does not even mention the builtin userdiff patterns, so I'll probably do a
PR there to mention it. Any other ideas for improving discoverability of
this very cool feature ?

[1] https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes

CC: Thomas Rast tr@thomasrast.ch [tr@thomasrast.ch], Eric Sunshine 
sunshine@sunshineco.com [sunshine@sunshineco.com], René Scharfe l.s.r@web.de
[l.s.r@web.de]

Philippe Blain (8):
  doc: log, gitk: move '-L' description to 'line-range-options.txt'
  doc: line-range: improve formatting
  blame-options.txt: also mention 'funcname' in '-L' description
  doc: add more pointers to gitattributes(5) for userdiff
  line-log: mention both modes in 'blame' and 'log' short help
  blame: enable funcname blaming with userdiff driver
  blame: simplify 'setup_scoreboard' interface
  blame: simplify 'setup_blame_bloom_data' interface

 Documentation/blame-options.txt      |  9 +++++----
 Documentation/diff-options.txt       |  5 ++++-
 Documentation/git-grep.txt           |  6 ++++--
 Documentation/git-log.txt            | 15 +--------------
 Documentation/gitk.txt               | 20 +-------------------
 Documentation/line-range-format.txt  | 28 +++++++++++++++-------------
 Documentation/line-range-options.txt | 15 +++++++++++++++
 blame.c                              | 16 +++++++---------
 blame.h                              |  4 +---
 builtin/blame.c                      | 11 ++++++-----
 builtin/log.c                        |  4 ++--
 t/annotate-tests.sh                  | 18 ++++++++++++++++++
 12 files changed, 79 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/line-range-options.txt


base-commit: 1d1c4a875900d69c7f0a31e44c3e370dc80ab1ce
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-774%2Fphil-blain%2Fblame-funcname-userdiff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-774/phil-blain/blame-funcname-userdiff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/774

Range-diff vs v1:

 1:  96f6f95abc ! 1:  b4fa5fb5ae doc: log, gitk: move '-L' description to 'line-range-options.txt'
     @@ Metadata
       ## Commit message ##
          doc: log, gitk: move '-L' description to 'line-range-options.txt'
      
     -    The description of the '-L' option for `git log` and `gitk` is the
     -    same, but is repeated in both 'git-log.txt' and 'gitk.txt'.
     +    The description of the '-L' option for `git log` and `gitk` is almost
     +    the same, but is repeated in both 'git-log.txt' and 'gitk.txt' (the
     +    difference being that 'git-log.txt' lists the option with a space
     +    after '-L', while 'gitk.txt' lists it as stuck and notes that `gitk`
     +    only understands the stuck form).
      
     -    Remove the duplication by creating a new file, 'line-range-options.txt',
     +    Reduce duplication by creating a new file, 'line-range-options.txt',
          and include it in both files.
      
     +    To simplify the presentation, only list the stuck form for both
     +    commands, and remove the note about `gitk` only understanding the stuck
     +    form.
     +
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Documentation/git-log.txt ##
     @@ Documentation/git-log.txt: produced by `--stat`, etc.
      -	`--name-only`, `--name-status`, `--check`) are not currently implemented.
      -+
      -include::line-range-format.txt[]
     -+:git-log: 1
      +include::line-range-options.txt[]
       
       <revision range>::
     @@ Documentation/gitk.txt: linkgit:git-rev-list[1] for a complete list.
      -*not* put a space after `-L`.
      -+
      -include::line-range-format.txt[]
     -+:gitk: 1
      +include::line-range-options.txt[]
       
       <revision range>::
     @@ Documentation/gitk.txt: linkgit:git-rev-list[1] for a complete list.
      
       ## Documentation/line-range-options.txt (new) ##
      @@
     -+ifdef::git-log[]
     -+-L <start>,<end>:<file>::
     -+-L :<funcname>:<file>::
     -+endif::git-log[]
     -+ifdef::gitk[]
      +-L<start>,<end>:<file>::
      +-L:<funcname>:<file>::
     -+endif::gitk[]
      +
      +	Trace the evolution of the line range given by "<start>,<end>"
      +	(or the function name regex <funcname>) within the <file>.  You may
     @@ Documentation/line-range-options.txt (new)
      +	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
      +	`--name-only`, `--name-status`, `--check`) are not currently implemented.
      ++
     -+ifdef::gitk[]
     -+*Note:* gitk (unlike linkgit:git-log[1]) currently only understands
     -+this option if you specify it "glued together" with its argument.  Do
     -+*not* put a space after `-L`.
     -+endif::gitk[]
     -++
      +include::line-range-format.txt[]
 2:  7d3fc0a503 ! 2:  6c44b1c576 doc: line-range: improve formatting
     @@ Documentation/line-range-format.txt
       
       +
      -If ``:<funcname>'' is given in place of <start> and <end>, it is a
     -+If "`:<funcname>`" is given in place of '<start>' and '<end>', it is a
     ++If `:<funcname>` is given in place of '<start>' and '<end>', it is a
       regular expression that denotes the range from the first funcname line
      -that matches <funcname>, up to the next funcname line. ``:<funcname>''
      +that matches '<funcname>', up to the next funcname line. `:<funcname>`
     @@ Documentation/line-range-format.txt
       file.
      
       ## Documentation/line-range-options.txt ##
     -@@ Documentation/line-range-options.txt: ifdef::gitk[]
     +@@
     + -L<start>,<end>:<file>::
       -L:<funcname>:<file>::
     - endif::gitk[]
       
      -	Trace the evolution of the line range given by "<start>,<end>"
      -	(or the function name regex <funcname>) within the <file>.  You may
     -+	Trace the evolution of the line range given by "'<start>,<end>'"
     ++	Trace the evolution of the line range given by '<start>,<end>'
      +	(or the function name regex '<funcname>') within the '<file>'. You may
       	not give any pathspec limiters.  This is currently limited to
       	a walk starting from a single revision, i.e., you may only
 3:  f7b64bf330 ! 3:  d38f0f7e26 blame-options.txt: also mention 'funcname' in '-L' description
     @@ Commit message
          '-L :<funcname>' by mentioning it at the beginnning of the description
          of the '-L' option.
      
     +    Also, in 'line-range-options.txt', which is used for git-log(1) and
     +    gitk(1), do not parenthesize the mention of the ':<funcname>' mode, to
     +    place it on equal footing with the '<start>,<end>' mode.
     +
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Documentation/blame-options.txt ##
     @@ Documentation/blame-options.txt
       -L :<funcname>::
      -	Annotate only the given line range. May be specified multiple times.
      -	Overlapping ranges are allowed.
     -+	Annotate only the line range given by '<start>,<end>'
     -+	(or by the function name regex '<funcname>').
     ++	Annotate only the line range given by '<start>,<end>',
     ++	or by the function name regex '<funcname>'.
      +	May be specified multiple times. Overlapping ranges are allowed.
       +
       '<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans from
       '<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
     +
     + ## Documentation/line-range-options.txt ##
     +@@
     + -L<start>,<end>:<file>::
     + -L:<funcname>:<file>::
     + 
     +-	Trace the evolution of the line range given by '<start>,<end>'
     +-	(or the function name regex '<funcname>') within the '<file>'. You may
     ++	Trace the evolution of the line range given by '<start>,<end>',
     ++	or by the function name regex '<funcname>', within the '<file>'. You may
     + 	not give any pathspec limiters.  This is currently limited to
     + 	a walk starting from a single revision, i.e., you may only
     + 	give zero or one positive revision arguments, and
 4:  da76a10717 ! 4:  9443a681e3 doc: add more pointers to gitattributes(5) for userdiff
     @@ Documentation/diff-options.txt: endif::git-format-patch[]
       -W::
       --function-context::
      -	Show whole surrounding functions of changes.
     -+	Show whole functions as context lines for each changes.
     ++	Show whole function as context lines for each change.
      +	The function names are determined in the same way as
      +	`git diff` works out patch hunk headers (see 'Defining a
      +	custom hunk-header' in linkgit:gitattributes[5]).
 5:  27ef94e9cc ! 5:  ae61d27a38 line-log: mention both modes in 'blame' and 'log' short help
     @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
       		OPT_CALLBACK_F('M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback),
      -		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
      +		OPT_STRING_LIST('L', NULL, &range_list, N_("range"),
     -+				N_("Process only the given line range (<range>=<start>,<end>) or function (<range>=:<funcname>)")),
     ++				N_("Process only line range <start>,<end> or function :<funcname>")),
       		OPT__ABBREV(&abbrev),
       		OPT_END()
       	};
     @@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, cons
      -		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
      -			     N_("Process line range n,m in file, counting from 1"),
      +		OPT_CALLBACK('L', NULL, &line_cb, "range:file",
     -+			     N_("Trace the evolution of the given line range (<range>=<start>,<end>) or function (<range>=:<funcname>) in <file>"),
     ++			     N_("Trace the evolution of line range <start>,<end> or function :<funcname> in <file>"),
       			     log_line_range_callback),
       		OPT_END()
       	};
 6:  a1e1c977d0 ! 6:  c77108e864 blame: enable funcname blaming with userdiff driver
     @@ Commit message
          funcname, 2013-03-28).
      
          Enable funcname blaming for paths using specific userdiff drivers by
     -    sending the local variable 'path' to 'parse_range_arg' instead of the
     -    yet unset 'sb.path'.
     +    initializing 'sb.path' earlier in 'cmd_blame', when some of its other
     +    fields are initialized, so that it is set when passed to
     +    'parse_range_arg'.
      
          Add a regression test in 'annotate-tests.sh', which is sourced in
          t8001-annotate.sh and t8002-blame.sh, leveraging an existing file used
          to test the userdiff patterns in t4018-diff-funcname.
      
     +    Also, use 'sb.path' instead of 'path' when constructing the error
     +    message at line 1114, for consistency.
     +
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## builtin/blame.c ##
      @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
     - 		long bottom, top;
     - 		if (parse_range_arg(range_list.items[range_i].string,
     - 				    nth_line_cb, &sb, lno, anchor,
     --				    &bottom, &top, sb.path,
     -+				    &bottom, &top, path,
     - 				    the_repository->index))
     - 			usage(blame_usage);
     + 	sb.contents_from = contents_from;
     + 	sb.reverse = reverse;
     + 	sb.repo = the_repository;
     ++	sb.path = path;
     + 	build_ignorelist(&sb, &ignore_revs_file_list, &ignore_rev_list);
     + 	string_list_clear(&ignore_revs_file_list, 0);
     + 	string_list_clear(&ignore_rev_list, 0);
     +@@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
       		if ((!lno && (top || bottom)) || lno < bottom)
     + 			die(Q_("file %s has only %lu line",
     + 			       "file %s has only %lu lines",
     +-			       lno), path, lno);
     ++			       lno), sb.path, lno);
     + 		if (bottom < 1)
     + 			bottom = 1;
     + 		if (top < 1 || lno < top)
     +@@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
     + 	string_list_clear(&range_list, 0);
     + 
     + 	sb.ent = NULL;
     +-	sb.path = path;
     + 
     + 	if (blame_move_score)
     + 		sb.move_score = blame_move_score;
      
       ## t/annotate-tests.sh ##
      @@ t/annotate-tests.sh: test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 -:  ---------- > 7:  3b28696e51 blame: simplify 'setup_scoreboard' interface
 -:  ---------- > 8:  7aca3274d2 blame: simplify 'setup_blame_bloom_data' interface

-- 
gitgitgadget
