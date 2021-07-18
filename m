Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C80C636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DC761179
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhGRIBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGRIBN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 04:01:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A9BC061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id g12so8365135wme.2
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slImhE+pD/fRrIpYitx4DXOtsizwqNn46KGxhRbtbLE=;
        b=PaAwFdg6cIGuid/vBfjIXCY8LnNQ8VzQafcyslXMdgak9A8ZjbGouh/X5Ikh5hq4i6
         eBJglQsIwLblUF2PYOuDpHk1eRB4A/vjvBbxR3uSMxXL06htELyqlKd02hc9BAQgeBAl
         rGvQfeis7GDUjiWaOuTZdpqVUVKsLuUEhvCee2jD+5LXYc6XkMqJ+37k43a/25t+8kEa
         7O8IM/9LtndvKpSFlucpc+MvH3iHqEkzaFU+tqQ7XSLHtJqfBNjOKxv1qLsEyz0uPRt7
         7EOi7frzD844AMC5NAwpeGcMg3bz7rDdKP2NNeE15z0QeAP4nXxg1A6EpDT1XnyfsYvp
         mVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slImhE+pD/fRrIpYitx4DXOtsizwqNn46KGxhRbtbLE=;
        b=JrxmXaXJbfePXP+ZWG5gwYxROTd1zUOwoM5k+47iGeuImbK9CpSEN7kDYvTwKQrnRk
         w+wIRz78v6q4FOsASxRywTS4bPuRJ++0Dg6LvMsMRG72LuuVX4DpQ6/YrgMAWFXPvLUO
         YOGHKFfFuefWpxvL8UOpD+ezYmNLVcxxIvwkp2t3Oo5pXcoaxML+SLzyr+OT80SvAt8A
         IOFN5JJmuXyYeu1R7H6T6ed0RWqhnuAZ3a7J7Chnzdzp/tkHWxLTm0uU+PgG7SGHwf3M
         bsLoQYy5gX821LYh3QuYDrWjoqFfq0hj4fswum5FiX588WhqSuI8QfogTwSKXH//M+CM
         9NDw==
X-Gm-Message-State: AOAM533mCHcmYirGeBRfcKx+hUrUp+skQhq0bWB+mStj2J0VZ5RvieIn
        RDXD7xlZjbxWvn72Iq2808RJsgafEP8=
X-Google-Smtp-Source: ABdhPJyt5kkkwv7msIpn2kSX521jl2Qp+98oJm9CBEndA1MnUfb5KSz7CYT7mOugRlb8CYyP1OgMNQ==
X-Received: by 2002:a05:600c:2a4b:: with SMTP id x11mr20296308wme.22.1626595093127;
        Sun, 18 Jul 2021 00:58:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm15904685wrt.55.2021.07.18.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 00:58:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] commit-graph: usage fixes
Date:   Sun, 18 Jul 2021 09:58:04 +0200
Message-Id: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.873.g94a0c75983d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This set of trivial fixes to commit-graph usage was submitted
originally back in February as
https://lore.kernel.org/git/20210215184118.11306-1-avarab@gmail.com/

I omitted the In-Reply-To in the header because this was deep in an
unrelated thread.

In the meantime Taylor's similar changes to the midx code landed (the
original v1 was a "hey, here's how you can do this with
parse_options()" on my part to him).

I did some changes based on feedback on the v1, but didn't pick up all
the suggestions, it was mostly subjective, so let's see what people
think this time around.

Ævar Arnfjörð Bjarmason (5):
  commit-graph: define common usage with a macro
  commit-graph: remove redundant handling of -h
  commit-graph: use parse_options_concat()
  commit-graph: early exit to "usage" on !argc
  commit-graph: show usage on "commit-graph [write|verify] garbage"

 builtin/commit-graph.c  | 95 +++++++++++++++++++++++------------------
 t/t5318-commit-graph.sh |  7 +++
 2 files changed, 60 insertions(+), 42 deletions(-)

Range-diff against v1:
1:  742648756a5 ! 1:  0b0bb04ecf5 commit-graph: define common usage with a macro
    @@ Commit message
         information, see e.g. 809e0327f5 (builtin/commit-graph.c: introduce
         '--max-new-filters=<n>', 2020-09-18).
     
    +    See b25b727494f (builtin/multi-pack-index.c: define common usage with
    +    a macro, 2021-03-30) for another use of this pattern (but on-list this
    +    one came first).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/commit-graph.c ##
2:  497b6cbc9a5 = 2:  6f386fc32c8 commit-graph: remove redundant handling of -h
3:  fd1deaa3c99 ! 3:  2e7d9b0b8e4 commit-graph: use parse_options_concat()
    @@ builtin/commit-graph.c: static struct opts_commit_graph {
      					 const char *obj_dir)
      {
     @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    - 	int fd;
    - 	struct stat st;
      	int flags = 0;
    --
    -+	struct option *options = NULL;
    + 
      	static struct option builtin_commit_graph_verify_options[] = {
     -		OPT_STRING(0, "object-dir", &opts.obj_dir,
     -			   N_("dir"),
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
     -		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
      		OPT_END(),
      	};
    -+	options = parse_options_dup(builtin_commit_graph_verify_options);
    ++	struct option *options = parse_options_dup(builtin_commit_graph_verify_options);
     +	options = add_common_options(options);
      
      	trace2_cmd_mode("verify");
    @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
      
      	if (!opts.obj_dir)
     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    - 	int result = 0;
    - 	enum commit_graph_write_flags flags = 0;
      	struct progress *progress = NULL;
    --
    -+	struct option *options = NULL;
    + 
      	static struct option builtin_commit_graph_write_options[] = {
     -		OPT_STRING(0, "object-dir", &opts.obj_dir,
     -			N_("dir"),
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      			0, write_option_max_new_filters),
      		OPT_END(),
      	};
    -+	options = parse_options_dup(builtin_commit_graph_write_options);
    ++	struct option *options = parse_options_dup(builtin_commit_graph_write_options);
     +	options = add_common_options(options);
      
      	opts.progress = isatty(2);
4:  3d4a1fb6680 ! 4:  d776424e8c8 commit-graph: refactor dispatch loop for style
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    commit-graph: refactor dispatch loop for style
    +    commit-graph: early exit to "usage" on !argc
     
    -    I think it's more readable to have one if/elsif/else chain here than
    -    the code this replaces.
    +    Rather than guarding all of the !argc with an additional "if" arm
    +    let's do an early goto to "usage". This also makes it clear that
    +    "save_commit_buffer" is not needed in this case.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/commit-graph.c ##
     @@ builtin/commit-graph.c: int cmd_commit_graph(int argc, const char **argv, const char *prefix)
    + 			     builtin_commit_graph_options,
    + 			     builtin_commit_graph_usage,
    + 			     PARSE_OPT_STOP_AT_NON_OPTION);
    ++	if (!argc)
    ++		goto usage;
      
      	save_commit_buffer = 0;
      
    @@ builtin/commit-graph.c: int cmd_commit_graph(int argc, const char **argv, const
     -		if (!strcmp(argv[0], "write"))
     -			return graph_write(argc, argv);
     -	}
    --
    --	usage_with_options(builtin_commit_graph_usage,
    --			   builtin_commit_graph_options);
    -+	if (argc && !strcmp(argv[0], "verify"))
    ++	if (!strcmp(argv[0], "verify"))
     +		return graph_verify(argc, argv);
     +	else if (argc && !strcmp(argv[0], "write"))
     +		return graph_write(argc, argv);
    -+	else
    -+		usage_with_options(builtin_commit_graph_usage,
    -+				   builtin_commit_graph_options);
    + 
    ++usage:
    + 	usage_with_options(builtin_commit_graph_usage,
    + 			   builtin_commit_graph_options);
      }
5:  e8481a0932a = 5:  57ffd5812d6 commit-graph: show usage on "commit-graph [write|verify] garbage"
-- 
2.32.0.873.g94a0c75983d

