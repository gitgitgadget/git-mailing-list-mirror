Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D4C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3505960F9C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhJHTJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhJHTJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:09:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A6FC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:07:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o20so32571445wro.3
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsvH4Wk7ZgVFpGqFCejGU41TeEzjrrF+hCVJQ0koyFk=;
        b=GiIEpXVVBC0TAUCv0LduSXElePGZncv2Ap8mN0+FJ9ADzQ21zldxeuFoVAug7lJGVD
         DMe5kaTqeKBbUkG43MXQ4YJCCENi4AmF6bnOCHa00b5Z40Nn+dbitFH0XNWBjPj+th9b
         yL2JidGc5WFwWZcdgTfgy4w84pTX18rWwGpEiXtCtwlZUY5KWwQSrYXjzucE6qD+g5QT
         h4nQrNLEOV+/M4A2sGmfJHn3+BenhpTiqDjmMFUt2oFES9HGtld+RobJP/yLiZayparH
         g43K51fheAq2Xcytl3Bqk1qaKa8Kh+eSpAjV7/YdAI5o9TBP9en2f7xIpMghtgupi9lZ
         yL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsvH4Wk7ZgVFpGqFCejGU41TeEzjrrF+hCVJQ0koyFk=;
        b=lRMARbO4wX8Ctoxfl5x0afblARqgFr9YAXAx3E7EyouOCJSvHsvMDXJCCwKat7BPos
         lORM5s60nSnt2jjW5Rs6oGiZs42FUAdylN8ytoMqfOQ47j/ESLPu9vwis6l347NeFL7t
         0taP3WBzrUmdgMBaPnqzDbMywgqWSrRaj6Oj9nrVaiLYjhCScf1pwfmP3ZoxblWHq5lh
         XMCR2b7oe6MXOwnxsd0EUI13UcwSBLyaV/XvaJsPHlmyaqjQQkKQ9R1MoY88QnRuYspP
         dkfsprmiVuilPttI1/VAdFnZwdsTMX8LbtpEI3XM6LCJoUhWaflCTN++RFruhCHBgRZ5
         2Y/A==
X-Gm-Message-State: AOAM530YeNiKBDFzeAcCBryruR1RTHRC/kV+iuoAflAM3dKB7fUJugAq
        5jR3KStegQz2arZ7yJsqTtHntaNy5jw=
X-Google-Smtp-Source: ABdhPJzogvTJ0w1VvdfrIt2UvpkmoASmsmXguQ3mfFBgIRN39KtvUaVcOadMGmHVwIJpZrssvbt+Zg==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr5240303wmq.73.1633720068289;
        Fri, 08 Oct 2021 12:07:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x17sm169882wrc.51.2021.10.08.12.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:07:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] fix bug, use more enums
Date:   Fri,  8 Oct 2021 21:07:36 +0200
Message-Id: <cover-v3-00.10-00000000000-20211008T190536Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of
https://lore.kernel.org/git/cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com/;
I dropped the addition of exhaustive enum arms for parse_opt_type.

There's other tweaks here pointed out by Junio & René, thanks both!
The "enum parse_opt_flags flags" change in the range-diff below was
there before, but it was (incorrectly, to begin with) in the
now-dropped patch.

Ævar Arnfjörð Bjarmason (10):
  parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
  parse-options.[ch]: consistently use "enum parse_opt_flags"
  parse-options.[ch]: consistently use "enum parse_opt_result"
  parse-options.c: use exhaustive "case" arms for "enum
    parse_opt_result"
  parse-options.h: make the "flags" in "struct option" an enum
  parse-options.c: move optname() earlier in the file
  commit-graph: stop using optname()
  parse-options.[ch]: make opt{bug,name}() "static"
  parse-options tests: test optname() output
  parse-options: change OPT_{SHORT,UNSET} to an enum

 builtin/blame.c          |  3 ++
 builtin/commit-graph.c   |  4 +-
 builtin/shortlog.c       |  3 ++
 parse-options.c          | 87 ++++++++++++++++++++++------------------
 parse-options.h          | 26 ++++++------
 t/t0040-parse-options.sh | 42 +++++++++++++++++--
 6 files changed, 109 insertions(+), 56 deletions(-)

Range-diff against v2:
 1:  553931702df =  1:  59195845497 parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
 2:  99f5251c557 !  2:  d4aaaa645de parse-options.[ch]: consistently use "enum parse_opt_flags"
    @@ Commit message
         Use the "enum parse_opt_flags" instead of an "int flags" as arguments
         to the various functions in parse-options.c.
     
    -    In C enums aren't first-class types, and the "enum
    -    parse_opt_option_flag" uses a enum-as-bitfield pattern. So unlike
    -    exhaustively enumerated "case" arms we're not going to get validation
    -    that we used the "right" enum labels.
    -
    -    I.e. this won't catch the sort of bug that was fixed with
    -    "PARSE_OPT_SHELL_EVAL" in the preceding commit.
    -
    -    But there's still a benefit to doing this when it comes to the wider C
    -    ecosystem. E.g. the GNU debugger (gdb) will helpfully detect and print
    -    out meaningful enum labels in this case. Here's the output before and
    -    after when breaking in "parse_options()" after invoking "git stash
    -    show":
    +    Even though this is an enum bitfield there's there's a benefit to
    +    doing this when it comes to the wider C ecosystem. E.g. the GNU
    +    debugger (gdb) will helpfully detect and print out meaningful enum
    +    labels in this case. Here's the output before and after when breaking
    +    in "parse_options()" after invoking "git stash show":
     
         Before:
     
    @@ parse-options.h: struct option {
      NORETURN void usage_with_options(const char * const *usagestr,
      				 const struct option *options);
     @@ parse-options.h: struct parse_opt_ctx_t {
    + 	const char **out;
    + 	int argc, cpidx, total;
    + 	const char *opt;
    +-	int flags;
    ++	enum parse_opt_flags flags;
    + 	const char *prefix;
    + 	const char **alias_groups; /* must be in groups of 3 elements! */
    + 	struct option *updated_options;
    +@@ parse-options.h: struct parse_opt_ctx_t {
      
      void parse_options_start(struct parse_opt_ctx_t *ctx,
      			 int argc, const char **argv, const char *prefix,
 3:  be198e42df9 =  3:  828e8b96574 parse-options.[ch]: consistently use "enum parse_opt_result"
 4:  a253db7a60d =  4:  bebf3448c49 parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
 5:  467828780d0 <  -:  ----------- parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
 6:  34669327550 =  5:  23e62d4139f parse-options.h: make the "flags" in "struct option" an enum
 7:  e82a4e477d5 =  6:  7afdb22885d parse-options.c: move optname() earlier in the file
 8:  58683b3d89d !  7:  67a9b38f66c commit-graph: stop using optname()
    @@ Commit message
         of "opt->flags" to optname(), that function expects flags, but not
         *those* flags.
     
    +    Let's pass "max-new-filters" to the new error because the option name
    +    isn't translatable, and because we can re-use a translation added in
    +    f7e68a08780 (parse-options: check empty value in OPT_INTEGER and
    +    OPT_ABBREV, 2019-05-29).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/commit-graph.c ##
    @@ builtin/commit-graph.c: static int write_option_max_new_filters(const struct opt
      		if (*s)
     -			return error(_("%s expects a numerical value"),
     -				     optname(opt, opt->flags));
    -+			return error(_("option `max-new-filters' expects a numerical value"));
    ++			return error(_("option `%s' expects a numerical value"),
    ++				     "max-new-filters");
      	}
      	return 0;
      }
 9:  8cbee660174 =  8:  520cc5a8dc0 parse-options.[ch]: make opt{bug,name}() "static"
10:  f727f683eb1 =  9:  a82987a03c7 parse-options tests: test optname() output
11:  4fbc07fc7fd = 10:  e05627d3634 parse-options: change OPT_{SHORT,UNSET} to an enum
-- 
2.33.0.1446.g6af949f83bd

