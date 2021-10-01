Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0192C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33D86135E
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354516AbhJAObH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353819AbhJAObG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:31:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6EC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:29:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t8so15849455wri.1
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4D6VFuHVr9Ej+rbTiMPjboUt4WtsXrMr1WESj7dGW4=;
        b=MFcJvSQAyDoDs6Vm9gV9xGSWI/Vl7Ers0NTcvFzWV9Fg3nb2qoKeKMkEODZ6QN57JT
         i/4yCugQ+R348b1ieqXjHo1IGjJi3IlQ25K8y6zGiyLmCXjJ+EAcQAYlst7uDa1Slu+u
         lgyRqhTeH989HBJr7p2mg5op82D82CLCyxu17hZ+YGlhLog0sZC9gmeUtMq59SQu9/VY
         SPdXs4AsqwcyaQx4115ZFWYRP65NCeobHqgjOJHZxA8shY5W7DlR7FiflwPaldO6QggV
         wntjNYzf1SMmlhsYlfMksNhc9130655bdHhCLkCHqgHqN0TdRyauMQjeSdkrGoid5/Ph
         kg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4D6VFuHVr9Ej+rbTiMPjboUt4WtsXrMr1WESj7dGW4=;
        b=u/lXVxmbvOsdMyeD3NhwrGdblHhPA6o6giJ/Sl3wR05Bc08NF2g4kZKy5AIeQZfyGl
         JKdTUtzOH8d4KCRJXnddQH1aXPUT0wAC5eDMXlo0ldgsBEOlFVdNjtQ3Zk06dIQ4u108
         5DQXkWgfhboSLgKT2zwjxUd9hWC6UmtmWob6iJwDS2vJQP/QvwEzUp+1faRsegjAkgvp
         5hBcBkGUVTrw44rDbMNNhg2Gd7ELU/j987FvkozjOQvEccj1u6u9qBOmPhTeMB99tY7g
         QlwuPATrXKFHWSoAYPDw2bmPZgUZuozDDQ8B6+I71EtrAaOJ3br52S4v5B7QjwLBreLG
         nEXg==
X-Gm-Message-State: AOAM531ekYF6ci5ZGoqNlTq/UFBFY+xVYZ54kdtPW5VnzaEqFd17SDcG
        XhFtWyi91Gf7e7jUhwqvnXe/FfOP0rS+HA==
X-Google-Smtp-Source: ABdhPJzZAFGxYzTqW9ppTGP7iA/4gag3TJIrxug5uc8UgGUd1l2saGeXnAfM87xGX5HR1xNqM4UE+Q==
X-Received: by 2002:a5d:4b11:: with SMTP id v17mr12817190wrq.313.1633098560231;
        Fri, 01 Oct 2021 07:29:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 189sm9042069wmz.27.2021.10.01.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:29:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] fix bug, use existing enums
Date:   Fri,  1 Oct 2021 16:29:06 +0200
Message-Id: <cover-v2-00.11-00000000000-20211001T142631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.gc8f4fa74caf
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some feature changes planned for parse-options.[ch], including
ones that allow us to delete some boilerplate (and sometimes buggy)
code in built-ins by having the API do heavier lifting.

In adding anything to the API I've found it hard to deal with it using
its own enums inconsistently, sometimes it's an "int", sometimes it's
the "enum", and having the "default" cases makes it hard to assert
that you've added things to all the right places.

This re-roll of the v1[1] should hopefully address all the feedback on
that version, particularly the motivation for the enum-as-bitfield
labeling, as expanded on in 02/11.

1. http://lore.kernel.org/git/cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (11):
  parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
  parse-options.[ch]: consistently use "enum parse_opt_flags"
  parse-options.[ch]: consistently use "enum parse_opt_result"
  parse-options.c: use exhaustive "case" arms for "enum
    parse_opt_result"
  parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
  parse-options.h: make the "flags" in "struct option" an enum
  parse-options.c: move optname() earlier in the file
  commit-graph: stop using optname()
  parse-options.[ch]: make opt{bug,name}() "static"
  parse-options tests: test optname() output
  parse-options: change OPT_{SHORT,UNSET} to an enum

 builtin/blame.c          |   3 +
 builtin/commit-graph.c   |   3 +-
 builtin/shortlog.c       |   3 +
 parse-options.c          | 135 ++++++++++++++++++++++++++-------------
 parse-options.h          |  26 ++++----
 t/t0040-parse-options.sh |  42 +++++++++++-
 6 files changed, 151 insertions(+), 61 deletions(-)

Range-diff against v1:
 1:  19d1573a4e0 =  1:  553931702df parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
 2:  289bb437eb5 !  2:  99f5251c557 parse-options.[ch]: consistently use "enum parse_opt_flags"
    @@ Commit message
         parse-options.[ch]: consistently use "enum parse_opt_flags"
     
         Use the "enum parse_opt_flags" instead of an "int flags" as arguments
    -    to the various functions in parse-options.c. This will help to catch
    -    cases where we're not handling cases in switch statements, and
    -    generally make it obvious which "flags" we're referring to in this
    -    case.
    +    to the various functions in parse-options.c.
    +
    +    In C enums aren't first-class types, and the "enum
    +    parse_opt_option_flag" uses a enum-as-bitfield pattern. So unlike
    +    exhaustively enumerated "case" arms we're not going to get validation
    +    that we used the "right" enum labels.
    +
    +    I.e. this won't catch the sort of bug that was fixed with
    +    "PARSE_OPT_SHELL_EVAL" in the preceding commit.
    +
    +    But there's still a benefit to doing this when it comes to the wider C
    +    ecosystem. E.g. the GNU debugger (gdb) will helpfully detect and print
    +    out meaningful enum labels in this case. Here's the output before and
    +    after when breaking in "parse_options()" after invoking "git stash
    +    show":
    +
    +    Before:
    +
    +        (gdb) p flags
    +        $1 = 9
    +
    +    After:
    +
    +        (gdb) p flags
    +        $1 = (PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN)
    +
    +    Of course as noted in[1] there's a limit to this smartness,
    +    i.e. manually setting it with unrelated enum labels won't be
    +    caught. There are some third-party extensions to do more exhaustive
    +    checking[2], perhaps we'll be able to make use of them sooner than
    +    later.
    +
    +    We've also got prior art using this pattern in the codebase. See
    +    e.g. "enum bloom_filter_computed" added in 312cff52074 (bloom: split
    +    'get_bloom_filter()' in two, 2020-09-16) and the "permitted" enum
    +    added in ce910287e72 (add -p: fix checking of user input, 2020-08-17).
    +
    +    1. https://lore.kernel.org/git/87mtnvvj3c.fsf@evledraar.gmail.com/
    +    2. https://github.com/sinelaw/elfs-clang-plugins/blob/master/enums_conversion/README.md
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ parse-options.c: int parse_options_end(struct parse_opt_ctx_t *ctx)
      {
      	struct parse_opt_ctx_t ctx;
      	struct option *real_options;
    -@@ parse-options.c: int parse_options(int argc, const char **argv, const char *prefix,
    - 	case PARSE_OPT_NON_OPTION:
    - 	case PARSE_OPT_DONE:
    - 		break;
    --	default: /* PARSE_OPT_UNKNOWN */
    -+	case PARSE_OPT_UNKNOWN:
    - 		if (ctx.argv[0][1] == '-') {
    - 			error(_("unknown option `%s'"), ctx.argv[0] + 2);
    - 		} else if (isascii(*ctx.opt)) {
     
      ## parse-options.h ##
     @@ parse-options.h: struct option {
 3:  fbcbaa47329 !  3:  be198e42df9 parse-options.[ch]: consistently use "enum parse_opt_result"
    @@ Commit message
         third caller in 309be813c9b (update-index: migrate to parse-options
         API, 2010-12-01) was already checking for these.
     
    +    As can be seen when trying to sort through the deluge of warnings
    +    produced when compiling this with CC=g++ (mostly unrelated to this
    +    change) we're not consistently using "enum parse_opt_result" even now,
    +    i.e. we'll return error() and "return 0;". See f41179f16ba
    +    (parse-options: avoid magic return codes, 2019-01-27) for a commit
    +    which started changing some of that.
    +
    +    I'm not doing any more of that exhaustive migration here, and it's
    +    probably not worthwhile past the point of being able to check "enum
    +    parse_opt_result" in switch().
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/blame.c ##
    @@ builtin/shortlog.c: int cmd_shortlog(int argc, const char **argv, const char *pr
      			exit(129);
     
      ## parse-options.c ##
    -@@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *,
    - 				       const char * const *,
    - 				       const struct option *, int, int);
    +@@ parse-options.c: static void free_preprocessed_options(struct option *options)
    + 	free(options);
    + }
      
    +-static int usage_with_options_internal(struct parse_opt_ctx_t *,
    +-				       const char * const *,
    +-				       const struct option *, int, int);
    +-
     -int parse_options_step(struct parse_opt_ctx_t *ctx,
     -		       const struct option *options,
     -		       const char * const usagestr[])
    ++static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
    ++							 const char * const *,
    ++							 const struct option *,
    ++							 int, int);
    ++
     +enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
     +					 const struct option *options,
     +					 const char * const usagestr[])
    @@ parse-options.c: int parse_options_end(struct parse_opt_ctx_t *ctx)
      {
      	struct parse_opt_ctx_t ctx;
      	struct option *real_options;
    +@@ parse-options.c: static int usage_argh(const struct option *opts, FILE *outfile)
    + #define USAGE_OPTS_WIDTH 24
    + #define USAGE_GAP         2
    + 
    +-static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
    +-				       const char * const *usagestr,
    +-				       const struct option *opts, int full, int err)
    ++static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *ctx,
    ++							 const char * const *usagestr,
    ++							 const struct option *opts,
    ++							 int full, int err)
    + {
    + 	FILE *outfile = err ? stderr : stdout;
    + 	int need_newline;
     
      ## parse-options.h ##
     @@ parse-options.h: struct option {
 -:  ----------- >  4:  a253db7a60d parse-options.c: use exhaustive "case" arms for "enum parse_opt_result"
 4:  624a19000e1 !  5:  467828780d0 parse-options.c: use exhaustive "case" arms for "enum parse_opt_type"
    @@ Commit message
         handling of options it's probably not worth it to get there, but let's
         match its ordering where it's easy to do so.
     
    +    There was a discussion about whether this was worth the added
    +    verbosity, as argued in[1] I think it's worth it for getting
    +    compile-time checking when adding new option types. We *should* have
    +    tests for some of these, but e.g. in the show_gitcomp() case one might
    +    run through the whole test suite and only hit a missing case at the
    +    end on the completion tests.
    +
    +    This technically changes the handling of OPTION_END, but it's
    +    obviously the right thing to do. We're calling this code from within a
    +    loop that uses OPTION_END as a break condition, so it was never caught
    +    by the "default" case.
    +
    +    So let's make encountering OPTION_END a BUG(), just like it already is
    +    in the get_value() handling added in 4a59fd13122 (Add a simple option
    +    parser., 2007-10-15).
    +
    +    1. https://lore.kernel.org/git/87tui3vk8y.fsf@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## parse-options.c ##
    @@ parse-options.c: static enum parse_opt_result get_value(struct parse_opt_ctx_t *
      }
      
      static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
    +@@ parse-options.c: static void parse_options_check(const struct option *opts)
    + 			err |= optbug(opts, "uses feature "
    + 					"not supported for dashless options");
    + 		switch (opts->type) {
    ++		case OPTION_END:
    ++			BUG("unreachable");
    ++
    + 		case OPTION_COUNTUP:
    + 		case OPTION_BIT:
    + 		case OPTION_NEGBIT:
     @@ parse-options.c: static void parse_options_check(const struct option *opts)
      			BUG("OPT_ALIAS() should not remain at this point. "
      			    "Are you using parse_options_step() directly?\n"
    @@ parse-options.c: static void parse_options_check(const struct option *opts)
     -			; /* ok. (usually accepts an argument) */
     +
     +		case OPTION_BITOP:
    -+		case OPTION_END:
     +		case OPTION_FILENAME:
     +		case OPTION_GROUP:
     +		case OPTION_INTEGER:
    @@ parse-options.c: static void parse_options_check(const struct option *opts)
      		}
      		if (opts->argh &&
      		    strcspn(opts->argh, " _") != strlen(opts->argh))
    +@@ parse-options.c: static void show_negated_gitcomp(const struct option *opts, int show_all,
    + 			continue;
    + 
    + 		switch (opts->type) {
    ++		case OPTION_END:
    ++			BUG("unreachable");
    ++
    + 		case OPTION_STRING:
    + 		case OPTION_FILENAME:
    + 		case OPTION_INTEGER:
     @@ parse-options.c: static void show_negated_gitcomp(const struct option *opts, int show_all,
      		case OPTION_SET_INT:
      			has_unset_form = 1;
      			break;
     -		default:
     +		/* special types */
    -+		case OPTION_END:
     +		case OPTION_GROUP:
     +		case OPTION_NUMBER:
     +		case OPTION_ALIAS:
    @@ parse-options.c: static void show_negated_gitcomp(const struct option *opts, int
      			break;
      		}
      		if (!has_unset_form)
    +@@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all)
    + 			continue;
    + 
    + 		switch (opts->type) {
    ++		case OPTION_END:
    ++			BUG("unreachable");
    + 		case OPTION_GROUP:
    + 			continue;
    + 		case OPTION_STRING:
     @@ parse-options.c: static int show_gitcomp(const struct option *opts, int show_all)
      				break;
      			suffix = "=";
      			break;
     -		default:
     +		/* special types */
    -+		case OPTION_END:
     +		case OPTION_NUMBER:
     +		case OPTION_ALIAS:
     +
 5:  697e432c012 =  6:  34669327550 parse-options.h: make the "flags" in "struct option" an enum
 6:  c065f7d7362 =  7:  e82a4e477d5 parse-options.c: move optname() earlier in the file
 7:  b0b313795c7 =  8:  58683b3d89d commit-graph: stop using optname()
 8:  07ba0e6f995 =  9:  8cbee660174 parse-options.[ch]: make opt{bug,name}() "static"
 9:  ce508fddc8f = 10:  f727f683eb1 parse-options tests: test optname() output
10:  a28ab961125 = 11:  4fbc07fc7fd parse-options: change OPT_{SHORT,UNSET} to an enum
-- 
2.33.0.1374.gc8f4fa74caf

