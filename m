Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BBC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3361604DB
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhHWMbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhHWMbI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024BCC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d26so5699222wrc.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R8CW8Zm35I48pO/ivw6PSG/9bGF6D0vfevhiOhdy/DQ=;
        b=nbE6c3uI7DbOqKVTc0HfKBLCBr640KfK7j9uvNxFZ99acr7lERhHEdA9sxZge73mdK
         L0/hngyEOtIg7Y99cVwxxK33McO8dsWdIsJiigs4rVj+irtuMXoucXaeRFZXac0GwvMC
         mas5kkXOto3jatnfZ8AAuUQ2aIpfw55qzlYd86Le5nK2p2KYa257aL9t5YhxEZ7FEwU8
         3eIPiMc3Qo4c8grgeI8cBviXkLKFh9p3aDBW2CBP0gttCPL1g1K765m+5hwIZAE9JMrU
         /x09Gea5dCfvbBWkdAH/uhEOYGOKCDO9+ZPx7+IQbVIUAx/JLgUG1B9wZBMvxoFG72BO
         QkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8CW8Zm35I48pO/ivw6PSG/9bGF6D0vfevhiOhdy/DQ=;
        b=HRTLNCGMi0XbMULEW6yNrZUQifvY1CURPy6Fn+MHw/E9XV9BWiZJrRG8Bgm3limx6o
         ZVIm186/7PFgPBksjfrsr8upL3SGUpyJLAcvko2lp3Ntn5rnifnufYn2IfEdf/7PjOcL
         hDitKYs19ZHbLwhxpCSnCtUHmLW15pmRMpWdwuAtgt8SNKNWhrc0H7MXD2SVzGWU+FmC
         jvaOugOiax33c4nCfvrp1KZJJdBdGfQi9f2RmWO+vJfHWlvFGaXYLzMuYABlx7TGO7vd
         K0S2ckwLrOYj1S67LF5o97pFo6jTIpuVQ2lUukIzroG8/pCQc7qLtREsZSD0FBFzF7LO
         6Gsw==
X-Gm-Message-State: AOAM533i/88gq0TTCS4I/u38MN6uvAMJWS9AroCB+8ub53+Fh8EzyIdb
        YPuk3BbMZ+Gen1JilPJsyyV1FT+qvQds9LRS
X-Google-Smtp-Source: ABdhPJwVlch1DjFqO9EcxkNz8XjD7S2uJCleEFWE7PkEey9R2e8cxqXryX+BpfsbXMFq3hAauLTElg==
X-Received: by 2002:adf:f490:: with SMTP id l16mr11740374wro.136.1629721824345;
        Mon, 23 Aug 2021 05:30:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/7] commit-graph: usage fixes
Date:   Mon, 23 Aug 2021 14:30:14 +0200
Message-Id: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of v3 which should fix all outstanding issues &
feedback. Thanks SZEDER & Taylor:
https://lore.kernel.org/git/cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com/

I dropped this myself because per
https://lore.kernel.org/git/87im14unfd.fsf@evledraar.gmail.com/ I was
under the impression that Taylor was intending to pick up these
patches as part of some more generale usage() fixes of his (which also
touched multi-pack-index.c), but his recent changes to fix
multi-pack-index.c didn't pick this up, so here it is as a re-roll instead.

Ævar Arnfjörð Bjarmason (7):
  commit-graph: define common usage with a macro
  commit-graph: remove redundant handling of -h
  commit-graph: use parse_options_concat()
  multi-pack-index: refactor "goto usage" pattern
  commit-graph: early exit to "usage" on !argc
  commit-graph: show usage on "commit-graph [write|verify] garbage"
  commit-graph: show "unexpected subcommand" error

 builtin/commit-graph.c     | 90 +++++++++++++++++++++-----------------
 builtin/multi-pack-index.c | 11 +++--
 t/t5318-commit-graph.sh    | 19 ++++++++
 3 files changed, 74 insertions(+), 46 deletions(-)

Range-diff against v3:
1:  1b9b4703ce2 = 1:  ef37a8243c8 commit-graph: define common usage with a macro
2:  8f50750ae5e = 2:  bbed18ff193 commit-graph: remove redundant handling of -h
3:  f02da994363 = 3:  32cc0d1c7bc commit-graph: use parse_options_concat()
4:  6e9bd877866 ! 4:  087f98bbec6 multi-pack-index: refactor "goto usage" pattern
    @@ Commit message
     
         Refactor the "goto usage" pattern added in
         cd57bc41bbc (builtin/multi-pack-index.c: display usage on unrecognized
    -    command, 2021-03-30) to maintain the same brevity, but doesn't run
    -    afoul of the recommendation in CodingGuidelines about braces:
    +    command, 2021-03-30) and 88617d11f9d (multi-pack-index: fix potential
    +    segfault without sub-command, 2021-07-19) to maintain the same
    +    brevity, but in a form that doesn't run afoul of the recommendation in
    +    CodingGuidelines about braces:
     
             When there are multiple arms to a conditional and some of them
             require braces, enclose even a single line block in braces for
    @@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv
      	else if (!strcmp(argv[0], "expire"))
      		return cmd_multi_pack_index_expire(argc, argv);
     -	else {
    +-		error(_("unrecognized subcommand: %s"), argv[0]);
     +
    ++	error(_("unrecognized subcommand: %s"), argv[0]);
      usage:
    --		error(_("unrecognized subcommand: %s"), argv[0]);
     -		usage_with_options(builtin_multi_pack_index_usage,
     -				   builtin_multi_pack_index_options);
     -	}
    -+	error(_("unrecognized subcommand: %s"), argv[0]);
     +	usage_with_options(builtin_multi_pack_index_usage,
     +			   builtin_multi_pack_index_options);
      }
5:  7acb4bd75ce = 5:  2983e16ba69 commit-graph: early exit to "usage" on !argc
6:  5c1694e071e ! 6:  85552a6f88c commit-graph: show usage on "commit-graph [write|verify] garbage"
    @@ Metadata
      ## Commit message ##
         commit-graph: show usage on "commit-graph [write|verify] garbage"
     
    -    Change the parse_options() invocation in the commit-graph code to make
    -    sense. We're calling it twice, once for common options parsing, and
    -    then for the sub-commands.
    +    Change the parse_options() invocation in the commit-graph code to
    +    error on unknown leftover argv elements, in addition to the existing
    +    and implicit erroring via parse_options() on unknown options.
     
    -    But we never checked if we had something leftover in argc in "write"
    -    or "verify", as a result we'd silently accept garbage in these
    -    subcommands. Let's not do that.
    +    We'd already error in cmd_commit_graph() on e.g.:
    +
    +        git commit-graph unknown verify
    +        git commit-graph --unknown verify
    +
    +    But here we're calling parse_options() twice more for the "write" and
    +    "verify" subcommands. We did not do the same checking for leftover
    +    argv elements there. As a result we'd silently accept garbage in these
    +    subcommands, let's not do that.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/commit-graph.c ##
     @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    - 	opts.progress = isatty(2);
      	argc = parse_options(argc, argv, NULL,
      			     options,
    --			     builtin_commit_graph_verify_usage, 0);
    -+			     builtin_commit_graph_verify_usage,
    -+			     PARSE_OPT_KEEP_UNKNOWN);
    + 			     builtin_commit_graph_verify_usage, 0);
     +	if (argc)
     +		usage_with_options(builtin_commit_graph_verify_usage, options);
      
      	if (!opts.obj_dir)
      		opts.obj_dir = get_object_directory();
     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    - 
      	argc = parse_options(argc, argv, NULL,
      			     options,
    --			     builtin_commit_graph_write_usage, 0);
    -+			     builtin_commit_graph_write_usage,
    -+			     PARSE_OPT_KEEP_UNKNOWN);
    + 			     builtin_commit_graph_write_usage, 0);
     +	if (argc)
     +		usage_with_options(builtin_commit_graph_write_usage, options);
      
-:  ----------- > 7:  962521cfa17 commit-graph: show "unexpected subcommand" error
-- 
2.33.0.662.gbc81f8cbdca

