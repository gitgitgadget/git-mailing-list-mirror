Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC1C433E1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCDE61955
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCUQ7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCUQ6k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B9C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c8so1309844wrq.11
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6u1d9hMpeb6mIlDbzHomCnZQAZgwNOWBAJtZh2PUvb8=;
        b=eC1vZTvqTa1jbH5gIT+PZQJ2R+LBF6RRLOLkgXBGHwJkHWGLxwhdoAD0Oum0hFcsQ+
         HVq3Earx+FacULyM8/uXgxZTOyPOTn90nTxvAmOiq3A7v8a9i0GlTnOJijtAcnr9P0m2
         TOv3/zgpW60NtPub+fqYtGsBdZhWTemDbjyKNhjnxtLMLb42mPCl8rxUlkjzvX3l1fhR
         xwJ7H+llsVXpGhtpCzXpyNXhizuO/I6irkVi29OVA3wYKE0THGEg2Hehk+QQVejKm8Mu
         LnGaaID7cGOqNatVJG35nmpLKZQelfbQTjI7fyc4JMdnBbV3qogglOAnmr8BW38e0Fm/
         CGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6u1d9hMpeb6mIlDbzHomCnZQAZgwNOWBAJtZh2PUvb8=;
        b=HpDnSVnsqCUDffEfISmwr+ENIkB3CcbZA3rxp9JmkIKc0LFZ+vbvxBNR05tXy7J33/
         JavD7IXNk+g6t+DxHpyCBzFktmTremtEREUTpoQRPzXMcfDXgjpHpR0zBORAylcC3hsQ
         10CsdgzAJO8JsCJfFisk97/xy/MstNJxjVbq0z8uLEIoG7Kl7OA/kdtMmEH0Lom0q8Br
         sXfog0rInwn/y52zHTEUakU7CXLmmtG/4euL0d7kJSP4ytFkd+FzAOOHiUOTfOQwBdg9
         sUoDqvocD6uYV+pKWVWIUiaZ3tsQnvb3Pg/9n/Ad/8lFL8SVXYGCDpx1ApayWpP8sApm
         I1Zw==
X-Gm-Message-State: AOAM531+o13Il3aSM7C4PwPPSBJWGjuL+t1/StqU1HnnF6zpV65rNYfc
        3yfK4hrRYeeepZrV+RKR5s0c6aPqSN0=
X-Google-Smtp-Source: ABdhPJwrWsi1/+a9+moI1r6Et6Tvnn6SvAtime3lwh69OWuAgwPYs7XBVKO2Q7+R36ErL8ZiNMzLYQ==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr14199099wri.403.1616345919055;
        Sun, 21 Mar 2021 09:58:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c11sm17928647wrm.67.2021.03.21.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:38 -0700 (PDT)
Message-Id: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:28 +0000
Subject: [PATCH v3 0/9] Fix all leaks in t0001
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V3:

 * Ensures we don't silently change enum values in "parse-options: convert
   bitfield values to use binary shift". Instead we retain the original
   values in that patch, and reuse the unused value in a later patch.
 * Fixes some silly commit message typos.

Thanks as always for the sharp-eyed reviews.

ATB, Andrzej

Andrzej Hunt (9):
  symbolic-ref: don't leak shortened refname in check_symref()
  reset: free instead of leaking unneeded ref
  clone: free or UNLEAK further pointers when finished
  worktree: fix leak in dwim_branch()
  init: remove git_init_db_config() while fixing leaks
  init-db: silence template_dir leak when converting to absolute path
  parse-options: convert bitfield values to use binary shift
  parse-options: don't leak alias help messages
  transport: also free remote_refs in transport_disconnect()

 builtin/clone.c        | 14 ++++++++++----
 builtin/init-db.c      | 32 ++++++++++----------------------
 builtin/ls-remote.c    |  4 ++--
 builtin/remote.c       |  8 ++++----
 builtin/reset.c        |  2 +-
 builtin/symbolic-ref.c |  4 +++-
 builtin/worktree.c     | 10 ++++++----
 parse-options.c        | 19 ++++++++++++++++++-
 parse-options.h        | 35 ++++++++++++++++++-----------------
 transport.c            |  2 ++
 10 files changed, 74 insertions(+), 56 deletions(-)


base-commit: 98164e9585e02e31dcf1377a553efe076c15f8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-899%2Fahunt%2Fleaksan-t0001-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-899/ahunt/leaksan-t0001-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/899

Range-diff vs v2:

  1:  c7bb403ae381 =  1:  6af157dfed79 symbolic-ref: don't leak shortened refname in check_symref()
  2:  da05fc72b77a =  2:  add6931b2138 reset: free instead of leaking unneeded ref
  3:  a74bbcae7363 =  3:  40c5c915fc1e clone: free or UNLEAK further pointers when finished
  4:  a10ab9e68809 =  4:  963f291d5344 worktree: fix leak in dwim_branch()
  5:  206a82200ca1 =  5:  b615fda790f0 init: remove git_init_db_config() while fixing leaks
  6:  aa345e50782f =  6:  953cc8f29885 init-db: silence template_dir leak when converting to absolute path
  7:  2b03785bd4cb !  7:  c2220434ab2c parse-options: convert bitfield values to use binary shift
     @@ Commit message
          Also add a trailing comma to the last enum entry to simplify addition of
          new flags.
      
     -    This changee was originally suggested by Peff in:
     +    This change was originally suggested by Peff in:
          https://public-inbox.org/git/YEZ%2FBWWbpfVwl6nO@coredump.intra.peff.net/
      
          Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
     @@ parse-options.h: enum parse_opt_type {
      +	PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
      +	PARSE_OPT_NODASH = 1 << 5,
      +	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
     -+	PARSE_OPT_SHELL_EVAL = 1 << 7,
     -+	PARSE_OPT_NOCOMPLETE = 1 << 8,
     -+	PARSE_OPT_COMP_ARG = 1 << 9,
     -+	PARSE_OPT_CMDMODE = 1 << 10,
     ++	PARSE_OPT_SHELL_EVAL = 1 << 8,
     ++	PARSE_OPT_NOCOMPLETE = 1 << 9,
     ++	PARSE_OPT_COMP_ARG = 1 << 10,
     ++	PARSE_OPT_CMDMODE = 1 << 11,
       };
       
       enum parse_opt_result {
  8:  4397c1fd8020 !  8:  6e46cd332023 parse-options: don't leak alias help messages
     @@ Commit message
      
          Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
      
     -    fold
     -
       ## parse-options.c ##
      @@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all)
        *
     @@ parse-options.c: static struct option *preprocess_options(struct parse_opt_ctx_t
      +		return;
      +
      +	for (i = 0; options[i].type != OPTION_END; i++) {
     -+		if (options[i].flags & PARSE_OPT_FROM_ALIAS) {
     ++		if (options[i].flags & PARSE_OPT_FROM_ALIAS)
      +			free((void *)options[i].help);
     -+		}
      +	}
      +	free(options);
      +}
     @@ parse-options.c: int parse_options(int argc, const char **argv, const char *pref
      
       ## parse-options.h ##
      @@ parse-options.h: enum parse_opt_option_flags {
     - 	PARSE_OPT_NOCOMPLETE = 1 << 8,
     - 	PARSE_OPT_COMP_ARG = 1 << 9,
     - 	PARSE_OPT_CMDMODE = 1 << 10,
     -+	PARSE_OPT_FROM_ALIAS = 1 << 11,
     - };
     - 
     - enum parse_opt_result {
     + 	PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
     + 	PARSE_OPT_NODASH = 1 << 5,
     + 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
     ++	PARSE_OPT_FROM_ALIAS = 1 << 7,
     + 	PARSE_OPT_SHELL_EVAL = 1 << 8,
     + 	PARSE_OPT_NOCOMPLETE = 1 << 9,
     + 	PARSE_OPT_COMP_ARG = 1 << 10,
  9:  a907f2460d42 =  9:  50a2b9693aa3 transport: also free remote_refs in transport_disconnect()

-- 
gitgitgadget
